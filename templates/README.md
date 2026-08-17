# Templates

Copyable Markdown models for the artifacts Mainstay relies on. Each file is a
skeleton you fill in: copy it into your repository, replace the placeholders,
delete the annotation comments, and commit it.

Annotation comments are written as HTML comments (`<!-- ... -->`). They explain
what each section is for. They render as nothing on GitHub, so you can keep them
while drafting and strip them once the artifact is final.

Every example in these templates is fictional: the recurring "Saved Views"
feature (`saved-views-panel`) from the walkthrough. No template contains data
from a real project.

## What each template is

### Knowledge and contract artifacts

| File | Lives at | Purpose |
|---|---|---|
| `context-file.md` | repo root, as `AGENTS.md` (or `CLAUDE.md`) | The memory pillar made operational: loaded at the start of every agent session; lean, layered, transverse-only. |
| `vault-index.md` | `vault/00-index.md` | The navigable index of the vault: the entry point an agent reads to orient itself. |
| `contract.md` | `vault/contracts/<screen>.md` | The full, signable contract for one screen: the source of truth for behaviour, edge cases, and acceptance criteria. |
| `decision.md` | `vault/decisions/DEC-XXX.md` | A dated, justified decision, usually the formal outcome of a grey zone. |
| `grey-zone-ledger.md` | next to its contract | The table that tracks every grey zone found in a scan until it is resolved. |
| `divergence-register.md` | `DIVERGENCES.md` at the rebuild root | The grey-zone ledger's twin for rebuilds against a frozen reference: measured divergences with statuses `assumed` / `fixed` / `to-arbitrate` / `deferred` (dated). |

### Prompt genres (used inline, never committed)

| File | Purpose |
|---|---|
| `generation-prompt.md` | The creation prompt for a first build: visual truth, numeric specs, initiative mandate, prohibitions, self-checklist. |
| `surgical-modification-prompt.md` | The prompt for changing one precise thing and nothing else; its heart is the closing prohibition. |
| `resume-prompt.md` | The prompt that restarts a session on an existing worksite: command-verifiable constraints, locked decisions, ordered first actions, hard exit gate. |

The fourth genre, the multi-role orchestrator prompt with a hard exit gate,
is described in `../docs/en/core/06-prompt-as-contract.md`; it is composed per
worksite rather than filled from a skeleton.

### Session and release artifacts

| File | Lives at | Purpose |
|---|---|---|
| `handoff.md` | `vault/handoffs/<date>-<topic>.md` | The end-of-session state record: measured (not deduced), with an expiry banner and an imposed first action for the next session. |
| `gates-state.md` | `GATES.md` at the worksite root | Named gates with measured entry criteria, plus the live state section quoting each go verbatim; an unwritten waiver is void. |
| `release-registry.md` | `RELEASES.md` at the repo root | The append-only registry of production releases: plain-words line, acceptance evidence, backup/rollback, go verbatim, tag, reconciliation against the real system. |
| `push-playbook.md` | `PLAYBOOK-PUSH.md` at the repo root | The path from working code to live code, opened by an executable secrets/PII gate and closed by an honest-residual section. |

## How to use them

1. **Pick the artifact you need.** A new screen needs a `contract.md`. A new
   repo needs a `context-file.md` and a `vault-index.md`. A first prototype
   needs a `generation-prompt.md`; a session restart needs a
   `resume-prompt.md`; a first production release needs a
   `release-registry.md` and a `push-playbook.md`.
2. **Copy the template** to its destination path (see the tables above);
   prompt genres are pasted inline, not committed.
3. **Fill every placeholder.** Placeholders are written `<LIKE_THIS>` or
   `[like this]`. An unfilled placeholder is a defect: agents will read it
   literally.
4. **Delete the annotation comments** once the section is written. They are
   scaffolding, not content.
5. **Commit it with the related code change**, in the same pull request. The
   knowledge artifact and the code it describes travel together.

## Frontmatter and fixed vocabularies

Contracts and decisions carry YAML frontmatter with English keys. The keys are
machine-read; do not translate or rename them. `status` values are a fixed
vocabulary: see each template. The same goes for verdicts (GO / NO-GO /
GO-WITH-CONDITIONS) and divergence statuses (`assumed` / `fixed` /
`to-arbitrate` / `deferred`): fixed words, defined in the glossary
(`../docs/en/reference/glossary.md`).

## See also

- `../skills/`: example skills, including `contract-lint` which validates a
  filled `contract.md` before it can be frozen, and `grey-zone-scan`.
- `../examples/walkthrough/`: the contract-chain templates, filled in for the
  fictional "Saved Views" feature.
- `../docs/en/core/09-release-gate-and-registry.md`,
  `../docs/en/core/10-session-conduct.md`,
  `../docs/en/core/12-secrets-and-pii.md`: the chapters behind the release,
  session, and playbook templates.
