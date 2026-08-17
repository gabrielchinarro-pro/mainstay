# Profile E · Team & Fleet

*Several real signatories, financial or regulatory stakes, dozens of
parallel sessions. This profile removes nothing from the core; it adds:
named gates, attestations, adversarial doubling, wave sequencing.*

> The field facts in this profile come from a private corpus: dated events,
> counts obtained by command, verified by an internal audit in three
> adversarial passes. They are not replayable by the reader.

## When to use it

At least two distinct human signatories (product and engineering) put
their signatures on the contracts, the stakes are financial or regulatory,
and the work advances through massively parallel batches and then waves of
PRs. At this scale the question is no longer "how do we ship a screen" but
"how do we keep dozens of sessions, several humans and a fleet of agents
pointed at the same truth".

The dosage test reads here at its maximum:

> **code ownership × cost of error**: code shared between several owners,
> error at maximal cost.

When an error can cost real money, a regulatory obligation or an
institutional client's trust, you compress nothing: you add. The reference
terrain is a fintech, where the eight-step production protocol was executed
for the first time on a real batch on May 13, 2026, nine days before this
documentation was published.

## Minimum rituals

1. **Named human gates, G1→G5, with the go recorded down to the verbatim**
   in a per-plan state file. Every gate has a name, a keeper, and a trace:
   who said go, when, in which words. A gate crossed without a trace was not
   crossed.
2. **Double signature, product + engineering, then freeze in `SIGNED/` with
   an attestation.** At this scale the frontmatter signature is no longer
   enough: the signatories are not in the same conversation, and the
   attestation materializes the commitment
   ([chapter 04](../core/04-delivery-chain.md)).
3. **Adversarial hardening precedes writing.** Before a contract is drafted
   or a structuring plan executed, the draft document goes through its own
   adversarial pass: load-bearing facts re-verified against the real code,
   graded verdict ([chapter 07](../core/07-adversarial-review.md)).
4. **1:1 adversarial doubling of every coder, on the uncommitted diff.**
   Every coding agent is paired with an adversary who reads the diff before
   commit and can refuse it. This is the mechanism that caught, on this
   terrain, four defects that three product review passes had let through.
5. **Review by rounds, stopping on two consecutive dry passes.** One round
   without a confirmed major closes nothing; two in a row do
   ([chapter 07](../core/07-adversarial-review.md)).
6. **Continuous numbering with a central registry, and written arbitration
   of collisions.** When several sessions create decisions in parallel, two
   `DEC-043`s eventually get born; the central registry hands out the
   numbers, and the collision that happens anyway is resolved by a
   decision, not by a silent rename
   ([chapter 02](../core/02-vault-and-sources-of-truth.md)).
7. **Worktree + port isolation per session; vault PRs separate from code
   PRs; never a push without a go.** Every parallel session has its worktree
   and its port; knowledge and code travel in distinct PRs, read by
   different eyes.
8. **Wave sequencing, when a stock of branches piles up.** Dozens of ready
   branches do not merge in bulk: a chain of roles orders the wave: who
   verifies what, in which order, with which passing criterion
   ([reference · orchestration](../reference/orchestration.md)).

## Mandatory artifacts

| Artifact | Role |
|---|---|
| A collaboration charter with a tiered validation matrix | Who validates what, at which level of stakes; written once, binding afterwards |
| `CT-*` contracts and `LOT-*` batches, with grey-zone registries arbitrated P0/P1/P2 | The contractualized unit of work, its grey zones prioritized and arbitrated |
| Per-plan state files: gates crossed, findings per round | The project's human telemetry: where every plan stands, on evidence |
| A `SIGNED/` folder + attestations | The freeze made material |
| Hardened execution plans + wave-sequencing documents | What survived adversarial hardening, and the merge order |
| Systematic dated handoffs | No session closes without transmitting a measured state ([chapter 10](../core/10-session-conduct.md)) |

## The human system

The method runs on pillars and layers, but everything is operated by
people. Four roles hold it: on a smaller project one person wears several
hats; here they are distinct people, and that is precisely what defines the
profile.

| Role | Owns | Signs | Cannot |
|---|---|---|---|
| **Product signatory** | The "what" of every contract: behaviours, copy, personas | The product line | Freeze alone: the engineering signature is required |
| **Engineering signatory** | The "buildable": endpoints, performance, edge cases | The engineering line | Freeze alone: the product signature is required |
| **Agentic infrastructure architect** | The harness: context files, skills, hooks, agent topology, orchestration tiers | Nothing | Settle a product or engineering question in a signatory's place |
| **Contributors** | Running the chain: prompts, scans, loops | Nothing | Resolve alone a grey zone that requires an authority |

The double signature exists to kill one precise trap: "validated by
product, discovered unbuildable by engineering two weeks later". The role
that scales hardest is the infrastructure architect: at team size it is a
hat, at fleet size it is a function: the harness has become shared
infrastructure everyone depends on.

Four team rituals keep the system alive, on top of the eight project
rituals above:

- **Contract review**: both signatories reread together before the freeze;
  the output is two signatures or a list of gaps, never a partial freeze.
- **Grey-zone triage**: the relevant signatory settles each grey zone as a
  formal decision or a contract note; there is no third outcome
  ([chapter 05](../core/05-grey-zones-and-divergence.md)).
- **Decision recording**: every arbitration returns to the vault as a
  dated `DEC-XXX`; skipping it means rediscovering the same question next
  batch.
- **Vault hygiene**, on a calendar cadence: expired contracts marked,
  superseded decisions marked `superseded`, divergences reconciled.
  Coherence debt is invisible until everything breaks at once.

### Scaling up

The method does not change with scale; the coordination cost does.

| Stage | What is true | What to watch |
|---|---|---|
| **Two-to-three** ([profile P](./product-build.md)) | Distinct roles, one vault, frontmatter signatures | Signature latency: make signing a fast ritual, not a meeting |
| **Team** | Named gates, `SIGNED/`, adversarial doubling | Signatures trailing behind the code (see risks) |
| **Fleet** | Dozens of parallel sessions, PR waves, central number registry | Collisions: of numbers, branches, decisions. Everything shared has a registry |

## What you allow yourself to drop

**Nothing from the core.** This is the only profile of the four where the
answer is empty: every ritual of the lighter profiles is kept, and rituals
are added. That is the dosage variable read at its maximum.

One relaxation, made knowingly: **"one prompt = one prototype" stops being
mandatory for internal tooling.** The terrain created the
contract-without-prototype precedent: a tool with no screen is
contractualized directly, and the variant is owned in writing in
[chapter 04](../core/04-delivery-chain.md). The relaxation is bounded: it
holds for tooling, not for the screens users see.

## Documented risks at this scale

**Signatures trailing behind the code.** At high fleet speed, the build
outruns the signatories, and the temptation is to build "while waiting for
the signature". The corpus records the breach, and the rule it founded: an
unsigned contract freezes nothing, and what is built on it is built
uncovered.

**Gates loosened orally, without ratification.** A state file in the corpus
carries the trace of a gate relaxed by voice, never ratified in writing.
The rule that follows is absolute: **any oral lifting of a gate is recorded
or void.** A gate you can lift with a word in a meeting is not a gate. It
is scenery.

**Adoption failure modes**, observed and corrected in the field:

| Failure | Symptom | Fix |
|---|---|---|
| Vault treated as a wiki | Knowledge lives outside the repo, never current | The vault is in the repo, versioned with the code; vault PRs exist, separate from code PRs |
| Single-signature contracts | Product validates, engineering discovers unbuildability late | Two signatures or no freeze |
| "We'll decide later" | A backlog of open grey zones | Two triage outcomes, never three |
| Under-investing the contract phase | High iteration counts, chained rework | The project's energy goes into the contract, not the correction |
| Obese context file | Slow agents that lose the thread | Lean, layered root context; the detail lives in the contracts |
| Complacency gates | Gates always pass, fast | The go is verbatim, dated, carried by a name, and its oral lifting is void |

## The layer above is not a profile

At this scale the temptation exists to add a fifth storey: a multi-context
steering layer above several projects. The corpus contains one attempt:
built in fourteen minutes, dead within a day, rituals never instantiated.
It is published as is, with its failure, as a
[non-normative annex](../reference/portfolio-layer.md): proposed, unproven.
The lesson holds for the whole grid: installing the structure does not
create the practice.

## Original terrain

A fintech (an eight-step production protocol, executed for the first time
on a real batch on May 13, 2026) in the private corpus.

## See also

- [Chapter 02 · The Vault and the Sources of
  Truth](../core/02-vault-and-sources-of-truth.md): continuous numbering,
  guardrails under parallel sessions
- [Chapter 04 · The Delivery Chain](../core/04-delivery-chain.md): the
  double signature, the contract-without-prototype variant
- [Chapter 06 · The Prompt as a Contract](../core/06-prompt-as-contract.md):
  the orchestrator mega-prompt with an exit gate
- [Chapter 07 · Adversarial Review](../core/07-adversarial-review.md): 1:1
  doubling, adversarial hardening, two dry passes
- [Chapter 09 · The Release Gate & the
  Registry](../core/09-release-gate-and-registry.md): the verbatim go
- [Chapter 10 · Session Conduct](../core/10-session-conduct.md): dated
  handoffs, measured state
- [Reference · Orchestration](../reference/orchestration.md): worktrees,
  fleet, waves
- [Reference · The multi-context steering
  layer](../reference/portfolio-layer.md): the non-normative annex
