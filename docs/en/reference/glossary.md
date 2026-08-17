# Glossary

*Every Mainstay term, defined and linked to the chapter that covers it. The verdict lexicon is settled here: GO, NO-GO and GO-WITH-CONDITIONS are the canon.*

Terms are listed alphabetically. Each entry gives a one-paragraph definition and a link to the chapter where the term is treated in full.

---

### Adversarial hardening

Adversarial review applied *before* production: a contract, an execution plan or a structuring decision is submitted to contradictors before being signed or executed. You harden the document while it costs a sentence to fix, not a project. See [Adversarial review](../core/07-adversarial-review.md).

### Agentic infrastructure architect

The person responsible for the harness itself: context files, skills, hooks, shared briefs, the role and fleet topology. The method has no stable name for this role; this is the working name. See [Profile · Team & fleet](../profiles/team-fleet.md).

### API spec

The versioned specification of the back end's interface, frozen *first* in the contract-first build. See [The delivery chain](../core/04-delivery-chain.md).

### Audit vault

The method applied to code you do not own: absolute read-only on existing code, database and infrastructure; citations marked "verified in the audit, to be re-verified on the live code"; no contract frozen during the pass; new code confined to self-contained packages. The method as a proof-and-write-guard apparatus before it is a delivery chain. See [Profile · Run & audit](../profiles/run-and-audit.md).

### Compact synthesis

The output of an exploration subagent: an answer, not a transcript: conclusions, named sources, ambiguity surfaced explicitly. See [Multi-agent orchestration](./orchestration.md).

### Conductor

The top tier of the orchestration grid, the strongest model, used sparingly for what cannot be delegated: architecture, contracts, arbitration. Associated field rule: the orchestrator does not trust agent reports; it re-measures itself. See [Multi-agent orchestration](./orchestration.md).

### Consistency debt

The cost that accumulates when sources of truth diverge: a note, a contract and code contradicting each other. Invisible until the day everything breaks at once. See [The vault and sources of truth](../core/02-vault-and-sources-of-truth.md).

### Context drift

An agent's tendency, in a long or under-constrained session, to wander beyond the requested scope. Countered by closing prohibitions, short sessions and the handoff. See [Failure protocols](../core/11-failure-protocols.md).

### Context file

The file loaded at the start of every agent session: lean (stable cross-cutting rules, prohibitions with their cause), layered (a short root file pointing to files loaded on demand). See [Agent architecture](../core/03-agent-architecture.md).

### Contract

A specification with acceptance criteria (behaviour, edge cases, endpoints, permissions, test data), signed by product and engineering, then frozen. The agent knows what is expected; you know what to verify. See [The prompt as a contract](../core/06-prompt-as-contract.md).

### Contract-first

The build approach where the frozen contract and API spec are the shared truth: front on spec-derived mocks, back behind feature flags, wiring in waves. See [The delivery chain](../core/04-delivery-chain.md).

### Dated deferral

The *framed* third outcome of the divergence register: a divergence explicitly deferred to a planned pass, with a date and a scope. Distinct from "we'll decide later", which remains forbidden: the dated deferral is tooled, visible and bounded; the silent deferral is a grey zone waiting for integration. See [Grey zones and divergence](../core/05-grey-zones-and-divergence.md).

### De-escalation

The *written* abandonment of a ritual: a dated decision declares the rule not applicable to the context, with its reason, and forbids re-flagging its absence as debt. This is what separates legitimate modulation from silent non-compliance. Any abandoned ritual is abandoned by dated decision, never by attrition. See [The release gate and registry](../core/09-release-gate-and-registry.md).

### Definition of done (DoD)

The per-layer checklist that decides whether work is complete. "Almost done" does not exist: a layer is done or it is not. See [The delivery chain](../core/04-delivery-chain.md).

### Delivery chain

The seven-step path from empty to production: vault → prototype → grey-zone scan → contract → parallel build → definition of done → return to vault. Each cycle leaves the infrastructure richer. See [The delivery chain](../core/04-delivery-chain.md).

### Dismissed false positive

A review finding counter-verified against the real code and rejected, *with its written technical justification, recorded next to the finding*. "Dismissed" without a written reason does not exist. The method does not count its findings: it refutes them. See [Adversarial review](../core/07-adversarial-review.md).

### Divergence register

The twin artefact of the grey-zone ledger, for reconstruction against a **frozen reference**: it records *measured divergences*, with four statuses: fixed, owned (divergence kept and justified), to arbitrate, and dated deferral to a planned pass. Arbitrations go up to the human, by name. See [Grey zones and divergence](../core/05-grey-zones-and-divergence.md).

### Dry pass

A complete review pass that produces no confirmed major defect. The adversarial review's stopping rule: the loop only closes after **two consecutive dry passes**: a single one can be luck or laziness. See [Adversarial review](../core/07-adversarial-review.md).

### Eval harness

The runner that executes evaluation cases (golden tasks, guardrail probes, regression sets) against an agent and scores the results. Status: prescriptive, not field-proven. See [Proof and probes](../core/08-proof-and-probes.md).

### Explicit go

The human authorisation given *in the current turn*, in so many words, before any push to production, publication or send. Passing acceptance or preproduction never counts as a go; "let's keep going" is not a go. The go is recorded verbatim in the release registry. See [The release gate and registry](../core/09-release-gate-and-registry.md).

### Full rebuild

A prompt mode that starts a screen from zero and forbids reusing existing code, for when accumulated touch-ups have made the code incoherent. See [The prompt as a contract](../core/06-prompt-as-contract.md).

### Gate

A named stopping point of the project that no progress crosses without a recorded human go. At fleet scale, gates are numbered and held in a state file; any oral lifting of a gate is recorded or void. The terminal gate of every project is the push to production. See [The release gate and registry](../core/09-release-gate-and-registry.md) and [Profile · Team & fleet](../profiles/team-fleet.md).

### Golden task

A fixed, representative task with a known-good expected outcome, used to regression-test the *method* when a prompt, context file or model changes. See [Proof and probes](../core/08-proof-and-probes.md).

### Grey zone

Anything the agent decided on its own because neither the prototype nor the contract specified it. Not a bug; a decision made in the dark by someone without authority. Spelled "grey" throughout Mainstay. See [Grey zones and divergence](../core/05-grey-zones-and-divergence.md).

### Grey-zone ledger

The running record of grey zones found during scans and their resolution: each settled as a formal decision or a contract note before the freeze. A ledger that records without resolving is not a ledger: it is a waiting list. See [Grey zones and divergence](../core/05-grey-zones-and-divergence.md).

### Guardrail

What the agent must never do, written explicitly and placed beyond its interpretation. Every major guardrail cites the incident that founded it. See [The three pillars](../core/01-three-pillars.md).

### Guardrail probe

An evaluation case that tries to make the agent do something forbidden and only passes if the agent refuses or escalates. See [Proof and probes](../core/08-proof-and-probes.md).

### Handoff

The dated artefact that formalises the pass-over between sessions: exact state *measured, not inferred*, locked decisions, known traps, first resumption action. Stale = marked stale. The most universal practice in the corpus. See [Session conduct](../core/10-session-conduct.md).

### Honest freeze

The verdict that closes a *non-converging* review loop: when the major count rises instead of falling, the lot is frozen in writing (state recorded, reopening forbidden without a human go) instead of being declared finished. A first-class verdict, on the same rank as GO and NO-GO. See [Adversarial review](../core/07-adversarial-review.md).

### Hook

A deterministic trigger attached to an event in the working cycle. It asks the model nothing; it executes. The proven main road is the git `pre-commit` hook versioned in the repository. See [CI/CD and hooks](./cicd-and-hooks.md).

### Initiative mandate

The prompt section that fixes what the agent may decide alone: *locked* (execute to the letter, escalate every deviation) or *open* (propose, with an obligation to record). See [The prompt as a contract](../core/06-prompt-as-contract.md).

### Iterations per screen

Proposed metric: the number of generation passes a screen requires, target 1. A high value means the upstream contract was vague. Status: proposed, unproven instrument. See [Metrics](./metrics.md).

### Lieutenant

The middle tier of the orchestration grid: a mid-tier model for structured work whose frame is set by a contract. Escalates ambiguity instead of guessing. See [Multi-agent orchestration](./orchestration.md).

### Living guide

A single synthesis document, semver-versioned, standing in for a fragmented vault when the project is an audit or a graft: a revision journal standing in for a registry, two reading levels, and an embedded challenge protocol: the prompt to verify it against reality is in the document itself. See [The vault and sources of truth](../core/02-vault-and-sources-of-truth.md).

### Mainstay

The method this repository documents, agent-driven software delivery, built on three pillars: memory, contract, guardrails. The name evokes the stay that keeps a mast upright. See the [preface](../00-preface.md).

### MCP server

A server exposing structured, contract-defined access to an external resource. Field status: the method *consumes* existing MCP servers; it does not write them. See [Agent architecture](../core/03-agent-architecture.md).

### Monorepo

A single repository hosting both code and knowledge, sharing history and reviews: a schema change and its documentation travel in the same commit. See [The vault and sources of truth](../core/02-vault-and-sources-of-truth.md).

### Orchestrator mega-prompt

The prompt genre that installs a full orchestration session: named roles, looping pipeline, session invariants (worktree, port, prohibitions), a checklist exit gate and an initiative mandate. See [The prompt as a contract](../core/06-prompt-as-contract.md).

### Probe

A measurement point placed on the **real code path** (never a reimplementation, never an agent's word), producing instrumented proof of a behaviour before it is asserted. See [Proof and probes](../core/08-proof-and-probes.md).

### Progressive disclosure

The principle that an agent only loads a capability's detail when a task triggers it: the mechanism behind the skills layer. See [Agent architecture](../core/03-agent-architecture.md).

### Prototype

The first runnable version of a screen, produced in a single generation request. Compared to the contract in a grey-zone scan; once validated, it becomes the basis of the signable contract, and "proto = truth" for rendering. See [The delivery chain](../core/04-delivery-chain.md).

### Reconciliation

The periodic verification that a registry still tells the truth, against the *real* state of the system: the server, not memory. An unreconciled registry drifts like a wiki. See [The release gate and registry](../core/09-release-gate-and-registry.md).

### Regression set

The accumulated corpus of an agent's past failures, frozen into evaluation cases so they cannot recur. See [Proof and probes](../core/08-proof-and-probes.md).

### Release registry

The single file (`RELEASES.md` by convention) held under the symmetric rule: no push to production without an entry, no entry without a push to production. Each entry carries the nature of the change, the acceptance, the backup/rollback and the go verbatim; a plain-language line makes it readable by a non-technician; a version tag anchors it in history. See [The release gate and registry](../core/09-release-gate-and-registry.md).

### Resumption prompt

The prompt genre that reopens a project: dated, measured state (checkable by command), locked decisions, known traps, expected posture, imposed first action. The handoff's twin, addressed to the next agent. See [The prompt as a contract](../core/06-prompt-as-contract.md) and [Session conduct](../core/10-session-conduct.md).

### Runner

The light tier of the orchestration grid: the cheapest model that reliably performs fully specified deterministic routines. Exercises no judgement. See [Multi-agent orchestration](./orchestration.md).

### Self-correction loop

The cycle created by a deterministic check: the agent edits, the check runs, the failure returns with actionable output, the agent corrects minimally, the check runs again. Its real seat in the field is the git `pre-commit` hook. See [CI/CD and hooks](./cicd-and-hooks.md).

### Skill

A folder encapsulating a reusable capability, loaded under progressive disclosure. Procedural memory, where the context file is declarative memory. See [Agent architecture](../core/03-agent-architecture.md).

### Source of truth

The single authority for a class of fact: code for the schema, the vault for conventions and decisions, the validated prototype for the visual, the contract for behaviour. When two diverge, the higher wins and the lower is updated at once. See [The vault and sources of truth](../core/02-vault-and-sources-of-truth.md).

### Staleness banner

The dated line placed at the top of an outdated artefact: "stale since [date], superseded by [path]". You mark, you neither rewrite nor delete: history stays readable and the doc stops lying for the price of one line. See [Failure protocols](../core/11-failure-protocols.md).

### Subagent

A dedicated agent instance with its own context and an assigned role. Profitable patterns: the explore/edit split, and the fan-out read-only review panel. See [Multi-agent orchestration](./orchestration.md).

### Surgical modification

A prompt mode that fixes one precise thing and closes with the capital prohibition "no modifications other than this one". The opposite of the full rebuild. See [The prompt as a contract](../core/06-prompt-as-contract.md).

### Validated prototype

A prototype that has passed its grey-zone scan and is accepted as the visual source of truth. See [The vault and sources of truth](../core/02-vault-and-sources-of-truth.md).

### Vault

The navigable knowledge layer of the monorepo: decisions, contracts, concepts. It indexes and gives meaning, but never contradicts the code: a layer of meaning on top of the layer of truth. See [The vault and sources of truth](../core/02-vault-and-sources-of-truth.md).

### Verdict (GO · NO-GO · GO-WITH-CONDITIONS)

The canonical lexicon of review verdicts, settled here. **GO**: no confirmed major. **NO-GO**: at least one confirmed major; back to the producer. **GO-WITH-CONDITIONS**: named reservations, each dated and owned by someone; a condition without a deadline and an owner requalifies the verdict as NO-GO. Two state verdicts complete the set: the **honest freeze** (non-converging loop, frozen in writing) and closure on **two dry passes**. Any other verdict lexicon (traffic lights, GREEN/PENDING/RED) does not belong to the canon. See [Adversarial review](../core/07-adversarial-review.md).

### Wave

The delivery scale above the lot: a stock of finished branches, arbitrated in writing into ordered PRs (dependencies, risks, splits) by a chain of roles. The wave has its own artefact, the sequencing document. See [Multi-agent orchestration](./orchestration.md).

### Wiring in waves

Connecting front and back endpoint by endpoint rather than all at once at the end: a progressive, verifiable replacement of mocks by real endpoints. See [The delivery chain](../core/04-delivery-chain.md).

### Worktree

An additional git checkout of the same repository, in its own folder, on its own branch. The unit of isolation for fleet work: one session = one worktree + one dedicated port, and the main checkout stays untouchable. See [Multi-agent orchestration](./orchestration.md).

---

## See also

- [The three pillars](../core/01-three-pillars.md)
- [Adversarial review](../core/07-adversarial-review.md)
- [Technical FAQ](./faq.md)
- [Preface](../00-preface.md)
