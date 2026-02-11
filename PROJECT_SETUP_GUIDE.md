# PNPM Monorepo Template Setup

This setup guide will:
1. **Clone** the PNPM monorepo template from `https://github.com/maplab-oss/pnpm-monorepo`
2. **Transform** all generic placeholders with your project details
3. **Install** dependencies and development tools
4. **Verify** the project builds and runs

The template contains a full-stack TypeScript monorepo with React frontend, Fastify backend, tRPC API, and shared packages.

## Prerequisites

The setup process will install these tools if not present:

**Required Runtimes:**
- **Node.js** (v18+) - JavaScript runtime
- **pnpm** (v8+) - Package manager (installed via corepack if missing)

**Development Tools:**
- **Zapper** - Process manager for running dev servers
- **Turbo** - Build system (installed as project dependency)

**Runtime Check:**
```bash
# Check if Node.js is installed
node --version || echo "Node.js required - install from https://nodejs.org"

# Enable pnpm (comes with Node.js 16+)
corepack enable

# Install Zapper globally
npm install -g @hyperdoc/zapper
```

---

## Setup Checklist

**Available Fields:**
- **Project display name**: Human-readable name (required)
- **Project description**: One-liner about the project (required)
- **Project slug**: Kebab-case identifier (optional, inferred from display name if blank)
- **Emoji**: For favicon and branding (optional)

### 1. **Clone Template**

```bash
# Clone into current directory
git clone https://github.com/maplab-oss/pnpm-monorepo.git .

# Remove git history for fresh start
rm -rf .git
git init
```

### 2. **Install Prerequisites**

```bash
# Verify Node.js (exit if not found)
if ! command -v node &> /dev/null; then
  echo "❌ Node.js not found. Install from https://nodejs.org (v18+)"
  exit 1
fi

# Enable pnpm package manager
corepack enable

# Install Zapper globally
npm install -g @hyperdoc/zapper

# Install project dependencies
pnpm install
```

### 3. **Transform Project (Programmatic)**

   Use find-and-replace across the entire codebase for speed:

   **Package names:**
   - `@my-org/my-project` → `@{slug}`
   - All package.json files: `"name": "@my-org/my-project-*"` → `"name": "@{slug}-*"`

   **Project references:**
   - `my-project` → `{slug}` (kebab-case contexts)
   - `"My project"` → `"{display-name}"` (quoted strings)
   - `My project` → `{display-name}` (unquoted text)

   **Files to process programmatically:**
   ```bash
   # Package names in all package.json files
   find . -name "package.json" -not -path "./node_modules/*" | xargs sed -i '' 's/@my-org\/my-project/@{slug}/g'

   # TypeScript imports
   find . -name "*.ts" -o -name "*.tsx" | xargs sed -i '' 's/@my-org\/my-project/@{slug}/g'

   # Zap configuration
   sed -i '' 's/my-project/{slug}/g' zap.yaml

   # Workspace file
   mv my-project.code-workspace {slug}.code-workspace

   # Frontend title and core message
   sed -i '' 's/My project/{display-name}/g' apps/frontend/index.html
   sed -i '' 's/My project/{display-name}/g' packages/core/src/index.ts
   sed -i '' 's/My project/{display-name}/g' apps/frontend/src/App.test.tsx

   # Dockerfile
   sed -i '' 's/@my-org\/my-project/@{slug}/g' apps/backend/Dockerfile
   ```

### 4. **Configure ports (Programmatic)**

   Generate random ports to avoid conflicts:
   ```bash
   BACKEND_PORT=$(./etc/bin/randomport)
   FRONTEND_PORT=$(./etc/bin/randomport)

   # Update .env.local
   sed -i '' "s/BACKEND_PORT=.*/BACKEND_PORT=$BACKEND_PORT/" .env.local
   sed -i '' "s/FRONTEND_PORT=.*/FRONTEND_PORT=$FRONTEND_PORT/" .env.local
   sed -i '' "s|VITE_API_BASE_URL=.*|VITE_API_BASE_URL=http://localhost:$BACKEND_PORT|" .env.local
   ```

### 5. **Update project metadata (Manual)**

   These require content generation and are better done manually:

   - **README.md**: Replace entire content:
     ```markdown
     # {emoji} {display-name}

     {description}

     ## Getting Started

     1. Install dependencies: `pnpm install`
     2. Start development servers: `zap up`
     3. Open http://localhost:{frontend-port}

     ## Architecture

     This is a full-stack TypeScript monorepo built with:
     - Frontend: React + Vite + Tailwind + shadcn/ui
     - Backend: Fastify + tRPC
     - Shared packages: core, server, trpc
     - Tools: ESLint, Vitest, Zapper
     ```

   - **AGENTS.md**: Update header and description:
     ```markdown
     # {display-name}

     {description}
     ```

### 6. **Update branding (Programmatic)**

   ```bash
   # Generate favicon if emoji provided
   if [ -n "{emoji}" ]; then
     FAVICON_B64=$(./etc/bin/emoji-favicon "{emoji}")
     sed -i '' "s|<link rel=\"icon\" href=\"[^\"]*\"|<link rel=\"icon\" href=\"$FAVICON_B64\"|" apps/frontend/index.html
   fi
   ```

### 7. **Verification and cleanup**

   ```bash
   # Verify all imports resolve
   pnpm typecheck

   # Test build
   pnpm build

   # Delete setup guide
   rm PROJECT_SETUP_GUIDE.md
   ```

---

## Complete Setup Script

This script handles the entire setup process:

```bash
#!/bin/bash
set -e

# Configuration (replace with actual values)
SLUG="{slug}"
DISPLAY_NAME="{display-name}"
DESCRIPTION="{description}"
EMOJI="{emoji}"

echo "🚀 Setting up PNPM Monorepo Template..."

# 1. Clone template
echo "📥 Cloning template..."
git clone https://github.com/maplab-oss/pnpm-monorepo.git .
rm -rf .git
git init

# 2. Install prerequisites
echo "🔧 Installing prerequisites..."

# Check Node.js
if ! command -v node &> /dev/null; then
  echo "❌ Node.js not found. Install from https://nodejs.org (v18+)"
  exit 1
fi

# Enable pnpm
corepack enable

# Install Zapper
npm install -g @hyperdoc/zapper

# Install dependencies
pnpm install

# 3. Transform project
echo "🔄 Transforming project..."

# Replace package names
find . -name "package.json" -not -path "./node_modules/*" | xargs sed -i '' "s/@my-org\/my-project/@$SLUG/g"

# Replace TypeScript imports
find . -name "*.ts" -o -name "*.tsx" | xargs sed -i '' "s/@my-org\/my-project/@$SLUG/g"

# Replace project references
sed -i '' "s/my-project/$SLUG/g" zap.yaml
mv my-project.code-workspace "$SLUG.code-workspace"

# Replace display names
sed -i '' "s/My project/$DISPLAY_NAME/g" apps/frontend/index.html
sed -i '' "s/My project/$DISPLAY_NAME/g" packages/core/src/index.ts
sed -i '' "s/My project/$DISPLAY_NAME/g" apps/frontend/src/App.test.tsx

# Update Dockerfile
sed -i '' "s/@my-org\/my-project/@$SLUG/g" apps/backend/Dockerfile

# 4. Configure ports
echo "🔌 Configuring ports..."
BACKEND_PORT=$(./etc/bin/randomport)
FRONTEND_PORT=$(./etc/bin/randomport)
sed -i '' "s/BACKEND_PORT=.*/BACKEND_PORT=$BACKEND_PORT/" .env.local
sed -i '' "s/FRONTEND_PORT=.*/FRONTEND_PORT=$FRONTEND_PORT/" .env.local
sed -i '' "s|VITE_API_BASE_URL=.*|VITE_API_BASE_URL=http://localhost:$BACKEND_PORT|" .env.local

# 5. Generate favicon
if [ -n "$EMOJI" ]; then
  echo "🎨 Generating favicon..."
  FAVICON_B64=$(./etc/bin/emoji-favicon "$EMOJI")
  sed -i '' "s|<link rel=\"icon\" href=\"[^\"]*\"|<link rel=\"icon\" href=\"$FAVICON_B64\"|" apps/frontend/index.html
fi

# 6. Verification
echo "✅ Verifying setup..."
pnpm typecheck
pnpm build

echo ""
echo "✅ Setup complete! Manual tasks remaining:"
echo "  📝 Update README.md with project description"
echo "  📝 Update AGENTS.md header"
echo "  🚀 Start development: zap up"
echo "  🌐 Frontend will be at: http://localhost:$FRONTEND_PORT"
```

## AI Agent Instructions

**Programmatic tasks** (use the script above for speed):
1. ✅ Replace all package names and imports
2. ✅ Update workspace and config files
3. ✅ Generate random ports
4. ✅ Update favicon if emoji provided

**Manual tasks** (require content generation):
1. ✅ Rewrite README.md with project-specific content
2. ✅ Update AGENTS.md header and description
3. ✅ Verify everything works: `pnpm typecheck && zap up`
4. ✅ Commit and push changes

The programmatic approach handles ~80% of the work instantly, leaving only content generation as manual tasks. Finally, confirm with the user that the project is running locally and provide the frontend URL.
