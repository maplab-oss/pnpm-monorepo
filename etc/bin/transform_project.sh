#!/bin/bash
set -e

# Check if required parameters are provided
if [ $# -ne 4 ]; then
  echo "Usage: $0 SLUG DISPLAY_NAME DESCRIPTION EMOJI"
  echo "Example: $0 my-app 'My App' 'A cool application' '🚀'"
  exit 1
fi

SLUG="$1"
DISPLAY_NAME="$2"
DESCRIPTION="$3"
EMOJI="$4"

echo "🔄 Transforming project with:"
echo "  Slug: $SLUG"
echo "  Display Name: $DISPLAY_NAME"
echo "  Description: $DESCRIPTION"
echo "  Emoji: $EMOJI"

# Replace package names
echo "📦 Updating package names..."
find . -name "package.json" -not -path "./node_modules/*" | xargs sed -i '' "s/@my-org\/my-project/@$SLUG/g"

# Replace TypeScript imports
echo "📄 Updating TypeScript imports..."
find . -name "*.ts" -o -name "*.tsx" | xargs sed -i '' "s/@my-org\/my-project/@$SLUG/g"

# Replace project references
echo "⚙️  Updating configuration files..."
sed -i '' "s/my-project/$SLUG/g" zap.yaml
mv my-project.code-workspace "$SLUG.code-workspace" 2>/dev/null || true

# Replace display names
echo "🏷️  Updating display names..."
sed -i '' "s/My project/$DISPLAY_NAME/g" apps/frontend/index.html
sed -i '' "s/My project/$DISPLAY_NAME/g" packages/core/src/index.ts
sed -i '' "s/My project/$DISPLAY_NAME/g" apps/frontend/src/App.test.tsx

# Update Dockerfile
sed -i '' "s/@my-org\/my-project/@$SLUG/g" apps/backend/Dockerfile

# Generate random ports
echo "🔌 Configuring random ports..."
BACKEND_PORT=$(./etc/bin/randomport)
FRONTEND_PORT=$(./etc/bin/randomport)
sed -i '' "s/BACKEND_PORT=.*/BACKEND_PORT=$BACKEND_PORT/" .env.local
sed -i '' "s/FRONTEND_PORT=.*/FRONTEND_PORT=$FRONTEND_PORT/" .env.local
sed -i '' "s|VITE_API_BASE_URL=.*|VITE_API_BASE_URL=http://localhost:$BACKEND_PORT|" .env.local

# Generate favicon if emoji provided
if [ -n "$EMOJI" ] && [ "$EMOJI" != "" ]; then
  echo "🎨 Generating favicon..."
  if [ -f "./etc/bin/emoji-favicon" ]; then
    FAVICON_B64=$(./etc/bin/emoji-favicon "$EMOJI")
    sed -i '' "s|<link rel=\"icon\" href=\"[^\"]*\"|<link rel=\"icon\" href=\"$FAVICON_B64\"|" apps/frontend/index.html
  else
    echo "⚠️  emoji-favicon script not found, skipping favicon generation"
  fi
fi

echo "✅ Project transformation complete!"
echo "  Backend port: $BACKEND_PORT"
echo "  Frontend port: $FRONTEND_PORT"