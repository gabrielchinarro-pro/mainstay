# Skills

A skill is a folder that packages one reusable capability: an instruction file
(`SKILL.md`), and often scripts and templates beside it. A skill encodes proven
know-how so you never have to re-explain it. Where the context file is
**declarative** memory (facts that are always true), a skill is **procedural**
memory (how to perform a task).

## Progressive disclosure

The key principle is **progressive disclosure**. An agent does not load a
skill's content by default — it loads it only when a task triggers it. The
`description` field in each `SKILL.md` frontmatter is what the agent sees up
front; the body is read on demand.

That is what lets a repository carry dozens of skills without flooding the
default context. The cost of a skill that is not triggered is one line of
description, nothing more.

How it works in practice:

1. The agent sees every skill's `name` + `description` — cheap, always loaded.
2. A task matches a skill's `description` (the trigger).
3. Only then does the agent read that skill's `SKILL.md` body and run its
   scripts.

Keep `description` fields sharp and trigger-oriented: they are the entire
routing signal.

## The skills in this directory

| Skill | Triggers when | What it does |
|---|---|---|
| [`grey-zone-scan/`](./grey-zone-scan/) | a prototype has been generated and must be compared to its contract or brief | Walks a systematic sweep — zone by zone, state by state, interaction by interaction — and scaffolds a grey-zone ledger of everything the agent decided on its own. |
| [`contract-lint/`](./contract-lint/) | a contract is about to be frozen | Validates the contract file: frontmatter keys present, required sections present, both signatures resolved, no empty mandatory sections. Exits non-zero on failure. |

## Anatomy of a skill

```
skill-name/
├── SKILL.md        # YAML frontmatter (name, description) + instructions
├── <script>.sh     # an executable the skill drives
└── <support>.md    # checklists, templates the skill references
```

## Writing your own

1. Create `skills/<your-skill>/SKILL.md`.
2. Give it frontmatter with a precise `name` and a trigger-shaped
   `description` — the description is how the agent decides to load it.
3. Keep the body imperative and concrete: a procedure, not an essay.
4. Add scripts beside it. Make them executable (`chmod +x`), POSIX bash, with
   `set -euo pipefail` and a `--help`.

## See also

- `../templates/` — the artifacts these skills produce or validate.
- `../hooks/` — deterministic triggers; a hook runs without asking the model,
  a skill is loaded by the model when a task matches.
