# The multi-context portfolio layer — non-normative annex

*A steering layer above the projects: a transverse decisions log, cross-structure deadlines, multi-tool routing. Status: proposed, unproven. The only field site that built it never lived a second day — and that failure is published with the concept, because it is the condition of its publication.*

> **Status: proposed, unproven.** This annex is not a profile of the method and does not belong to the canon. It describes a device built once, on a single site, that was never used. Facts cited here come from a private corpus — dated facts, counters obtained by command, verified by internal audit — not replayable by the reader.

---

## The problem the layer wants to solve

The entire method stops at the project boundary. The vault lives in the monorepo; decisions, contracts and registries belong to one project. But the person steering several structures at once — several clients, several products, several companies — has facts that belong to no project: a tax deadline crossing two structures, a commitment made to someone who works on three projects, a priority call between two clients. Today those facts live in one head.

The portfolio layer proposes giving them a repository: a **multi-context steering exoskeleton** — a personal vault, above the project monorepos, applying to cross-cutting affairs the same disciplines the method applies to code.

## What the layer proposes

The site that built it had designed four devices:

| Device | Form | What it transposes |
|---|---|---|
| Transverse decisions log | One dated line per decision — no ID, no status, no supersession | The dated decision trace, maximally compressed |
| Cross-structure deadlines | One table of every structure's deadlines, each with its "impact if missed" | The cost of error made explicit, per deadline |
| Relational intelligence | One file per counterpart: context, commitments, friction points | Cross-session memory, applied to people |
| Routing matrix | Which tool, channel and repository for which class of task | The context file, applied to a portfolio |

The idea is coherent with the rest of the method — each device compresses an invariant that proved itself at project scale: dated decisions, named error cost, written memory over mental memory, explicit routing rules. That is precisely why the idea is seductive. And precisely why its usage failure must be published with it.

---

## The usage failure — published with the concept

Here is what actually happened, counters attached.

The only site in the corpus that built this layer built it **in one day**: 77 files created in 14 minutes, on 19 April 2026. Then:

- **not one file modified since** — four months later, the count of files touched after creation day is zero;
- **git never initialised**, even though the exoskeleton's own README states versioning as its "cardinal rule" — the device violated its first rule on day one;
- **not one ritual ever instantiated** — not a single weekly review held, the journal stopped on creation day;
- **an index pointing at files that do not exist**, and part of the announced executable tooling missing;
- a decisions log with 31 dated entries — all from the same initial burst.

The diagnosis fits in one sentence, and it is already in this documentation's preface: **tooling without rituals is dead weight.** The exoskeleton was fully built and never took a second beat. It failed exactly where the method says systems fail — closure never arrives on its own, and a device no ritual makes beat dies on the day it is born, however well designed.

Measure the irony, because it is the lesson: the same operator, the same disciplines, kept registries of hundreds of entries alive for months on the project sites. The difference is not the person or the tooling. The difference is that at project scale, **rituals have external triggers** — a release forces a registry entry, an incident forces a rule, a session forces a handoff. The portfolio layer has no external trigger: nothing ever forces a beat. That is the unsolved problem, and none of the 77 files solved it.

---

## If you attempt the layer anyway

This annex does not recommend the layer. If you attempt it, attempt it against the documented cause of failure — not its symptom:

1. **Start with one file, not seventy-seven.** A one-line decisions log that lives beats a complete tree that dies. Add a second file only when the first has survived a month of real use.
2. **Attach every device to a trigger that already exists.** A "whenever I think of it" review does not exist. Anchor the beat to an event that happens anyway — the end of a working session, a billing deadline, an existing team ritual.
3. **Git from the first hour.** The field site violated its own cardinal rule on day one. An unversioned steering vault has no history, no proof, no recovery — it is not a vault.
4. **Date the verdict.** At creation, set a review date — thirty days — and a rule: if by that date the journal has no new entries, the layer is deleted, by dated decision. A dead exoskeleton left on disk is not neutral: it is documentation lying about its own use, and the method forbids exactly that ([Chapter 11 — Failure protocols](../core/11-failure-protocols.md), the staleness banner).

And if your real need is smaller than the layer — the most common case — the method already covers the essentials with no new tooling: dated handoffs carry cross-session state ([Chapter 10](../core/10-session-conduct.md)), and each project carries its own decisions. The layer only becomes necessary the day facts *belonging to no project* actually get lost — and on that day, start with the one-line log.

---

## Why publish a failure

Because the alternative is worse. Publishing the layer without its failure would turn it into a promise — the one unproven part of the corpus presented like the rest, which is proven. Omitting it entirely would deprive the reader of a counter-example the method paid to learn: proof by absence that the three pillars are not enough without a beat, and that the beat does not come from tooling.

The method distinguishes itself less by its successes than by how it records its failures — violations found the rules, honest freezes beat complacent GOs, and an exoskeleton dead in a day deserves documentation on the same terms as a registry of two hundred entries. This annex is that principle applied to the method itself.

---

## See also

- [Preface](../00-preface.md) — when not to use Mainstay; the dosing variable
- [Chapter 10 — Session conduct](../core/10-session-conduct.md) — what already covers cross-session state
- [Chapter 11 — Failure protocols](../core/11-failure-protocols.md) — staleness marking
- [Profiles](../profiles/solo-compressed.md) — the method's four normative profiles
