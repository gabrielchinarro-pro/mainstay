# Team Adoption

*Mainstay is a method, not a tool, so adopting it is a change in how people work — not an install. This chapter covers the human roles, the rituals that keep the method alive, how it scales from solo to multi-team, the failure modes that kill adoption, and a 90-day rollout plan.*

The method runs on three pillars and six architectural layers, but all of it is operated by people. A vault does not fill itself; a contract does not sign itself; a grey zone does not get triaged by an agent. This chapter is about the human system around the technical one.

---

## Human roles

Mainstay needs four roles. On a solo project one person wears all four hats; on a team they are distinct people; the responsibilities are the same either way.

### Product signer

Owns the product signature on every contract. Decides what the screen should do, what the copy says, what the personas are, which behaviours are required. The product signer is the authority behind the "what".

- **Signs:** the product line of a contract's signature section.
- **Triages:** grey zones that are product decisions (a missing empty-state, an undefined behaviour).
- **Cannot:** freeze a contract alone — the engineering signature is also required.

### Engineering signer

Owns the engineering signature. Confirms the contract is *buildable* — that the endpoints, performance expectations, and edge cases are technically sound. This role exists to kill the trap of "validated by product, found infeasible by engineering two weeks later".

- **Signs:** the engineering line of a contract's signature section.
- **Triages:** grey zones that are technical (a performance constraint, an error-state behaviour).
- **Cannot:** freeze a contract alone — the product signature is also required.

### Agentic-infrastructure architect

Owns the harness itself: the context files, skills, hooks, MCP servers, subagent topology, and orchestration tiers. This role designs and tunes the infrastructure that makes agents reliable. The method has no settled name for it — "agentic-infrastructure architect", or simply the person accountable for the system.

- **Owns:** `AGENTS.md` and layered context files, the `hooks/` and `skills/` directories, the orchestration model (see [Multi-Agent Orchestration](./11-multi-agent-orchestration.md)), the eval harness.
- **Watches:** the health metrics (see [Observability & Metrics](./12-observability-and-metrics.md)) and acts on bad values.
- **Decides:** which model class runs which tier, when to add a hook, when a skill is worth extracting.

### Contributors

Everyone who drives agents to produce work — writing prompts, running the delivery chain, doing grey-zone scans. Contributors are the operators of the method day to day.

- **Do:** write prompts as contracts, run grey-zone scans after every pass, keep the vault current.
- **Escalate:** grey zones they cannot resolve to the relevant signer, never deciding alone.

| Role | Owns | Signs | Solo-project equivalent |
|---|---|---|---|
| Product signer | The "what" of each screen | Product signature | The founder wearing the product hat |
| Engineering signer | The "buildable" of each screen | Engineering signature | The founder wearing the engineering hat |
| Infrastructure architect | The harness | — | Whoever set up the monorepo |
| Contributor | Running the chain | — | The person at the keyboard |

---

## Rituals

Rituals are what keep the method from decaying into a folder of stale files. Four are non-negotiable.

### Contract review

Before a contract is frozen, the product and engineering signers review it together. The review checks that all twelve sections are filled, that no decision is deferred, and that the contract is buildable. The output is two signatures or a list of gaps. A contract is never frozen by a single person.

### Grey-zone triage

After each prototype pass, the contributor runs a grey-zone scan. The grey zones that need authority go to triage: the relevant signer rules each one as either a **formal decision** (logged in the vault, dated, justified) or a **documented note** on the contract. The triage has exactly two outcomes — never "decide later".

### Decision logging

When a grey zone becomes a formal decision, it is written to `vault/decisions/` as a dated `DEC-XXX` record with context, decision, justification, and consequences. This ritual is the delivery chain's step 6: decisions return to the vault so the next feature starts richer. Skipping it means the same grey zone is rediscovered next quarter.

### Vault hygiene

On a regular cadence (a fortnightly slot works well) the team audits the vault: stale contracts moved to `obsolete`, superseded decisions marked `superseded`, divergences between sources reconciled by the divergence golden rule. Consistency debt is invisible until everything breaks at once; vault hygiene is how you pay it down a little at a time.

---

## Scaling from solo to multi-team

The method does not change as you scale — the *coordination overhead* changes.

| Stage | What is true | What to watch |
|---|---|---|
| **Solo** | One person, all four roles. The vault is small. | Discipline: it is tempting to skip the grey-zone scan when you are also the signer. Don't — the scan catches what you assumed. |
| **Team** | Roles are distinct people. One monorepo, one vault. | Signature latency: contracts now wait on other people. Make signing a fast ritual, not a meeting. |
| **Multi-team** | Multiple teams, one monorepo (or a few). Many contracts in flight. | Decision collisions: two teams making contradicting decisions. The infrastructure architect owns cross-team consistency; the divergence golden rule applies across teams too. |

The structural choices that make scaling survivable are already in the method: one monorepo means one source of truth even with many teams; layered context files mean each team loads only its sub-system's detail; the orchestration tiers mean cost stays controlled as volume grows.

The role that scales hardest is the infrastructure architect. At solo and team size it is a part-time hat; at multi-team size it is a dedicated function, because the harness is now shared infrastructure that everyone depends on.

---

## Common adoption failure modes

| Failure mode | Symptom | Fix |
|---|---|---|
| **Vault treated as a wiki** | The vault lives outside the repo, or is never updated. | The vault is in the monorepo, versioned with code. Doc updates are a merge condition (a hook). |
| **Skipping the grey-zone scan** | Screens look done, then break at integration. | The scan is mandatory after every pass. It is the cheapest insurance in the method. |
| **"We'll decide later"** | A backlog of unresolved grey zones. | Triage has two outcomes only. Deferred grey zones explode together. |
| **Single-signature contracts** | Product validates, engineering discovers infeasibility late. | Both signatures or no freeze. The double signature exists precisely for this. |
| **Underinvesting the contract phase** | High iterations per screen, high rework ratio. | The contract is where the project's energy goes. A vague brief is the agent's only real failure cause. |
| **Heavy context file** | Agents are slow, lose focus, hit limits. | Keep the root context file lean and layered; feature detail lives in contracts. |
| **No metrics** | No one knows if the method is working. | Stand up the health dashboard early — metrics that are not collected are not improved. |

---

## A 90-day rollout plan

A realistic adoption is incremental. The plan below assumes a team retrofitting Mainstay onto an existing codebase (see Path B in the [Quickstart](./10-quickstart.md)).

| Phase | Days | Goals | Done when |
|---|---|---|---|
| **Foundations** | 1–15 | Create the `vault/` tree. Seed it from current code with an exploration subagent. Add a lean `AGENTS.md`. Add the first hook in advisory mode. | The vault exists; the context file is accurate; one hook runs. |
| **First contract** | 16–35 | Pick one screen about to change. Write its contract, run a grey-zone scan, get both signatures, freeze it. Build the change through the full chain. | One screen has shipped end to end via the chain. |
| **Hooks become blocking** | 36–55 | Move the format/lint hook to blocking. Add the doc/schema sync hook. Add contract-signature and grey-zone-scan blocking checks to CI. | CI enforces the method, not just compilation. |
| **Orchestration & evals** | 56–75 | Introduce the conductor/lieutenant/runner split. Stand up the eval harness with a first golden suite and guardrail probes. | Cost per screen drops; a new prompt is gated by the harness. |
| **Rituals & metrics** | 76–90 | Make contract review, grey-zone triage, decision logging, and vault hygiene recurring rituals. Stand up the health dashboard. | The four rituals are on the calendar; the dashboard refreshes in CI. |

By day 90 the method is self-sustaining: every new feature follows the chain, the vault compounds, the metrics are watched, and the rituals run without anyone championing them.

---

## See also

- [Quickstart](./10-quickstart.md)
- [The Delivery Chain](./05-the-delivery-chain.md)
- [Multi-Agent Orchestration](./11-multi-agent-orchestration.md)
- [Observability & Metrics](./12-observability-and-metrics.md)
