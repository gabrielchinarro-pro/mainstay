# Technical FAQ

*Sharp, concrete answers to the questions teams ask when adopting Mainstay.*

These are technical questions with technical answers. Each answer is short and concrete. Where a topic has a full chapter, the answer points to it.

---

### 1. Why must knowledge live in a monorepo and not a wiki?

Anything outside the repository drifts from the code mechanically: the code changes in a commit, the wiki does not, and months later the agent reads a truth that lies. In a monorepo, code and knowledge share one history, one set of reviews, and one merge. A doc update becomes a condition of merging, enforced by a hook — so it cannot be forgotten. See [The Monorepo](./02-monorepo.md).

### 2. What if some knowledge genuinely cannot live in the repo?

Some knowledge legitimately lives elsewhere — a live database, a metrics service, a partner API. You do not copy that into the repo; you expose it through an MCP server so the agent queries it on demand with a defined tool contract. The rule is narrower than "everything in the repo": the *schema's source of truth* is the code, and *durable conventions and decisions* live in the vault. Transient external state is accessed, not copied.

### 3. How big should the context file be?

As small as possible. Everything in it is reloaded every turn and consumes context. Keep the root file to transverse, stable rules — commands, architecture, conventions, permanent prohibitions — and aim for roughly under 100 lines. Feature detail belongs in that feature's contract, not the context file. Layer it: a short root that points to specialised files loaded on demand. See [The Agentic Architecture](./03-agent-architecture.md).

### 4. What model do I need to run Mainstay?

Mainstay is model-agnostic. The method's whole point is that a solid infrastructure with an ordinary model beats a brilliant model on a shaky infrastructure. You do not need one model — you need three tiers: a high-end conductor for decisions, a mid-tier lieutenant for structured work, a lightweight runner for routines. See [Multi-Agent Orchestration](./11-multi-agent-orchestration.md).

### 5. Isn't "one prompt for the prototype" unrealistic?

It is realistic precisely when the brief is good. The single-prompt rule is a *measurement*, not a constraint: if the agent needs four passes, the contract upstream was vague. The single generation still runs two to four internal passes — structure, implementation, polish, cross-viewport check. You are not asking for one model pass; you are asking for one *request*, and using the iteration count as a quality signal.

### 6. How do I handle a huge legacy codebase?

You do not boil the ocean. Seed the vault from the existing code with a read-only exploration subagent, then adopt the method one screen at a time — write each contract just before you change that screen. Introduce hooks in advisory mode first so they do not fail on pre-existing problems. See Path B in the [Quickstart](./10-quickstart.md).

### 7. Does Mainstay only work for web apps?

No. The walkthrough uses a web screen because screens are easy to show, but the method is domain-agnostic. The pillars (memory, contract, guardrails), the chain, and the grey-zone protocol apply to any software: a CLI, a data pipeline, an embedded system. "Screen" generalises to "deliverable unit"; "prototype" generalises to "first runnable version".

### 8. How do I price an orchestrated build?

Estimate tokens per task, then multiply by the tier price — not the top-tier price for everything. Decision work goes to the expensive conductor; structured implementation to the mid-tier lieutenant; routines to the cheap runner. In the illustrative cost model in [Multi-Agent Orchestration](./11-multi-agent-orchestration.md), routing each task to its tier costs roughly 5× less than using the top model throughout.

### 9. What if product and engineering disagree on a contract?

That disagreement is the contract review doing its job. A contract cannot be frozen without both signatures, which is exactly the mechanism that surfaces "looks good to product, infeasible to engineering" *before* two weeks of work, not after. The disagreement is resolved in review — usually by adjusting the contract or logging a decision — and only then is the contract frozen.

### 10. How do I stop context drift?

Three things. Close every prompt with a scope prohibition ("no changes other than this one"). Keep sessions short — a long session accumulates noise. Use the explore-vs-edit split so the editing agent's context is never spent on searching. Measure it: the context-drift metric tells you when prompts are missing their closing prohibition. See [Observability & Metrics](./12-observability-and-metrics.md).

### 11. What exactly is a grey zone, and why obsess over it?

A grey zone is anything the agent decided on its own because neither the prototype nor the contract specified it — an invented empty state, an arbitrary sort, an unvalidated error message. It is not a bug; it is a decision taken in the dark by someone without authority. Fifteen unresolved grey zones are fifteen bombs that detonate together at integration. See [Grey Zones](./07-grey-zones.md).

### 12. When do I run a grey-zone scan?

After every prototype pass — not once. Each iteration creates new grey zones, so you re-scan after each one. The scan is mechanical: for every observable element, ask "did the contract demand this explicitly?". No means grey zone.

### 13. Should I do a surgical modification or a full rebuild?

Surgical modification when you are correcting a specific point — it changes one thing and forbids touching anything else. Full rebuild when accumulated patches have made the existing code incoherent — it restarts from zero and forbids reusing the old code. The signal for a rebuild is that small changes keep breaking unrelated things. See [The Prompt as a Contract](./06-prompt-as-contract.md).

### 14. Front then back, or in parallel?

Always in parallel, never sequenced. Freeze the versioned API spec first as the shared technical truth. The front starts on mocks and types derived from the spec; the back advances behind feature flags and can merge to production before the front is ready. Wiring is done in waves, endpoint by endpoint — a progressive, verifiable replacement, not a risky final phase.

### 15. What does "done" mean?

"Almost done" does not exist. Done is per-layer and checklist-verified. *Contract done*: all sections filled, both signatures, frozen. *Back done*: code, tests, API spec current, integration verified against a stub, performance measured on realistic volume. *Front done*: every state implemented, every endpoint consumed, error cases handled, permissions enforced, pixel-conformant.

### 16. Do hooks slow the agent down?

The opposite. A hook removes a decision the agent would otherwise make and possibly get wrong. The format-and-lint hook means the agent never thinks about style; the test hook means a broken commit never enters history. Hooks also create the self-correction loop, which lets the agent run unattended. See [CI/CD & Hooks](./14-cicd-and-hooks.md).

### 17. How is testing an agent different from testing code?

Code testing answers "does the artifact work?". Agent evaluation answers "does the agent honour the contract and the guardrails?". An agent can write correct code while ignoring a guardrail or exceeding its scope — a green build that still failed the method. You need both: an output test suite and an eval harness with golden tasks and guardrail probes. See [Testing & Evaluating Agents](./13-testing-and-evaluating-agents.md).

### 18. What is a guardrail probe?

A test that tries to make the agent do something forbidden — edit a frozen contract, invent a missing value, exceed a surgical-modification scope — and passes only if the agent refuses or escalates. A guardrail that is never probed is a guardrail you only hope works.

### 19. Two sources of truth contradict each other — what do I do?

Apply the divergence golden rule: the higher-authority source wins, and the lower one is updated immediately so two truths never coexist. The authority order is code (technical truth) and the validated prototype (visual truth) above the contract, with the contract above application code. Never silently pick one — surface the divergence. See [Sources of Truth](./04-sources-of-truth.md).

### 20. How many subagents should I use?

As few as the task needs. A subagent earns its place only when the context saved by delegating exceeds the context spent on the handoff. A two-file change needs none. A large exploration that compresses into a short synthesis needs one. Splitting a single indivisible decision across agents fragments it — don't.

### 21. The generation crashed mid-output — should I regenerate?

No. Regenerating destroys validated work. Read the artifact, find the exact cause (a syntax error, a missing import, a render loop), apply the smallest correction that restores output, and touch nothing else. If that is not enough, return to the last stable point and re-apply changes one at a time with a test between each. See [Failure Protocols](./08-failure-protocols.md).

### 22. How do I know the method is actually working?

Measure it. Iterations per screen trending to 1, grey-zone rate below ~0.15, rework ratio below 0.10, velocity rising while rework falls — that last pair means the vault is compounding and the infrastructure is getting smarter each cycle. A method you do not measure is a method you cannot trust. See [Observability & Metrics](./12-observability-and-metrics.md).

---

## See also

- [Quickstart](./10-quickstart.md)
- [Grey Zones](./07-grey-zones.md)
- [Multi-Agent Orchestration](./11-multi-agent-orchestration.md)
- [Glossary](./17-glossary.md)
