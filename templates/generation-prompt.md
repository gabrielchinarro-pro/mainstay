<!--
  TEMPLATE: generation prompt (creation / first build)
  USE INLINE: this is not a committed file, it is the prompt you hand an
  agent to produce a FIRST build of a screen or component.

  A prompt is not a conversation. It is a contract. Every section below
  closes a door the agent could otherwise wander through. A blurry brief is
  the single largest cause of extra iterations: if a prototype needs more
  than one pass, the brief was the failure, not the agent.

  This is one genre in a family of four. Pick the right one:
   - CREATION (this file): nothing exists yet; you are specifying a build.
   - SURGICAL (surgical-modification-prompt.md): one precise change to a
     build that works.
   - RESUME (resume-prompt.md): restarting a session on an existing
     worksite: measured state, locked decisions, exit gate.
   - ORCHESTRATOR: a multi-role prompt that runs a whole pipeline with a
     hard exit gate; described in ../docs/en/core/06-prompt-as-contract.md.
  Using a creation prompt where a resume prompt belongs is how a fresh
  session quietly rebuilds yesterday's work.

  Fill every <PLACEHOLDER>. Delete these comments. Then paste the result.
-->

CREATION · `<SCREEN_OR_COMPONENT_ID>`

CONTEXT
<!-- Where this screen lives in the product, who uses it, what they are
     trying to do. Two or three sentences: enough to make the right call on
     tone and density, not a history lesson. -->
<This screen lives in <area of the product>. It is used by <persona> to
<goal>. It sits <before/after> <neighbouring screen>.>

VISUAL TRUTH
<!-- One source wins on everything visible. If a validated prototype or a
     frozen reference exists, point at it; the prompt then governs
     behaviour, not pixels. If nothing exists yet, supply the tokens inline:
     an agent does not know your design system unless the prompt states it. -->
- **Prototype / reference:** <path or link; "the prototype wins on layout,
  copy, and states">.
- **If no prototype exists**, tokens the build must use: colours <exact
  tokens or hex>; typography <family and scale>; radii <values>; spacing
  <scale, e.g. 4 / 8 / 12 / 16 / 24>; components to reuse <names, never
  re-implemented>.

SPECIFICATIONS
<!-- The heart of the prompt. Structure, every state, exact content, and
     NUMERIC values the agent cannot reinterpret. Vague adjectives ("clean",
     "modern") produce grey zones. Numbers do not. -->
- **Layout:** <regions and their proportions, e.g. "left list 70%, detail 30%">.
- **States:** describe every one: loading, empty, populated, error, and any
  partial state. Name what each shows.
  - Loading: <what the user sees>.
  - Empty: <exact empty-state copy and any call to action>.
  - Populated: <what a row/card contains, field by field>.
  - Error: <exact error copy, per error class>.
- **Content:** exact copy for every label, button, heading, helper text. Do
  not let the agent write copy; supply it.
- **Numeric values:** <sizes, weights, counts, limits, e.g. "row height
  44px, title 600/14px, max 50 items before pagination">.
- **Interactions:** <every click, hover, focus, keyboard path: what it does>.

INITIATIVE MANDATE
<!-- How much the agent may decide alone. Pick one, delete the other. -->
- **Locked:** build exactly what is specified. Every gap is a question
  surfaced at the end, not a decision.
- **Open on:** <named class of choices, e.g. "internal component naming">.
  Each choice taken is listed in the final report as a decision-to-confirm.
  Everything else is locked.

PROHIBITIONS
<!-- Explicit "never" lines. The agent fills every gap; name the gaps you do
     not want filled. -->
- Do not invent copy, labels, values, or endpoints. If something is missing,
  surface it; do not guess.
- Do not introduce a component or pattern outside the visual truth above.
- Do not add features, fields, or states that were not requested.
- Do not skip a state because it "rarely happens"; build every state listed.

CHECKLIST
<!-- Observable, binary criteria the agent ticks itself before returning.
     Each line must be checkable by looking, not by trusting. -->
- [ ] Every state above is implemented and reachable.
- [ ] All copy matches the strings supplied, none invented.
- [ ] Numeric specs are respected (spot-check the values listed).
- [ ] Layout holds at mobile, tablet, and desktop widths.
- [ ] Visual truth respected: no token or component from outside it.
- [ ] No feature or field added beyond the specification.
- [ ] Gaps encountered are listed at the end, as questions.

<!--
  AFTER GENERATION: run a grey-zone scan (see ../skills/grey-zone-scan/ and
  grey-zone-ledger.md). Compare the build to this prompt point by point.
  Anything the agent decided that this prompt did not specify is a grey
  zone; resolve every one before the contract is written.
-->
