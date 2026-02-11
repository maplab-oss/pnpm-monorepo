# Template for E2E typescript monorepos

Build end to end typescript apps with:
- PNPM workspace
- Turborepo
- Vite
- eslint
- zapper
- zod
- superjson
- Vitest
- tRPC
- shadcn/ui

Also includes recipes (for AI!) to add:
- Clerk auth
- BullMQ
- MongoDB
- Playwright
- S3

## Getting Started

### 1. Create your repo from the template

Set project name `export NEW_PROJECT_NAME=my-project`

```bash
gh repo create your-org/$NEW_PROJECT_NAME --template your-org/my-project --clone --private
cd $NEW_PROJECT_NAME
mv my-project.code-workspace "$NEW_PROJECT_NAME.code-workspace"
cursor "$NEW_PROJECT_NAME.code-workspace"
```

### 2. Run the setup guide

Open Cursor's agent mode and run:

```
@PROJECT_SETUP_GUIDE.md set up this project.

Details
- Project name:
- Project slug (optional):
- Project description:
- Repo URL (optional):
- Emoji:
```

The agent will walk you through renaming, ports, branding, and committing the initial setup.

### 3. Deploy

Push to GitHub and test.

## Recommended next steps

- Write the PRODUCT.md
- Build an MVP

## Diagram

                    ┌─────────────────────────────────────┐
                    │            APPLICATION              │
                    │   ┌───────────┐   ┌─────────────┐   │
                    │   │  Frontend │   │   Backend   │   │
                    │   │   React   │   │   Fastify   │   │
                    │   │  Tailwind │   │    tRPC     │   │
                    │   │  shadcn   │   │    Pino     │   │
                    │   └───────────┘   └─────────────┘   │
                    │         ┌───────────────┐           │
                    │         │ Shared Pkgs   │           │
                    │         │ core · server │           │
                    │         │ Zod · trpc    │           │
                    │         └───────────────┘           │
                    └──────────────────┬──────────────────┘
                                       │
                    ┌──────────────────┴──────────────────┐
                    │            BUILD LAYER              │
                    │   TypeScript · Turbo · ESLint       │
                    │   Vitest · Vite (bundling)          │
                    └──────────────────┬──────────────────┘
                                       │
                    ┌──────────────────┴──────────────────┐
                    │              RUNTIME                │
                    │         Node.js · Browser           │
                    └──────────────────┬──────────────────┘
                                       │
                    ┌──────────────────┴──────────────────┐
                    │          PACKAGE MANAGER            │
                    │               pnpm                  │
                    └──────────────────┬──────────────────┘
                                       │
                    ┌──────────────────┼──────────────────┐
                    │                                     │
           ┌────────┴────────┐                   ┌────────┴────────┐
           │   LOCAL DEV     │                   │   PRODUCTION    │
           │                 │                   │                 │
           │     Zapper      │                   │  Your Platform  │
           │    zap.yaml     │                   │   (configurable)│
           │                 │                   │     Docker      │
           │  nvm (Node)     │                   │                 │
           │  Vite dev       │                   │                 │
           │  tsx watch      │                   │                 │
           └─────────────────┘                   └─────────────────┘
