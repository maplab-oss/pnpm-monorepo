#!/bin/bash
set -e

# Check if required parameters are provided
if [ $# -ne 4 ]; then
  echo "Usage: $0 SLUG DISPLAY_NAME DESCRIPTION EMOJI"
  echo "Example: $0 my-app 'My App' 'A cool application' '🚀'"
  echo ""
  echo "This script runs the complete project setup:"
  echo "  1. Clone template"
  echo "  2. Transform project files"
  echo "  3. Install dependencies"
  echo "  4. Verify setup"
  exit 1
fi

SLUG="$1"
DISPLAY_NAME="$2"
DESCRIPTION="$3"
EMOJI="$4"

echo "🚀 Setting up PNPM Monorepo project..."
echo "  Slug: $SLUG"
echo "  Display Name: $DISPLAY_NAME"
echo "  Description: $DESCRIPTION"
echo "  Emoji: $EMOJI"
echo ""

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Clone template (skip if already in template directory)
if [ -f "$SCRIPT_DIR/clone_template.sh" ]; then
  echo "⏭️  Skipping clone (already in template directory)"
else
  "$SCRIPT_DIR/clone_template.sh"
fi

# 2. Transform project
"$SCRIPT_DIR/transform_project.sh" "$SLUG" "$DISPLAY_NAME" "$DESCRIPTION" "$EMOJI"

# 3. Install dependencies
"$SCRIPT_DIR/install_deps.sh"

# 4. Verify setup
"$SCRIPT_DIR/verify_setup.sh"

echo ""
echo "🎉 Project setup complete!"
echo ""
echo "Next steps:"
echo "  📝 Update README.md with your project description"
echo "  📝 Update AGENTS.md header"
echo "  🚀 Start development: zap up"
echo "  🌐 Frontend will be at: http://localhost:$(grep FRONTEND_PORT .env.local | cut -d'=' -f2)"