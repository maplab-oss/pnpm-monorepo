#!/bin/bash
set -e

echo "📥 Cloning PNPM monorepo template..."

# Clone template into current directory
git clone https://github.com/maplab-oss/pnpm-monorepo.git .

# Remove git history for fresh start
rm -rf .git
git init

echo "✅ Template cloned and git reinitialized"