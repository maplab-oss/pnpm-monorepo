# My Project

A modern full-stack application template.

## Packages

- **`core`** - Browser-safe code: types, constants, schemas, pure functions. Safe to import anywhere including frontend.
- **`server`** - Node.js-only infrastructure: tRPC instance (`t`), logger, context types. Only import from backend.
- **`trpc`** - The tRPC router and procedures. Exports `createTrpcRouter` and `AppRouter` type.

See [modular-monolith.md](docs/modular-monolith.md) for the architecture philosophy.

## Running the Project

The project may well already be running in the background. Check and manage with:

```bash
zap ps
zap start someservice
zap logs someservice --no-follow
zap restart someservice
```

Check [zapper-usage.md](docs/zapper.md) for more details on running servers, restarting, viewing logs.

## Documentation

Read these before making changes:

- **[style-guide.md](docs/style-guide.md)** - For significant code changes
- **[crud.md](docs/crud.md)** - For implementing simple CRUD patterns
- **[errors.md](docs/errors.md)** - For throwing and handling errors
- **[trpc.md](docs/trpc.md)** - For doing frontend queries/mutations
- **[logging.md](docs/logging.md)** - For logging on backend (via tRPC context) and frontend
- **[event-schema.md](docs/event-schema.md)** - For sending/storing any kind of events: errors, logs, analytics, real time events follow this

## Extending

If you need to add things to this project, like new services, databases, or integrations, read [zapper-usage.md](docs/zapper.md) about processes/docker and check the `docs/extensions` directory to see if any of those are applicable.

## UI

The frontend uses [shadcn/ui](https://ui.shadcn.com/) for UI components. Add new components with `npx shadcn@latest add <component>` from the `apps/frontend` directory.

Always use shadcn/ui where possible, including utilities like `cn` for conditional classnames.

## Agent Responsibility

You are expected to check logs, check which services are running, and help with development tasks. The developer will do most of the manual testing. You can test for debugging purposes.

All the servers have hot reloading so you would not need to restart after every code change. If something big or low level changes; or it seems broken it can be worth restarting.

IMPORTANT: `.env.local` is for non-secrets, its ok for you to view and edit it! The regular `.env` is for secrets so leave that to the dev, just ask them to update secrets.

## Validation

For small changes, run `zap t check` to run linting and typechecking. For bigger system level changes run that and also `zap t build` to check that all the builds still succeed.
