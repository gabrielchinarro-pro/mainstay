# Glossary

*Every Mainstay term, defined and cross-linked to the chapter that covers it.*

Terms are listed alphabetically. Each entry gives a one-paragraph definition and a link to the chapter where the term is treated in full.

---

### Agentic-infrastructure architect

The person accountable for the harness itself — the context files, skills, hooks, MCP servers, subagent topology, and orchestration tiers. The method has no settled name for the role; this is the working one. The architect designs the infrastructure that makes agents reliable and watches the health metrics to keep it sound. See [Team Adoption](./15-team-adoption.md).

### API spec

The versioned specification of the back-end interface — endpoints, payloads, return codes. In the contract-first build it is frozen *first* and becomes the shared technical truth that front and back both build against. See [The Delivery Chain](./05-the-delivery-chain.md).

### Conductor

The top orchestration tier — a high-end model used on demand for the work that cannot be delegated: architecture decisions, contract design, grey-zone adjudication, planning. Expensive per token, used sparingly. See [Multi-Agent Orchestration](./11-multi-agent-orchestration.md).

### Consistency debt

The cost that accumulates when two or more sources of truth are allowed to disagree — a note, a contract, and code that diverge. It is invisible until the day everything breaks at once, which is why it is the most expensive debt in a project. The divergence golden rule exists to prevent it. See [Sources of Truth](./04-sources-of-truth.md).

### Context drift

The tendency of an agent, during a long or under-constrained session, to wander beyond the requested scope — over-correcting, "improving" unrequested code, touching unrelated areas. Measured as out-of-scope edits over total edits. Countered by closing prohibitions in prompts and short sessions. See [Observability & Metrics](./12-observability-and-metrics.md) and [Failure Protocols](./08-failure-protocols.md).

### Context file

A file loaded automatically at the start of every agent session, by convention `AGENTS.md` at the monorepo root. It is the memory pillar made operational. It must be lean (only transverse, stable rules — reloaded every turn) and layered (a short root pointing to specialised files loaded on demand). See [The Agentic Architecture](./03-agent-architecture.md).

### Contract

A specification with acceptance criteria for a screen or deliverable — not a vague brief the agent interprets. It states behaviour, edge cases, endpoints, permissions, copies, and test data, and carries a product and an engineering signature. The agent knows what is expected; you know what to verify. See [The Prompt as a Contract](./06-prompt-as-contract.md).

### Contract-first

The build approach in which the frozen contract and API spec are the shared truth, and front and back develop in parallel against it rather than sequentially. The front starts on mocks derived from the spec; the back advances behind feature flags. See [The Delivery Chain](./05-the-delivery-chain.md).

### Definition of done (DoD)

The per-layer checklist that decides whether work is complete. "Almost done" does not exist. *Contract done*: sections filled, both signatures, frozen. *Back done*: code, tests, current API spec, verified integration, measured performance. *Front done*: all states implemented, all endpoints consumed, errors handled, permissions enforced, pixel-conformant. See [The Delivery Chain](./05-the-delivery-chain.md).

### Delivery chain

The seven-step path from nothing to production: vault → prototype → grey-zone scan → contract → parallel contract-first build → definition of done → back to the vault. Each cycle leaves the infrastructure richer. See [The Delivery Chain](./05-the-delivery-chain.md).

### Eval harness

The runner that executes eval cases — golden tasks, conformance tests, guardrail probes, regression sets — against an agent and grades the results. It is to agent evaluation what CI is to code testing, and it gates the promotion of a new prompt or model. See [Testing & Evaluating Agents](./13-testing-and-evaluating-agents.md).

### Full rebuild

A prompt mode that restarts a screen from zero and forbids reusing the existing code. Used when accumulated patches have made the existing code incoherent, so that small changes keep breaking unrelated things. Contrast with surgical modification. See [The Prompt as a Contract](./06-prompt-as-contract.md).

### Golden task

A fixed, representative task with a known-good expected outcome, used to regression-test the *method*. When you change a prompt template, context file, or model, you re-run the golden suite to confirm nothing regressed. A good golden task is small, stable, representative, and deterministic enough to grade. See [Testing & Evaluating Agents](./13-testing-and-evaluating-agents.md).

### Grey zone

Anything the agent decided on its own because neither the prototype nor the contract specified it — an invented empty state, an arbitrary sort, an unvalidated error message, an assumed permission. Not a bug; a decision taken in the dark by someone without authority. Detected by comparing the product to the contract element by element. Spelled "grey" throughout Mainstay. See [Grey Zones](./07-grey-zones.md).

### Grey-zone ledger

The running record of grey zones found during scans and their resolution — each one ruled either a formal decision or a documented contract note. It is also the source data for the grey-zone-rate metric. See [Grey Zones](./07-grey-zones.md).

### Guardrail

What the agent must never do, written explicitly and placed beyond its interpretation. An agent always fills the empty space it is left, and rarely the way you hoped — guardrails close that space. The third pillar. See [The Three Pillars](./01-three-pillars.md).

### Guardrail probe

An eval case that tries to make the agent do something forbidden — edit a frozen contract, invent a missing value, exceed a surgical-modification scope — and passes only if the agent refuses or escalates. See [Testing & Evaluating Agents](./13-testing-and-evaluating-agents.md).

### Hook

A deterministic trigger attached to an event in the agent's cycle — format and lint after every edit, run tests before a commit, verify doc/schema sync after a migration. A hook does not ask the model; it runs. Hooks turn good practice into a guarantee and create the self-correction loop. See [CI/CD & Hooks](./14-cicd-and-hooks.md).

### Iterations per screen

The headline health metric: the number of generation passes a screen needs. The target is one. A high value does not mean the agent failed — it means the contract upstream was vague. See [Observability & Metrics](./12-observability-and-metrics.md).

### Lieutenant

The middle orchestration tier — a mid-tier model that does structured work where the frame is already set by a contract or a plan: implementing a screen, writing handlers against an API spec, wiring endpoints. The workhorse of the chain. Escalates ambiguity to the conductor rather than guessing. See [Multi-Agent Orchestration](./11-multi-agent-orchestration.md).

### Mainstay

The method this repository documents — an agent-driven software-delivery method built on three pillars (memory, contract, guardrails). The name evokes the line that holds a mast upright: the infrastructure that keeps an agent's output standing. See [Introduction](./00-introduction.md).

### MCP server

A server that exposes a structured, contract-defined access to an external resource — a database, a business API, an internal tool. Instead of pasting data into the prompt, the agent queries the source on demand. The access layer of the architecture. See [The Agentic Architecture](./03-agent-architecture.md).

### Monorepo

A single repository holding both the code and the knowledge base, sharing one history and one set of reviews. A schema change and its documentation travel in the same commit and merge together, so knowledge cannot fall behind code. See [The Monorepo](./02-monorepo.md).

### Progressive disclosure

The principle that an agent loads a capability's detail only when a task triggers it. It lets a project hold dozens of skills without saturating the default context. The mechanism behind the skills layer. See [The Agentic Architecture](./03-agent-architecture.md).

### Prototype

The first runnable version of a screen, produced in a single generation request (with two to four internal passes). It is compared to the contract in a grey-zone scan, and once validated becomes the basis of the signable contract. See [The Delivery Chain](./05-the-delivery-chain.md).

### Regression set

The accumulated body of past agent failures, frozen as eval cases. Every real-world mistake — an invented label, a scope drift, a missed state — is captured as a case so it cannot recur. Run whenever anything affecting agent behaviour changes. See [Testing & Evaluating Agents](./13-testing-and-evaluating-agents.md).

### Runner

The lightweight orchestration tier — the cheapest capable model, used for deterministic routines: formatting, mechanical refactors, extracting a synthesis, regenerating mocks. Runs constantly and often in parallel. Makes no judgement calls. See [Multi-Agent Orchestration](./11-multi-agent-orchestration.md).

### Self-correction loop

The cycle created by hooks and CI: the agent edits, a hook tests, a failure returns to the agent with actionable output, the agent makes a minimal correction, the hook runs again. It closes when the hook passes, and it lets an agent run unattended. See [CI/CD & Hooks](./14-cicd-and-hooks.md).

### Skill

A folder encapsulating a reusable capability — an instruction file (`SKILL.md`), sometimes scripts and templates — loaded under progressive disclosure. A skill is procedural memory (a know-how), where the context file is declarative memory (facts and rules). See [The Agentic Architecture](./03-agent-architecture.md).

### Source of truth

The single authority for a class of fact. Code is the source of truth for the schema and technical contracts; the vault for conventions and decisions; the validated prototype for the visible interface; the contract for behaviour. When two disagree, the higher wins and the lower is updated at once. See [Sources of Truth](./04-sources-of-truth.md).

### Subagent

A dedicated agent instance with its own context, assigned a role. The most rentable pattern separates exploration (read-only, returns a compact synthesis) from editing (applies the change with a clean context), preserving the editing agent's context. See [Multi-Agent Orchestration](./11-multi-agent-orchestration.md).

### Surgical modification

A prompt mode that corrects one precise point and closes with the capital prohibition "no changes other than this one", preventing the agent from reworking what already worked. Contrast with full rebuild. See [The Prompt as a Contract](./06-prompt-as-contract.md).

### Synthesis (compact synthesis)

The output of an exploration subagent: an answer, not a transcript. It returns conclusions and the few facts that support them, names sources rather than pasting them, and surfaces any ambiguity explicitly. A handoff that returns everything it read is not a synthesis. See [Multi-Agent Orchestration](./11-multi-agent-orchestration.md).

### Validated prototype

A prototype that has passed its grey-zone scan and is accepted as the visual source of truth. It then becomes the basis of the signable contract. See [Sources of Truth](./04-sources-of-truth.md).

### Vault

The navigable knowledge layer inside the monorepo, holding decisions, screen contracts, business concepts, and the links between them. It indexes and gives meaning, but never contradicts the code — for technical facts the code wins. The vault is a layer of meaning over the layer of truth, not a competing truth. See [The Monorepo](./02-monorepo.md).

### Wiring in waves

Connecting front and back endpoint by endpoint rather than all at once at the end — a progressive, verifiable replacement of mocks by real endpoints. It turns integration from one risky final phase into a continuous, low-risk activity. See [The Delivery Chain](./05-the-delivery-chain.md).

---

## See also

- [The Three Pillars](./01-three-pillars.md)
- [The Agentic Architecture](./03-agent-architecture.md)
- [Technical FAQ](./16-faq.md)
- [Quickstart](./10-quickstart.md)
