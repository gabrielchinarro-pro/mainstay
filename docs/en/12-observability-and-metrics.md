# Observability & Metrics

*A method you cannot measure is a method you cannot improve. This chapter defines seven metrics for Mainstay health, each with a formula, a collection method, a target range, and a reading of what a bad value means.*

Mainstay makes a strong claim: the number of iterations an agent needs is a direct measure of the quality of the brief upstream. That claim only holds if you measure. This chapter turns the method's principles into numbers you can collect from the monorepo and from your agent runtime, and shows a dashboard concept that puts them in one view.

Measure the **method**, not the model. Every metric below answers the question "is the infrastructure doing its job?" — not "is the model smart?".

---

## The seven metrics

### 1. Iterations per screen

The headline metric. Mainstay says a prototype should emerge in a single generation; more iterations mean the brief was vague.

**Formula:**

```
iterations_per_screen = number_of_generation_passes / 1 screen
```

Count a *pass* as one full generate-or-modify request, not the internal structure/polish passes inside a single generation.

- **Collect:** count prompt cycles tagged to a screen id (e.g. `saved-views-panel`) in your agent runtime logs, or count contract-linked commits before `status: frozen`.
- **Target:** 1, with internal multi-pass generation. A value of 2–3 is acceptable on genuinely novel screens.
- **Bad value (≥4):** the contract or the design system was incomplete. The fix is upstream, not in the agent — re-scan for grey zones before the next screen.

### 2. Grey-zone rate

How much the agent had to decide on its own.

**Formula:**

```
grey_zone_rate = grey_zones_found / observable_elements_scanned
```

An *observable element* is anything a grey-zone scan inspects: a state, an interaction, a copy string, an empty state, a hover.

- **Collect:** from the filled grey-zone scan artifact for each screen (see [Grey Zones](./07-grey-zones.md) and `examples/walkthrough/02-grey-zone-scan.md`).
- **Target:** below 0.15 — fewer than one element in seven was left to the agent's discretion.
- **Bad value (>0.30):** the contract is underspecified. Each grey zone is a decision taken in the dark by someone without authority. A high rate predicts integration failures.

### 3. Velocity

Throughput of the delivery chain.

**Formula:**

```
velocity = screens_reaching_definition_of_done / sprint
```

Only count screens that passed the full per-layer DoD, not "almost done" screens — "almost done" does not exist.

- **Collect:** count contracts whose `07-definition-of-done` checklist is fully checked within the period.
- **Target:** set a baseline from your first three sprints, then watch the trend, not the absolute number.
- **Bad value (declining trend):** either the vault is thinning out (agents hesitate) or grey zones are being deferred (debt accumulating). Cross-read with metrics 2 and 4.

### 4. Context drift

How far the agent has wandered from the contract during a session.

**Formula:**

```
context_drift = edits_outside_contract_scope / total_edits
```

An *edit outside contract scope* is any change the agent made that the contract or the prompt did not request — over-correction, "improvement", touching unrelated code.

- **Collect:** diff the agent's changeset against the contract's stated scope; a reviewer or a hook tags out-of-scope hunks.
- **Target:** below 0.05.
- **Bad value (>0.15):** the prompt lacked a closing prohibition ("no changes other than this one"), or the session ran too long without a reset. See the drift protocol in [Failure Protocols](./08-failure-protocols.md).

### 5. Contract lead time

How long a contract takes to go from `draft` to `frozen`.

**Formula:**

```
contract_lead_time = frozen_on - draft_created_on   (in working days)
```

- **Collect:** from contract frontmatter — the difference between the `draft` creation date and `frozen_on`.
- **Target:** 1–3 working days for a typical screen. Long enough to scan grey zones and get two signatures; short enough that the contract does not rot.
- **Bad value (>10 days):** the contract is stuck in disagreement (often product vs engineering) or no one owns signing it. A stalled contract blocks the whole parallel build.

### 6. Rework ratio

How much shipped work had to be redone.

**Formula:**

```
rework_ratio = edits_to_already-done_code / total_edits
```

*Already-done code* is code behind a screen whose DoD was checked.

- **Collect:** attribute commits to a screen; count commits landing after that screen's DoD date.
- **Target:** below 0.10.
- **Bad value (>0.25):** the definition of done was applied loosely, or grey zones surfaced after delivery. High rework is consistency debt being paid late, at the worst price.

### 7. Signature latency

The gap between a contract being ready to sign and both signatures arriving.

**Formula:**

```
signature_latency = max(signed_product_at, signed_engineering_at)
                    - contract_ready_for_review_at   (in working days)
```

- **Collect:** from the review/sign timestamps in the contract's history or PR record.
- **Target:** under 2 working days.
- **Bad value (>5 days):** signing is not a ritual yet — see [Team Adoption](./15-team-adoption.md). Without both signatures you cannot freeze, and an unfrozen contract is not a contract.

---

## Reading the metrics together

No metric is meaningful alone. The pairs that tell a story:

| If you see... | ...read it as |
|---|---|
| High iterations + high grey-zone rate | The contract phase is being underinvested. |
| Low velocity + long contract lead time | Signing is the bottleneck, not building. |
| High context drift + high rework | Prompts lack closing prohibitions; sessions run too long. |
| Low grey-zone rate + high rework | Grey zones are being *missed*, not resolved — re-scan harder. |
| Velocity rising + rework falling | The vault is compounding; the infrastructure is getting smarter. |

The last row is the goal state described in the delivery chain's step 6: each cycle leaves the infrastructure richer, so the next screen starts from a better place.

---

## A dashboard concept

A Mainstay health dashboard fits in one table, refreshed per sprint. This is a mockup with **illustrative** values.

```
MAINSTAY HEALTH — Sprint 14 (illustrative figures)

Metric                  Value     Target      Status
─────────────────────── ───────── ─────────── ────────
Iterations / screen     1.4       1–3         OK
Grey-zone rate          0.11      < 0.15      OK
Velocity                6 screens baseline    OK (▲ +1)
Context drift           0.18      < 0.05      ALERT
Contract lead time      2.1 days  1–3 days    OK
Rework ratio            0.09      < 0.10      OK
Signature latency       1.3 days  < 2 days    OK

ACTION: context drift above target — audit recent prompts for
missing closing prohibitions; cap session length.
```

The dashboard's job is to make one bad number impossible to ignore. The single ALERT above points the team at a precise, fixable cause.

---

## A collection script idea

You do not need a platform. Most metrics are derivable from the monorepo itself, because contracts, decisions, and history all live there. A small script can produce the data shape the dashboard consumes.

**Data shape (one JSON record per screen):**

```json
{
  "screen": "saved-views-panel",
  "iterations": 1,
  "observable_elements": 28,
  "grey_zones": 3,
  "draft_created_on": "2026-05-12",
  "frozen_on": "2026-05-14",
  "ready_for_review_on": "2026-05-13",
  "signed_product_at": "2026-05-14",
  "signed_engineering_at": "2026-05-14",
  "edits_total": 41,
  "edits_out_of_scope": 2,
  "edits_after_dod": 3,
  "dod_complete": true
}
```

**Script idea (pseudocode):**

```text
for each contract file in vault/contracts/:
    read frontmatter -> dates, status
    read linked grey-zone scan -> grey_zones, observable_elements
    query git log filtered by screen tag -> edit counts, timing
    emit one JSON record (shape above)
aggregate records per sprint -> compute the seven metrics
render the dashboard table
```

Run it as a CI step (see [CI/CD & Hooks](./14-cicd-and-hooks.md)) so the dashboard refreshes every time the main branch moves. Metrics that are computed automatically get looked at; metrics that need a manual export do not.

---

## See also

- [Grey Zones](./07-grey-zones.md)
- [The Delivery Chain](./05-the-delivery-chain.md)
- [Testing & Evaluating Agents](./13-testing-and-evaluating-agents.md)
- [CI/CD & Hooks](./14-cicd-and-hooks.md)
