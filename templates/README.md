# Templates

Copyable Markdown models for the artifacts Mainstay relies on. Each file is a
skeleton you fill in: copy it into your repository, replace the placeholders,
delete the annotation comments, and commit it.

Annotation comments are written as HTML comments (`<!-- ... -->`). They explain
what each section is for. They render as nothing on GitHub, so you can keep them
while drafting and strip them once the artifact is final.

## What each template is

| File | Lives at | Purpose |
|---|---|---|
| `context-file.md` | repo root, as `AGENTS.md` (or `CLAUDE.md`) | The memory pillar made operational. Loaded automatically at the start of every agent session. Lean, layered, transverse-only. |
| `generation-prompt.md` | nowhere — used inline | The prototype/creation prompt. The contract you hand an agent for a first build. |
| `surgical-modification-prompt.md` | nowhere — used inline | The prompt for changing one precise thing without touching anything else. |
| `contract.md` | `vault/contracts/<screen>.md` | The full, signable contract for one screen. The source of truth for behaviour, edge cases, and acceptance criteria. |
| `decision.md` | `vault/decisions/DEC-XXX.md` | A dated, justified decision — usually the formal outcome of a grey zone. |
| `vault-index.md` | `vault/00-index.md` | The navigable index of the vault. The entry point an agent reads to orient itself. |
| `grey-zone-ledger.md` | next to a contract, or `vault/contracts/<screen>.grey-zones.md` | The table that tracks every grey zone found in a scan until it is resolved. |

## How to use them

1. **Pick the artifact you need.** A new screen needs a `contract.md`. A new
   repo needs a `context-file.md` and a `vault-index.md`. A first prototype
   needs a `generation-prompt.md`.
2. **Copy the template** to its destination path (see the table above).
3. **Fill every placeholder.** Placeholders are written `<LIKE_THIS>` or
   `[like this]`. An unfilled placeholder is a defect — agents will read it
   literally.
4. **Delete the annotation comments** once the section is written. They are
   scaffolding, not content.
5. **Commit it with the related code change**, in the same pull request. The
   knowledge artifact and the code it describes travel together.

## Frontmatter

Contracts and decisions carry YAML frontmatter with English keys. The keys are
machine-read; do not translate or rename them. `status` values are a fixed
vocabulary — see each template.

## See also

- `../skills/` — example skills, including `contract-lint` which validates a
  filled `contract.md` before it can be frozen.
- `../examples/walkthrough/` — every one of these templates, filled in for the
  fictional "Saved Views" feature.
