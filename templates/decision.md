<!--
  TEMPLATE: decision (DEC-XXX)
  COPY TO: vault/decisions/DEC-XXX.md

  A decision records something that was settled — most often the formal outcome
  of a grey zone. It is dated, justified, and becomes a rule the whole repo
  follows. Once written, a decision is not edited in place: if it is overturned,
  a new decision supersedes it and this one's status becomes `superseded`.

  Decision IDs are sequential: DEC-001, DEC-002, ... Never reuse an ID.

  The frontmatter keys are English and machine-read. `status` is a fixed
  vocabulary: proposed | accepted | superseded.

  Fill every <PLACEHOLDER>. Delete these comments.
-->
---
type: decision
id: DEC-XXX                       # next free sequential id, e.g. DEC-012
date: YYYY-MM-DD                  # the date the decision was settled
status: accepted                  # proposed | accepted | superseded
supersedes: null                  # the id this decision replaces, or null
---

# DEC-XXX — <Short Title>

## Context

<!-- What raised this decision. Almost always a grey zone: something the
     prototype and the contract both left unspecified, so it had to be settled.
     State the situation plainly. -->
<Describe the grey zone or situation that forced a decision. What was
unspecified, and where it surfaced.>

## Decision

<!-- What was settled, in one sentence. Unambiguous. This is the rule. -->
<The decision, in one clear sentence.>

## Rationale

<!-- Why this choice and not the alternatives. Name the options considered and
     why the chosen one won. -->
<Why this option. What alternatives were weighed and rejected.>

## Consequences

<!-- What this imposes downstream — on the design, the contract, the code. List
     concrete obligations so an agent can act on them. -->
- **Design / prototype:** <what changes or is constrained>.
- **Contract:** <which contract section must reflect this; link the contract>.
- **Code:** <what the implementation must now do>.

<!--
  AFTER WRITING:
   - Add this id to `related_decisions` in every contract it affects.
   - Update the lower sources (contract, then code) to match — never leave two
     truths coexisting.
   - Link it from the grey-zone ledger row that produced it.
-->
