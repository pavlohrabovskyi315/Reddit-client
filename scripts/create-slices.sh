#!/bin/bash

echo "Creating Redux slices..."

# Posts slice
cat > src/features/posts/postsSlice.js << 'EOF'
import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { getPosts, searchPosts } from "../../api/redditAPI";

export const fetchPosts = createAsyncThunk(
  "posts/fetchPosts",
  async (subreddit) => {
    const json = await getPosts(subreddit);
    return json.data.children.map((c) => c.data);
  }
);

export const fetchSearchResults = createAsyncThunk(
  "posts/search",
  async (query) => {
    const json = await searchPosts(query);
    return json.data.children.map((c) => c.data);
  }
);

const postsSlice = createSlice({
  name: "posts",
  initialState: { items: [], isLoading: false, error: null, searchTerm: "" },
  reducers: {
    setSearchTerm(state, action) {
      state.searchTerm = action.payload;
    }
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchPosts.pending, (state) => { state.isLoading = true; })
      .addCase(fetchPosts.fulfilled, (state, action) => {
        state.isLoading = false;
        state.items = action.payload;
      })
      .addCase(fetchSearchResults.fulfilled, (state, action) => {
        state.items = action.payload;
        state.isLoading = false;
      });
  }
});

export const { setSearchTerm } = postsSlice.actions;
export default postsSlice.reducer;
EOF

# Comments slice
cat > src/features/comments/commentsSlice.js << 'EOF'
import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { getPostComments } from "../../api/redditAPI";

export const fetchComments = createAsyncThunk(
  "comments/fetchComments",
  async ({ subreddit, id }) => {
    const json = await getPostComments(subreddit, id);
    return { id, comments: json[1].data.children.map((c) => c.data) };
  }
);

const commentsSlice = createSlice({
  name: "comments",
  initialState: { byPostId: {}, isLoading: false },
  extraReducers: (builder) => {
    builder.addCase(fetchComments.fulfilled, (state, action) => {
      state.byPostId[action.payload.id] = action.payload.comments;
      state.isLoading = false;
    });
  }
});

export default commentsSlice.reducer;
EOF

# Categories slice
cat > src/features/categories/categoriesSlice.js << 'EOF'
import { createSlice } from "@reduxjs/toolkit";

const categoriesSlice = createSlice({
  name: "categories",
  initialState: {
    list: ["popular", "news", "funny", "pics", "gaming", "worldnews"],
    selected: "popular"
  },
  reducers: {
    setCategory(state, action) {
      state.selected = action.payload;
    }
  }
});

export const { setCategory } = categoriesSlice.actions;
export default categoriesSlice.reducer;
EOF
