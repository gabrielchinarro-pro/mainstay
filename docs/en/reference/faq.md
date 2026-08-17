# Technical FAQ

*Sharp, concrete answers to the questions teams ask when adopting Mainstay.*

These are technical questions with technical answers. Each answer is short and concrete. Where a topic has a full chapter, the answer points to it.

---

### 1. Why must knowledge live in a monorepo and not a wiki?

Anything outside the repository drifts from the code mechanically: the code changes in a commit, the wiki does not, and months later the agent reads a truth that lies. In a monorepo, code and knowledge share one history, one review set and one merge. A doc update becomes a condition of the commit, enforced by a hook — so it cannot be forgotten. See [The vault and sources of truth](../core/02-vault-and-sources-of-truth.md).

### 2. What if some knowledge genuinely cannot live in the repo?

Some knowledge legitimately lives elsewhere — a live database, a metrics service, a partner API. You do not copy that into the repository; you expose it through an MCP server so the agent queries it on demand. The rule is narrower than "everything in the repo": the *source of truth for the schema* is the code, and *durable conventions and decisions* live in the vault. Transient external state is accessed, not copied. See [Agent architecture](../core/03-agent-architecture.md).

### 3. How big should the context file be?

As small as possible. Everything in it is reloaded every turn and consumes context. Keep the root file for stable, cross-cutting rules — commands, architecture, permanent prohibitions with their cause — and aim under 100 lines. Feature detail belongs in that feature's contract. Layer it: a short root file pointing to specialised files loaded on demand. See [Agent architecture](../core/03-agent-architecture.md).

### 4. What model do I need to run Mainstay?

Mainstay is model-agnostic. The method's entire point is that solid infrastructure with an ordinary model beats a brilliant model on shaky infrastructure. What is field-proven is the separation of *roles* — producer, acceptance, read-only reviewers — not model tiering: tiering has exactly one field occurrence, where only the mechanical acceptance role dropped to a lower model. See [Multi-agent orchestration](./orchestration.md).

### 5. Isn't "one prompt for the prototype" unrealistic?

It is realistic precisely when the brief is good. The single-prompt rule is a *measurement*, not a constraint: if the agent needs four passes, the upstream contract was vague. The single generation still runs two to four internal passes — structure, implementation, polish, verification. Note the variant the field owns: for internal tooling, a contract without a prototype is a documented precedent. See [The delivery chain](../core/04-delivery-chain.md).

### 6. How do I handle a huge legacy codebase?

You don't boil the ocean. Seed the vault from the existing code with a read-only exploration subagent, then adopt the method one work item at a time. If the codebase is in production and errors are expensive, this stops being a question of size: it is the [run & audit profile](../profiles/run-and-audit.md) — release registry, backup before every write, proof on the real code path. The variable that governs the setup is code ownership and the cost of error, not size.

### 7. Does Mainstay only work for web apps?

No. The walkthrough uses a web screen because screens are easy to show, but the method is domain-agnostic. The pillars, the chain and the grey-zone protocol apply to any software. "Screen" generalises to "deliverable unit"; "prototype" to "first runnable version". The method's corpus covers a legacy e-commerce platform, a fintech, a bot, audit vaults — not just screens.

### 8. How do I price an orchestrated build?

Estimate tokens per task, then multiply by the tier's price — not the top tier's price for everything. Decision work goes to the expensive model; structured implementation to the mid-tier; routines to the light one. In the illustrative cost model of [Multi-agent orchestration](./orchestration.md), routing each task to its tier costs about 5× less. The figures are illustrative; the principle — match token price to required judgement — is the durable part.

### 9. What if product and engineering disagree on a contract?

That disagreement is the contract review doing its job. A contract cannot be frozen without both signatures, and that is exactly the mechanism that surfaces "great on the product side, infeasible on the engineering side" *before* two weeks of work. The disagreement is resolved in review — by adjusting the contract or recording a decision — and only then is the contract frozen. See [The delivery chain](../core/04-delivery-chain.md).

### 10. How do I stop context drift?

Three things. Close every prompt with a scope prohibition ("no modifications other than this one"). Keep sessions short — and hand over through a dated handoff rather than stretching the session ([Session conduct](../core/10-session-conduct.md)). Use the explore/edit split so the editing agent's context is never spent on search. See [Failure protocols](../core/11-failure-protocols.md).

### 11. What exactly is a grey zone, and why obsess over it?

A grey zone is anything the agent decided on its own because neither the prototype nor the contract specified it — an invented empty state, an arbitrary sort order, an unvalidated error message. It is not a bug; it is a decision made in the dark by someone without authority. Fifteen unresolved grey zones are fifteen bombs going off together at integration. See [Grey zones and divergence](../core/05-grey-zones-and-divergence.md).

### 12. When do I run a grey-zone scan?

After every prototype pass — not once. Each iteration creates new grey zones, so you re-scan after each one. The scan is mechanical: for every observable element, "did the contract explicitly ask for this?" No means grey zone. And every ledger entry gets resolved — into a decision or a contract note — before the freeze; on a system rebuilt against a frozen reference, the divergence register additionally allows the dated deferral, framed. See [Grey zones and divergence](../core/05-grey-zones-and-divergence.md).

### 13. Surgical modification or full rebuild?

Surgical modification when you are fixing one precise thing — it changes one thing and forbids touching the rest. Full rebuild when accumulated touch-ups have made the code incoherent — it starts from zero and forbids reusing the old code. The rebuild signal: small changes keep breaking unrelated things. See [The prompt as a contract](../core/06-prompt-as-contract.md).

### 14. Front then back, or in parallel?

Always in parallel, never sequenced. Freeze the versioned API spec first as the shared technical truth. The front starts on mocks derived from the spec; the back advances behind feature flags. Wiring happens in waves, endpoint by endpoint — a progressive, verifiable replacement, not one risky final phase. See [The delivery chain](../core/04-delivery-chain.md).

### 15. What does "done" mean?

"Almost done" does not exist. Done is per layer and checklist-verified. *Contract done*: all sections filled, both signatures, frozen. *Back done*: code, tests, spec current, integration verified, performance measured at realistic volume. *Front done*: every state, every endpoint, errors handled, permissions enforced, pixel-faithful. And a stage is never closed by whoever built it — closure goes through adversarial review. See [Adversarial review](../core/07-adversarial-review.md).

### 16. Do hooks slow the agent down?

The opposite. A hook removes a decision the agent would otherwise make and could get wrong. The proven main road is the git `pre-commit` hook, versioned in the repository: it applies to agent and human alike, and blocks at the boundary where state becomes history. The agent-lifecycle hooks (format after every edit, etc.) remained prescriptive — no field site adopted them. See [CI/CD and hooks](./cicd-and-hooks.md).

### 17. How does adversarial review differ from product acceptance?

Product acceptance verifies the deliverable does what the contract asks. Adversarial review tries to break it — and its mandate forbids complacency: findings counter-verified against the real code, false positives dismissed with a written justification, fixes re-measured under the same conditions. The field proves the difference: work that passed product acceptance three times was refused twice by the adversarial reviewers, on real defects. See [Adversarial review](../core/07-adversarial-review.md).

### 18. What are GO, NO-GO and GO-WITH-CONDITIONS?

The three canonical review verdicts. **GO**: no confirmed major, proceed. **NO-GO**: at least one confirmed major, back to the producer, full new pass after correction. **GO-WITH-CONDITIONS**: named reservations, each dated and owned — a condition without a deadline and an owner requalifies the verdict as NO-GO. A verdict is pronounced on refuted findings, never on counted ones. And the review only closes after two consecutive dry passes. See [Adversarial review](../core/07-adversarial-review.md) and the [glossary](./glossary.md).

### 19. Two sources of truth contradict each other — what do I do?

Apply the golden rule of divergence: the higher-authority source wins, and the lower one is updated immediately so two truths never coexist. Never silently pick one — escalate the divergence. And if an artefact is stale and cannot be updated on the spot, mark it stale with a dated banner: the marking costs one line, documentary lying costs a project. See [The vault and sources of truth](../core/02-vault-and-sources-of-truth.md).

### 20. How many subagents should I use?

As few as the task demands. A subagent earns its place only when the context saved by delegation exceeds the context spent on the handoff. A two-file change needs none. A large exploration that compresses into a short synthesis needs one. Beyond that — massively parallel sessions — the problem changes nature: worktree+port isolation, shared brief, wave sequencing. See [Multi-agent orchestration](./orchestration.md).

### 21. The generation broke halfway — should I regenerate?

No. Regenerating destroys validated work. Read the artefact, find the exact cause, apply the smallest correction that restores the output, and touch nothing else. If that is not enough, return to the last stable point — this is why a named backup precedes every risky write — and reapply changes one at a time. See [Failure protocols](../core/11-failure-protocols.md).

### 22. How do I know the method actually works?

By its registries, not by a dashboard. A release registry where every entry carries its go — and where violations are recorded; loop journals where findings converge to two dry passes — or to an honest freeze; before/after measurements replayed under identical conditions. Those are the proofs the field actually keeps. The seven metrics of the dedicated chapter remain a [proposed, unproven instrument](./metrics.md) — nobody has collected them yet.

### 23. Acceptance passed — can I push to production?

No. Passing acceptance or preproduction **never** counts as authorisation. Production requires an explicit human go, given in the current turn, recorded in the release registry. "Let's keep going" is not a go. This rule was born from its violations — unrequested promotions, recorded in the very registry they founded. See [The release gate and registry](../core/09-release-gate-and-registry.md).

### 24. How do I pick a project back up weeks later, or hand it to someone else?

Through a dated artefact: the handoff (state of play at session end) or the resumption prompt (the same state, addressed to the next agent). The state in it is *measured, not inferred* — every claim checkable by command — with locked decisions, known traps and the imposed first action. A stale artefact gets marked stale, never deleted. It is the most universal practice in the corpus. See [Session conduct](../core/10-session-conduct.md).

### 25. Do I have to apply the whole method to every project?

No — and the method says so itself. The variable that governs the level of tooling is neither codebase size nor project duration: it is **code ownership and the cost of error**. An owned, reversible, single-head deliverable can run on a decisions journal and a single spec ([solo compressed profile](../profiles/solo-compressed.md)); a client's production demands the full apparatus ([run & audit profile](../profiles/run-and-audit.md)). What never modulates: the human go before anything ships, a dated decision trace, the return to the spec after divergence, a minimal replayable verification. And any abandoned ritual is abandoned by dated decision — never by attrition. See the [preface](../00-preface.md).

### 26. Does the method apply to code I don't own?

Yes — that is where it hardens most. The audit vault applies the method to auditing a client's platform: absolute read-only on code, database and infrastructure; citations marked "verified in the audit, to be re-verified on the live code"; no contract frozen during the pass; new code confined to self-contained packages. The method becomes a proof-and-write-guard apparatus before it is a delivery chain. See the [run & audit profile](../profiles/run-and-audit.md).

---

## See also

- [Preface](../00-preface.md) — the four-question profile selector
- [Grey zones and divergence](../core/05-grey-zones-and-divergence.md)
- [Multi-agent orchestration](./orchestration.md)
- [Glossary](./glossary.md)
