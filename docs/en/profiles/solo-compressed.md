# Profile S — Compressed Solo

*One head, one deliverable, a cycle measured in days. Every function of the
method is kept; its artifacts are reincarnated in lighter forms — and every
lightening is a decision, not an oversight.*

> The field facts in this profile come from a private corpus: dated events,
> counts obtained by command, verified by an internal audit in three
> adversarial passes. They are not replayable by the reader.

## When to use it

You are one person with agents, on a single deliverable, with a cycle
measured in days — and the code is yours, or the scope is frozen and
verifiable by command. At this scale the full method is dead weight; the
compressed version keeps every one of its functions in forms that fit inside
a session.

The test is the same one that governs the whole method:

> **code ownership × cost of error**

Code you own, costly error (a public site, a go-live, a push to a shared
repository) → this profile. Code you own, *reversible* error, a project that
fits in one head → even this profile may be too much: reread
[“When NOT to use Mainstay”](../00-preface.md#when-not-to-use-mainstay) and
its four non-negotiables. The moment the code stops being yours, switch
profiles — [Run & audit](./run-and-audit.md) — no matter how few days the
work takes.

## Minimum rituals

1. **A single decision log** — or, as a strict equivalent, the trio {living
   resume prompt, dated debrief, locked decisions inline}. One decision per
   entry, numbered, dated, with its reason. It is the entire vault, reduced
   to one file.
2. **A named backup per stage before any risky iteration.** A snapshot that
   carries the stage's name, not "backup2-final". This is what makes the
   iteration reversible — and therefore safe to attempt.
3. **A minimal adversarial pass before anything is published.** Someone — an
   agent will do — tries to break the deliverable before it ships. If the
   pass is multi-agent, findings are counter-verified and false positives
   dismissed with a written justification, as in
   [chapter 07](../core/07-adversarial-review.md). On a personal site in the
   corpus, the first verdict of that pass was a NO-GO with four blockers —
   all fixed, then re-measured.
4. **An explicit human go before any go-live or push.** The rule does not
   compress with scale: the
   [release gate](../core/09-release-gate-and-registry.md) shrinks to one
   recorded sentence, but it holds.
5. **After every incident, the rule enters the log — with its cause.** An
   incident not converted into a rule will happen again; this is the
   "forbidden (cause: dated incident)" template of the
   [three pillars](../core/01-three-pillars.md), in one-line form.
6. **Retire documents with a dated obsolescence banner** — mark, never
   rewrite, never delete. An outdated document that says so remains an archive; a
   silently rewritten one is documentary lying
   ([failure protocols](../core/11-failure-protocols.md)).
7. **A frozen scope is made verifiable by command.** "Don't touch
   anything else" is a wish; "git status must be empty at the end of the
   session" is a replayable test. In the field, the second form is the one
   that held.

## Mandatory artifacts

| Artifact | Minimal form | What it replaces |
|---|---|---|
| The log | A `DECISIONS.md` at the root — or resume prompt + dated debrief | `vault/decisions/`, handoffs, the index |
| The history | Minimal git, or failing that, named snapshots | Branch backups, tags |
| Leaving the machine | A replayable deploy script OR a push playbook with a secrets/PII gate | The CI/CD pipeline |

On history, the corpus is unambiguous: **two projects worked without git at
all, and their history is unrecoverable**. Nobody can answer "why is this
file in this state" there anymore. Minimal git — one `git init`, commits at
each stage — costs five minutes and closes that blind spot for good.

On leaving the machine: the moment code leaves your workstation, the
secrets/PII gate is non-negotiable — a check run by command before every
push, not an eyeball pass
([chapter 12 — Secrets & PII](../core/12-secrets-and-pii.md)).

## What you allow yourself to drop

Everything below is dropped **because its function is kept in another
form** — a dosage choice, written down, not neglect. The field calls this
the compressed version: functions kept, artifacts reincarnated.

| Function | Canonical form | Compressed solo form |
|---|---|---|
| Memory ([vault](../core/02-vault-and-sources-of-truth.md)) | Versioned `vault/`, frontmatter, index | A few MD files at the root + the agent's persistent memory |
| Decisions | `vault/decisions/DEC-XXX` | Dated "Locked decisions" sections, carried by the log |
| [Grey zones](../core/05-grey-zones-and-divergence.md) | Separate ledger, columns, statuses | The "block and ask" escalation: the agent is forbidden to guess, and keeps a "waiting on you" list |
| Contract | Twelve-section screen contract, double signature | The resume prompt is contract and handover at once ([chapter 06](../core/06-prompt-as-contract.md)) |
| Definition of done | Per-layer checklist | A checkable manual review + recorded proofs (command, query, screenshot) |
| Return to vault | Step 6 of the [chain](../core/04-delivery-chain.md) | Updating the root MD files, dated obsolescence banners |
| Handoffs | Multiple dated handoffs | **One** living resume prompt |
| Named gates, metrics | G1→G5, dashboard | The recorded human go; nothing else |

Two honesty notes. First, the grey-zone line does not delete the protocol:
it moves its moment. Instead of an after-the-fact sweep logged in a ledger,
the agent is constrained *upstream* to block on everything the brief does
not say — the grey zone is caught before it exists. Second, the lightest
project in the corpus escaped the adversarial review entirely — no pass, no
verdict — and the method drew a rule from it rather than shame: skipping a
ritual is a choice that gets written down, with its reason. A ritual
silently not held is a debt; a ritual dismissed in writing is a dosage.

## When this profile stops being enough

Compression is a state, not an identity. Three signals trigger the switch —
and the switch is made like every other decision: by a dated entry in the
log.

| Signal | Switch to | Why |
|---|---|---|
| A second human enters the project | [Profile P](./product-build.md) | A narrative log reminds, it does not transmit; you need a vault and contracts the other person can read without you |
| The code stops being yours — a client, a live platform | [Profile R](./run-and-audit.md), immediately | The dosage variable has changed value; the number of days is irrelevant |
| The cycle stretches from days to weeks, deliverables multiply | [Profile P](./product-build.md) | One living resume prompt cannot carry several workstreams; compressed memory saturates |

When torn between two profiles, the preface settles it: take the lighter
one and harden by dated decision.

## Documented risks at this scale

The compressed profile has one main failure mode, and the corpus documents
it instead of hiding it.

**The return to the vault cracks at the end of the project.** When pressure
mounts, the last thing you document is the last thing you did — which is
often the most sensitive. On a pilot feature on a SaaS product, the most
sensitive workstream of the whole batch — security — stayed invisible to the
documentation: twelve entries in git status left undocumented, including the
closing of a scoping vulnerability. The code was right; the trace did not
exist. The countermeasure is one rule: **the session does not close until
the log carries the last decision** — and the resume prompt is precisely the
file that makes that closure verifiable
([session conduct](../core/10-session-conduct.md)).

**The narrative log drifts.** A `DECISIONS.md` is a registry as long as it
stays one dated decision per entry; it becomes a diary the day you write
mood paragraphs into it. The "registry → log" trade-off is owned at this
scale, but it has an exit clause: the moment a second human enters the
project, or the cycle stretches from days to weeks, switch to
[profile P](./product-build.md) — a diary reminds, it does not transmit.

**Missing history is irreversible.** It is the only risk in this list that
cannot be repaired after the fact; hence its place among the mandatory
artifacts, not the options.

## Original terrain

A personal site that went from study to live in two days (22 dated decisions
across three days of log), and a pilot feature on a SaaS product delivered
in about a week of active days — both in the private corpus.

## See also

- [Preface](../00-preface.md) — the dosage variable, and when not to use
  Mainstay at all
- [Chapter 04 — The Delivery Chain](../core/04-delivery-chain.md) — what the
  compression tightens
- [Chapter 07 — Adversarial Review](../core/07-adversarial-review.md) —
  counter-verifying findings, even solo
- [Chapter 09 — The Release Gate](../core/09-release-gate-and-registry.md) —
  the human go, at every scale
- [Chapter 10 — Session Conduct](../core/10-session-conduct.md) — the resume
  prompt, this profile's central artifact
- [Chapter 12 — Secrets & PII](../core/12-secrets-and-pii.md) — the
  secrets/PII gate of the push playbook
- [Profile P — Product build](./product-build.md) — the switch when the
  project grows
