<!--
  TEMPLATE: release registry (RELEASES.md)
  COPY TO: RELEASES.md, at the repository root.

  The release registry is the single, append-only history of everything that
  reached production. It exists because "deployed" is a fact that deserves the
  same discipline as a decision: dated, evidenced, reversible, and authorised.

  Two rules make it work:
   1. No production release without an EXPLICIT go, given in the current
      exchange. "The review passed" is not a go. "Looks good" on staging is
      not a go. A go is a sentence someone accountable actually said, and the
      registry quotes it verbatim.
   2. The registry records violations instead of hiding them. A release that
      shipped without a go gets an entry marked "Go: ⚠️ not asked" — that
      honesty is what lets the rule improve instead of eroding.

  One entry per release, newest first. The entry model below covers: nature,
  a plain-words line for non-technical readers, acceptance evidence, backup
  and rollback, the go verbatim, the tag, and a post-release check. There is
  no separate "release entry" template — the repeatable block IS this file.

  The example entry is entirely fictional (the "Saved Views" walkthrough
  feature). Fill every <PLACEHOLDER>. Delete these comments.
-->

# RELEASES — <product name>

## Rules of this registry

- **Versioning:** semver. MAJOR = breaking for users or integrators;
  MINOR = new behaviour; PATCH = fix with no new behaviour.
- **Go:** every release requires an explicit go from <who is accountable>,
  given in the current exchange, quoted verbatim in the entry. A validated
  staging run is never an implicit go.
- **Order:** the entry is written **before** the deploy; the post-release
  check completes it after.
- **Tag:** every release is tagged `v<version>` at the deployed commit.
- **Reconciliation:** after each release, the registry is compared against
  the real system (deployed version, tag list). Any discrepancy becomes its
  own entry — the registry must never quietly diverge from production.
- **De-escalation:** if this registry is not applicable to a repository
  (no production, no users), that is declared in writing where the rule was
  set — it is not abandoned in silence.

---

## <version> — <YYYY-MM-DD>

**In plain words:** <one sentence a non-technical stakeholder understands.>

- **Nature:** <feature | fix | infra> — <what changed, with the contract or
  decision it implements>.
- **Acceptance:** <the evidence that it works: review verdict, proof files,
  measures replayed. Point at artifacts, do not summarise from memory.>
- **Backup:** <what was saved before deploying, where, and how you know the
  backup is restorable>.
- **Rollback:** <the exact way back: tag to redeploy, dump to restore, and
  any destructive migration that makes rollback partial>.
- **Go (verbatim):** <who>, <date>: "<the exact sentence>".
- **Tag:** `v<version>`
- **Post-release check:** <what was verified on the live system, when>.

---

## 1.4.0 — 2026-05-21  *(fictional example)*

**In plain words:** users can now save a filtered view of their data table
and reopen it later from a side panel.

- **Nature:** feature — `saved-views-panel` (contract v1.0, frozen
  2026-05-18; DEC-007, DEC-011).
- **Acceptance:** adversarial review round 2 closed at 0 major findings
  open; proof files `_proof/saved-views/00_*` → `07_*` replayed on staging
  under the same conditions as round 1.
- **Backup:** database dump `pre-1.4.0.dump` taken 2026-05-21 09:12,
  restore rehearsed on staging; previous build reachable at tag `v1.3.2`.
- **Rollback:** redeploy `v1.3.2`, restore `pre-1.4.0.dump`. No destructive
  migration in this release — rollback is total.
- **Go (verbatim):** product owner, 2026-05-21: "Go for 1.4.0, ship it."
- **Tag:** `v1.4.0`
- **Post-release check:** health endpoint 200 at 09:31; one saved view
  created and reopened in production with a test account.

---

## 1.3.2 — 2026-05-09  *(fictional example — a recorded violation)*

**In plain words:** fixed the empty-state text of the views panel.

- **Nature:** fix — copy correction on `saved-views-panel`.
- **Acceptance:** visual check on staging only.
- **Backup:** none taken.
- **Rollback:** redeploy `v1.3.1`.
- **Go (verbatim):** ⚠️ **not asked** — deployed on momentum, entry written
  retroactively. This violation is why the "go in the current exchange"
  rule above exists.
- **Tag:** `v1.3.2`
- **Post-release check:** none.

<!--
  KEEPING IT HONEST:
   - Never rewrite an old entry; append a correction entry that references it.
   - A violation entry (missing go, missing backup) stays in the registry
     forever — it is the origin story of the rule it violated.
   - If the registry and production disagree at reconciliation, production is
     the fact and the registry gets a discrepancy entry, dated.
  See ../docs/en/core/09-release-gate-and-registry.md for the full chapter.
-->
