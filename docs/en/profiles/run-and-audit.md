# Profile R — Run & Audit

*The code is not yours and a live platform is at stake. The unit of work is
the ticket, the workstream or the audit pass — not the screen. Here the
method does not compress: it hardens.*

> The field facts in this profile come from a private corpus: dated events,
> counts obtained by command, verified by an internal audit in three
> adversarial passes. They are not replayable by the reader.

## When to use it

The code belongs to a client, or a production platform with real users is at
stake — and there is nothing to prototype: the system already exists, and
your job is to run it, fix it or audit it. The unit of work is not the
screen but the ticket, the workstream or the audit pass, and every write can
cost money, data or a third party's trust.

The test is the one that governs the whole method — and this terrain is
where it was named:

> **code ownership × cost of error** — not size, not duration.

A three-hundred-line script that touches a client's production belongs to
this profile; a thirty-thousand-line product that only you can break does
not. The profile covers two variants: **(a) run** — tickets and workstreams
on a legacy codebase in production; **(b) the audit vault** — the method
applied to code you analyse without owning it (see the module below). On the
run terrain, the first commit under the method describes itself as
"Mainstay light": the method entered in a lightened form, and the lightened
form is what held — then hardened, incident by incident.

## Minimum rituals

1. **The production go is explicit and given in the current turn** — never
   inferred from a passing review, never carried over from an earlier
   conversation. A green review authorizes you to *ask* for the go; it does
   not replace it ([chapter 09](../core/09-release-gate-and-registry.md)).
2. **One registry entry per release** — or, as a variant, the revision log
   of a versioned living guide, where every revision carries four things:
   the fix, the review, the backup, the commit. No release without an entry,
   no entry without a release.
3. **A timestamped backup before any write** to a server or a preprod. The
   backup precedes the write; it never follows it. This is rule number one
   of every brief in this profile, with no recorded exception.
4. **A proof harness on the real code path before promotion — and the proof
   replayed after.** You do not prove on a mock of the system: you probe the
   real path, promote, then replay the same proof in production
   ([chapter 08](../core/08-proof-and-probes.md)). The field keeps numbered
   review runs — sixteen checks out of sixteen, eight out of eight —
   recorded with their commands.
5. **Prohibitions born of incidents are written down with their cause.** The
   context file of this profile is a list of permanent prohibitions, each
   dated, each caused. An uncaused prohibition gets worked around; a caused
   one gets respected.
6. **The registry is periodically reconciled against the real state of the
   server.** Server-verified, not memory-verified: a dated reconciliation in
   the corpus realigned the registry with what was actually running. A
   registry never reconciled is a fiction that ages well.

## Mandatory artifacts

| Artifact | Role |
|---|---|
| An `AGENTS.md` of permanent, **caused** prohibitions | The write guardrail — every prohibition carries its originating incident |
| `vault/decisions/` as `DEC-XXX` | The cross-session memory; **with a central number registry if two vaults coexist** — numbering collisions are a documented trap of this profile |
| `RELEASES.md` + tags — or a living guide in semver, self-challengeable | The registry: what shipped, when, on whose go |
| Defensive release scripts + a runbook **distinct** from the guide | The guide explains; the runbook executes. The field wrote the distinction out in full: the guide "is not a runbook" |
| One folder of review proofs per workstream | The replayable trace of what was verified, and how |

## The chain, incarnated by the ticket

The [delivery chain](../core/04-delivery-chain.md) does not vanish in this
profile: every link survives in an incarnation suited to a system you did
not build.

| Canonical link | Run & audit incarnation |
|---|---|
| Step 0 — the vault | `AGENTS.md` of caused prohibitions + `DEC-XXX`: the memory precedes the first ticket |
| Step 1 — the prototype | Nothing. You do not prototype an existing system; you read it, read-only probes in hand |
| Step 2 — grey zones | Ticket triage: what the ticket does not say gets asked, not guessed |
| Step 3 — the contract | The pair `DEC-XXX` + workstream brief — never a freeze in the audit variant |
| Step 4 — the build | The fix, preceded by its timestamped backup, confined to its perimeter |
| Step 5 — the definition of done | The proof harness on the real path, numbered, replayed after promotion |
| Step 6 — the return to the vault | The registry entry + the caused prohibition, if the incident taught something |

## Module — the audit vault

The most hardened variant of the profile: applying the method to code you
**audit without owning**. The vault is no longer the foundation of a build —
it is an investigation memory placed alongside a client's platform. Four
rules set it apart, all from the same terrain:

1. **Absolute read-only on the existing code.** The audit modifies nothing
   of what it analyses. Not "we avoid it": a structural prohibition, written
   into the context file, with the list of the only write zones allowed.
2. **Every citation of audited code is marked "verified in the audit, to be
   re-verified on the live code".** An audit freezes a moment; the platform
   keeps living. An audit claim not re-dated at the moment you rely on it is
   a divergence in waiting
   ([chapter 05](../core/05-grey-zones-and-divergence.md)).
3. **No contract is frozen during the audit pass.** You do not freeze a
   contract on a system you do not own and have not finished understanding —
   the terrain's context file forbids it explicitly. The audit's
   deliverables are findings and decisions, not screen contracts.
4. **New code is confined to self-contained packages** — never interleaved
   with the client's code — **and nothing reaches production or preprod
   without a go.** The boundary between "theirs" and "ours" is physical, not
   conventional.

The module inherits everything else in the profile: timestamped backups
before every allowed write, numbered adversarial review (on this terrain, a
thirty-agent pass produced 24 findings of which 19 were confirmed — the rest
dismissed with written justification), an explicit go for everything.

## What you allow yourself to drop

**The prototype and the per-screen chain.** No prototype was produced on
these terrains — there is nothing to prototype when the system already
exists. The per-screen [delivery chain](../core/04-delivery-chain.md) gives
way to the cycle ticket → proof → go → registry. This is a choice of form,
not a surrender of substance: every link (contract, proof, gate, return to
memory) survives in another incarnation.

**The twelve-section screen contract.** Replaced by the pair decision
(`DEC-XXX`) + workstream brief — and, in the audit variant, by an outright
freeze prohibition. The screen contract assumes you own what you specify;
here you do not.

**The dashboard metrics.** None were collected on these terrains. This
profile's observability is the registry itself and its reconciliation — not
a dashboard ([reference — metrics](../reference/metrics.md), a proposed,
unproven instrument).

What you do **not** allow yourself to drop, even under audit pressure:

- **Registry-requirement coherence.** The corpus records the violation: a
  runbook that demands a version bump + registry entry + tag, on a
  repository with zero tags and no registry. A written requirement the
  artifact does not follow is worse than no requirement — it teaches agents
  that rules are decorative.
- **The git remote.** Two terrains in this profile worked on repositories
  never pushed anywhere — including 99 commits of client work on a single
  workstation. On someone else's code, unreplicated history is a risk you
  make the client carry without telling them.

## Documented risks at this scale

The two breaches above — a registry demanded but not kept, a repository
never pushed — are the profile's main risks, and they share a root: **on
someone else's code, declared discipline diverges from practised discipline
as soon as nobody reconciles**. The countermeasure is ritual 6: periodic,
dated reconciliation against the real state — of the server *and* of the
repository.

Add the risk specific to deferral: a security finding discovered during the
audit and deferred **carries a deadline and a confirmation, otherwise it is
deemed open**. The corpus carries a critical finding deferred with no
tracked follow-up for weeks — exactly the hole the rule closes
([chapter 12](../core/12-secrets-and-pii.md)).

## Original terrain

A legacy e-commerce platform in production kept under a registry (run
variant) and an audit vault on a client's platform (audit variant) — both in
the private corpus.

## See also

- [Preface](../00-preface.md) — the dosage variable: code ownership × cost
  of error
- [Chapter 02 — The Vault and the Sources of
  Truth](../core/02-vault-and-sources-of-truth.md) — the semver living
  guide, the numbering collision
- [Chapter 07 — Adversarial Review](../core/07-adversarial-review.md) —
  findings get refuted, in audits too
- [Chapter 08 — Proof & Probes](../core/08-proof-and-probes.md) — the
  harness on the real path, the replayed proof
- [Chapter 09 — The Release Gate & the
  Registry](../core/09-release-gate-and-registry.md) — this profile's
  operational core
- [Chapter 11 — Failure Protocols](../core/11-failure-protocols.md) —
  reconciliation
- [Chapter 12 — Secrets & PII](../core/12-secrets-and-pii.md) — tracking
  deferred findings
