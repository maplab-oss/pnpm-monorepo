# PNPM Monorepo Template Setup

This setup guide clones the PNPM monorepo template from `https://github.com/maplab-oss/pnpm-monorepo` and customizes it for your project.

**What gets installed:**

- **Node.js dependencies** (via pnpm)
- **Zapper** - Process manager for dev servers
- **Project dependencies** - React, Fastify, tRPC, etc.

## Setup Steps

### 1. Clone template

```bash
# Clone template into current directory
git clone https://github.com/maplab-oss/pnpm-monorepo.git .

# Remove git history for fresh start
rm -rf .git
git init
```

Clones template and initializes fresh git repo.

### 2. Check machine prerequisites

```bash
./etc/bin/machine_setup.sh
```

Verifies that Node.js toolchain and Zapper are installed. If ANY dependencies are missing or ANY issues occur, STOP and ask the user what to do. Present ALL problems and options in a single AskUserQuestion.

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

## Verification

You must complete the full verification process:

1. Run the verify_setup.sh script - it will start services, run the smoke test, and stop services
2. The smoke test verifies the "Hello World" endpoint is working end-to-end
3. Only declare setup successful if the smoke test passes
4. If verification fails, troubleshoot using service logs before declaring success

The setup is not complete until the smoke test confirms the full stack is working.

## Manual Tasks

After running the scripts, manually update:

- **README.md** - Replace with project-specific content
- **AGENTS.md** - Update header with project name and description

**Goal:** Get the user to a working state with minimal back-and-forth questions

## Final Output

When everything works, write final output in this format, replacing URL with the real URL:

```
Setup is complete! ✅

Open [<URL>](<URL>) in your browser to see the app.
```

 