<!--
  TEMPLATE: vault index
  COPY TO: vault/00-index.md

  The vault is the navigable mirror over the code: decisions, screen contracts,
  business concepts, the design system, and the links between them. It never
  contradicts the code; on technical facts, the code wins. The vault is the
  layer of meaning on top of the layer of truth.

  This index is the entry point. An agent reads it to orient itself inside the
  vault. Keep it current: a stale index sends agents to the wrong place. Prefer
  to keep the index thin and let the linked files carry detail.

  Fill every <PLACEHOLDER>. Delete these comments.
-->

# Vault Index · <PROJECT_NAME>

The vault is the navigable mirror of this repository's knowledge. It holds the
decisions, screen contracts, concepts, and design system. It does not hold
technical truth: for the data schema, types, and routes, read the code.

Start here, then follow the links below.

## How the vault is organised

| Folder | Holds | Source of truth for |
|---|---|---|
| `decisions/` | `DEC-XXX` notes, dated and justified | settled rules and trade-offs |
| `contracts/` | one contract per screen, with a status | screen behaviour and acceptance |
| `concepts/` | business concept notes | shared domain vocabulary |
| `design-system/` | tokens, components, patterns | visual conventions |

For technical facts (table shapes, types, routes), see
`apps/backend/docs/database/` and the code itself, not the vault.

## Decisions

<!-- List every decision, newest first. Keep status visible so an agent does
     not act on a superseded rule. -->
| ID | Title | Date | Status |
|---|---|---|---|
| [DEC-XXX](./decisions/DEC-XXX.md) | <short title> | YYYY-MM-DD | accepted |
| <...> | | | |

## Contracts

<!-- One row per screen. Status tells an agent whether the contract can be
     built against (`frozen`) or is still moving (`draft` / `review`). -->
| Screen | Contract | Status | Related decisions |
|---|---|---|---|
| `<screen-id>` | [contract](./contracts/<screen-id>.md) | draft | <DEC-XXX, ...> |
| <...> | | | |

## Concepts

<!-- The domain vocabulary. Link each concept note. -->
- [<Concept name>](./concepts/<concept>.md): <one-line gloss>.
- <...>

## Design system

<!-- Pointers into the design-system folder. -->
- [Tokens](./design-system/tokens.md): colours, typography, spacing, radii.
- [Components](./design-system/components.md): the reusable component catalogue.
- [Patterns](./design-system/patterns.md): layout and interaction patterns.

## Conventions for the vault itself

- Every contract and decision carries YAML frontmatter with English keys.
- A frozen contract is never edited in place; a change goes through a new
  decision and a version bump.
- A decision is never edited in place; it is superseded by a newer decision.
- This index is updated in the same commit as any file it should list.

<!--
  KEEP THIS INDEX CURRENT. A new contract or decision that is not listed here
  is effectively invisible to an agent navigating the vault.
-->
