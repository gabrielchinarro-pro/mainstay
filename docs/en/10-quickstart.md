# Quickstart

*Two paths to adopt Mainstay — one for a brand-new repository, one for a codebase that already exists — ending with your first feature in 30 minutes.*

Mainstay is not a tool you install; it is a structure you put in place. This chapter gives you the concrete commands and files for both starting points. Pick the path that matches your situation.

- **Path A — Greenfield.** You are starting a new project. Build the monorepo skeleton, the root context file, the `vault/`, the first hook, the first skill.
- **Path B — Existing repo.** You have a working codebase. Retrofit Mainstay without breaking the current flow: seed the vault from the code you already have, add the context file, introduce hooks incrementally, backfill one contract.

Both paths converge on the same end state described in [The Three Pillars](./01-three-pillars.md) and [The Monorepo](./02-monorepo.md): knowledge lives beside code, behaviour is captured in contracts, and guardrails are enforced by hooks.

---

## Path A — Greenfield repo

### A.1 Create the monorepo skeleton

A Mainstay monorepo holds code and knowledge in one repository, one history, one set of reviews. Start with the directory tree.

```bash
mkdir my-project && cd my-project
git init

mkdir -p apps/backend/src apps/backend/docs/database
mkdir -p apps/frontend/src
mkdir -p packages
mkdir -p vault/decisions vault/contracts vault/concepts vault/design-system
mkdir -p skills hooks tools
touch vault/00-index.md
```

The annotated version of this tree lives in `examples/monorepo-skeleton/` in this repository — copy it rather than typing it out. The shape you are aiming for:

```
my-project/
├── AGENTS.md                 # root context file, loaded every session
├── apps/
│   ├── backend/
│   │   ├── src/              # code = source of truth for the schema
│   │   └── docs/database/    # canonical data model, co-located, derived
│   └── frontend/
├── packages/                 # shared types and code
├── vault/                    # knowledge base (navigable mirror)
│   ├── 00-index.md
│   ├── decisions/            # DEC-XXX, dated
│   ├── contracts/            # one per screen, with status
│   ├── concepts/             # business concepts
│   └── design-system/
├── skills/                   # progressively disclosed capabilities
└── hooks/                    # deterministic triggers
```

### A.2 Write the root context file (`AGENTS.md`)

The context file is the memory pillar made operational. It loads at the start of every agent session, so it must be **lean** (only transverse, stable rules) and **layered** (a short root that points to detail loaded on demand). See [The Agentic Architecture](./03-agent-architecture.md) for the discipline behind this.

```markdown
# Project context

## Commands
- Build:  `npm run build`
- Test:   `npm run test`
- Lint:   `npm run lint`

## Architecture
- Monorepo. Backend in `apps/backend`, frontend in `apps/frontend`.
- The code is the source of truth for the data schema.
- Shared types live in `packages/` — never duplicate a type.

## Conventions
- Naming: kebab-case files, PascalCase components.
- Every screen has a contract in `vault/contracts/`.

## Permanent prohibitions
- Never edit a frozen contract without a new decision.
- Never invent a label or value — fetch it from its source of truth.
- Never run a destructive command without explicit confirmation.

## Going further (loaded on demand)
- Backend detail:  ./apps/backend/docs/
- Decisions:       ./vault/decisions/
- Design system:   ./vault/design-system/
```

Keep this file under roughly 100 lines. Anything feature-specific belongs in a contract, not here.

### A.3 Seed the vault

The vault is the navigable mirror over the code (see [The Monorepo](./02-monorepo.md)). On a greenfield repo it starts almost empty — that is fine — but `00-index.md` should exist from day one so every agent knows where to look.

```markdown
<!-- vault/00-index.md -->
# Vault index

- [Decisions](./decisions/)   — dated DEC-XXX records
- [Contracts](./contracts/)   — one signed contract per screen
- [Concepts](./concepts/)     — business concepts and glossary
- [Design system](./design-system/) — colours, type, spacing, components
```

Add at least one design-system note before you generate any prototype. An agent with no design system invents one, and an invented design system is a field of grey zones.

### A.4 Add the first hook

A hook is a deterministic trigger attached to an event in the agent's cycle. The most valuable first hook runs the formatter and linter after every edit — it turns a good practice into a guarantee and starts the [self-correction loop](./14-cicd-and-hooks.md).

```bash
# hooks/post-edit-format.sh
#!/usr/bin/env bash
# Trigger: after every file edit by an agent.
# Effect: format and lint the changed files; non-zero exit returns to the agent.
set -euo pipefail

npm run lint -- --fix
npm run format

echo "post-edit: format + lint passed"
```

```bash
chmod +x hooks/post-edit-format.sh
```

Register the hook with your agent runtime according to its configuration (the mechanism varies; the contract is "run this script after the edit event"). The `hooks/` directory in this repository contains ready-to-copy examples, each with a header comment naming its trigger event.

### A.5 Add the first skill

A skill is a folder that encapsulates a reusable capability with progressive disclosure: the agent loads its content only when a task triggers it. A skill is procedural memory, where the context file is declarative memory.

```
skills/contract-review/
├── SKILL.md
└── checklist.md
```

```markdown
<!-- skills/contract-review/SKILL.md -->
---
name: contract-review
description: >
  Review a screen contract for completeness before signing.
  Triggers when the user asks to review, sign, or freeze a contract.
---

# Contract review

When asked to review a contract:
1. Confirm all twelve sections are filled (see ./checklist.md).
2. Flag any section that defers a decision ("TBD", "later").
3. Verify endpoints carry payloads, return codes, and test data.
4. Refuse to mark `status: frozen` unless both signatures are present.
```

The `skills/` directory in this repository ships example skills with their scripts — copy and adapt.

---

## Path B — Existing repo

You already have a codebase that ships. The goal is to retrofit Mainstay **without a big-bang rewrite** and without breaking anyone's flow. Introduce it in four incremental moves.

### B.1 Seed the vault from current code

You do not write the vault from imagination — you extract it from what exists. The first flow of knowledge is **extracted from code** (schema, types, routes); the second is **added by humans** (decisions, contracts, concepts).

```bash
mkdir -p vault/decisions vault/contracts vault/concepts vault/design-system
touch vault/00-index.md
```

Then run a one-off extraction pass. Point an exploration subagent (read-only) at the repository and ask it for a faithful synthesis — see the explore-vs-edit split in [Multi-Agent Orchestration](./11-multi-agent-orchestration.md).

```text
EXPLORE (read-only) the repository and produce:
- A list of every screen/route currently shipped.
- The current data schema, read from migrations and entity files.
- The de-facto design tokens (colours, spacing, type) found in the code.
Return a compact synthesis. Do NOT edit any file.
```

Write the synthesis into `apps/backend/docs/database/` (the schema) and `vault/design-system/` (the tokens). This is your starting truth. It will be imperfect; mark genuine gaps `<!-- TODO: confirm -->` rather than guessing.

### B.2 Add the context file without breaking flow

Drop an `AGENTS.md` at the repo root using the template from A.2, but describe the repo **as it is today**, not as you wish it were. The context file is descriptive first; it becomes prescriptive over time.

A safe starting `AGENTS.md` on a legacy repo:

```markdown
# Project context

## Commands
- Build / test / lint: <real commands here>

## Architecture (current state)
- Describe the actual layout, including the parts you dislike.
- Mark known-bad areas: "legacy module X — do not extend, see DEC-001".

## Conventions
- Document conventions that are actually followed, not aspirational ones.

## Permanent prohibitions
- Never edit `<sensitive area>` without review.
- Never invent a value — fetch it from its source.
```

This file changes nothing about how humans work. It only gives agents a stable starting point.

### B.3 Introduce hooks incrementally

Do not enable a blocking hook on day one — a noisy hook that fails on pre-existing problems gets disabled and never comes back. Introduce hooks in three stages:

| Stage | Hook mode | Effect |
|---|---|---|
| Week 1 | Advisory | Hook runs, prints findings, never blocks. |
| Week 2–3 | Blocking on new code | Hook fails only for files the change touched. |
| Week 4+ | Blocking repo-wide | Full enforcement once the baseline is clean. |

Start with `post-edit-format.sh` from A.4 in advisory mode. Add the doc/schema sync hook (see [CI/CD & Hooks](./14-cicd-and-hooks.md)) once `apps/backend/docs/database/` reflects reality.

### B.4 Backfill the first contract

Do not try to write a contract for every screen. Pick **one screen you are about to change** and write its contract just before the change. This pays for itself immediately and teaches the team the format.

1. Copy the contract template from `templates/contract.md` into `vault/contracts/<screen-id>.md`.
2. Fill the visual source-of-truth section with a link to the current screen.
3. Fill behaviour, edge cases, permissions, endpoints from how the screen works **today**.
4. Run a grey-zone scan (see [Grey Zones](./07-grey-zones.md)) — every "I'm not sure how this behaves" is a grey zone to resolve before you touch the code.
5. Get the product and engineering signatures, set `status: frozen`.

From here, every new feature follows the full delivery chain. The vault grows one contract at a time, exactly when each contract is needed.

---

## Your first feature in 30 minutes

Both paths converge here. To go end to end on a real, small feature, follow the worked example in `examples/walkthrough/`. It builds the **Saved Views** feature on a generic data-table screen — a user saves a named combination of filters, sort, and visible columns, marks one as default, and keeps it private or shares it.

The walkthrough's eight artifacts mirror the delivery chain:

| Artifact | Chain step |
|---|---|
| `00-vault-entry.md` | Step 0 — the concept already in the vault |
| `01-prototype-prompt.md` | Step 1 — single-prompt prototype |
| `02-grey-zone-scan.md` | Step 2 — grey-zone validation |
| `03-contract.md` | Step 3 — the frozen, signed contract |
| `04-api-spec.yaml` | Step 4 — the API spec, frozen first |
| `05-mocks/` | Step 4 — mocks and types from the spec |
| `06-decision-DEC-007.md` | Step 6 — a decision returned to the vault |
| `07-definition-of-done.md` | Step 5 — the per-layer DoD, fully checked |

Two of its grey zones became formal decisions: `DEC-007` (default-view behaviour) and `DEC-011` (private vs shared visibility). Read the walkthrough's `README.md` first; it narrates the thirty minutes step by step.

---

## See also

- [The Monorepo: Home of Knowledge](./02-monorepo.md)
- [The Delivery Chain](./05-the-delivery-chain.md)
- [CI/CD & Hooks](./14-cicd-and-hooks.md)
- [Team Adoption](./15-team-adoption.md)
