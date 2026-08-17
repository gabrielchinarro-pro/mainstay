<!--
  TEMPLATE: resume prompt
  USE INLINE — this is the prompt you paste to START a session on an existing
  worksite. It is the inline twin of the handoff (handoff.md): the handoff is
  the committed record, the resume prompt is the contract you hand the agent
  that picks the work back up.

  A resume prompt is a genre of its own, distinct from a creation prompt
  (generation-prompt.md) and a surgical prompt (surgical-modification-prompt.md).
  Its defining features:
   - constraints that are VERIFIABLE BY COMMAND, so the agent can prove
     compliance instead of promising it;
   - locked decisions restated as prohibitions, not context;
   - an initiative mandate — how much the agent may decide alone;
   - ordered first actions, so the session starts on rails;
   - a hard exit gate: nothing pushed, published, or deployed without an
     explicit go in this exchange.

  All example content is fictional. Fill every <PLACEHOLDER>. Delete these
  comments. Then paste the result.
-->

RESUME — `<worksite id, e.g. saved-views-panel / wiring wave 2>`

STATE
<!-- Point at the handoff; do not paraphrase it. The agent reads the source. -->
Read `vault/handoffs/<YYYY-MM-DD>-<topic>.md` first. It is the state of this
worksite, measured on <date>. If its expiry banner has tripped, stop and
re-measure before doing anything else.

HARD CONSTRAINTS — each one verifiable by command
<!-- One line per constraint, with the command that proves compliance. -->
- Work only under `<path/scope>`. Verify: `git status` shows no change
  outside it.
- Do not touch `<other repo / other directory>` at all. Verify: `git -C
  <path> status` stays clean for the whole session.
- Stay on branch `<branch>`; never commit to the default branch. Verify:
  `git branch --show-current`.
- Local only: no push, no deploy, no publication. Verify: `git log
  origin/<branch>..HEAD` may grow; `origin` itself must not move.

LOCKED DECISIONS
<!-- Restate as prohibitions. Reference the source; never paraphrase the rule. -->
- DEC-007 and DEC-011 are settled. Do not reopen, "improve", or work around
  them. If a task seems to conflict with one, stop and say so.

INITIATIVE MANDATE
<!-- Pick one and delete the other. This is the session's authority level. -->
- **Locked:** execute the task below exactly. Every choice not specified is
  a question, not a decision.
- **Open:** you may decide <named class of choices, e.g. "internal naming
  and test structure"> alone; log each such decision in your final report as
  a decision-to-confirm. Everything else is a question.

TASK — P0
<!-- One task. If there are two tasks, there are two sessions. -->
<The single priority, in observable terms — e.g. "wire DELETE
/v1/saved-views/{id}: replace the mock, handle 404 and 409 per contract §6,
keep every other endpoint untouched.">

**Do not guess.** If the contract, the handoff, or the code does not answer
a question (a schema, a copy string, an endpoint shape), ask — do not fill
the gap.

FIRST ACTIONS — in this order
1. <e.g. Re-run the handoff's measured-state table; report any drift.>
2. <e.g. Read contract §6 for the delete endpoint.>
3. <e.g. Start the P0 task; smallest verifiable step first.>

EXIT GATE
- Push nothing, publish nothing, deploy nothing without an explicit go given
  in THIS exchange. A passing review is not a go.
- End the session by writing the next handoff (handoff.md), with the
  measured-state table re-measured — not copied.

<!--
  RELATED GENRES: generation-prompt.md for a first build;
  surgical-modification-prompt.md for one precise change; the multi-role
  orchestrator prompt is described in ../docs/en/core/06-prompt-as-contract.md.
-->
