import { message } from "@my-org/my-project-core";
import type { TRPCInstance } from "@my-org/my-project-server";

export const helloWorld = (t: TRPCInstance) =>
  t.procedure.query(() => {
    return { message };
  });
