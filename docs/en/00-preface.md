# Preface: Where this method comes from, and when not to use it

*Mainstay is practice turned into theory, not theory put into practice. This
preface gives you the thesis, the evidence, the limits, and your entry point
in four questions.*

## The thesis: the inversion

Everyone is watching the model. The game is being played somewhere else.

A single sentence carries the whole thesis:

> The best model in the world, sitting on shaky infrastructure, will always
> produce a shaky project. Solid infrastructure, even served by an ordinary
> model, ships whole features in weeks.

Your energy does not go into the model. It goes into the three pillars:
memory, contract, guardrails. Everything in this documentation is, in some
way, a consequence of that choice. It is an inversion: while the industry
benchmarks brains, Mainstay builds what surrounds them, and that is what
separates an impressive demo from software in production.

## Where this method comes from

### Practice came before doctrine

The order of the dates matters. The eight-step production protocol was
executed for the first time on a real batch of work on 13 May 2026. The
repository you are reading was published on 22 May 2026, nine days later. The
canon then kept absorbing patterns from the field, with dated commits to show
for it, through early June 2026. Nothing here was written and then tried;
everything was tried and then written.

That chronology is not there for bragging rights. It explains the shape of
this documentation: rules carry their causes, prohibitions cite their incidents,
and the method's own violations of the method are on the record, because they
are what the rules were built from.

### What the field has proven

On a legacy e-commerce platform in production, five days separate the first
commit under the method from switching all of the client's shops over to
production (4 to 9 June 2026). The first commit describes itself as "Mainstay
light": the method entered in its compressed form, and the compressed form is
what held. That same platform has since kept a registry under one simple rule
(no release without an entry, no entry without a release): 239 entries and 193
version tags between June and August 2026, with the human go recorded down to
the decision-maker's exact words. Including its two absences. The two releases
that went out without a requested go are cited in the registry, entry by
entry, and are precisely what produced the gate protocol that now makes them
impossible to repeat in silence. A dated reconciliation later realigned the
registry against the actual state of the server: verified on the server, not
from memory.

On that same platform, the discipline of proof caught real money. A missing
VAT on shipping fees, found across 146 orders, was fixed with a probe
measuring the actual code path: 44 cases verified, zero change to the price
any customer paid. A broken payment callback was repaired with two customer
orders recreated, and acceptance-tested on a real harness. No amount is
published, anywhere.

On a fintech, a backend component shipped as a strictly additive diff (17
files, 1,578 insertions, zero deletions) with 61 green tests, and the
adversarial review, run in rounds, only closed after two consecutive passes
with no major defect, six rounds in all. The same fintech is where adversarial
review showed what it catches and classic acceptance testing misses: three
acceptance passes by two product reviewers had returned GO; the two
adversarial reviewers refused the commit twice, over four defects no
acceptance pass had seen: a schema validation that blocked what it should
not, a comparison that tolerated too much, a product decision silently
reversed, a deletion aimed at the wrong target.

Adversarial verdicts are not taken on faith either. On a two-developer,
multi-repo product, a thirteen-agent audit before pre-production
counter-verified every one of the seven alleged blockers: six downgraded, one
refuted. On the same product, a privilege risk named at architecture-decision
time (a token never scoped as read-only) was closed with a read-only-scoped
token, dated commit of 4 August 2026 in evidence. The counter-verification
repeats elsewhere: on a pilot feature on a SaaS product, a multi-agent
adversarial review produced 45 raw findings of which 32 were confirmed:
thirteen false positives dismissed with a written technical justification; on
an audit vault on a client's platform, thirty agents produced 24 findings of
which 19 were confirmed. The method does not count its findings. It refutes
them.

It also records its non-convergences. A batch whose major-defect count was
*rising* between two rounds (thirteen, then twenty-one) was frozen in
writing, with the sentence "this is not convergence" and a written prohibition
on reopening it without a human go. Declaring an honest freeze instead of a
finished job is a verdict of the method, not a failure of it.

At the other end of the scale, a personal site went from study to launch in
two days (study on 6 August, live on the 7th, consolidation on the third day)
with 22 numbered, dated, attributed decisions across three days of journal,
a six-round reviewer-agent loop that fixed 25 findings including two blockers,
and an adversarial acceptance run whose first verdict was a NO-GO with four
blockers: all fixed, then re-measured. On that same site, the rule "no number
without a verified source" caught three wrong public figures and one
arithmetic inconsistency before publication; the error, its verification and
the rule it produced are all on the record, without the faulty figures being
republished.

Finally, the supervision this documentation promises is structured, not
absent. On every terrain, the rule is an explicit human go, recorded down to
the decision-maker's exact words, before any release, any client-facing send,
and any account creation. Its known violations are themselves in the
registries, where they produced the rule.

### The status of this evidence

All of the evidence above comes from a private corpus: dated facts, counters
obtained by running commands against the artifacts themselves, verified by an
internal audit in three adversarial passes: evidence, completeness,
publishability. It is not replayable by you, the reader: the repositories
belong to clients and private products, and they will stay private. What this
documentation forbids itself in exchange: no figure that could not be verified
even internally is published, no fictional example ever carries a number
presented as real, and no phrasing allows a client to be identified. You are
free not to believe these numbers. You are not free to find an invention in
them: every one has a dated artifact behind it.

## When NOT to use Mainstay

The full method is dead weight when three conditions hold at once:

1. **You own the code.** Nobody else depends on your choices, nobody audits
   you, no contract binds you.
2. **Errors are reversible.** A defect is fixed by shipping again; it costs no
   customer money, no data, no trust.
3. **The work fits in one head.** A single person can hold the system's
   complete state without handing it over.

When all three are true, the vault, the screen contracts, the ledger and the
named gates are overhead with no counterpart. The corpus carries two
demonstrations of this, pointing in opposite directions.

**The counter-example by success: the single-spec bot.** A wholly-owned
ordering bot was run with none of the Mainstay apparatus: one specification
file of 736 lines written *before* the first line of code, an interface map of
781 lines, and an allowlist of syntactic checks run on every file. Zero vault,
zero numbered decisions, zero ledger, zero release registry. And yet: an MVP
in real use the same day as the spec, a v1 committed the next day, eleven
commits in three days. The exhaustive single-file spec played, by itself, the
role of contract, interface map and memory. On an owned, reversible, one-head
product, that is enough. And it is faster.

**The counter-example by failure: the exoskeleton that died in a day.** The
opposite is just as well documented: tooling without rituals is dead weight. A
multi-context steering exoskeleton (77 files created in fourteen minutes)
never lived a second day: not one file modified since creation, git never
initialized despite its own "cardinal rule", zero instances of the weekly
review it prescribed, journal stopped on the day of its birth. A complete
skeleton that never took a second heartbeat. The lesson is blunt: installing
structure does not create practice. If you are not going to run the rituals,
do not build the tooling. (That layer is published as is, failure included, as
a [non-normative annex](./reference/portfolio-layer.md).)

### What stays non-negotiable, even there

Even on the smallest owned, reversible job, four disciplines are not up for
negotiation, because the link that breaks is the same at every scale: closure
never happens on its own.

1. **A human go before any send, publication or push.** The single-spec bot
   itself never sent a supplier email without recorded proof of the send.
2. **A dated trace of decisions, even one line long.** The same bot
   accumulated eight fix commits without a single recorded why, and that is
   exactly the knowledge missing when work resumes.
3. **Returning to the spec after divergence.** The bot's spec diverged from
   its code the very day of v1: a capability still declared out of scope in the
   spec was already implemented in the code. A dated obsolescence banner costs
   one line and prevents documentary lying: mark, don't rewrite.
4. **A minimal replayable verification.** On the bot, the allowlist of
   syntactic checks is precisely the ritual that outlived everything else.
   Yours can be just as small, but it must exist and replay from one command.

### The dosage variable

The variable that governs how much apparatus you need is neither the size of
the code nor the length of the job. It is:

> **code ownership × cost of error**

That is the joint lesson of the corpus's two extremes: the full method,
hardened, on an audit vault sitting on code you do not own; and a single spec
on an owned, reversible, one-head product. A three-hundred-line script that
touches a client's production deserves more apparatus than a
thirty-thousand-line product only you can break.

| | Reversible error | Costly error |
|---|---|---|
| **You own the code** | Single spec + the four non-negotiables | Compressed solo profile, real registry |
| **Someone else's code / live platform** | Run & audit profile, lightened by written decision | Full method, hardened |

## Pick your profile in four questions

The method is the same everywhere; only its embodiment changes. Four questions
find yours.

1. **Is the code yours, or someone else's?** A client's code, a live platform,
   a high cost of error → [Profile R · Run &
   audit](./profiles/run-and-audit.md). The unit of work there is the ticket
   or the audit pass, not the screen, and a timestamped backup precedes every
   write.
2. **Are you building a product, or running and auditing what exists?**
   Building screen by screen or batch by batch, with a prototype possible →
   [Profile P · Product build](./profiles/product-build.md). This is the
   canonical chain: prototype → grey zones → frozen contract → build → return
   to the vault.
3. **Are you alone, or are there several real signatories?** At least two
   distinct human signatories (product and engineering), financial or
   regulatory stakes, massively parallel workstreams → [Profile E · Team &
   fleet](./profiles/team-fleet.md). This profile removes nothing from the
   core; it adds named gates, attestations and wave sequencing.
4. **Is the cycle measured in days, or in months?** One head, one deliverable,
   a cycle in days → [Profile S · Compressed
   solo](./profiles/solo-compressed.md). Functions kept, artifacts
   reincarnated: the vault becomes a journal, the definition of done a
   checkable acceptance run with proofs.

Take the first question whose answer points you to a profile; the order is
the order of the cost of error. When torn between two profiles, take the
lighter one and harden it by dated decision: that is what the dosage variable
means, and it is what the field actually did.

## How to read the rest

The short path: this preface, then [the three
pillars](./core/01-three-pillars.md), [the delivery
chain](./core/04-delivery-chain.md), [grey
zones](./core/05-grey-zones-and-divergence.md), and your profile. That is
enough to understand the method and defend it. The rest ([adversarial
review](./core/07-adversarial-review.md), [proof and
probes](./core/08-proof-and-probes.md), [the release
gate](./core/09-release-gate-and-registry.md)) is there for when a need hooks
you.

## See also

- [The three pillars](./core/01-three-pillars.md)
- [The delivery chain](./core/04-delivery-chain.md)
- [Adversarial review](./core/07-adversarial-review.md)
- [The profiles](./profiles/solo-compressed.md): compressed solo, [run &
  audit](./profiles/run-and-audit.md), [product
  build](./profiles/product-build.md), [team &
  fleet](./profiles/team-fleet.md)
- [The multi-context steering layer (non-normative
  annex)](./reference/portfolio-layer.md)
