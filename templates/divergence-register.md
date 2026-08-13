<!--
  TEMPLATE: divergence register
  COPY TO: DIVERGENCES.md at the root of the rebuild worksite
           (or vault/DIVERGENCES.md).

  Use this register when you rebuild AGAINST A FROZEN REFERENCE — an
  existing site to re-implement, a legacy screen to reproduce, a design pack
  that must be matched. It is the twin of the grey-zone ledger, but the two
  are not interchangeable:

   - A GREY ZONE is a decision the agent took where the contract was
     silent. Its register lives while the contract is being written.
   - A DIVERGENCE is a measured difference between the rebuild and a
     reference that already exists and is frozen. Its register lives for
     the whole rebuild.

  One consequence matters: in this register — and only here — a DATED
  DEFERRAL is a legitimate status. The grey-zone rule "there is no third
  outcome" protects contracts from "we'll decide later"; a rebuild, by
  contrast, may knowingly ship with a divergence scheduled for later,
  provided the deferral carries a date, an owner, and a review trigger.
  A deferral without all three is not a status — it is an open divergence
  wearing a costume.

  Statuses (fixed vocabulary):
   - assumed       — divergence kept on purpose, justified in writing.
   - fixed         — rebuild brought back to the reference, re-measured.
   - to-arbitrate  — awaiting a decision from someone with authority.
   - deferred      — dated deferral: date + owner + review trigger.

  All example content is fictional. Fill every <PLACEHOLDER>. Delete these
  comments.
-->

# Divergence Register — <rebuild id>

- **Frozen reference:** <what the rebuild is measured against — e.g. the
  reference capture pack `ref-captures/2026-05-01/`, checksummed; or the
  live legacy site pinned at <version/date>>.
- **Rebuild under measure:** <build / commit / URL being compared>.
- **How divergences are measured:** <the method — e.g. side-by-side
  captures at 3 viewports, DOM text diff, replayed interaction scripts.
  Divergences are MEASURED, not remembered.>

## Register

| ID | Divergence (measured) | Reference | Rebuild | Status | Justification / date |
|---|---|---|---|---|---|
| DIV-01 | Body font differs | <ref font> | system font stack | assumed | Licensed font not redistributable; approved by <who>, <date> |
| DIV-02 | Card grid 3-wide at tablet | 4-wide | 3-wide | fixed | Re-measured <date>: matches at all 3 viewports |
| DIV-03 | Footer legal text shortened | full text | 2 lines | to-arbitrate | Question sent to <who> <date> |
| DIV-04 | Search has no keyboard shortcut | `/` focuses search | none | deferred | Due <date>, owner <who>, reviewed when <trigger, e.g. "search rework starts"> |

## Measures

<!-- The before/after evidence for anything claimed fixed, replayed under
     the same conditions both times. A "fixed" row with no measure here is
     not fixed. -->
- DIV-02 — comparison script: <N> mismatching regions before, 0 after,
  same viewport set, same capture tool, runs of <date> and <date>.
- <measure>.

## Review log

<!-- Dated entries: arbitrations rendered, deferrals reviewed at their
     trigger, statuses changed. Statuses change here first, then in the
     table — never silently in the table alone. -->
- <date> — DIV-03 arbitrated by <who>: keep full text → status `fixed`
  once re-measured.
- <date> — DIV-04 deferral reviewed at trigger: <outcome>.

<!--
  RULES:
   - Every known difference gets a row, including the flattering ones.
   - `assumed` requires a written justification and a name — "looks fine"
     is not a justification.
   - `deferred` rows are re-reviewed at their trigger, not at leisure; a
     lapsed date flips the row to `to-arbitrate` automatically.
   - When the rebuild ships, rows still `to-arbitrate` block the ship;
     rows `assumed` and `deferred` ship with it, visibly.
  See ../docs/en/core/05-grey-zones-and-divergence.md for the chapter, and
  grey-zone-ledger.md for the twin artifact.
-->
