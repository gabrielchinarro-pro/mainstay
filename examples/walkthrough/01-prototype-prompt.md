---
type: prompt
kind: prototype-generation
screen: saved-views-panel
based_on: CON-saved-views
created_on: 2026-05-11
---

# Prototype generation prompt — `saved-views-panel`

> Step 1 of the delivery chain: the prototype comes out of a **single
> generation**. If the screen needs a second prompt to be usable, the brief
> below was vague — the iteration count measures the quality of this prompt,
> not the agent. This is the prompt, reproduced verbatim, that produced the
> validated prototype the grey-zone scan ([`02`](./02-grey-zone-scan.md)) then
> examined.

---

```
CREATION of the screen "saved-views-panel"

CONTEXT
This panel lives inside a generic data-table screen. The table already
exists; you are adding the Saved Views panel that sits in the table's
toolbar. Users are workspace members who reconfigure the same table daily.
The concept is defined in the vault: a saved view stores filters + sort +
visible columns, can be marked default, and can be private or shared with
the workspace.

DO 3 PASSES
  Pass 1 — Structure: lay out every zone and every state as static markup.
  Pass 2 — Implementation: wire interactions, list rendering, the create
           and edit forms, all states below.
  Pass 3 — Polish and responsive: spacing, focus order, empty/loading/error
           visuals; verify at 360px, 768px and 1280px widths.

SPECIFICATIONS

Layout
- A toolbar button labelled "Views" opens the panel as a 320px-wide
  dropdown anchored under the button.
- Panel header: title "Saved views" (16px, weight 600) and a primary
  button "New view" aligned right.
- Below the header: a vertical list of saved views, one row per view,
  1px separators between rows, no per-row card or shadow.

A view row (single line, 44px tall)
- Left: the view name (14px, weight 500), truncated with an ellipsis past
  the available width.
- A small "Default" badge (11px, uppercase) shown only on the default view.
- A small "Shared" badge (11px) shown only on workspace-shared views.
- Right: a 3-dot menu button revealing: Apply, Set as default, Edit,
  Delete.
- The whole row is clickable to Apply the view.

States (all required)
- Loading: 3 skeleton rows.
- Empty: centered text "No saved views yet" plus the "New view" button.
- Error: inline message "Could not load saved views." plus a "Retry" link.
- Populated: the list of rows.
- Create/Edit form: replaces the list inside the panel. Fields: a text
  input "Name" (max 60 chars, required) and a radio pair
  "Private" / "Shared with workspace". Buttons: "Cancel" and "Save".
  Name validation message on blank: "Enter a name."

VALUES
- Panel width 320px; row height 44px; internal padding 12px.
- Separator 1px. Border radius 8px on the panel, 4px on inputs/buttons.
- Badge: 11px text, 2px/6px padding, 4px radius.

DESIGN SYSTEM RECALL  (never assume — restate)
- Primary action color: the design-system "accent" token.
- Text: primary token for names, muted token for secondary text.
- Typography: the system sans; sizes used here are 11/13/14/16px.
- Spacing scale: multiples of 4px only.
- Use the existing Button, TextInput, Radio and Menu components from the
  design system; do not invent new component styles.

PROHIBITIONS
- Do not invent copy. Use exactly the strings given above. If a string is
  needed and not given, leave a visible TODO marker — do not guess.
- Do not invent behaviour for cases not specified (see self-check).
- Do not add features beyond this brief (no search, no folders, no
  drag-to-reorder).
- Do not restyle the surrounding table or toolbar.
- Do not use any color, size, or radius outside the values above.

SELF-CHECK CHECKLIST  (tick every item before returning)
[ ] All five states are present and reachable.
[ ] The view row matches the single-line, 44px, separator spec.
[ ] "Default" and "Shared" badges appear only on the relevant rows.
[ ] The create/edit form has Name + visibility radios + Cancel/Save.
[ ] Name validation message shows on blank submit.
[ ] Only design-system components and tokens are used.
[ ] No invented copy; any gap is a visible TODO marker.
[ ] Verified at 360px, 768px, 1280px.
```

---

## Why each section closes a door

- **Context** stops the agent re-imagining where the panel lives.
- **Passes** force a structured generation instead of one undisciplined dump.
- **Specifications with numbers** (320px, 44px, 1px) leave no room to
  reinterpret layout.
- **Design-system recall** prevents invented colors and components — the most
  common source of grey zones.
- **Prohibitions** name what *not* to do, explicitly.
- **Self-check** makes the agent verify its own output before returning.

What the prompt deliberately leaves open becomes the grey-zone scan's job:
nothing here says *which* view applies on first load, or whether a shared view
can be edited by a non-owner. Those gaps surface in
[`02-grey-zone-scan.md`](./02-grey-zone-scan.md).
