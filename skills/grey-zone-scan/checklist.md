# Grey-Zone Sweep Checklist

Walk every item. For each one, ask: *did the contract or brief specify this
explicitly?* If not, it is a grey zone — add a row to the ledger.

The sweep is grouped into three families: **zones** (regions of the screen),
**states** (the conditions the screen can be in), and **interactions** (what
happens when the user acts). Do not skip a family because it "looks fine" —
grey zones are precisely the things that look fine because the agent made a
plausible choice.

## 1. Zones — every region of the screen

- [ ] **Layout proportions** — were the region sizes/ratios specified, or chosen?
- [ ] **Headers and titles** — exact copy specified, or written by the agent?
- [ ] **Empty regions** — what fills a region with no content? Specified?
- [ ] **Spacing and density** — row heights, padding, gaps: specified numerically?
- [ ] **Ordering of items** — sort order specified, or arbitrary?
- [ ] **Truncation** — long text behaviour (ellipsis, wrap, clamp): specified?
- [ ] **Counts and limits** — page size, max items, "show more": specified?
- [ ] **Iconography** — which icons, where: specified, or picked by the agent?
- [ ] **Secondary / metadata text** — labels, timestamps, helper text: specified?

## 2. States — every condition the screen can be in

- [ ] **Loading state** — what shows while data loads? Specified?
- [ ] **Empty state** — exact copy and any call-to-action: specified?
- [ ] **Populated state** — every field of a row/card: specified?
- [ ] **Error state** — exact error copy, per error class: specified or invented?
- [ ] **Partial / mixed state** — some data present, some failing: handled, specified?
- [ ] **Disabled states** — when controls are disabled and what they show: specified?
- [ ] **Selected / active state** — appearance of the active item: specified?
- [ ] **Optimistic / pending state** — what shows during a write before it
      confirms: specified?
- [ ] **Permission-restricted state** — what a user without rights sees: specified?

## 3. Interactions — every action the user can take

- [ ] **Hover behaviour** — invented hovers are a classic grey zone. Specified?
- [ ] **Focus and keyboard** — tab order, focus rings, keyboard shortcuts: specified?
- [ ] **Click targets** — what each click does, including secondary clicks: specified?
- [ ] **Form validation** — rules, timing (on blur / on submit), messages: specified?
- [ ] **Confirmation prompts** — destructive actions: confirmed? copy specified?
- [ ] **Success feedback** — toast, inline message, redirect: specified?
- [ ] **Error feedback on action** — what a failed action shows: specified?
- [ ] **Transitions / animation** — motion between states: specified, or chosen?
- [ ] **Defaults on create** — pre-filled values for a new item: specified?
- [ ] **Side effects** — what else changes when an action runs: specified?

## After the sweep

- Every unticked-because-unspecified item became a ledger row.
- Every ledger row has an outcome: `decision` or `contract` — never "later".
- Re-run this whole checklist after the next iteration pass.
