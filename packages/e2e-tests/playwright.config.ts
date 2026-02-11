import { defineConfig, devices } from "@playwright/test";

const frontendPort = process.env.FRONTEND_PORT || "6234";

export default defineConfig({
  testDir: "./tests",
  fullyParallel: false,
  forbidOnly: !!process.env.CI,
  retries: 0,
  workers: 1,
  reporter: "list",
  timeout: 15000,
  expect: { timeout: 5000 },
  use: {
    baseURL: `http://localhost:${frontendPort}`,
    trace: "on-first-retry",
  },
  projects: [{ name: "chromium", use: { ...devices["Desktop Chrome"] } }],
});
