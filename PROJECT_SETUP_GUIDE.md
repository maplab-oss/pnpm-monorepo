# Project Setup Guide for AI Agents

This is a generic TypeScript monorepo template that needs to be customized for your specific project. Before proceeding, gather the following information from the user:

**Required Information:**
- **Organization name**: Your GitHub organization or username (e.g., "acme-corp", "myusername")
- **Project name**: The name of your project (e.g., "task-manager", "chat-app")
- **Project display name**: Human-readable name (e.g., "Task Manager", "Chat App")
- **Project description**: A one-liner explaining what the project does
- **Repository URL**: GitHub repository URL (e.g., https://github.com/acme-corp/task-manager)
- **Emoji**: For favicon and branding (optional, default: 🚀)

If this information is not provided, **ask the user for it before proceeding**.

---

Cloning the repo:

when you start, you'll be in an empty project folder. You need to clone the repo from GitHub into the current folder:

https://github.com/maplab-oss/pnpm-monorepo

---

## Setup Checklist

Complete these tasks to transform the template into the new project:

### 1. **Replace all generic references**

   The template uses these generic placeholders that need to be replaced:
   - `@my-org` → `@{organization-name}`
   - `my-project` → `{project-name}`
   - "My project" → "{project-display-name}"

   **Files to update:**
   - All `package.json` files in root, apps/*, and packages/*
   - All TypeScript imports in `src/` directories
   - `zap.yaml` project name and filter commands
   - `my-project.code-workspace` → `{project-name}.code-workspace`
   - `apps/frontend/index.html` title
   - `packages/core/src/index.ts` message
   - `apps/frontend/src/App.test.tsx` test assertions
   - `apps/backend/Dockerfile` CMD filter
   - All documentation files in `docs/`

### 2. **Configure port numbers**

   Assign random ports to avoid conflicts with other projects:
   - Use `./etc/bin/randomport` to generate ports
   - Update `.env.local`:
     ```bash
     BACKEND_PORT={random-port-1}
     FRONTEND_PORT={random-port-2}
     VITE_API_BASE_URL=http://localhost:{backend-port}
     ```

### 3. **Update project metadata**

   - **README.md**: Replace with project-specific content:
     ```markdown
     # {emoji} {project-display-name}

     {project-description}

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

   - **AGENTS.md**: Update the header and description:
     ```markdown
     # {project-display-name}

     {project-description}
     ```

### 4. **Update branding**

   - **Favicon**: Use `./etc/bin/emoji-favicon {emoji}` to generate a base64 favicon
   - **Frontend title**: Update `apps/frontend/index.html` `<title>` tag
   - **Core message**: Update `packages/core/src/index.ts` export message

### 5. **Verify package dependencies**

   Ensure all package.json files have correct workspace dependencies:
   ```bash
   # Should all use the new organization/project names
   @{organization-name}/{project-name}-core
   @{organization-name}/{project-name}-server
   @{organization-name}/{project-name}-trpc
   ```

### 6. **Clean up template artifacts**

   - Delete this `PROJECT_SETUP_GUIDE.md`
   - Remove any remaining placeholder content
   - Verify all imports resolve correctly: `pnpm typecheck`

### 7. **Initialize and commit**

   - Test that everything works: `pnpm install && zap up`
   - Create initial commit: `git add . && git commit -m "Initial commit: {project-display-name}"`
   - Set up remote: `git remote add origin {repository-url}`
   - Push to GitHub: `git push -u origin main`

---

## Example Transformation

If user provides:
- Organization: "acme-corp"
- Project name: "task-manager"
- Display name: "Task Manager"
- Description: "A collaborative task management application"
- Emoji: "📋"

Then transform:
```
@my-org/my-project-* → @acme-corp/task-manager-*
"My project" → "Task Manager"
my-project → task-manager
🚀 → 📋
```

## AI Agent Instructions

Your job is not complete until:
1. ✅ All generic placeholders are replaced with real values
2. ✅ All package.json files have correct names and dependencies
3. ✅ All TypeScript imports resolve correctly
4. ✅ Project builds and starts successfully (`zap up`)
5. ✅ Changes are committed and pushed to the correct repository
6. ✅ README.md is rewritten for the specific project

Finally, confirm with the user that the project is running locally and provide the frontend URL.
