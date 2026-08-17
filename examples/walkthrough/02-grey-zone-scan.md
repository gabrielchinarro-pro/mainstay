---
type: grey-zone-scan
screen: saved-views-panel
prototype_reviewed: 2026-05-12
brief: 01-prototype-prompt.md
---

# Grey-zone scan · `saved-views-panel`

> Step 2 of the delivery chain. A **grey zone** is anything the agent decided
> on its own because neither the prototype prompt nor the concept note told it
> what to do. Not a bug, not a right answer: a choice made by default, in the
> shadows, by something without the authority to make it.
>
> The protocol: compare the validated prototype to the brief, item by item,
> state by state. For every observable element, one question: *did the brief
> ask for this explicitly?* Yes: pass. No: it is a grey zone, and it gets one
> of exactly two outcomes.

## The two outcomes (never a third)

- **Formal decision**: the stakes are cross-cutting; it becomes a dated,
  justified `DEC-XXX` in the vault and a reusable rule.
- **Contract note**: the stakes are local; it is recorded as an explicit
  line in the screen contract and nowhere else.

"We'll decide later" is not an outcome. Fifteen unresolved grey zones are
fifteen bombs that detonate together at integration.

## The ledger

| ID | Grey zone observed in the prototype | Why it is grey | Outcome | Resolution |
|---|---|---|---|---|
| GZ-01 | On first load the prototype applies the **first view in the list**. | The brief never said which view, if any, is applied automatically on open. The concept mentions a "default view" but not first-load behaviour. | **Formal decision** | → [DEC-007](./06-decision-DEC-007.md): on open, apply the user's default view if one exists; otherwise apply no view (raw table). |
| GZ-02 | The "Set as default" action in the prototype appeared to change the default **for everyone**. | The concept says a user marks "their" default but does not say if "default" is per-user or per-workspace. | **Formal decision** | → [DEC-007](./06-decision-DEC-007.md): the default is a per-user preference; marking a default never affects other users. |
| GZ-03 | A newly created view defaulted to **"Shared with workspace"** because the radio's first option was pre-selected. | The brief lists the radio pair but never says which option is selected by default. | **Formal decision** | → [DEC-011](./06-decision-DEC-011.md): a new view is **private** by default; sharing is an explicit opt-in. |
| GZ-04 | In the prototype, a non-owner viewing a **shared** view could open Edit and Delete. | The concept says the owner edits/deletes, but the brief's 3-dot menu showed all actions for all viewers. | **Formal decision** | → [DEC-011](./06-decision-DEC-011.md): shared views are read-only for non-owners; Edit/Delete/Set-as-default are owner-only. Non-owners may only Apply. |
| GZ-05 | The prototype allowed two views with the **same name**. | The concept says names "should not collide confusingly" but sets no rule. | **Contract note** | Recorded in the contract, §9 Business rules: view names are unique per user, case-insensitive; a duplicate is rejected with code `validation_failed`. |
| GZ-06 | On Delete, the prototype removed the row **with no confirmation**. | The brief's menu lists "Delete" but says nothing about a confirmation step. | **Contract note** | Recorded in the contract, §7 Edge cases: Delete asks for an inline confirmation ("Delete this view?") before the request is sent. |
| GZ-07 | Deleting the **current default view** left the screen with no default and no message. | Neither brief nor concept covers what happens to "default" when the default view is deleted. | **Contract note** | Recorded in the contract, §9 Business rules: deleting the default view simply clears the user's default; next open shows the raw table (consistent with DEC-007). |
| GZ-08 | The empty-state copy "No saved views yet" was rendered for both **loading-finished-empty** and a **failed load** before the error state was wired. | Transient: the error state was specified; this was a pass-1 artifact. | **No action** | Not a grey zone: the brief specifies a distinct error state; pass 3 wired it. Logged for traceability only. |

## Roll-up

- **2 formal decisions** raised: DEC-007 (rows GZ-01, GZ-02) and DEC-011 (rows GZ-03, GZ-04).
- **3 contract notes** raised: rows GZ-05, GZ-06, GZ-07, folded into
  [`03-contract.md`](./03-contract.md) §7 and §9.
- **1 non-issue** (row GZ-08), logged and closed.

Every row has an outcome. The scan is closed; the contract can be written.

## See also

- Prototype prompt: [`01-prototype-prompt.md`](./01-prototype-prompt.md)
- Contract: [`03-contract.md`](./03-contract.md)
- Decisions: [DEC-007](./06-decision-DEC-007.md), [DEC-011](./06-decision-DEC-011.md)
