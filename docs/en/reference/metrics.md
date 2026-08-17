# Metrics: a proposed, unproven instrument

*Seven health metrics for the method, each with a formula, a collection method, a target and a reading. None has ever been collected on a real project. This chapter is a designed instrument, not a proven one.*

## Foreword: this chapter's honest status

Read this chapter for what it is. The method has run on some ten real projects: a legacy e-commerce platform in production, a fintech, products under construction, audits of client platforms. **None of the seven metrics below was collected on any of them.** Not one. The numeric targets ("under 0.15", "under 0.10") are design hypotheses, not thresholds calibrated by use.

What the field actually measures is something else, documented elsewhere: **registry counters**: release entries, version tags, numbered decisions ([Chapter 09](../core/09-release-gate-and-registry.md)); **adversarial counters**: raw findings, confirmed findings, dismissed false positives, dry passes ([Chapter 07](../core/07-adversarial-review.md)); and **before/after measurements replayed under identical conditions** ([Chapter 08](../core/08-proof-and-probes.md)). Those counters exist, are dated, and were verified by internal audit against a private corpus.

Why publish this chapter at all? Because the instrument remains coherent with the method (each metric follows from a principle the field has proven by other means) and because a reader who wants to instrument their own practice deserves a designed starting point rather than a blank page. But the reading rule is firm: **everything below is proposed; nothing is proven.** If you collect these metrics on a real project, you will be ahead of the authors.

---

## The seven proposed metrics

### 1. Iterations per screen

The flagship of the design. Mainstay says a prototype should emerge in a single generation; more iterations means the brief was vague.

```
iterations_per_screen = number_of_generation_passes / 1 screen
```

Count a *pass* as one full generation or modification request, not the internal structure/polish passes inside a single generation.

- **Collect:** count prompt cycles tied to a screen identifier in your agent runtime's logs, or contract-linked commits before `status: frozen`.
- **Target (hypothesis):** 1, with internal passes; 2-3 acceptable on genuinely novel screens.
- **Bad value (≥4):** the contract or design system was incomplete. The fix is upstream: re-scan the grey zones before the next screen.

### 2. Grey-zone rate

How much the agent had to decide on its own.

```
grey_zone_rate = grey_zones_found / observable_elements_scanned
```

- **Collect:** from the completed scan ledger for each screen ([Chapter 05](../core/05-grey-zones-and-divergence.md)).
- **Target (hypothesis):** under 0.15.
- **Bad value (>0.30):** the contract is under-specified; a high rate predicts integration failures. A rate of *zero* usually means the scan was skipped.

### 3. Velocity

Throughput of the delivery chain.

```
velocity = screens_reaching_definition_of_done / sprint
```

Count only screens that passed the full per-layer DoD: "almost done" does not exist.

- **Collect:** count contracts whose DoD checklist is fully ticked in the period.
- **Target (hypothesis):** establish a baseline over three sprints, then watch the trend.
- **Bad value (declining trend):** the vault is thinning, or grey zones are being deferred. Cross-read with metrics 2 and 4.

### 4. Context drift

How far the agent wandered from the contract during a session.

```
context_drift = edits_outside_contract_scope / total_edits
```

- **Collect:** compare the agent's changeset to the stated scope; a reviewer tags the out-of-scope chunks.
- **Target (hypothesis):** under 0.05.
- **Bad value (>0.15):** the prompt lacked a closing prohibition, or the session ran too long without re-anchoring. See [Failure protocols](../core/11-failure-protocols.md).

### 5. Contract lead time

How long a contract takes from `draft` to `frozen`.

```
contract_lead_time = frozen_on - draft_created_on   (in working days)
```

- **Collect:** from the contract frontmatter.
- **Target (hypothesis):** 1-3 working days: long enough to scan and sign, short enough that the contract does not rot.
- **Bad value (>10 days):** the contract is stuck in a disagreement, or nobody owns the signature. A stalled contract blocks the entire parallel build.

### 6. Rework ratio

How much delivered work had to be redone.

```
rework_ratio = edits_to_already-done_code / total_edits
```

- **Collect:** attribute commits to a screen; count those landing after that screen's DoD date.
- **Target (hypothesis):** under 0.10.
- **Bad value (>0.25):** the DoD was applied softly, or grey zones surfaced after delivery: consistency debt paid late, at the worst price.

### 7. Signature latency

The gap between a contract being ready to sign and both signatures arriving.

```
signature_latency = max(signed_product_at, signed_engineering_at)
                    - contract_ready_for_review_at   (in working days)
```

- **Collect:** from review timestamps in the contract history or the PR record.
- **Target (hypothesis):** under 2 working days.
- **Bad value (>5 days):** signing is not yet a ritual. Without both signatures you cannot freeze, and an unfrozen contract is not a contract.

---

## Reading the metrics together

No metric means anything alone. The pairs that would tell a story:

| If you see... | ...read it as |
|---|---|
| High iterations + high grey-zone rate | The contract phase is under-invested. |
| Low velocity + long contract lead time | Signing is the bottleneck, not building. |
| High context drift + high rework | Prompts lack closing prohibitions; sessions run too long. |
| Low grey-zone rate + high rework | Grey zones are being *missed*, not resolved: scan harder. |
| Rising velocity + falling rework | The vault is compounding; the infrastructure is getting smarter. |

---

## What the field counts instead

Until some project collects these ratios, the method does not live without numbers; it lives with numbers of a different nature, held in its registries:

| What is counted | Where | What it measures |
|---|---|---|
| Release entries, tags, recorded gos, and their absences | The release registry ([Ch. 09](../core/09-release-gate-and-registry.md)) | Production discipline, violations included |
| Raw → confirmed → dismissed findings, per pass | Loop journals ([Ch. 07](../core/07-adversarial-review.md)) | A lot's real convergence, or its honest freeze |
| Before/after measurements replayed under identical conditions | Proof folders ([Ch. 08](../core/08-proof-and-probes.md)) | A fix's real effect, not its intention |
| Numbered, dated, superseded decisions | The vault ([Ch. 02](../core/02-vault-and-sources-of-truth.md)) | Learning retained |

The difference in nature is instructive: the field's counters are **artefact facts**: they fall out of registries the method mandates anyway, with no extra instrumentation. The seven metrics of this chapter demand dedicated collection. That is probably why they were never collected, and the lesson is worth keeping: a metric that requires a manual export does not get looked at.

---

## A dashboard concept

If you do instrument, the dashboard fits in a single view, refreshed per sprint. **Illustrative** values:

```
MAINSTAY HEALTH · Sprint 14 (illustrative figures)

Metric                  Value     Target      Status
─────────────────────── ───────── ─────────── ────────
Iterations / screen     1.4       1-3         OK
Grey-zone rate          0.11      < 0.15      OK
Velocity                6 screens baseline    OK (+1)
Context drift           0.18      < 0.05      ALERT
Contract lead time      2.1 days  1-3 days    OK
Rework ratio            0.09      < 0.10      OK
Signature latency       1.3 days  < 2 days    OK
```

Most of the data is derivable from the monorepo itself: contracts, decisions and history all live there. A script can read contract frontmatter, grey-zone ledgers and a screen-filtered `git log`, emit one JSON record per screen, and aggregate per sprint. Run it as a non-blocking CI step ([CI/CD and hooks](./cicd-and-hooks.md)): automatically computed metrics get looked at; manually exported ones do not.

---

## See also

- [Chapter 05 · Grey zones and divergence](../core/05-grey-zones-and-divergence.md)
- [Chapter 07 · Adversarial review](../core/07-adversarial-review.md): the counters the field actually keeps
- [Chapter 08 · Proof and probes](../core/08-proof-and-probes.md)
- [Chapter 09 · The release gate and registry](../core/09-release-gate-and-registry.md)
- [Reference · CI/CD and hooks](./cicd-and-hooks.md)
