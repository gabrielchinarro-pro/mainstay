# Monorepo skeleton

An annotated directory tree for a monorepo built the Mainstay way. This is
**illustrative**, not runnable code — it expands the "Structure type" from the
method into a fully commented layout you can copy as a starting point.

The one rule it encodes: **knowledge lives beside the code, versioned with it,
and the code stays the source of truth for everything technical.**

```
monorepo/
├── AGENTS.md                       # Root context file: loaded at the start of
│                                   #   every agent session. Lean and layered —
│                                   #   only cross-cutting, stable rules. Points
│                                   #   to the detailed files below.
├── README.md                       # Human entry point: what the repo is, how
│                                   #   to build and run it.
│
├── apps/                           # Deployable applications.
│   ├── backend/
│   │   ├── src/                    # Back-end code. THE source of truth for the
│   │   │   ├── entities/           #   data schema: entities define the model.
│   │   │   ├── migrations/         #   Schema migrations — the schema's history.
│   │   │   └── routes/             #   API route handlers.
│   │   ├── docs/
│   │   │   └── database/           # Canonical data-model docs, co-located with
│   │   │                           #   the back. DERIVED from src/ — regenerated,
│   │   │                           #   never hand-edited to diverge from code.
│   │   └── tests/                  # Back-end tests.
│   └── frontend/
│       ├── src/                    # Front-end code.
│       │   ├── components/         #   UI components.
│       │   ├── screens/            #   Screen-level views (one per contract).
│       │   └── api/                #   API client; consumes generated types.
│       ├── mocks/                  # Generated mock fixtures + types, derived
│       │                           #   from the frozen API spec (contract-first).
│       └── tests/                  # Front-end tests.
│
├── packages/                       # Shared, versioned code used by both apps.
│   ├── types/                      #   Shared TypeScript types.
│   └── config/                     #   Shared lint / build / tsconfig presets.
│
├── vault/                          # The knowledge vault: the navigable mirror
│   │                               #   on top of the code. Adds meaning, never
│   │                               #   contradicts the code.
│   ├── 00-index.md                 #   Vault index — the map of everything below.
│   ├── decisions/                  #   Dated decision records (DEC-XXX).
│   │   ├── DEC-007.md              #     e.g. default-view behaviour.
│   │   └── DEC-011.md              #     e.g. private-vs-shared visibility.
│   ├── contracts/                  #   One frozen contract per screen, with
│   │   └── saved-views-panel.md    #     status + double signature in frontmatter.
│   ├── concepts/                   #   Business concept notes (the "what" / "why").
│   │   └── saved-views.md
│   └── design-system/              #   Tokens, components, copy rules — the
│                                   #     visual source of truth for prototypes.
│
├── skills/                         # Reusable agent capabilities (progressive
│   └── <skill-name>/               #   disclosure: loaded only when triggered).
│       ├── SKILL.md                #     Instructions + YAML frontmatter.
│       └── scripts/                #     Optional helper scripts.
│
├── hooks/                          # Deterministic triggers on agent-cycle
│   │                               #   events — they run, they do not ask.
│   ├── post-edit-format.sh         #   After each edit: format + lint.
│   ├── pre-commit-test.sh          #   Before each commit: run the test suite.
│   └── post-migration-doc-sync.sh  #   After a migration: block the merge until
│                                   #     docs/database/ is back in sync.
│
├── tools/                          # Project tooling.
│   ├── mcp-server/                 #   MCP server: the agent's access layer.
│   └── spec-to-mocks/              #   OpenAPI -> types + mocks generator.
│
└── .github/                        # CI workflows, issue and PR templates —
                                    #   where blocking checks enforce the DoD.
```

## How the two knowledge flows show up here

- **Extracted from code:** `apps/backend/src/` (entities, migrations) is the
  schema's source of truth. `apps/backend/docs/database/` is *derived* from it
  — a `hooks/post-migration-doc-sync.sh` check keeps the two in lockstep.
- **Added by humans and agents:** `vault/decisions/`, `vault/contracts/`,
  `vault/concepts/` hold what the code cannot carry — the *why*, the agreed
  behaviour, the meaning. The vault indexes and explains; it never overrides
  the code on a technical fact.

Because both flows live in the same repo, an agent reads real code and the
knowledge around it in one place — no external wiki, no doc that quietly went
stale three months ago.
