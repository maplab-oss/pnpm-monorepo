FROM node:22-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/backend/package.json apps/backend/
COPY packages/core/package.json packages/core/
COPY packages/server/package.json packages/server/
COPY packages/trpc/package.json packages/trpc/

RUN pnpm install --frozen-lockfile

COPY apps/backend apps/backend
COPY packages packages
COPY etc/tsconfig.base.json etc/tsconfig.base.json

ENV NODE_ENV=production
ENV APP_ENV=production

EXPOSE 8080

CMD ["pnpm", "--filter=@my-org/my-project-backend", "start"]
