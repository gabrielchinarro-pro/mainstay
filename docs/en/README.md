# Mainstay — Documentation Index (English)

> A mainstay is the line that holds the mast upright. Mainstay is the
> infrastructure that keeps an AI agent's output upright: memory, contracts,
> guardrails.

This is the English reference documentation. Read it in order for the full
method, or jump straight to a chapter. French translation: [`../fr/README.md`](../fr/README.md).

## Core chapters

| # | Chapter | What it covers |
|---|---|---|
| 00 | [Introduction — Why Mainstay exists](./00-introduction.md) | The model is not the game; the infrastructure is. The promise. Who this is for. How to read the docs. |
| 01 | [The Three Pillars](./01-three-pillars.md) | Memory, contract, guardrails. Why each, what breaks without it, how they interlock. |
| 02 | [The Monorepo: Home of Knowledge](./02-monorepo.md) | Knowledge lives beside code, versioned with it. Code is the schema's source of truth. The vault as navigable mirror. The two knowledge flows. Annotated skeleton. |
| 03 | [The Agentic Architecture](./03-agent-architecture.md) | The six layers: context file, skills, hooks, MCP, subagents, orchestration. Each layer concretely. |
| 04 | [Sources of Truth](./04-sources-of-truth.md) | The authority table. The divergence golden rule. Historization with frontmatter. The escalation reflex. |
| 05 | [The Delivery Chain](./05-the-delivery-chain.md) | Steps 0–6: vault → prototype → grey-zone scan → contract → parallel contract-first build → DoD → back to vault. |
| 06 | [The Prompt as a Contract](./06-prompt-as-contract.md) | Anatomy of a prompt. Surgical modification vs full rebuild. Worked example. Why each section closes a door. |
| 07 | [Grey Zones](./07-grey-zones.md) | Definition. The detection protocol. The two outcomes. Re-scanning after each pass. The grey-zone ledger. |
| 08 | [Failure Protocols](./08-failure-protocols.md) | Generation-crash recovery. Transpilation false positives. Context drift. Rollback discipline. |
| 09 | [Patterns & Anti-Patterns](./09-patterns-and-antipatterns.md) | Full catalogue, each with symptom / cost / fix. |

## Practice and operations

| # | Chapter | What it covers |
|---|---|---|
| 10 | [Quickstart](./10-quickstart.md) | Adopt Mainstay on a greenfield repo, then on an existing repo. Concrete commands, file by file. |
| 11 | [Multi-Agent Orchestration](./11-multi-agent-orchestration.md) | Conductor/lieutenant/runner. Roles, contexts, handoff, cost model, explore-vs-edit split. |
| 12 | [Observability & Metrics](./12-observability-and-metrics.md) | Iterations per screen, grey-zone rate, velocity, context drift, contract lead time. How to collect and read them. |
| 13 | [Testing & Evaluating Agents](./13-testing-and-evaluating-agents.md) | Verifying an agent honours contracts and guardrails. Eval harness, golden tasks, regression sets. |
| 14 | [CI/CD & Hooks](./14-cicd-and-hooks.md) | Continuous integration, the doc/schema sync hook, blocking checks, the self-correction loop. |
| 15 | [Team Adoption](./15-team-adoption.md) | Human roles, rituals, scaling, the agentic-infrastructure architect. |
| 16 | [Technical FAQ](./16-faq.md) | ~20 sharp Q&As. |
| 17 | [Glossary](./17-glossary.md) | Every term defined, cross-linked. |

## How to read this

If you have one hour, read [00](./00-introduction.md), [01](./01-three-pillars.md),
[05](./05-the-delivery-chain.md), and [07](./07-grey-zones.md). That is the
spine of the method. The rest is depth and operations.

If you want to adopt Mainstay this week, read [10 — Quickstart](./10-quickstart.md)
and copy the templates it points to.
