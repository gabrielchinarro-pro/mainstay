<!--
  TEMPLATE: root context file
  COPY TO:  <repo root>/AGENTS.md   (or CLAUDE.md, depending on your agent)

  This is the memory pillar made operational. An agent loads this file
  automatically at the start of every session. Two disciplines decide whether
  it helps or hurts:

   1. Keep it LEAN. Everything here is reloaded on every turn and consumes
      context. Write only what is transverse and stable: commands, conventions,
      architecture rules, permanent prohibitions. The detail of one feature
      belongs in that feature's contract, NEVER here.

   2. LAYER it. This root file stays short and points to specialised files
      loaded on demand. The agent reads a subsystem's detail only when it
      works on that subsystem.

  Delete every HTML comment before committing. Replace every <PLACEHOLDER>.
-->

# Project Context — <PROJECT_NAME>

<!-- One or two sentences: what this repository is, who ships it. No history,
     no roadmap. Just enough for an agent to know where it landed. -->

<PROJECT_NAME> is a <one-line description of the product>. This file is the
contract every agent reads first. It is intentionally short. When you need
detail, follow the "Load on demand" pointers at the bottom — do not expect the
detail to be inline here.

## Commands

<!-- The exact, runnable commands for the everyday loop. An agent should never
     have to guess these. Keep them current — a stale command here is a trap. -->

| Task | Command |
|---|---|
| Install dependencies | `<install command>` |
| Build | `<build command>` |
| Run the test suite | `<test command>` |
| Lint | `<lint command>` |
| Format | `<format command>` |
| Start the dev environment | `<dev command>` |

## Architecture rules

<!-- Transverse rules ONLY — things true across the whole repo. If a rule is
     specific to one feature, it belongs in that feature's contract. Each rule
     is one line, imperative, testable. -->

- The code is the source of truth for the data schema. Never describe a table
  or type from memory — read it from `<path to entities/migrations>`.
- The canonical data-model docs live in `apps/backend/docs/database/`. A change
  to the schema and a change to those docs ship in the same commit.
- The vault (`vault/`) is the navigable mirror of decisions and contracts. It
  never contradicts the code; on technical facts, the code wins.
- New screens are built contract-first: the contract is frozen before the
  implementation starts, the API spec is frozen before front and back diverge.
- <Add repo-specific transverse rules here, one line each.>

## Conventions

<!-- Naming, file layout, and style choices an agent must follow to stay
     consistent with the existing codebase. Keep it to what is non-obvious. -->

- **Naming:** <files / components / variables — e.g. `kebab-case` files,
  `PascalCase` components>.
- **Structure:** <where new code goes — e.g. one folder per feature under
  `apps/frontend/src/features/`>.
- **Style:** <enforced by the formatter; name it so the agent does not
  hand-format — e.g. "formatting is enforced by the formatter; do not align by
  hand">.
- **Commits:** <convention — e.g. Conventional Commits, present tense>.
- **Tests:** <where tests live and what must be covered>.

## Permanent prohibitions

<!-- The guardrail pillar. What an agent must NEVER do, written plainly, out of
     reach of interpretation. An agent fills every gap you leave — and rarely
     the way you hoped. Be specific and absolute. -->

- Never invent a label, copy string, value, or endpoint. If it is not in a
  source, stop and escalate — do not guess.
- Never edit generated files by hand (`<list generated paths/globs>`).
- Never commit secrets, tokens, or credentials. Use placeholders and the
  secrets manager.
- Never modify a frozen contract. Open a new decision instead.
- Never make a change outside the scope you were asked for ("surgical
  modification" means surgical).
- Never delete or rewrite working code to "improve" it unless explicitly asked.
- <Add repo-specific hard prohibitions here.>

## Load on demand

<!-- The layering pointers. The agent reads these files only when the task
     touches that subsystem. Keep the root file lean by pushing detail here. -->

Read these only when your task touches the relevant area:

- **Backend detail & data model** → `./apps/backend/docs/`
- **Frontend architecture** → `./apps/frontend/docs/`
- **Shared packages** → `./packages/README.md`
- **Decisions (DEC-XXX)** → `./vault/decisions/`
- **Screen contracts** → `./vault/contracts/`
- **Business concepts** → `./vault/concepts/`
- **Design system** → `./vault/design-system/`
- **Vault index (start here to navigate the vault)** → `./vault/00-index.md`

<!--
  END OF TEMPLATE.
  Sanity check before committing:
   - Is anything here feature-specific? Move it to a contract.
   - Is any command stale? Run it.
   - Are all <PLACEHOLDER> tokens replaced?
   - Are all annotation comments deleted?
-->
