# MongoDB Setup

This guide covers setting up MongoDB for your application.

## Environment Variables

This extension adds the following environment variables:

| Variable | Services | Secret | Notes |
|----------|----------|--------|-------|
| `MONGODB_URL` | backend, worker | Yes | Connection string to shared MongoDB Atlas cluster |

## After Adding This Extension

Update the following files:

### 1. docs/env-vars.md

Add to the registry table:

```markdown
| `MONGODB_URL` | MongoDB connection string | backend, worker | Yes | Yes | Yes | Yes |
```

### 2. deployment-runbook.md

Add `MONGODB_URL` to the secrets table.

## Local Development

Add to `zap.yaml`:

```yaml
docker:
  mongodb:
    image: mongo:latest
    ports:
      - "27017:27017"
    volumes:
      - mongodb-data:/data/db
```

Add to `.env.local`:
```bash
MONGODB_URL=mongodb://localhost:27017/helloworld?directConnection=true
```

## Dependencies

```bash
pnpm add mongodb
```

## Connection Setup

Create a connection manager in your app:

```typescript
// apps/backend/src/db.ts
import { MongoClient, type Db } from "mongodb";

let client: MongoClient | null = null;

export const getMongoClient = async (url: string): Promise<MongoClient> => {
  if (client) return client;
  client = new MongoClient(url);
  await client.connect();
  return client;
};

export const getDb = async (url: string): Promise<Db> => {
  const c = await getMongoClient(url);
  return c.db();
};

export const closeDb = async () => {
  if (client) {
    await client.close();
    client = null;
  }
};
```

Wire it up in your app startup:

```typescript
import { env } from "./config";
import { getDb, closeDb } from "./db";

const db = await getDb(env.MONGODB_URL);

// Graceful shutdown
process.on("SIGTERM", async () => {
  await closeDb();
  process.exit(0);
});
```

## Usage

```typescript
const users = db.collection("users");
await users.insertOne({ name: "Alice" });
const user = await users.findOne({ name: "Alice" });
```
