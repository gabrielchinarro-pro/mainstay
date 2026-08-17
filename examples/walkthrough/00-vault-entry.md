---
type: concept
id: CON-saved-views
title: "Saved Views"
status: active
created_on: 2026-05-08
related_screens: [saved-views-panel]
related_decisions: []
---

# Concept · Saved Views

> A business concept note. It pre-exists in the vault before any prototype is
> drawn. It explains *what the feature is and why it matters*, never how it
> looks or how it is built. The visual is the prototype's job; the behaviour
> is the contract's job.

## What it is

A **saved view** is a named, reusable combination of the three things a user
sets up on a data-table screen:

1. **Filters**: which rows are shown.
2. **Sort**: the order rows appear in.
3. **Visible columns**: which columns are shown, and in what order.

Instead of reconfiguring the table every session, a user saves that
configuration once, names it, and recalls it in one click.

## Why it matters

Users of data-heavy screens return to the same handful of table setups every
day. Rebuilding a filter set by hand is slow, error-prone, and forgettable.
Saved views turn a repeated chore into a single action, and make a setup
shareable so a workspace converges on common ways of looking at the data.

## Vocabulary

| Term | Meaning |
|---|---|
| **Saved view** | A named, stored table configuration owned by one user. |
| **Default view** | The view applied automatically when the user opens the screen. |
| **Private view** | Visible only to its owner. |
| **Shared view** | Visible to everyone in the owner's workspace. |
| **Owner** | The user who created the view; the only one who may edit or delete it. |

## Behavioural intent (not yet specified)

The concept note records *intent*, not specification. The following points
are deliberately open: they are exactly what the prototype and the grey-zone
scan will surface and the contract will pin down:

- A user can mark one view as their default.
- A view can be kept private or shared with the workspace.
- A view has a name; names should be meaningful and not collide confusingly.

These open points are why this concept later spawns decisions **DEC-007**
(default-view behaviour) and **DEC-011** (private vs shared visibility).

## Scope boundaries

- **In scope:** filters, sort, visible columns; naming; default; private vs
  shared.
- **Out of scope:** column width, pagination size, cross-screen views,
  scheduling or exporting a view. <!-- TODO: confirm; source concept note is
  silent on whether exporting is a future phase. -->

## Related artifacts

- Screen contract: [`saved-views-panel`](./03-contract.md)
- Prototype prompt: [`01-prototype-prompt.md`](./01-prototype-prompt.md)
- Decisions: [DEC-007](./06-decision-DEC-007.md), [DEC-011](./06-decision-DEC-011.md)
