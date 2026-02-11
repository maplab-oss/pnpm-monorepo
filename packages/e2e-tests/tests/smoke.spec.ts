import { test, expect } from "@playwright/test";

test("frontend loads and tRPC data renders", async ({ page }) => {
  await page.goto("/");
  const message = page.locator("p");
  await expect(message).not.toBeEmpty();
});
