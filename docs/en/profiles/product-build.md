# Profile P · Product Build

*The canonical chain lives here: proto → grey zones → frozen contract →
build → return to vault. Solo or two-to-three, single repo or multi-repo:
this is the profile the method was written for.*

> The field facts in this profile come from a private corpus: dated events,
> counts obtained by command, verified by an internal audit in three
> adversarial passes. They are not replayable by the reader.

## When to use it

You are building a product screen by screen or batch by batch, a prototype
is possible, and you are alone or two-to-three: a pair with a partner
developer, a small agency, a founder and their first hire. This is the
profile of the full [delivery chain](../core/04-delivery-chain.md), applied
as written: two batches in the corpus prove it: on a two-developer,
multi-repo product, the sequence proto → grey-zone scan → contract v1.0 →
v1.1 with double signature → build ran in exactly that order; on an agency's
internal cockpit, dated commits show the contract committed *before* the
first build commit.

The dosage test:

> **code ownership × cost of error**

The code is yours (or shared with a named partner), and the error costs:
a product that has or will have users, a preprod that commits you, a frozen
reference to match to the pixel. If the code belongs to a third party, move
to [profile R](./run-and-audit.md); if you are alone on a days-long
deliverable, [profile S](./solo-compressed.md) is enough; if several
distinct human signatories enter the picture, move up to
[profile E](./team-fleet.md).

## Minimum rituals

1. **The full chain, whenever there is a screen**: prototype → grey-zone
   scan → contract frozen with double signature **before** the build →
   definition of done → return to vault. The order is the ritual; a
   contract signed after the code is a chronicle, not a contract.
2. **A stage is never closed by the one who built it.** The adversarial
   loop runs to convergence (zero confirmed majors *and* one real refutation
   attempt that fails), and if the defect count climbs instead of falling,
   you freeze in writing: the
   [honest freeze](../core/07-adversarial-review.md) is a verdict, not a
   failure.
3. **A deviation registry when the reference is frozen; a grey-zone ledger
   otherwise.** When you rebuild against a reference (an existing site, a
   pixel-perfect mock), every observed deviation gets a status (owned,
   fixed, to-arbitrate, or **dated** deferral), and in both forms the
   arbitrations go up to the human, by name: the agent proposes a status, it
   does not decide one
   ([chapter 05](../core/05-grey-zones-and-divergence.md)).
4. **A dated handoff at the end of the workstream**, carrying a *verified*
   state (measured by command, not recalled from memory) and an expiry
   banner that says how long to trust it
   ([chapter 10](../core/10-session-conduct.md)).
5. **The production go gate is distinct from preprod**, with a registry and
   tags. Passing preprod authorizes nothing; production is a second, human,
   recorded go ([chapter 09](../core/09-release-gate-and-registry.md)).
6. **Read-only probes before any architecture decision.** Before settling a
   refactor, you measure the existing system with probes that modify
   nothing: the decision rests on collected numbers, not on the agent's
   intuition ([chapter 08](../core/08-proof-and-probes.md)).
7. **Any ritual you abandon is abandoned by dated decision, never by
   attrition.** The corpus carries an exemplary de-escalation: a release
   registry declared not applicable *in writing*, with its reason, in a
   numbered decision. That is the difference between a dosage and a drift.

## Mandatory artifacts

| Artifact | Role |
|---|---|
| A context file with "no interpretation" guardrails and explicit freezes | What the agent may not decide, and what is frozen |
| `vault/`: `decisions/` + `contracts/` + grey-zone ledger **or** deviation registry + per-batch loop journals | The project's full memory, including the history of adversarial rounds |
| `RELEASES.md` + tags, or their written de-escalation if there is no production yet | The registry, or the dated decision not to keep one |
| Review notes per batch | What was verified, by whom, with which measurements |
| The multi-repo module below, whenever the boundary exists | The discipline of the seam |

## The twin: grey-zone ledger or deviation registry

This profile knows two forms of the same project, and each has its own
divergence artifact. Confusing them is expensive; the choice is made when
the workstream opens, not along the way.

| | New product | Rebuild against a frozen reference |
|---|---|---|
| The question asked of every observation | "Did the contract explicitly ask for this?" | "Does the reference show this?" |
| The artifact | Grey-zone ledger | Deviation registry |
| The outcomes | Formal decision or contract note, never a third | Owned, fixed, to-arbitrate, or **dated** deferral |
| Who decides | The relevant signatory | The human, by name: the agent proposes a status, it does not decide one |
| The documented trap | Grey zones adjudicated but never closed in the registry | The undated deferral, a grey zone in disguise |

Both forms obey the same underlying law
([chapter 05](../core/05-grey-zones-and-divergence.md)): make the invisible
decision visible, and never leave it to someone without the authority to
take it.

## Module · multi-repo and third-party developer

The moment the product crosses a boundary (several repositories, or a
repository that belongs to a partner), four rules are added. They were
proven independently on two terrains of the corpus: a two-developer,
multi-repo product and a pilot feature on a SaaS product spanning four
repositories.

1. **The boundary is a decision, not a fact of life.** Who owns what, where
   the seam runs, who may write where: recorded in a dated decision in the
   vault, taken *before* building on either side. On the two-developer
   product, it is decision number one of the whole project.
2. **Boundary fixtures are byte-identical and tested from both sides.** The
   same fixture file is committed in each repository, and each side carries
   a test that verifies conformity to the byte. Two "equivalent" copies
   always diverge; two byte-identical tested copies cannot. It is the
   contract-first of [chapter 04](../core/04-delivery-chain.md), made
   verifiable by command.
3. **Grey zones are inherited by name across the boundary.** A grey zone
   born on one side ("what does the back end do when the field is empty?")
   is written verbatim, under the same identifier, into the other side's
   registry. Without inheritance by name, each repository resolves the same
   question on its own. Differently.
4. **On the third party's repositories: branch + PR, never main.** No direct
   write to the main branch of a repository you do not own, whatever the
   level of trust. The PR is the gate; the third party is the signatory of
   their own territory.

## What you allow yourself to drop

**Named gates G1→G5 and the `SIGNED/` folder.** The double signature in the
contract's frontmatter is enough at two or three: the signatories talk to
each other, and the formal attestation adds only weight. It becomes
mandatory again at [profile E](./team-fleet.md), where the signatories are
no longer in the same conversation.

**The massive worktree fleet and delivery waves.** Two or three parallel
workstreams can be steered by hand; wave sequencing is a fleet tool, not a
trio tool ([reference · orchestration](../reference/orchestration.md)).

**The formal evaluation bench.** No terrain in this profile built one. The
per-batch adversarial loop stands in for it: less systematic, but actually
practised.

Each of these drops follows ritual 7: it is enacted by a dated decision that
says what is dropped and why. That is what separates it from neglect, and
what lets you revisit it the day the scale changes.

## Documented risks at this scale

**Vault fossilization.** The vault is alive as long as you write to it; it
fossilizes the moment the build's pace outruns the recording's pace. The
corpus shows it on evidence: a release registry left empty despite eleven
tags, an index lagging behind the files it claims to index. A fossil vault
is worse than none: it answers wrong things with confidence.
Countermeasure: vault hygiene is a calendar ritual, and the
index-in-the-same-commit rule applies
([chapter 02](../core/02-vault-and-sources-of-truth.md)).

**Versioning that silently stops.** Two terrains in the corpus carry dozens
of uncommitted paths (85 on one, 123 on the other) accumulated "by
choice" of the human, with no decision enacting it. The rule that follows:
**a prolonged non-commit is either a dated decision or an anomaly**: there
is no third status. What is not committed is not backed up, not
transmissible, not auditable; if it is deliberate, it gets written down.

**The deferral that never ends.** The deviation registry allows the *dated*
deferral, its fourth status. A deferral without a date, or whose date has
passed unexamined, is a grey zone that has learned to disguise itself. The
resolution counter of
[chapter 05](../core/05-grey-zones-and-divergence.md) exists precisely
because one terrain adjudicated hundreds of grey zones… without ever closing
a single one in the registry.

## Original terrain

A two-developer, multi-repo product, an agency site rebuilt against a frozen
reference, and an agency's internal cockpit, all three in the private
corpus.

## See also

- [Chapter 04 · The Delivery Chain](../core/04-delivery-chain.md): the
  sequence this profile applies as written
- [Chapter 05 · Grey Zones &
  Divergence](../core/05-grey-zones-and-divergence.md): the ledger and its
  twin, the deviation registry
- [Chapter 06 · The Prompt as a Contract](../core/06-prompt-as-contract.md):
  the contract that precedes the build
- [Chapter 07 · Adversarial Review](../core/07-adversarial-review.md):
  closure by someone other than the builder, the honest freeze
- [Chapter 09 · The Release Gate & the
  Registry](../core/09-release-gate-and-registry.md): preprod and prod, two
  gates
- [Chapter 10 · Session Conduct](../core/10-session-conduct.md): the dated
  handoff, the measured state
- [Profile E · Team & fleet](./team-fleet.md): when the signatories become
  several
