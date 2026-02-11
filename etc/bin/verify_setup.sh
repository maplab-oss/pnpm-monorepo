#!/bin/bash
set -e

echo "✅ Verifying project setup..."

# Check TypeScript compilation
echo "🔍 Checking TypeScript..."
pnpm typecheck

# Test build
echo "🏗️  Testing build..."
pnpm build

# Start services for end-to-end verification
echo "🔄 Starting services for verification..."
zap up

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 15

# Run smoke test to verify end-to-end functionality
echo "🔥 Running smoke test..."
if zap t smoke; then
  echo "✅ Smoke test passed - 'Hello World' endpoint working!"
else
  echo "❌ Smoke test failed - there may be setup issues"
  echo "📋 Service status:"
  zap ps
  echo "📜 Backend logs:"
  zap logs backend --no-follow --tail 20
  zap stop
  exit 1
fi

# Stop services after verification
echo "⏹️  Stopping verification services..."
zap stop

# Clean up setup guide
if [ -f "PROJECT_SETUP_GUIDE.md" ]; then
  echo "🧹 Removing setup guide..."
  rm PROJECT_SETUP_GUIDE.md
fi

echo "✅ Setup verification complete!"
echo "🚀 Your project is ready! Start development with: zap up"
echo "💡 Tip: Run 'zap t smoke' anytime to verify your setup is working"