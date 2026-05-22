<!--
  TEMPLATE: screen contract
  COPY TO: vault/contracts/<screen-id>.md

  A contract turns a validated prototype into something signable. It adds to the
  pixels everything they cannot show: endpoints, permissions, error states,
  transitions, rules, test data. It is the source of truth for behaviour.

  A contract is frozen only with TWO signatures — product and engineering.
  Without both, it stays a draft. The double signature kills the trap of
  "approved by UX, found unbuildable by engineering two weeks later".

  The frontmatter keys below are English and machine-read — do not translate or
  rename them. `status` is a fixed vocabulary: draft | review | frozen |
  obsolete. Run ../skills/contract-lint/ before you freeze.

  Fill every <PLACEHOLDER>. Delete these comments.
-->
---
type: contract
screen: "<screen-id>"            # e.g. saved-views-panel
version: "0.1"                   # bump on every material change after freeze
status: draft                    # draft | review | frozen | obsolete
signed_product: false            # true only when product has signed
signed_engineering: false        # true only when engineering has signed
frozen_on: null                  # YYYY-MM-DD — set when status becomes frozen
related_decisions: []            # e.g. [DEC-007, DEC-011]
---

# Contract — <Screen Name>

<!-- One-line summary of what this screen is. -->
<One sentence describing the screen.>

## 1. Context and persona

<!-- Where the screen lives, who uses it, what they are trying to accomplish.
     The "why" behind the screen. -->
- **Location in the product:** <where this screen sits>.
- **Persona:** <who uses it>.
- **Job to be done:** <what the user accomplishes here>.

## 2. Visual source of truth

<!-- The validated prototype is the truth for anything visible. Link it. The
     contract never overrides the prototype on appearance. -->
- **Prototype:** <link or path to the validated prototype>.
- **Note:** for anything visible (layout, copy, states), the prototype wins.
  This contract governs behaviour, not pixels.

## 3. Architecture — fixed vs conditional zones

<!-- Separate the regions that are always present from the regions that appear
     under a condition. This split prevents an agent from treating a conditional
     region as permanent, or vice versa. -->
- **Fixed zones** (always rendered):
  - <zone> — <what it contains>.
- **Conditional zones** (rendered only when a condition holds):
  - <zone> — shown when <condition>.

## 4. States and transitions

<!-- Every state the screen can be in, and how it moves between them. Loading,
     empty, populated, error, partial. A state missing here is a grey zone
     waiting to happen. -->
| State | What the user sees | Entered from | Leaves to |
|---|---|---|---|
| Loading | <description> | initial load / refetch | Populated / Error / Empty |
| Empty | <exact empty-state copy> | load returns no data | Populated |
| Populated | <description> | load returns data | <...> |
| Error | <exact error copy> | load fails | Loading (on retry) |
| <partial state> | <description> | <...> | <...> |

## 5. Components — exact copy and validations

<!-- Each interactive component: its exact copy strings, its validation rules,
     its disabled/enabled conditions. Copy is quoted verbatim — no paraphrase. -->
- **<Component name>**
  - Copy: `"<exact label / placeholder / helper text>"`.
  - Validation: <rule, e.g. "required, 1-60 characters, trimmed">.
  - Enabled when: <condition>. Disabled state: <what shows>.
- **<Component name>**
  - Copy: `"<exact copy>"`.
  - Validation: <rule>.

## 6. Endpoints

<!-- Every endpoint this screen calls: method, path, request payload, response
     shape, return codes, and concrete test data. Use a fake host only. -->
Base URL: `https://api.example.com`

### `<METHOD> <path>`
- **Purpose:** <what it does>.
- **Request payload:**
  ```json
  { "<field>": "<type / example>" }
  ```
- **Success response:** `<code>`
  ```json
  { "<field>": "<type / example>" }
  ```
- **Error responses:** `<code>` — <when and what payload>.
- **Test data:** <a concrete request/response pair an agent can use>.

<!-- Repeat the block above for each endpoint. -->

## 7. Edge cases

<!-- The awkward situations. Each one: the situation and the required behaviour.
     If the prototype did not show it, it MUST be decided here — not left open. -->
- <Edge case> → <required behaviour>.
- <Edge case> → <required behaviour>.

## 8. Permissions

<!-- Who can see and do what. An assumed permission is a grey zone. State the
     rule for every role and every action. -->
| Role | Can view | Can create | Can edit | Can delete |
|---|---|---|---|---|
| <role> | <yes/no/conditional> | <...> | <...> | <...> |

## 9. Business rules

<!-- The domain logic that is not visible in the UI. Ordering, defaults,
     uniqueness, computed values, side effects. One rule per line, testable. -->
- <Rule — e.g. "only one item per user may be marked as default">.
- <Rule>.

## 10. Test data

<!-- A concrete, reusable dataset for building and verifying this screen. Real
     enough to exercise every state, fully fictional. -->
```json
[
  { "<field>": "<value>" }
]
```

## 11. Acceptance criteria

<!-- Binary, observable criteria. The definition of done for this screen. Each
     line is checkable by looking or running, not by opinion. -->
- [ ] Every state in section 4 is implemented and reachable.
- [ ] Every endpoint in section 6 is consumed; error responses are handled.
- [ ] Every permission rule in section 8 is enforced.
- [ ] Every business rule in section 9 holds.
- [ ] Copy matches section 5 exactly.
- [ ] The build matches the prototype to the pixel.
- [ ] <Add screen-specific acceptance criteria.>

## 12. Signatures

<!-- The contract is frozen ONLY when both boxes are ticked, status is `frozen`,
     frozen_on is set, and signed_product / signed_engineering are true in the
     frontmatter. One signature is not enough. -->
- [ ] **Product** — signed by <name/role>, on <YYYY-MM-DD>.
- [ ] **Engineering** — signed by <name/role>, on <YYYY-MM-DD>.

<!--
  BEFORE FREEZING:
   - Run ../skills/contract-lint/lint.sh on this file.
   - Resolve every grey zone (see the grey-zone ledger template).
   - Set status: frozen, frozen_on, and both signed_* keys in the frontmatter.
-->
