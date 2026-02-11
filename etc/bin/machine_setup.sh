#!/bin/bash

echo "Checking machine setup..."
echo ""

# Track results
node_ok=false
pnpm_ok=false
zapper_ok=false
any_failures=false

# Check Node.js
if command -v node &> /dev/null; then
  node_version=$(node --version)
  echo "Node.js: $node_version (installed)"
  node_ok=true
else
  echo "Node.js: missing"
  any_failures=true
fi

# Check pnpm
if command -v pnpm &> /dev/null; then
  pnpm_version=$(pnpm --version)
  echo "pnpm: $pnpm_version (installed)"
  pnpm_ok=true
else
  echo "pnpm: missing"
  any_failures=true
fi

# Check Zapper
if command -v zap &> /dev/null; then
  zapper_version=$(zap --version)
  echo "Zapper: $zapper_version (installed)"
  zapper_ok=true
else
  echo "Zapper: missing"
  any_failures=true
fi

echo ""
echo "SUMMARY:"
if [ "$any_failures" = true ]; then
  echo "Machine is NOT ready for development."
  echo ""
  echo "Missing dependencies:"
  if [ "$node_ok" = false ]; then
    echo "- Node.js (install from https://nodejs.org v18+)"
  fi
  if [ "$pnpm_ok" = false ]; then
    echo "- pnpm (run: corepack enable)"
  fi
  if [ "$zapper_ok" = false ]; then
    echo "- Zapper (run: npm install -g @hyperdoc/zapper)"
  fi
  exit 1
else
  echo "Machine is ready for development."
  exit 0
fi