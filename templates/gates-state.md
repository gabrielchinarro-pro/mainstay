<!--
  TEMPLATE: named gates + state file
  COPY TO: GATES.md at the root of the worksite (or vault/GATES.md).

  A gate is a named checkpoint a build cannot pass without a measured
  criterion AND an explicit human go. Gates turn "are we ready?" from a
  feeling into a table. They pair with staged construction: each stage ends
  at a gate, and no stage starts before the previous gate is passed.

  Two rules make gates real instead of decorative:
   1. The entry criterion is MEASURED, not asserted — a command, a count,
      a replayed check. "Feels stable" opens no gate.
   2. The go is quoted verbatim, with its date. An oral waiver of a gate
      criterion is written in the state section within the same exchange —
      or it is void. A gate "sort of passed" is a gate not passed.

  All example content is fictional (the "Saved Views" walkthrough).
  Fill every <PLACEHOLDER>. Delete these comments.
-->

# Gates — <worksite, e.g. saved-views-panel>

## Gate table

<!-- Define every gate up front, before stage 1 starts. Adding a gate later
     is fine (dated); removing one silently is not. -->

| Gate | Opens the right to… | Entry criterion (measured) | Go given by |
|---|---|---|---|
| G1 | build against the contract | contract `status: frozen`, both signatures; contract-lint passes; grey-zone ledger: 0 open rows | <who> |
| G2 | wire front to real endpoints | API spec frozen and tagged; mocks generated from spec; back merged dark behind flags | <who> |
| G3 | submit to adversarial review | every state of contract §4 reachable; DoD checklist self-ticked; proof files present | <who> |
| G4 | release to production | review verdict GO (or GO-WITH-CONDITIONS with conditions met); backup taken and restore rehearsed | <who> |

## State — updated <YYYY-MM-DD HH:MM>

<!-- The live section. One line per gate, newest information wins. This
     section is re-dated at every update; an undated state is expired. -->

- **Current gate:** G3 — open since <date>.
- **G1 — passed** <date>. Criterion: contract frozen <date>, lint clean.
  Go (verbatim): <who>: "G1 ok, start the build."
- **G2 — passed** <date>. Criterion: spec `v1.0` tagged, 4 mocked
  endpoints generated. Go (verbatim): <who>: "Spec is good, wire it."
- **G3 — in progress.** Blocking criterion: proof files 5/8 present.
- **G4 — not reached.**

## Waivers and exceptions

<!-- Every softening of a criterion lands here, dated, with its scope. An
     exception that is not written here does not exist. -->

- <date> — G2 criterion "back merged dark" waived for endpoint
  `set-default` only (back not started); ratified in writing by <who> the
  same day. Expires when wave 2 starts.

<!--
  RULES OF THE FILE:
   - A stage never starts before its opening gate is passed and quoted.
   - The person who built a stage does not give the go that closes it.
   - De-escalation is allowed but written: if a gate is not applicable to
     this worksite, say so here, dated — do not skip it in silence.
  See ../docs/en/core/09-release-gate-and-registry.md and
  ../docs/en/core/10-session-conduct.md.
-->
