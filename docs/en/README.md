# Mainstay · Documentation Index (English)

> A mainstay is the line that holds the mast upright. Mainstay is the
> infrastructure that keeps an AI agent's output upright: memory, contracts,
> guardrails.

This is the English reference documentation. French version:
[`../fr/README.md`](../fr/README.md). The documentation is organised in four
blocks: a preface, thirteen core chapters, four scale profiles, and six
reference annexes.

## The spine in one hour

Five reads are enough to understand the method and defend it:

1. [The preface](./00-preface.md): the thesis, the field evidence, when NOT to use Mainstay.
2. [The three pillars](./core/01-three-pillars.md): memory, contract, guardrails.
3. [The delivery chain](./core/04-delivery-chain.md): from an empty repository to production, in a loop.
4. [Grey zones & divergence](./core/05-grey-zones-and-divergence.md): the heart of the method.
5. **The profile that matches you**: see the selector below; only one of the four applies to you.

Everything else is depth: read it when a need hooks you.

## Pick your profile in four questions

The method is the same everywhere; only its embodiment changes. Take the first
row whose answer is yes; the order is the order of the cost of error. The full
reasoning is in [the preface](./00-preface.md#pick-your-profile-in-four-questions).

| Question | If yes | Profile |
|---|---|---|
| Does the code belong to a client, or is a live platform at stake? | The unit of work is the ticket or the audit pass; a timestamped backup precedes every write. | [Profile R · Run & Audit](./profiles/run-and-audit.md) |
| Are you building a product, screen by screen or batch by batch, with a prototype possible? | The canonical chain: proto → grey zones → frozen contract → build → return to vault. | [Profile P · Product Build](./profiles/product-build.md) |
| Are there several real signatories (product and engineering) with financial or regulatory stakes? | Nothing removed from the core; named gates, attestations and wave sequencing added. | [Profile E · Team & Fleet](./profiles/team-fleet.md) |
| Are you alone, with one deliverable and a cycle measured in days? | Functions kept, artifacts reincarnated: the vault becomes a journal, the DoD a checkable acceptance run. | [Profile S · Compressed Solo](./profiles/solo-compressed.md) |

When torn between two profiles, take the lighter one and harden it by dated
decision.

## Preface

| Chapter | What it covers |
|---|---|
| [Preface: Where this method comes from, and when not to use it](./00-preface.md) | The inversion thesis. The field evidence and its epistemic status. The three overhead conditions, the four non-negotiables, the dosage variable. The profile selector. |

## The core: 13 chapters

| # | Chapter | What it covers |
|---|---|---|
| 01 | [The Three Pillars](./core/01-three-pillars.md) | Memory, contract, guardrails. What breaks without each. The "forbidden (cause: dated incident)" template. |
| 02 | [The Vault and the Sources of Truth](./core/02-vault-and-sources-of-truth.md) | Knowledge in the monorepo. The authority table. Vault guardrails under parallel sessions. The semver living guide. |
| 03 | [The Agentic Architecture](./core/03-agent-architecture.md) | The six layers, each carrying its field verdict: two kept, three rebuilt, one emerging. |
| 04 | [The Delivery Chain](./core/04-delivery-chain.md) | Steps 0-6. The hard prohibition: nothing is built until the contract is frozen. The no-prototype and grafted-design variants. |
| 05 | [Grey Zones & Divergence](./core/05-grey-zones-and-divergence.md) | The detection protocol. The two outcomes. The divergence register as twin artifact. The resolution counter. |
| 06 | [The Prompt as a Contract](./core/06-prompt-as-contract.md) | Anatomy of a prompt. Surgical vs rebuild. The resume prompt and the orchestrator mega-prompt. Initiative mandate and posture. |
| 07 | [Adversarial Review](./core/07-adversarial-review.md) | Roles, finding counter-verification, false-positive triage, the two-dry-passes rule, the honest freeze. |
| 08 | [Proof & Probes](./core/08-proof-and-probes.md) | Probes on the real code path, numbered proof files, proof replayed post-release, mock-fidelity audits. |
| 09 | [The Release Gate & Registry](./core/09-release-gate-and-registry.md) | Explicit human go in the current turn. The release registry. Registry-vs-reality reconciliation. Written de-escalation. |
| 10 | [Session Conduct](./core/10-session-conduct.md) | Dated handoffs, "measured, not deduced" state, explicit expiry, state-prefixed titles, memory notes. |
| 11 | [Failure Protocols](./core/11-failure-protocols.md) | Crash recovery. Rollback. Reconciliation. The obsolescence banner: mark, don't rewrite. |
| 12 | [Secrets & PII](./core/12-secrets-and-pii.md) | Written by four real incidents. Pre-push PII gate, key-by-key secret externalisation, tracking of deferred findings. |
| 13 | [Patterns & Anti-Patterns](./core/13-patterns-and-antipatterns.md) | The full catalogue, each with symptom / cost / fix. |

## The profiles: 4 scales

| Profile | For whom | File |
|---|---|---|
| S · Compressed Solo | One head, one deliverable, a cycle in days. | [solo-compressed.md](./profiles/solo-compressed.md) |
| R · Run & Audit | Someone else's code, a live platform, a high cost of error. | [run-and-audit.md](./profiles/run-and-audit.md) |
| P · Product Build | The canonical chain, solo or two-to-three, single or multi-repo. | [product-build.md](./profiles/product-build.md) |
| E · Team & Fleet | Several real signatories, batches and waves, massively parallel sessions. | [team-fleet.md](./profiles/team-fleet.md) |

## The reference: 6 annexes

| Annex | What it covers |
|---|---|
| [Multi-agent orchestration](./reference/orchestration.md) | Role separation, review panels, worktree fleets. "A stage is never closed by whoever built it." |
| [Metrics](./reference/metrics.md) | A proposed, unproven instrument: no metric has yet been collected on a real project. |
| [CI/CD & hooks](./reference/cicd-and-hooks.md) | The git `pre-commit` hook as the main path. The static decision guard in CI. The rest marked prescriptive. |
| [The multi-context portfolio layer](./reference/portfolio-layer.md) | Non-normative annex: proposed, unproven, published with its failure in use. |
| [Technical FAQ](./reference/faq.md) | Sharp answers to common questions. |
| [Glossary](./reference/glossary.md) | Every term defined. The verdict lexicon settled: GO / NO-GO / GO-WITH-CONDITIONS. |

## Old paths

The v1 chapters `00-introduction.md` through `17-glossary.md` are kept as
redirect stubs; inbound links keep working.
