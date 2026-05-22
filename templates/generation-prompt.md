<!--
  TEMPLATE: generation prompt (prototype / creation)
  USE INLINE — this is not a committed file, it is the prompt you hand an agent
  to produce a first build of a screen or component.

  A prompt is not a conversation. It is a contract. Every section below closes
  a door the agent could otherwise wander through. A blurry brief is the single
  largest cause of extra iterations: if a prototype needs more than one pass,
  the brief was the failure, not the agent.

  Anatomy (source section 6): operation type; number of passes and their
  content; context; specifications with numeric values; design-system recall
  (always — never assumed known); explicit prohibitions; a self-check checklist.

  Fill every <PLACEHOLDER>. Delete these comments. Then paste the result.
-->

CREATION — `<SCREEN_OR_COMPONENT_ID>`

CONTEXT
<!-- Where this screen lives in the product, who uses it, what they are trying
     to do. Two or three sentences. Enough for the agent to make the right call
     on tone and density — not a history lesson. -->
<This screen lives in <area of the product>. It is used by <persona> to
<goal>. It sits <before/after> <neighbouring screen>.>

DO 3 PASSES
<!-- Ask for 2-4 solid internal passes inside the single generation. Name what
     each pass covers so the agent does not stop at a rough draft. -->
1. Structure — layout, regions, hierarchy, all states stubbed.
2. Implementation — real content, the numeric specs below, all interactions.
3. Polish & responsive — spacing, alignment, cross-viewport check (mobile,
   tablet, desktop).

SPECIFICATIONS
<!-- The heart of the prompt. Structure, every state, exact content, and NUMERIC
     values the agent cannot reinterpret. Vague adjectives ("clean", "modern")
     produce grey zones. Numbers do not. -->
- **Layout:** <regions and their proportions, e.g. "left list 70%, detail 30%">.
- **States:** describe every one — loading, empty, populated, error, and any
  partial state. Name what each shows.
  - Loading: <what the user sees>.
  - Empty: <exact empty-state copy and any call to action>.
  - Populated: <what a row/card contains, field by field>.
  - Error: <exact error copy, per error class>.
- **Content:** exact copy for every label, button, heading, helper text. Do not
  let the agent write copy — supply it.
- **Numeric values:** <sizes, weights, counts, limits — e.g. "row height 44px,
  title 600/14px, max 50 items before pagination">.
- **Interactions:** <every click, hover, focus, keyboard path — what it does>.

DESIGN-SYSTEM RECALL
<!-- Always include this, even if "obvious". An agent does not know your design
     system unless you state it in the prompt. -->
- Colours: <primary, surface, text, danger — exact tokens or hex>.
- Typography: <family, the scale you use>.
- Radii: <corner radii in use>.
- Spacing: <the spacing scale, e.g. 4 / 8 / 12 / 16 / 24>.
- Components to reuse: <names of existing components the agent must not
  re-implement>.

PROHIBITIONS
<!-- Explicit "never" lines. The agent fills every gap; name the gaps you do
     not want filled. -->
- Do not invent copy, labels, values, or endpoints. If something is missing,
  surface it — do not guess.
- Do not introduce a component or pattern not in the design system above.
- Do not add features, fields, or states that were not requested.
- Do not skip a state because it "rarely happens" — build every state listed.

CHECKLIST
<!-- Observable, binary criteria the agent ticks itself before returning. Each
     line must be checkable by looking, not by trusting. -->
- [ ] Every state above is implemented and reachable.
- [ ] All copy matches the strings supplied — none invented.
- [ ] Numeric specs are respected (spot-check the values listed).
- [ ] Layout holds at mobile, tablet, and desktop widths.
- [ ] No design-system violation; only listed components used.
- [ ] No feature or field added beyond the specification.

<!--
  AFTER GENERATION: run a grey-zone scan (see ../skills/grey-zone-scan/).
  Compare the build to this prompt point by point. Anything the agent decided
  that this prompt did not specify is a grey zone — resolve it before the
  contract is written.
-->
