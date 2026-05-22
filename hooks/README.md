# Hooks

A hook is a deterministic trigger attached to an event in the agent's or the
repository's lifecycle. A hook does not ask the model anything — it runs. That
is what turns a good practice into a guarantee, and what creates the
**self-correction loop**: the agent edits, the hook tests, the failure returns
to the agent, the agent fixes it.

Every script here is POSIX `bash`, starts with `#!/usr/bin/env bash` and
`set -euo pipefail`, carries a header comment stating its trigger event and how
to wire it, and degrades gracefully — none of them hard-crash a clean checkout.

## The hooks in this directory

| Hook | Trigger event | What it does |
|---|---|---|
| `post-edit-format.sh` | after a file edit | Runs the detected formatter and linter on the changed files. No-ops cleanly if no tool is present. |
| `pre-commit-tests.sh` | before a commit | Runs the test suite. Blocks the commit on failure. |
| `doc-schema-sync.sh` | before a commit | If the commit touches schema/migration files, blocks unless the canonical data-model docs under `apps/backend/docs/database/` were updated in the same change. |
| `grey-zone-reminder.sh` | after a prototype generation artifact changes | Prints the grey-zone scan checklist as a reminder. Never blocks. |

## The self-correction loop

```
  edit ──▶ post-edit-format ──▶ (lint/format fixes) ──▶ edit again if needed
                                                            │
  commit ──▶ pre-commit-tests ──▶ doc-schema-sync ──▶ commit lands
                  │                      │
                  └── fail ──────────────┴── fail ──▶ message returns to agent
                                                       agent fixes, retries
```

The agent never has to remember to run these. The event fires, the hook runs,
and a failure comes back as an actionable message.

## How to install them

### Option A — Git hooks (works for any repository)

Git looks for hooks in `.git/hooks/`. Point Git at this directory, or symlink
individual scripts.

Point Git at a tracked hooks directory (recommended — the hooks travel with the
repo):

```sh
git config core.hooksPath hooks
```

With `core.hooksPath` set, Git runs a file named exactly after the event. The
script names here do not match Git's event names, so add thin dispatchers:

```sh
# hooks/pre-commit  — tracked, tiny, calls the real hooks
#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
"$DIR/pre-commit-tests.sh"
"$DIR/doc-schema-sync.sh"
```

Or, without `core.hooksPath`, symlink into `.git/hooks/` directly:

```sh
ln -sf ../../hooks/pre-commit-tests.sh   .git/hooks/pre-commit
```

(Only one script can be symlinked per Git event; use a dispatcher when you need
several, as with `pre-commit` above.)

### Option B — Agent hook config

If your agent runtime supports lifecycle hooks, register each script against
its event:

| Script | Agent event |
|---|---|
| `post-edit-format.sh` | after-edit / post-tool-use (file write) |
| `pre-commit-tests.sh` | before-commit |
| `doc-schema-sync.sh` | before-commit |
| `grey-zone-reminder.sh` | after-edit on prototype artifacts |

Consult your runtime's documentation for the exact config format. The contract
each script honours is: read its inputs from arguments or the working tree,
exit `0` to allow, exit non-zero to block (except `grey-zone-reminder.sh`,
which never blocks).

## Graceful degradation

A hook must never break a clean checkout. Each script here:

- detects its tooling and **no-ops with a clear message** if the tool is
  absent (`post-edit-format.sh`, `pre-commit-tests.sh`);
- exits `0` when there is genuinely nothing to do;
- exits non-zero **only** on a real, actionable failure.

Run any script with `--help` for its specifics.

## See also

- `../skills/contract-lint/` — `pre-commit-tests.sh` can call the contract
  linter as one of its checks.
- `../skills/grey-zone-scan/` — `grey-zone-reminder.sh` points back to this
  skill.
