# The Release Gate & the Release Registry

*A passing acceptance run authorises nothing. The go is human, explicit,
given in the current turn — and every production release leaves an entry a
non-technical reader can understand.*

The entire delivery chain converges on one irreversible act: putting
software into production. This chapter describes the machinery around that
act — the **gate** that conditions it on an explicit human go, the
**registry** that records it, the **reconciliation** that checks the
registry still tells the truth, the **exposure** that makes it readable by
the client, and the **de-escalation rule** that governs the only legitimate
way to abandon any of it: in writing.

> The field facts in this chapter come from a private corpus: dated events,
> counts obtained by command, verified by an internal audit in three
> adversarial passes. They are not replayable by the reader.

## The explicit go, in the current turn

The rule fits in one sentence:

> No production release, no push, no publication without an explicit human
> go, given in the current turn.

Each of the three qualifiers carries a clause.

**Human.** The decision to ship is never the agent's, whatever the state of
the acceptance run. The agent prepares, measures, proves — then stops and
asks. The question is short and impossible to misread: "go for release?"

**Explicit.** A go is an unambiguous formulation, not an inference. An
approving tone is not a go. Silence is not a go. The absence of an
objection is not a go.

**In the current turn.** A go authorises the action now, on the current
state of the code. Yesterday's go authorised yesterday's state — and if a
commit has landed since, yesterday's state no longer exists. A go cannot be
stored, carried forward, or deduced from an earlier conversation.

The most counter-intuitive consequence — and the most violated — is this:
**a validated acceptance run never counts as authorisation.** The
acceptance run says the software is ready to ship. It does not say it
ships. Those are two distinct decisions, made by two distinct authorities:
the acceptance verdict is a technical judgment
([Chapter 07 — Adversarial Review](./07-adversarial-review.md)); the
release is an operational decision that weighs things no acceptance run can
see — the timing, the client, the risk of the day.

What a go is not:

| This is not a go | Why |
|---|---|
| An acceptance run that came back GO | It says "ready to ship," not "ship" |
| "I approve the staging build" | That approves staging. Production is a separate decision |
| "Let's move forward" | That resumes the work, not the deployment |
| A go given yesterday | It authorised yesterday's state, which no longer exists |
| An approved plan that contains a release | Approving the plan authorises the plan, not every irreversible act inside it |

On the corpus terrains this distinction is spelled out in the context files
themselves: "I approve staging" is *not* a production go; "let's move
forward" is *not* "push." Each of these formulations was added one at a
time, after each had been misread exactly once.

## The rule was born from its violations

This rule was not derived from a principle. It was paid for.

On a legacy e-commerce platform in production, on 10 June 2026, two
parallel agent sessions promoted their work to production **without anyone
asking for it**. Neither was technically wrong: the acceptance runs were
green, the code worked. That is precisely what makes the incident
instructive — each session did the thing this chapter forbids: it read a
validated acceptance run as permission to ship.

The incident produced, the same day, a gate protocol recorded as a dated
decision. And the release registry — founded by that very decision —
carries the two rogue promotions *as entries*: where normal entries record
the go verbatim, these record its absence, note that the fault was one of
process, and point to the decision the incident created. The violations are
recorded in the registry they founded.

The rule was then violated again: one release recorded retroactively, and a
relapse on 22 June — counted in writing as the third occurrence in the
session memory, with a hardened protocol to follow. Mainstay publishes
these breaches deliberately: a rule whose violations are known, dated, and
traceable is stronger than an absolute no one can audit. This is the
template from [Chapter 01](./01-three-pillars.md): every prohibition cites
the incident that created it.

## The release registry

The release registry is a single file at the repository root — by
convention `RELEASES.md` — kept under a symmetric rule:

> No release without an entry, no entry without a release.

The registry is the bookkeeping of production. Like all bookkeeping, it is
only worth its completeness: a registry that records *almost* every release
can no longer answer the only question that matters — "what is running in
production, since when, and who authorised it?"

Every entry carries:

| Field | Content |
|---|---|
| **Version** | House semver: MAJOR = platform overhaul, MINOR = work package, PATCH = fix |
| **Date** | The date of the actual release, not the commit |
| **Nature** | Code, data, or both — a data migration is a release |
| **Origin** | The ticket, work package, or decision the change comes from |
| **In plain words** | One de-jargonised line a non-technical reader understands |
| **Go** | The verbatim of the human go, with its author — or the dated record of its absence |
| **Acceptance** | What was verified, and how ([Chapter 08 — Proof & Probes](./08-proof-and-probes.md)) |
| **Backup / rollback** | Where the backup lives, how to go back |
| **Visibility** | Public or internal — the flag that governs client exposure |

Two fields deserve a pause.

**The "in plain words" line.** Every entry contains one natural-language
sentence, jargon-free, saying what the release changes *for the user or the
client*. This is not courtesy: it is a test. If the change cannot be said
in one clear sentence, the work was not clear. And this line is what makes
the registry exposable — see below.

**The go verbatim.** The entry does not say "go obtained"; it quotes the
decider's exact words, in quotation marks, with their name. A verbatim can
be contested, checked, reread six months later. A ticked box proves
nothing.

Every release also puts a **version tag** on the deployed commit. The
registry narrates; the tag anchors. Either without the other is
incomplete: a registry without tags cannot be verified against the
repository; tags without a registry say neither the why nor the go.

A sample entry, on the documentation's running (fictional) example:

```markdown
## 1.4.0 — 2026-05-21 — Saved views: team sharing

> In plain words: you can now share a saved view with your team; views
> stay private until you share them.

- **Nature**: code (no data migration)
- **Origin**: contract saved-views-panel v1.0, DEC-011
- **Release go**: explicit (R. Muller, "acceptance reviewed, you can ship
  to production")
- **Acceptance**: 12/12 contract cases replayed on staging; permissions
  verified across the three roles
- **Backup / rollback**: tag v1.3.2; rollback = redeploy the tag, no data
  to restore
- **Visibility**: public
```

What this machinery yields at scale, on the terrain that founded it: a
legacy e-commerce platform in production, brought under the method on
4 June 2026 — five days between the first commit and the cutover of all of
the client's shops to production, the first commit describing itself as a
lightened version of the method. Between June and August 2026 the registry
accumulated **239 entries and 193 version tags**, the human go recorded
verbatim on every entry — including its two absences, which are the origin
of the rule.

## Reconciling the registry against reality

A registry is a claim about the world. Periodically, you ask the world to
confirm it.

The drift mode is well known: parallel sessions each advance the version
bookkeeping on their own, a number gets taken twice, an entry gets written
from memory. The registry stays plausible — which is what makes it
dangerous. On the reference terrain, a dated reconciliation realigned the
registry with the real state of the server: the corrections were
established from what production was actually doing — **verified on the
server, not from memory** — and recorded as a dated note in the registry
header, visible, never erased.

Three disciplines follow:

1. **Reconcile periodically, and after any episode of parallel sessions.**
   Compare the registry to the real state — displayed version, existing
   tags, deployed artefacts — and every gap becomes a dated correction
   *inside* the registry.
2. **Correct by annotation, never by rewriting.** A wrong entry is marked
   wrong and corrected next to itself; the history of the error is part of
   the history
   ([Chapter 11 — Failure Protocols](./11-failure-protocols.md)).
3. **Lock the number before bumping.** When working in parallel, verify no
   other session has taken the version number before you claim it. Number
   collisions are the early symptom of drift.

## Client exposure — zero re-keying

The registry has a reader, and that reader is not a developer. The "in
plain words" line exists for them.

The principle: **the client reads the registry itself — never a re-keyed
copy.** Any manual transcription of the registry into a client-facing tool
(a recap email, a separately maintained table, a hand-updated page) creates
a second truth, and it will diverge. Exposure is plumbing, not data entry.

The field produced two variants:

- **The page that reads the registry.** On the legacy e-commerce platform,
  a script pushes the registry to the client's back office, where a
  "Releases" page reads it directly: the client sees every release, its
  date and its plain-words line, without a single piece of information
  having been re-keyed. Entries flagged internal are filtered at display
  time — the entry's visibility flag governs what the client sees, not a
  separate edit.
- **Publish, then verify.** On an agency's client space, the publish
  command puts the document online *and then verifies it actually
  arrived* — the exposure itself obeys the proof discipline of
  [Chapter 08](./08-proof-and-probes.md). The local rule: never edit on
  the server; the server only serves a copy of the source of truth.

Both variants apply the same invariant as the vault
([Chapter 02](./02-vault-and-sources-of-truth.md)): one truth per
question, references everywhere else.

## De-escalation — a registry is never abandoned in silence

Everything above has a ceremony cost, and not every project justifies it.
The method knows this — and this is where the line runs between a
modulation and a failure.

The corpus carries all four possible states of the machinery, observed on
the artefacts themselves:

| State | Seen on | Verdict |
|---|---|---|
| **Kept** — 239 entries, 193 tags, verbatim gos | A legacy e-commerce platform in production | Conforming |
| **Instituted, not kept** — registry created by decision, template ready… left empty while 11 version tags accumulated; the file still claimed no production release had ever happened | A two-developer, multi-repo product | Failure: the registry became false without anyone deciding it |
| **Required, nonexistent** — the project runbook required a bump, a registry entry, and a tag on every release, but the repository had neither a registry nor a single tag; in practice the revision journal of a living guide served the role, each revision carrying fix, acceptance, backup, and commit | An audit vault on a client's platform | A failure of writing: the substitution may have been legitimate, but no one recorded it — the requirement pointed at a ghost |
| **De-escalated in writing** — the "bump + entry + tag" rule declared not applicable, in writing: no production, no users; with an explicit ban on re-flagging the missing tags as debt (a "false gap") | An agency's internal cockpit | Conforming |

The fourth row is the rule of this chapter:

> **A registry that does not apply declares itself not applicable — in
> writing, by a dated decision. It is never abandoned in silence.**

The written de-escalation costs three lines: the rule being suspended, the
reason, the date. In exchange it buys two things. First, the registry
stops lying: a registry declared not applicable is true; an empty registry
that should have been filling up is false. Second, the suspension becomes
*reversible with full knowledge*: the day the project acquires a
production environment and users, the de-escalation decision is the
document that says exactly what to reactivate, and why it had been
suspended.

Because the documented failure mode of the registry is not refusal — no
one, anywhere in the corpus, ever argued *against* the registry. It is
**silent attrition**: the registry stops living without any decision
recording it, and goes on asserting a world that no longer exists. An
abandoned registry is worse than no registry: it carries the authority of
the machinery while no longer telling the truth.

The variable that governs de-escalation is the same one that governs the
whole method: **ownership of the code and the cost of error** — not the
size of the project, not its duration. A client's production system with a
high cost of error demands the full machinery
([Run & Audit profile](../profiles/run-and-audit.md)); an internal tool
with no production can suspend it in writing; a solo project can compress
it into a go-live journal, each entry carrying its final verification
battery ([Solo Compressed profile](../profiles/solo-compressed.md)). What
never modulates: the explicit human go in the current turn, and the
writing-down of the modulation itself.

## See also

- [Chapter 01 — The Three Pillars](./01-three-pillars.md) — the
  "prohibition (cause: dated incident)" template
- [Chapter 02 — The Vault & Sources of Truth](./02-vault-and-sources-of-truth.md) —
  one truth per question, references everywhere else
- [Chapter 07 — Adversarial Review](./07-adversarial-review.md) — the
  acceptance verdict, which never counts as a go
- [Chapter 08 — Proof & Probes](./08-proof-and-probes.md) — the acceptance
  evidence every registry entry cites
- [Chapter 11 — Failure Protocols](./11-failure-protocols.md) — correct by
  annotation, never by rewriting
- [Run & Audit profile](../profiles/run-and-audit.md) — the registry as a
  minimum ritual on someone else's production
- [Solo Compressed profile](../profiles/solo-compressed.md) — the
  compressed form of the registry
