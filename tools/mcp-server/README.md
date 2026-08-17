# Example MCP server

> **Deprecated (2026-08).** Never adopted in the field across three months of
> practice — the field *consumes* MCP servers, it does not write them. Kept for
> reference; not maintained. See the field verdict in
> [`docs/en/core/03-agent-architecture.md`](../../docs/en/core/03-agent-architecture.md).

A minimal, runnable MCP server. It is a teaching artifact for the **access
layer** of the Mainstay agentic architecture — see
[`docs/en/core/03-agent-architecture.md`](../../docs/en/core/03-agent-architecture.md).

## What an MCP server is, in Mainstay's architecture

The six-layer harness around a model has an **access layer**: instead of
copy-pasting data into the prompt, the agent queries a real source on demand,
through a defined tool contract. An MCP server is that access layer made
concrete. It exposes two kinds of capability:

| Concept | Direction | In this example |
|---|---|---|
| **Resource** | The agent *reads* data | `vault://index` — the vault's Markdown index |
| **Tool** | The agent *invokes* an action with typed arguments | `lookup_decision` — fetch a `DEC-XXX` record |

An MCP server connects the agent to the world without flooding its context:
the agent pulls exactly what it needs, exactly when it needs it.

## What this server exposes

- **Resource `vault://index`** — reads a Markdown file and returns it. Stands
  in for the navigable vault index the agent uses to orient itself.
- **Tool `lookup_decision`** — takes a `decision_id` (`DEC-007` shape) and
  returns a stub decision record. Stands in for "check why a past decision was
  made before contradicting it" — the escalation reflex from the method.

There are no secrets, no network calls, and no real endpoints. The decision
store is an in-memory stub so the example stays self-contained.

## Install and run

Requires Node.js 20+.

```sh
cd tools/mcp-server
npm install
npm start
```

`npm start` runs the TypeScript source directly via `tsx`. To compile to
plain JavaScript first:

```sh
npm run build      # emits dist/server.js
npm run start:built
```

The server speaks JSON-RPC over **stdio**. Started on its own it will print
`mainstay-example-mcp-server is running on stdio.` to stderr and then wait —
that is expected. A real MCP server is driven by a client, not a human.

## How an agent connects

An MCP client (the agent's runtime) launches this server as a child process
and talks to it over stdin/stdout. Registration usually looks like this in the
client's config:

```json
{
  "mcpServers": {
    "mainstay-vault": {
      "command": "node",
      "args": ["--import", "tsx", "src/server.ts"],
      "cwd": "tools/mcp-server"
    }
  }
}
```

Once connected, the agent can:

1. **List resources** and read `vault://index` to get the vault map.
2. **List tools** and call `lookup_decision` with `{ "decision_id": "DEC-007" }`.

Try the call mentally: `lookup_decision` with `DEC-007` returns the
default-view decision; with `DEC-999` it returns an error result. Malformed
ids (anything not matching `DEC-\d{3}`) are rejected by the input schema
before the handler runs — the tool contract is the guardrail.

## Files

| File | Role |
|---|---|
| `src/server.ts` | The server: one resource, one tool, stdio transport. |
| `sample-vault-index.md` | The Markdown file served by `vault://index`. |
| `package.json` | Node project, depends on `@modelcontextprotocol/sdk` + `zod`. |
| `tsconfig.json` | TypeScript config, NodeNext module resolution. |
