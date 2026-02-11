#!/bin/bash
set -e

echo "✅ Verifying project setup..."

# Check TypeScript compilation
echo "🔍 Checking TypeScript..."
pnpm typecheck

# Test build
echo "🏗️  Testing build..."
pnpm build

# Clean up setup guide
if [ -f "PROJECT_SETUP_GUIDE.md" ]; then
  echo "🧹 Removing setup guide..."
  rm PROJECT_SETUP_GUIDE.md
fi

echo "✅ Setup verification complete!"
echo "🚀 Ready to start development with: zap up"