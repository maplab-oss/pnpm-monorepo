import type { TRPCInstance } from "@my-org/my-project-server";
import { helloWorld } from "./procedures/helloWorld";

export const createTrpcRouter = (t: TRPCInstance) =>
  t.router({
    helloWorld: helloWorld(t),
  });

export type AppRouter = ReturnType<typeof createTrpcRouter>;
