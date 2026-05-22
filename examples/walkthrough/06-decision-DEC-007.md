---
type: decision
id: DEC-007
date: 2026-05-14
status: accepted
supersedes: null
related_screens: [saved-views-panel]
---

# DEC-007 — Default saved view is a per-user preference

## Context

The grey-zone scan of `saved-views-panel`
([`02-grey-zone-scan.md`](./02-grey-zone-scan.md), rows 1 and 2) surfaced two
linked unknowns:

- On opening the screen, the prototype applied the **first view in the list** —
  nobody specified what should happen on first load.
- The prototype's "Set as default" action appeared to change the default
  **for the whole workspace** — the concept note said a user marks "their"
  default but never said whether "default" is per-user or per-workspace.

Both touch every user of the screen, so this is a formal decision, not a
local contract note.

## Decision

The default saved view is a **per-user preference**. Marking a view as default
sets it only for the user who performed the action and never changes what any
other user sees. On opening the screen, the user's own default view is applied
automatically if they have one; if they do not, no view is applied and the
raw table is shown.

## Justification

- A workspace-wide default would let one member silently reframe the screen
  for everyone — a surprising, unowned side effect.
- Users build saved views around their own recurring tasks; "default" is
  inherently personal.
- A per-user default keeps the "Set as default" action safe: its blast radius
  is exactly one user, the one who clicked it.
- Showing the raw table when there is no default avoids inventing a choice
  (e.g. silently picking the first or most-recent view), which would itself be
  a new grey zone.

## Consequences

- **Design / prototype:** the "Default" badge reflects the *current user's*
  default only. Each user may see the badge on a different row.
- **Contract (`saved-views-panel`):** §4 states first-load behaviour; §9
  records that deleting the default view clears that user's default; §6
  documents `POST /v1/saved-views/{id}/default` as a per-user action.
- **API / code:** the default is stored per `(user_id, view_id)`, not on the
  view itself. `SavedView.is_default` in a response is resolved relative to
  the **calling user**. Setting a new default automatically unsets that user's
  previous default.
- **Shared views:** a user may set a workspace-shared view they do not own as
  *their* default; this does not affect the owner or anyone else.
