#!/bin/bash

echo "Creating pages..."

# Home page
cat > src/pages/Home/Home.js << 'EOF'
import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { fetchPosts } from "../../features/posts/postsSlice";
import PostList from "../../components/PostList/PostList";

export default function Home() {
  const dispatch = useDispatch();
  const category = useSelector((state) => state.categories.selected);

  useEffect(() => {
    dispatch(fetchPosts(category));
  }, [category]);

  return <div className="container"><PostList /></div>;
}
EOF

# PostDetail page
cat > src/pages/PostDetail/PostDetail.js << 'EOF'
import { useEffect } from "react";
import { useParams } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { fetchComments } from "../../features/comments/commentsSlice";
import ReactMarkdown from "react-markdown";
import Comment from "../../components/Comment/Comment";

export default function PostDetail() {
  const { subreddit, id } = useParams();
  const dispatch = useDispatch();
  const post = useSelector((state) => state.posts.items.find((p) => p.id === id));
  const comments = useSelector((state) => state.comments.byPostId[id]);

  useEffect(() => { dispatch(fetchComments({ subreddit, id })); }, [id]);

  if (!post) return <p>Post not found.</p>;

  return (
    <div className="container">
      <h1>{post.title}</h1>
      {post.selftext && <ReactMarkdown>{post.selftext}</ReactMarkdown>}
      <h2>Comments</h2>
      {comments ? comments.map((c) => <Comment key={c.id} comment={c} />) : <p>Loading...</p>}
    </div>
  );
}
EOF
