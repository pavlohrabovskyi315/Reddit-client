#!/bin/bash

echo "Creating core React files..."

cat > src/index.js << 'EOF'
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import { Provider } from "react-redux";
import { store } from "./app/store";
import { BrowserRouter } from "react-router-dom";
import "./styles.css";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <Provider store={store}>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </Provider>
);
EOF

cat > src/App.js << 'EOF'
import { Routes, Route } from "react-router-dom";
import Header from "./components/Header/Header";
import Home from "./pages/Home/Home";
import PostDetail from "./pages/PostDetail/PostDetail";

export default function App() {
  return (
    <>
      <Header />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/post/:subreddit/:id" element={<PostDetail />} />
      </Routes>
    </>
  );
}
EOF

cat > src/styles.css << 'EOF'
body {
  margin: 0;
  font-family: Arial, sans-serif;
  background: #f6f7f8;
}
.container {
  max-width: 900px;
  margin: auto;
  padding: 1rem;
}
.post-card {
  background: white;
  border-radius: 6px;
  padding: 1rem;
  margin-bottom: 1rem;
  text-decoration: none;
  color: black;
  display: block;
  transition: 0.2s ease;
}
.post-card:hover {
  transform: translateY(-3px);
}
EOF
