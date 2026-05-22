/**
 * Mainstay example MCP server
 * =============================
 *
 * An MCP server is the "access layer" of the agentic architecture (see
 * docs/en/03-agent-architecture.md, §3.4). Instead of pasting data into the
 * prompt, the agent calls a structured endpoint with a defined tool contract.
 *
 * This file is a deliberately minimal, heavily commented example. It exposes
 * exactly two things so you can learn the shape of an MCP server without noise:
 *
 *   1. ONE resource  — `vault://index`
 *      A resource is read-only data the agent can pull on demand. Here it
 *      returns the contents of a Markdown vault index file.
 *
 *   2. ONE tool       — `lookup_decision`
 *      A tool is an action the agent invokes with typed arguments. Here, given
 *      a decision id like `DEC-007`, it returns a stub decision record.
 *
 * Transport: stdio. The agent launches this process and speaks JSON-RPC over
 * stdin/stdout. There are no network calls, no secrets, no real endpoints.
 *
 * Run it:  npm install && npm start
 */

import { readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

// The MCP SDK. `McpServer` is the high-level server; the transport carries
// the JSON-RPC messages. We import the stdio transport because the agent
// spawns this server as a child process.
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";

// `zod` describes the shape of tool inputs. The MCP SDK turns a zod schema
// into a JSON Schema the agent sees, and validates incoming arguments against
// it before your handler ever runs.
import { z } from "zod";

// Resolve paths relative to this file so the server works from any cwd.
const __dirname = dirname(fileURLToPath(import.meta.url));

// The Markdown file the `vault://index` resource serves. In a real monorepo
// this would point at `vault/00-index.md`. Here we ship a tiny sample file
// next to the source so the example is self-contained.
const VAULT_INDEX_PATH = resolve(__dirname, "..", "sample-vault-index.md");

/**
 * A stub "database" of decision records.
 *
 * A real server would query the vault, a database, or an internal API behind
 * this lookup. The point of the example is the *tool contract*, not the store.
 */
const DECISION_STORE: Record<
  string,
  { id: string; title: string; date: string; status: string; summary: string }
> = {
  "DEC-007": {
    id: "DEC-007",
    title: "Default saved view: per-user, not per-workspace",
    date: "2026-05-14",
    status: "accepted",
    summary:
      "The default view is a per-user preference. Marking a view as default " +
      "never changes what other users see.",
  },
  "DEC-011": {
    id: "DEC-011",
    title: "Saved view visibility: private by default, shareable to workspace",
    date: "2026-05-15",
    status: "accepted",
    summary:
      "A new saved view is private. The owner may switch it to workspace " +
      "visibility; shared views are read-only for non-owners.",
  },
};

// --------------------------------------------------------------------------
// 1. Create the server. `name` and `version` are advertised to the agent
//    during the MCP handshake so it knows what it connected to.
// --------------------------------------------------------------------------
const server = new McpServer({
  name: "mainstay-example-mcp-server",
  version: "0.1.0",
});

// --------------------------------------------------------------------------
// 2. Register the resource: `vault://index`.
//
//    Signature: registerResource(name, uri, metadata, handler).
//    The handler returns `contents`, an array of { uri, mimeType, text }.
//    The agent reads the resource by its URI when it needs the vault map.
// --------------------------------------------------------------------------
server.registerResource(
  "vault-index",
  "vault://index",
  {
    title: "Vault index",
    description: "The navigable index of the knowledge vault (Markdown).",
    mimeType: "text/markdown",
  },
  async (uri) => {
    // Read the Markdown file from disk. If it is missing we surface a clear
    // message rather than crashing the server — a degraded resource is more
    // useful to the agent than a dead connection.
    let text: string;
    try {
      text = await readFile(VAULT_INDEX_PATH, "utf8");
    } catch {
      text = "# Vault index\n\n_(index file not found — this is a stub.)_\n";
    }
    return {
      contents: [
        {
          uri: uri.href,
          mimeType: "text/markdown",
          text,
        },
      ],
    };
  },
);

// --------------------------------------------------------------------------
// 3. Register the tool: `lookup_decision`.
//
//    Signature: registerTool(name, config, handler).
//    `inputSchema` is a map of zod validators — this IS the tool contract.
//    The handler returns `content`, an array of typed blocks (here, text).
//    `isError: true` marks a result the agent should treat as a failure.
// --------------------------------------------------------------------------
server.registerTool(
  "lookup_decision",
  {
    title: "Look up a decision record",
    description:
      "Given a decision id (format DEC-XXX), return the matching decision " +
      "record from the vault. Use this to check why a past choice was made " +
      "before contradicting it.",
    inputSchema: {
      // The agent must pass `decision_id`. The regex rejects malformed ids
      // before the handler runs, so the handler only ever sees `DEC-###`.
      decision_id: z
        .string()
        .regex(/^DEC-\d{3}$/, "decision_id must look like DEC-007")
        .describe("The decision identifier, e.g. DEC-007."),
    },
  },
  async ({ decision_id }) => {
    const record = DECISION_STORE[decision_id];

    // Not found: return a result flagged as an error. The tool call still
    // "succeeded" at the protocol level — the agent gets a clear answer.
    if (!record) {
      return {
        isError: true,
        content: [
          {
            type: "text",
            text: `No decision found for ${decision_id}.`,
          },
        ],
      };
    }

    // Found: return the record as pretty-printed JSON inside a text block.
    return {
      content: [
        {
          type: "text",
          text: JSON.stringify(record, null, 2),
        },
      ],
    };
  },
);

// --------------------------------------------------------------------------
// 4. Connect over stdio and start serving.
//
//    `connect` wires the server to the transport and begins the handshake.
//    From here on, the agent drives: it lists resources/tools and calls them.
// --------------------------------------------------------------------------
async function main(): Promise<void> {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  // IMPORTANT: log to stderr, never stdout. stdout is the JSON-RPC channel;
  // a stray line there corrupts the protocol.
  console.error("mainstay-example-mcp-server is running on stdio.");
}

main().catch((error) => {
  console.error("Fatal error starting MCP server:", error);
  process.exit(1);
});
