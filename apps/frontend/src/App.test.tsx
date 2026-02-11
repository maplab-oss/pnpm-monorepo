import { describe, it, expect, vi, beforeEach } from "vitest";
import { render, screen, waitFor } from "@testing-library/react";
import { App } from "./App";
import { trpc } from "./trpc";

vi.mock("./trpc", () => ({
  trpc: {
    helloWorld: {
      query: vi.fn(),
    },
  },
}));

describe("App", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("should render the message from the API", async () => {
    vi.mocked(trpc.helloWorld.query).mockResolvedValueOnce({
      message: "My project",
    });

    render(<App />);

    await waitFor(() => {
      expect(screen.getByText("My project")).toBeInTheDocument();
    });

    expect(trpc.helloWorld.query).toHaveBeenCalledTimes(1);
  });
});
