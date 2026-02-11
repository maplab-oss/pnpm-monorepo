# PNPM Monorepo Template Setup

This setup guide clones the PNPM monorepo template from `https://github.com/maplab-oss/pnpm-monorepo` and customizes it for your project.

**What gets installed:**
- **Node.js dependencies** (via pnpm)
- **Zapper** - Process manager for dev servers
- **Project dependencies** - React, Fastify, tRPC, etc.

## Quick Setup

Run the complete setup in one command:

```bash
./etc/bin/setup_project.sh SLUG "DISPLAY_NAME" "DESCRIPTION" "EMOJI"
```

Example:
```bash
./etc/bin/setup_project.sh my-app "My App" "A cool application" "🚀"
```

## Step-by-Step Setup

### 1. Check machine prerequisites
```bash
./etc/bin/machine_setup.sh
```
Installs Node.js toolchain and Zapper if missing.

### 2. Clone template
```bash
./etc/bin/clone_template.sh
```
Clones template and initializes fresh git repo.

### 3. Transform project
```bash
./etc/bin/transform_project.sh SLUG "DISPLAY_NAME" "DESCRIPTION" "EMOJI"
```
Replaces all generic placeholders with your project details.

### 4. Install dependencies
```bash
./etc/bin/install_deps.sh
```
Installs all npm packages via pnpm.

### 5. Verify setup
```bash
./etc/bin/verify_setup.sh
```
Runs typecheck and build to ensure everything works.

## Manual Tasks

After running the scripts, manually update:

- **README.md** - Replace with project-specific content
- **AGENTS.md** - Update header with project name and description

## Troubleshooting

If any script fails, check the script contents in `etc/bin/` and fix issues. Common problems:

- **Node.js not found** - Install from https://nodejs.org (v18+)
- **Permission errors** - Run `chmod +x etc/bin/*.sh`
- **Port conflicts** - Scripts generate random ports automatically
- **Build failures** - Check TypeScript errors after transformation

## AI Agent Instructions

**If automated scripts fail:**
1. Read the failing script in `etc/bin/`
2. Identify the issue (missing tools, permissions, syntax errors)
3. Fix the problem and re-run
4. Continue with remaining steps

All scripts are designed to be transparent and debuggable.
