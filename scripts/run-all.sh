#!/bin/bash

echo "Running full Reddit Client build process..."

bash scripts/create-project.sh
bash scripts/create-package-json.sh
bash scripts/create-public-files.sh
bash scripts/create-src-structure.sh
bash scripts/create-core-files.sh
bash scripts/create-api.sh
bash scripts/create-redux-store.sh
bash scripts/create-slices.sh
bash scripts/create-pages.sh
bash scripts/zip-project.sh

echo "All done!"
