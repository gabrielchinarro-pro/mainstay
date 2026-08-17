<!--
  TEMPLATE: handoff
  COPY TO: vault/handoffs/<YYYY-MM-DD>-<topic>.md

  A handoff is the committed artifact a session writes before it ends, so the
  next session (you, tomorrow, or another agent, in an hour) starts with the
  truth instead of a guess. It is the written half of the pair; the inline
  half is the resume prompt (see resume-prompt.md), which is derived from it.

  Three disciplines make a handoff trustworthy:
   1. MEASURED, NOT DEDUCED. Every claim about the state comes with the
      command that measured it and what it returned. "The tests pass" is a
      belief; "npm test → 42 passed at 17:50" is a fact.
   2. AN EXPIRY BANNER. A handoff describes a moment. Past its expiry
      condition, it is a trap; the banner says so before anything else.
   3. A FIRST ACTION. The next session does not choose where to start; the
      handoff imposes it. Choosing is where a fresh session goes wrong.

  All content below is a fictional example (the "Saved Views" walkthrough).
  Fill every <PLACEHOLDER>. Delete these comments.
-->

> ⚠️ **EXPIRY**: this handoff describes the state as measured on
> <YYYY-MM-DD HH:MM>. It expires on <date>, or at the first commit after
> `<short-sha>`, whichever comes first. After that: re-measure, do not trust.

# Handoff · <worksite, e.g. saved-views-panel, wiring wave 2>

## 1. Measured state

<!-- One line per claim: the claim, the command, the observed result. If you
     cannot attach a command, the claim does not belong in this section. -->

| Claim | Measured by | Result |
|---|---|---|
| Branch is `feat/saved-views-wiring`, clean | `git status` | clean at <HH:MM> |
| Wave 1 endpoints wired (list, create) | `npm test -- wiring` | 18 passed |
| Wave 2 (delete, set-default) still on mocks | `grep -r "mock" src/api/` | 2 hits |
| Contract untouched since freeze | `git log -1 vault/contracts/saved-views-panel.md` | <sha, date> |

## 2. Locked decisions

<!-- Decisions the next session must not reopen. Reference, do not restate:
     a paraphrase of a decision is how decisions drift. -->
- DEC-007: exactly one default view per user. Do not reopen.
- DEC-011: new views are private until shared. Do not reopen.
- <decision>: <one line>, see <link>.

## 3. Known traps

<!-- What this session learned the hard way. Each trap: the symptom, the
     cause, what to do instead. This section is why handoffs exist. -->
- <Symptom observed>: caused by <cause>. Do <the right move> instead.
- The mock for `set-default` returns 200 on a nonexistent id; the real
  endpoint returns 404. Do not trust the mock's happy path on this call.

## 4. Not done, and known to be not done

<!-- The honest remainder. Listing it here is what prevents the next session
     from "discovering" it and treating it as a regression. -->
- Wave 2 wiring (2 endpoints).
- Error-state copy for the delete confirmation: waiting on <who/what>.

## 5. First action for the next session

<!-- Imposed, not suggested. One action, concrete, verifiable. -->
Re-run the measured-state table above, then wire `DELETE /v1/saved-views/{id}`
against the contract, mock replaced last (see the wiring order in
<link to plan>). Do not start anywhere else.

## 6. Posture

<!-- The working relationship the next session should assume: what it may do
     alone, what requires a human, how to report. Keep it short. -->
- Initiative mandate: <locked | open> (see resume-prompt.md).
- Push nothing without an explicit go in that session's exchange.
- Surface blockers as questions; never guess a schema, a copy string, or an
  endpoint shape.

<!--
  BEFORE COMMITTING THIS HANDOFF:
   - Every row of section 1 measured in THIS session, not copied forward.
   - Expiry banner filled with a real condition, not "soon".
   - Commit it with the code state it describes, same branch.
  See ../docs/en/core/10-session-conduct.md for the full chapter.
-->
