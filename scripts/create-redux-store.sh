#!/bin/bash

echo "Creating Redux store..."

cat > src/app/store.js << 'EOF'
import { configureStore } from "@reduxjs/toolkit";
import postsReducer from "../features/posts/postsSlice";
import commentsReducer from "../features/comments/commentsSlice";
import categoriesReducer from "../features/categories/categoriesSlice";

export const store = configureStore({
  reducer: {
    posts: postsReducer,
    comments: commentsReducer,
    categories: categoriesReducer
  }
});
EOF
