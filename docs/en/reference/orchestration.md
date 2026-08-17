# Multi-agent orchestration

*The most battle-tested part of orchestration is not model tiering; it is role separation. A stage is never closed by whoever built it.*

Orchestration covers two distinct disciplines. The first: route every unit of work to the right role, and keep each agent's context unpolluted. The second, absent from earlier versions of this documentation: run dozens of parallel sessions against a single repository without them destroying each other. This chapter covers both, and marks each pattern with its real status: field-proven, or proposed reading grid.

Field facts cited here come from a private corpus: dated facts, counters obtained by command, verified by an internal audit in three contradictory passes. They are not replayable by the reader.

---

## Roles before models

What the field actually built is not a hierarchy of models. It is a **separation of roles**, governed by a single rule:

> **A stage is never closed by whoever built it.**

The topology observed on the most heavily instrumented projects in the corpus is an orchestrator surrounded by named roles:

| Role | Mandate | Write access |
|---|---|---|
| Orchestrator | Slices the work, arbitrates, re-measures everything itself | Yes, and it alone closes |
| Producer (mutator) | Writes the code or the artefact | Yes, within its scope |
| Product acceptance (PO) | Validates function and rendering against the contract | No: read-only |
| Agnostic reviewer | Reviews without knowing the producer's intent | No: read-only |
| Adversarial reviewer | Tries to break it, in parallel | No: read-only |

Two properties hold this topology together. First, reviewers are **read-only**: a reviewer who can fix things becomes a second producer, and the stage loses its judge. Second, **the orchestrator does not trust agent reports**: it re-measures before closing. On an agency's internal cockpit, that rule is written into the context file itself; on an agency site rebuilt against a frozen reference, a handoff records entire test suites re-run by the orchestrator personally before closure. The full protocol for the adversarial roles (finding counter-verification, graded verdicts, the stopping rule) is in [Chapter 07 · Adversarial review](../core/07-adversarial-review.md).

---

## The three tiers: a reading grid

For routing work, Mainstay proposes a three-tier grid. It is a reading grid (a vocabulary for reasoning about routing), not a device the corpus ran as such.

| Tier | Model class | Relative cost | Owns | Escalates when |
|---|---|---|---|---|
| Conductor | High-end | High | Decisions, architecture, contracts, arbitration | Never: it is the top |
| Lieutenant | Mid-tier | Medium | Structured implementation against a frozen contract | An ambiguity the contract does not cover |
| Runner | Lightweight | Low | Fully specified deterministic routines | The instruction requires judgement |

The principle that runs through the grid: **match the token price to the judgement required.** Every token a high-end model spends on formatting is overpaid; every architectural judgement handed to a lightweight model is underpaid, and will be paid back in grey zones. A lieutenant that hits ambiguity escalates instead of guessing: guessing produces grey zones ([Chapter 05](../core/05-grey-zones-and-divergence.md)).

## Multi-model tiering: an emergent pattern, one occurrence

Actual tiering of *models* (different model classes assigned to different roles inside one topology) exists on **exactly one occurrence in the corpus**, and it deserves precise description rather than generalisation.

On an agency site rebuilt against a frozen reference, the four-role topology (product steering, code, contradictor, acceptance) assigned models like this: the three judgement roles ran on the strong model, and **only the mechanical, repeatable role (acceptance: pixel comparison against the reference, contrast checks, keyboard walkthroughs) dropped to a lower model**.

The rule that travels, if you attempt tiering:

> What drops a model tier is what is mechanical and repeatable. Judgement does not drop.

The acceptance role drops because its protocol is an executable grid: compare, measure, tick. The contradictor does not drop: refutation takes judgement. One occurrence is not proven canon; it is an emergent pattern, published as such.

---

## The explore/edit split

The most profitable subagent pattern is not "more agents"; it is separating **exploration** from **editing**.

Reading a large codebase burns context. An agent that read forty files to answer a question now carries forty files of noise into every subsequent edit. The fix is a division of labour:

- An **exploration subagent** runs read-only and returns a **compact synthesis**: not the files, the answer.
- An **editing agent**, whose context was never spent on the search, applies the change with a clean, focused context.

The handoff is a synthesis, governed by three rules:

1. **Answer, don't transcribe.** Conclusions and the few facts that support them, never raw file contents.
2. **Name sources, don't paste them.** Cite the path; let the editing agent open it only if it must.
3. **Surface ambiguity explicitly.** A grey zone found during exploration is reported, never resolved in a subagent.

```text
SYNTHESIS · filter state for the data table

WHERE:    apps/frontend/src/table/use-table-state.ts
SHAPE:    { filters: Filter[], sort: SortSpec, columns: string[] }
OWNER:    the table screen; persisted per-user on save
CONSTRAINT: a saved view stores a snapshot, not a live reference
GREY ZONE: behaviour when a saved column no longer exists is
           unspecified; needs a decision before editing.
NEXT:     editing the panel is safe; resolve the grey zone first.
```

Twelve lines replace forty files. That is the entire point of the handoff. The pattern reaches the field by another road: the fan-out review panel of [Chapter 07](../core/07-adversarial-review.md) is exactly read-only subagents returning syntheses (findings) to an orchestrator whose context stays clean for judging.

---

## A cost model (illustrative)

The figures below are **invented for the example**: they show the *shape* of the argument, not a quote. Scenario: build one screen end to end.

| Approach | Exploration | Contract | Implementation | Format/lint | Total |
|---|---|---|---|---|---|
| Naive: high-end model for everything | $2.70 | $0.90 | $3.60 | $1.35 | **$8.55** |
| Orchestrated: each task at its tier | $0.09 | $0.90 | $0.72 | $0.045 | **$1.76** |

In this illustrative scenario the orchestrated approach costs roughly 5× less for the same output, because expensive tokens are spent only on genuine decision work. The second saving is latency: cheap parallel work does not queue behind a single expensive model.

---

## Working as a fleet

Beyond a handful of subagents, the field ran something else: **dozens of parallel sessions against a single repository**, for weeks. On a fintech, around a hundred active worktrees were counted by command; on a two-developer, multi-repo product, seven worktrees shared the back office. At that scale the problem is no longer routing; it is collision. Four corpus patterns neutralise it.

### One session = one worktree + one port

Each session lives in its own git worktree, on its own branch, with its own **dedicated dev port**, and the main checkout is untouchable.

| What is isolated | Mechanism | What it prevents |
|---|---|---|
| Files | One worktree per session (`git worktree add`) | Two sessions clobbering the same tree |
| History | A branch named per work item (`agent/<type>/<slug>`) | Cross-committed, unattributable changes |
| Runtime | A dedicated port per session, never the main checkout's | Two dev servers trampling each other |
| Dependencies | `node_modules` symlinked from the main checkout | Reinstalling everything in every worktree |

The session frame (worktree slug, branch, port) is filled in at the top of every orchestrator mega-prompt ([Chapter 06](../core/06-prompt-as-contract.md)). Isolation is not an optimisation: it is the existence condition of parallelism. Without it, the second session destroys the first.

### Vault PRs separate from code PRs

On the corpus fintech, knowledge and code travel in **separate** pull requests: a code PR for the application diff, a vault PR for decisions, contracts and concepts, with dedicated worktrees for vault PRs, and the rule "never push directly to the vault's main branch."

The separation has two reasons. The signers differ: a vault PR reads like a document, and product can sign it alone; a code PR reads like code. And the rhythms differ: a decision can be adopted before, during or after the code it governs, so coupling it to the code PR makes one wait for the other. The trade-off is managed elsewhere: the sync hook guarantees doc and schema cannot drift apart ([CI/CD and hooks](./cicd-and-hooks.md)).

### The shared orchestration brief

When several sessions work the same wave, each gets its own prompt, but all inherit a **shared brief**: a single file of cross-cutting rules that every session prompt references instead of restating.

An observed shared brief typically carries:

- **the backup rule**: a named, timestamped sidecar copy before any risky write ([Chapter 08](../core/08-proof-and-probes.md));
- **anti-collision guards**: who writes where; the files no session touches;
- **reserved gestures**: what is only posted at the end of the chain, by the orchestrator, never by a working session (customer replies, notably);
- **the closing chain**: who accepts, who closes, in what order.

The shared brief is to parallelism what the context file is to a session: the shared memory that keeps every prompt from reinventing (or forgetting) the rules of coexistence.

### Wave sequencing by a chain of roles

A productive fleet accumulates a stock of finished branches faster than anyone merges them. The corpus produced a dedicated artefact for that moment: the **wave sequencing document**. On the fintech, a stock of 15 branches was arbitrated in writing into **18 ordered PRs** (some branches split, others merged), each PR carrying its order, its dependencies and its risk.

The arbitration is not a mechanical sort: it is rendered by a **simulated chain of roles**: the stock passes through successive readings with distinct mandates (a technical reading of dependency and risk, an architecture reading, a product reading of value), each amending the proposed order. The wave plan is itself a hardened artefact: submitted to independent contradictors before execution, and amended on evidence ([Chapter 07](../core/07-adversarial-review.md), adversarial hardening).

The rule that triggers the artefact: **when the stock of branches exceeds what one head can order from memory, the merge order becomes a written decision** (dated, arbitrated, recorded), not an implicit queue.

### Fleet debt: the recorded limits

The corpus also documents what a fleet costs, and those limits are published with the patterns:

- **Parallelism debt.** A fleet accumulates unmerged branches and stale checkouts; wave sequencing was born precisely because the stock had outgrown one head's memory. A fleet without a draining ritual grows until it is ungovernable.
- **Numbering collisions.** Parallel sessions that create decisions produce duplicate numbers: the corpus carries several, some never resolved. The guardrail is the central number registry ([Chapter 02](../core/02-vault-and-sources-of-truth.md)).
- **Vault copy drift.** A vault copied into a worktree and extended locally diverges from the main vault with no resync procedure. Treat every copy as cache: truth stays in the main vault.

---

## When NOT to use subagents

Subagents are not free: every handoff can lose information and adds latency. Do not orchestrate when:

- **the task is small and self-contained**: two files are cheap to read; the handoff would cost more than it saves;
- **the context is already loaded**: the agent that just built the screen carries the context; a fresh subagent throws it away;
- **the work is one indivisible decision**: splitting a single architectural judgement fragments it;
- **the synthesis would be as large as the source**: then the area *is* the work; edit it directly;
- **you are hunting a subtle, stateful bug**: handoffs break the chain of reasoning that finds the cause.

The rule: a subagent earns its place when the **context saved by delegation exceeds the context spent on the handoff**. Below that line, a single agent is faster, cheaper and sharper.

---

## See also

- [Chapter 03 · Agent architecture](../core/03-agent-architecture.md)
- [Chapter 06 · The prompt as a contract](../core/06-prompt-as-contract.md): the orchestrator mega-prompt
- [Chapter 07 · Adversarial review](../core/07-adversarial-review.md)
- [Profile · Team & fleet](../profiles/team-fleet.md)
- [Reference · CI/CD and hooks](./cicd-and-hooks.md)
