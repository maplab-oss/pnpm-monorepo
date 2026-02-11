#!/bin/bash
set -e

echo "📦 Installing project dependencies..."

# Install dependencies
pnpm install

# Install Playwright browsers for smoke tests
echo "🎭 Installing Playwright browsers..."
pnpm --filter=@my-org/my-project-e2e-tests exec playwright install chromium

echo "✅ Dependencies installed successfully!"