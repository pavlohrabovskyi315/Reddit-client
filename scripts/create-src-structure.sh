#!/bin/bash

echo "Creating src folder structure..."

mkdir -p src/{api,app,components,features,pages,utils,tests}
mkdir -p src/components/{Header,SearchBar,Post,PostList,Comment}
mkdir -p src/features/{posts,comments,categories}
mkdir -p src/pages/{Home,PostDetail}
mkdir -p src/tests/{unit,e2e}
