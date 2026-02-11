#!/bin/bash
set -e

echo "🔧 Setting up development machine..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
  echo "❌ Node.js not found. Install from https://nodejs.org (v18+)"
  echo "   Or use a version manager like nvm:"
  echo "   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
  echo "   nvm install node"
  exit 1
fi

echo "✅ Node.js $(node --version) found"

# Enable pnpm package manager
echo "🔄 Enabling pnpm..."
corepack enable

# Install Zapper globally if not present
if ! command -v zap &> /dev/null; then
  echo "🔄 Installing Zapper..."
  npm install -g @hyperdoc/zapper
else
  echo "✅ Zapper already installed"
fi

echo "✅ Machine setup complete!"
echo "   Node.js: $(node --version)"
echo "   pnpm: $(pnpm --version)"
echo "   Zapper: $(zap --version)"