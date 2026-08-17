---
type: decision
id: DEC-011
date: 2026-05-15
status: accepted
supersedes: null
related_screens: [saved-views-panel]
---

# DEC-011 · Saved views are private by default and read-only when shared

## Context

The grey-zone scan of `saved-views-panel`
([`02-grey-zone-scan.md`](./02-grey-zone-scan.md), rows 3 and 4) surfaced two
linked unknowns about visibility:

- The create form's visibility radio pair had its **first option pre-selected**,
  so a new view defaulted to "Shared with workspace"; nobody specified the
  default selection.
- The prototype's 3-dot menu offered **Edit and Delete to every viewer**,
  including non-owners of a shared view; the concept note said the owner
  edits and deletes, but the brief did not restrict the menu.

Visibility and permissions cut across every saved view, so this is a formal
decision.

## Decision

A saved view is **private by default**. Sharing is an explicit opt-in: the
owner must actively switch the view to workspace visibility. A workspace-shared
view is **read-only for everyone except its owner**: non-owners may only
*apply* it (and set it as their own default, per DEC-007). Edit, Delete, and
changing visibility are owner-only actions.

## Justification

- Defaulting to "shared" risks leaking a half-built or personal view to the
  whole workspace the moment it is saved. Private-by-default fails safe.
- A view that anyone could edit would have no stable owner and no accountable
  source of truth: the same "two truths" anti-pattern the method warns
  against.
- Read-only sharing still delivers the concept's value (a workspace converging
  on common table setups) without the ambiguity of shared write access.

## Consequences

- **Design / prototype:** in the create/edit form the "Private" radio is
  pre-selected. For a non-owner viewing a shared view, the 3-dot menu shows
  only "Apply" and "Set as default"; Edit, Delete and the visibility control
  are hidden.
- **Contract (`saved-views-panel`):** §8 Permissions table encodes
  owner-vs-non-owner rights; §5 specifies the default radio selection; §7
  covers the non-owner menu.
- **API / code:** `SavedViewCreate.visibility` is optional and defaults to
  `private`. `PATCH`/`DELETE /v1/saved-views/{id}` return `403 forbidden` when
  the caller is not the owner. `GET /v1/saved-views` returns the caller's
  private views plus all workspace-shared views.
- **Relation to DEC-007:** independent but compatible. Visibility governs
  *who can see and edit* a view; DEC-007 governs *whose default* it is.
