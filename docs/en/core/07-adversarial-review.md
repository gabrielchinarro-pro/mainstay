# Adversarial Review

*The product review checks that the deliverable does what was asked. The
adversarial review pays someone to prove that it doesn't — and it does not
count its findings: it refutes them.*

This chapter is new to the method, and every line of it comes from the field:
no earlier version of this documentation contained the word "adversarial."
Meanwhile, on almost every project in the corpus, a second review had taken
root next to the first — one whose mandate is not to validate but to break.
This chapter gives the full protocol: the roles, the counter-verification of
findings, the graded verdicts, the stopping rule, the honest freeze, and the
extension of the same mechanism to contracts and plans before signature.

> The field facts in this chapter come from a private corpus: dated events,
> counts obtained by command, verified by an internal audit in three
> adversarial passes. They are not replayable by the reader.

## Why a review distinct from the product review

The product review asks one question: *does the deliverable do what we
asked?* Whoever runs it is looking for conformance — walking the contract,
ticking behaviours, confirming. Indispensable, and structurally blind: you do
not find what you are not looking for, and someone verifying an expectation
looks exactly where the expectation points.

The adversarial review asks the opposite question: *what breaks if I try?*
Whoever runs it hunts for the flaw — attacking inputs, edges, the states the
contract never staged — and it does not deliver an opinion: it delivers
reproduced defects.

The corpus contains the demonstration that the two questions do not overlap.
On one project at a fintech, **three review passes run by two product
reviewers had returned GO**. The two adversarial reviewers who followed
**refused the commit, twice**, over four defects no review had seen: a schema
validation that blocked what it should not, a comparison that tolerated too
much, a product decision silently reversed, and a destructive operation aimed
at the wrong target. A reversed product decision is precisely what a product
review exists to catch — and it did not, because it was verifying the
presence of the expected behaviour, not the absence of the forbidden one.

| | Product review | Adversarial review |
|---|---|---|
| Question | Does it do what was asked? | What breaks if I try? |
| Posture | Confirm conformance | Refute conformance |
| Material | The contract, behaviour by behaviour | Edges, hostile inputs, invariants, the diff itself |
| Output | A ticked checklist | *Reproduced* defects, with the command that reproduces them |
| Blind spot | Whatever the contract never staged | Business sense — which is why the other review stays |

The two reviews are not redundant; they are complementary and **not
substitutable**. A product GO is not an adversarial GO, and the reverse holds
too: an adversary cannot tell you whether the behaviour is *the right one* —
only whether it holds.

One transverse rule, recorded on several fields of the corpus, underpins the
whole chapter:

> **A milestone is never closed by the one who built it.**

This is not distrust of the coding agent in particular — it is distrust of
*any producer*, human or agent, grading its own work. The producer built the
deliverable with a mental model; it will verify with the same mental model,
and the holes in one are the holes in the other.

## The roles

The adversarial review is not one more agent: it is a topology. The field
converged, on unrelated projects, toward the same cast — the [read-only
review panel of Chapter 03](./03-agent-architecture.md):

| Role | Reads | Writes | Mandate |
|---|---|---|---|
| **Producer** (coder) | Everything | **The only writer** | Build; deliver without committing; fix confirmed findings |
| **Product reviewer** | Deliverable, contract | Nothing | Verify conformance to the contract, behaviour by behaviour |
| **Agnostic reviewer** | Deliverable, *not the code* | Nothing | Fresh eyes; contests everything; must justify even a "nothing to report" |
| **Systematic contradictor** | Everything, code and diff included | Nothing | Break things; **reproduce every defect before reporting it** |

Three disciplines hold the cast together:

1. **Exactly one role mutates the code.** A reviewer who "fixes in passing"
   stops being a reviewer — it becomes a second producer, with a producer's
   blind spots.
2. **The contradictor reproduces before reporting.** A defect without a
   reproduction is an opinion. The contradictor delivers the command, the
   input, the state that triggers the defect — which is what makes its
   finding refutable, and therefore usable.
3. **The agnostic reviewer justifies even its silence.** A bare "nothing to
   report" is unverifiable: you cannot tell whether it looked. The field
   requires the list of what was contested and held. On a site-rebuild
   project, it was the agnostic reviewer — the one that does not read code —
   that found four real defects the product review and the developer had both
   missed.

### Adversarial doubling, 1:1, on the uncommitted diff

The tightest form of the mechanism was born at a fintech in the corpus, and
it fits in one rule: **every coding agent is doubled by an adversary, one for
one.** Not one adversary for the team, not an extra adversarial pass at the
end of the batch — *also* one adversary per coder, which reads **the
uncommitted diff** and can **refuse the commit**. The coder delivers without
committing; the adversary attacks the diff; nothing is committed until its
verdict.

The timing is the heart of the rule. The uncommitted diff is the cheapest
moment in the entire chain to find a defect: a refused commit costs nothing —
no history to rewrite, no branch to untangle, no rollback. Every stage a
defect survives multiplies its price: in the commit, a revert; in the batch,
a review pass; in production, an incident. The 1:1 doubling puts the
contradictor exactly where its catch is cheapest — and it produced the fact
quoted above: the three review GOs were about the product; the two
adversarial refusals were about the diff.

## Counter-verifying the findings

An adversarial panel produces volume — that is its job. Raw volume is
unusable as is: it mixes real defects, plausible false positives and inflated
severities. So the method inserts a mandatory pass between the panel and the
producer: **every finding is counter-verified against the real code before it
is admitted.**

The protocol, finding by finding:

1. **Reproduce.** Replay the alleged scenario on the real code, in the real
   conditions. Not on a reading of the code: on its execution.
2. **Rule.** Confirmed, or discarded. There is no "probably" status.
3. **Justify every discard in writing.** A false positive does not vanish: it
   is discarded *with its technical justification*, recorded next to the
   finding. "Discarded" without a written reason does not exist.
4. **Grade what remains.** Major (violates the contract, corrupts data,
   breaks an invariant) or minor — the severity is itself
   counter-verifiable, not declarative.

The corpus measures what the pass eliminates. On a pilot feature on a SaaS
product, a multi-agent contradictory review produced **45 raw findings; 32
were confirmed; 13 false positives were discarded with a written technical
justification** — for instance a "missing" protection that was in fact the
correct choice for the architecture at hand. On an audit vault on a client's
platform, a 30-agent pass produced **24 findings, 19 confirmed**. On a
two-developer, multi-repo product, a 13-agent pre-staging audit alleged **7
blockers: 6 were downgraded, 1 refuted** — zero real blockers, a verdict
rendered *after* counter-verification, not before.

> **The method does not count its findings: it refutes them.**

A finding count is a vanity metric in both directions. Too high, it drowns
the producer in ghosts — without the refutation pass, thirteen pointless
fixes would have consumed the budget of the real ones. Too low, it reassures
falsely — an absence of findings can measure the laziness of the attack, not
the health of the code. Only findings *that survive refutation* carry
information.

Counter-verification applies to the adversary itself. On an agency's internal
cockpit, a batch reviewed by a single adversary was escalated to a widened
panel of 16 agents: the panel found **6 majors the single adversary had
missed**, and **downgraded 3 false majors** the same adversary had inflated.
The lesson is a rule: an adversarial verdict is a measurement, and
measurements get counter-verified — by widening the panel when the stakes
justify it, never by taking the adversary's word.

## The raw list is kept

The refutation pass creates an archival obligation: **the raw list of
findings — the discarded ones included — is kept next to the verdict**, with
the discard justifications.

The reason is auditability. A triage is only legitimate if it can be
contested: someone — a human, a widened panel, a later audit — must be able
to reopen the thirteen discards and check that each justification holds. A
triage of which only the result survives ("32 confirmed") is an act of faith:
you know *how many* were discarded, no longer *why*, nor whether the discard
was right.

The counter-example is in the corpus, and it founded the rule. On the pilot
feature cited above, the counters were recorded — but the raw list of 45 was
not fully preserved: **the triage is unauditable after the fact.** No one can
verify anymore that the 13 discards really were false positives. The project
was probably right; "probably" is exactly what the method refuses to build
on.

Concretely: the review report is a versioned artefact holding three tables —
*confirmed and fixed* (with the re-measurement, below), *discarded* (with
justification), *deferred* (with a deadline and an owner — a deferral without
a date is a discard that won't say its name). Counters at the top; the lines
below; nothing leaves the table.

## Before/after measurements, replayed under the same conditions

A confirmed finding triggers a fix. A fix triggers a re-measurement — and the
re-measurement obeys a strict rule: **same conditions as the measurement that
caught the defect.** Same environment, same dataset, same command, same
client. A fix verified through a different path than the detection does not
prove the defect is closed; it proves that a different path passes.

The field holds this rule to the letter. On an agency site rebuilt against a
frozen reference, the divergence register records the **before/after**
measurements of the adversarial pass: 18 failures out of 42 checks before the
fixes, 0 out of 40 after — both numbers obtained by the same battery,
replayed. On the pilot feature, every fix in the review report carries the
word "Verified" followed by the exact test that proves it, input and output
values included.

Two corollaries:

- **The orchestrator re-measures with its own hands.** On an agency's
  internal cockpit, the rule is written down: the orchestrator does not
  believe its agents' reports — it replays the final counters itself before
  pronouncing a verdict. An agent's report is a finding like any other: it
  gets counter-verified.
- **A measurement is an artefact, not a sentence.** Commands, outputs and
  conditions are recorded — that is the subject of [Chapter 08 — Proof &
  Probes](./08-proof-and-probes.md).

## Graded verdicts

An adversarial review does not return a green light or nothing. It returns
one of three verdicts, and the vocabulary is canonical throughout the method
([glossary](../reference/glossary.md)):

| Verdict | Meaning | What follows |
|---|---|---|
| **GO** | Zero confirmed majors after refutation; stopping rule reached | The milestone may be closed — by someone other than its builder |
| **GO-WITH-CONDITIONS** | Named reservations, each dated and owned | Proceed, conditions on the register; a condition without a deadline and an owner requalifies the verdict as NO-GO |
| **NO-GO** | At least one confirmed major remains | Back to the producer; a full new pass after the fixes |

The GO-WITH-CONDITIONS is the most useful verdict and the most dangerous. Useful,
because it avoids blocking a whole project on real but bounded reservations.
Dangerous, because it is the front door of the complacency GO: a vague
"condition," undated and unowned, is a NO-GO dressed up as a GO. The corpus
carries its disciplined use — a 32-agent hardening dossier returned
**GO-WITH-CONDITIONS**, reservations listed, before a structural decision was
even drafted — and the frank use of NO-GO: on a personal site, the first
review verdict was **NO-GO with 4 blockers**, all fixed and then re-measured
before the GO.

Two firm boundaries:

- **A review verdict is not a production go.** The adversarial GO says the
  deliverable holds; the decision to put it in front of users is a separate,
  human, explicit ritual — see [Chapter 09 — Release Gate &
  Registry](./09-release-gate-and-registry.md).
- **A verdict is pronounced on refuted findings, never on counted ones.**
  "24 findings" is neither a GO nor a NO-GO: it is raw material.

## The stopping rule: two consecutive dry passes

The adversarial review loops in rounds: attack pass → refutation → fixes →
re-measurements → new pass. It needs a stopping rule, or it closes at the
worst possible moment — when the reviewer tires, which is exactly when the
guard drops.

The field's rule:

> **A dry pass is a complete pass that produces no confirmed major. The
> review is closed only after two consecutive dry passes.**

A single dry pass can be luck, or a lazy pass; the second one confirms it.
Closure becomes a measured fact — two zeros in a row in the loop journal —
rather than a feeling.

The corpus textbook case: at a fintech, a backend component was delivered as
a strictly additive diff — 17 files, 1,578 insertions, **0 deletions** — with
61 green tests, and the adversarial review by rounds was closed only at the
sixth round, on confirmed majors per round of **0, 2, 1, 2, 0, 0**. The two
final zeros are the stopping rule in action; the zero of round one, alone,
would have closed nothing — and the sequel proved it right: rounds two
through four found five majors. On that field, "confirmed" had its own
discipline: a major only counted when validated by two refuters out of three.

The rule mirrors the [grey-zone rule](./05-grey-zones-and-divergence.md):
there, you rescan after every pass because every pass creates new grey zones;
here, you re-attack after every fix because every fix can create new
defects. Stopping is a criterion, not an impression.

## The honest freeze

The stopping rule assumes the count goes down. Sometimes it doesn't.

On an agency's internal cockpit, a batch went from **13 majors in round one
to 21 in round two**. The loop journal states it in plain words: *the count
is rising — this is not convergence.* The batch was not declared finished.
Nor was it quietly abandoned. It was **frozen in writing**: the verdict "not
converged, frozen" recorded down to the commit message, the exact state of
what was known and what was open archived, and a written prohibition on
reopening it without a human go.

This is the verdict most review processes lack, so the method names it: the
**honest freeze**. A loop that does not converge is telling you something —
scope too large, brief too vague, architecture not ready — and a GO extracted
from a diverging loop does not silence that information: it forwards it to
production, at full price.

A freeze entry contains four things:

1. **The numbered record** — the counts per round, and the sentence that says
   why this is not convergence.
2. **The exact state** — what is known, what is fixed and re-measured, what
   remains open.
3. **The resumption condition** — what must change (scope, brief,
   architecture) before reopening.
4. **The lock** — resumption requires an explicit human go; a freeze does not
   expire on its own.

The freeze is a first-class verdict, on the same rank as GO and NO-GO. A
method that cannot freeze can only say "finished" or "not finished yet" — and
"not finished yet," repeated long enough on a diverging batch, always ends as
a complacency GO.

## Adversarial hardening — before contracts and plans

Everything above attacks code. The field extended the mechanism one step
earlier: **before a contract is drafted or a structural plan is executed, the
draft itself goes through an adversarial pass.** Independent contradictors
attack the text — its load-bearing facts are re-verified against the real
code, its invariants contested, its completeness holes hunted — and the pass
returns a graded verdict, exactly as for code.

The corpus carries the heaviest use of it: at a fintech, a structural
architecture decision was *drafted* only after a hardening dossier produced
by a multi-agent pass — 32 agents: anchoring on the real code, a two-lens
attack, a completeness critique, a double verdict — returned
**GO-WITH-CONDITIONS**, the dossier's load-bearing facts having been
re-verified one by one
against the code. The field formula that sums up the discipline: *hardening
precedes writing.*

The logic is the same as for the uncommitted diff: attack at the cheapest
moment. A wrong contract costs more than a wrong diff — everything built on
top inherits the defect, and [Chapter 06](./06-prompt-as-contract.md) showed
that a frozen contract carries authority precisely because no one re-debates
it. What will no longer be debated must be attacked *before* it is frozen. An
execution plan falls under the same rule: its load-bearing claims ("this
branch is mergeable," "this data exists") are findings in waiting, and they
get counter-verified before execution, not during.

## Dosage — and the recorded limit

The adversarial review has a real cost: extra roles, extra rounds,
re-measurements. The method does not prescribe the full protocol everywhere.
The dosage variable is the method's one variable: **code ownership × cost of
error**. A backend touching money on shared code justifies the 1:1 doubling,
the rounds and the refuter vote; a disposable internal tool on wholly-owned
code can settle for a single contradictor on the final diff.

The low end exists, and the corpus records it instead of hiding it: **the
lightest project in the corpus escaped the adversarial review entirely** — no
pass, no verdict. The method draws no shame from that, but a rule, the same
as for every de-escalation: skipping the review is a choice made in writing,
with the reason (low stakes, disposable code, reversible error) — not an
omission discovered after the fact. A review silently not held is a debt; a
review waived in writing is a dosage.

## See also

- [Chapter 03 — The Agentic Architecture](./03-agent-architecture.md) — the
  read-only review panel, layer 5
- [Chapter 05 — Grey Zones & Divergence](./05-grey-zones-and-divergence.md) —
  the divergence register, twin of the review report
- [Chapter 06 — The Prompt as Contract](./06-prompt-as-contract.md) — what
  gets frozen gets hardened first
- [Chapter 08 — Proof & Probes](./08-proof-and-probes.md) — the measurement
  as artefact
- [Chapter 09 — Release Gate & Registry](./09-release-gate-and-registry.md) —
  a review GO is not a production go
- [Reference — Glossary](../reference/glossary.md) — GO, NO-GO,
  GO-WITH-CONDITIONS, dry pass, honest freeze, discarded false positive
