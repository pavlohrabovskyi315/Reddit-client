#!/bin/bash

echo "Creating public folder..."

mkdir public
cat > public/index.html << 'EOF'
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Reddit Client</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
</html>
EOF
