<!--
  TEMPLATE: surgical-modification prompt
  USE INLINE — the prompt you hand an agent to change ONE precise thing.

  A surgical modification corrects a single point and nothing else. Its
  defining feature is the closing prohibition: "no other change than this
  one". Without it, an agent re-does, by its own taste, things that already
  worked — and you inherit regressions you never asked for.

  This is one genre in a family of four — creation (generation-prompt.md),
  surgical (this file), resume (resume-prompt.md), and the multi-role
  orchestrator prompt (../docs/en/core/06-prompt-as-contract.md). A
  surgical prompt is by nature a LOCKED-mandate prompt: the agent decides
  nothing beyond the change named below.

  Use this mode when the existing build is sound and one thing must change.
  Two boundary cases:
   - If the build has accumulated so many patches that it is incoherent, do
     NOT use this template — do a full rebuild instead (a from-scratch
     prompt that forbids reusing the existing code).
   - If the build is measured against a frozen reference, record the change
     in the divergence register (divergence-register.md): a surgical fix
     that closes a divergence flips its row to `fixed` — with a re-measure.

  Fill every <PLACEHOLDER>. Delete these comments. Then paste the result.
-->

SURGICAL MODIFICATION — `<SCREEN_OR_COMPONENT_ID>`

CURRENT PROBLEM
<!-- Name the problem in OBSERVABLE terms — what is on screen, what is wrong
     about it. Not "make it nicer". Describe what a reviewer would see. -->
<Describe exactly what exists today and why it is wrong. Observable facts
only: sizes, layout, copy, behaviour.>

TARGET PATTERN
<!-- The end state, again in observable terms. What the screen should look
     like or do once the change lands. -->
<Describe the intended result. One pattern, clearly stated.>

SPECIFICATIONS
<!-- The precise, numeric instructions for this one change. Numbers the
     agent cannot reinterpret. -->
- <Exact spec line — e.g. "row height 44px, was 64px">.
- <Exact spec line — e.g. "remove the per-item shadow; one container only">.
- <Exact spec line — e.g. "title 600/14px, description 13px on a single line">.

PROHIBITIONS
<!-- The capital prohibition lives here. It is what makes the modification
     surgical. Keep the last line verbatim in spirit. -->
- Do not restyle, re-lay-out, or "tidy" anything outside the change above.
- Do not rename, move, or refactor files that this change does not require.
- Do not change copy, behaviour, or states that were not named above.
- Do not reopen any locked decision this screen implements.
- **No other change than this one.** If you believe something else should
  change, stop and say so — do not act on it.

CHECKLIST
<!-- Two kinds of line: the change landed, and nothing else moved. -->
- [ ] The target pattern above is in place.
- [ ] Every numeric spec above is respected.
- [ ] No regression anywhere else on the screen — the rest is byte-for-byte
      the same in behaviour and appearance.
- [ ] No file changed that this modification did not require — verifiable:
      the diff touches only <expected files>.

<!--
  AFTER THE CHANGE:
   - Verify against a real screenshot or run, not a description. A surgical
     change is "done" only when the diff is exactly the scope above.
   - Re-run the grey-zone scan on the touched area: even a one-line change
     can introduce a new silent decision.
   - If this change closes a divergence-register row, re-measure and update
     the row (divergence-register.md).
-->
