<!--
  TEMPLATE: push & deploy playbook
  COPY TO: PLAYBOOK-PUSH.md at the repository root.

  A playbook is the written path from "the code works here" to "the code is
  live there" — with a blocking gate at the front. The gate exists because
  the two worst things a repository can ship are a secret and someone's
  personal data, and both ship silently.

  Principles baked into this template:
   - The secrets/PII gate is EXECUTABLE: commands whose output must be
     empty, not a paragraph asking you to "be careful".
   - Secrets are externalized key by key, and each key has a control
     command proving it is out of the repo.
   - Real data is confined: production dumps live OUTSIDE any git repo,
     scratch databases are separate, production datasources are read-only.
   - Branch + PR, never the default branch directly — without exception on
     repositories you do not own.
   - Publish THEN verify: a deploy is not done when the command exits, it
     is done when the live system shows the change.
   - The playbook ends with an HONEST RESIDUAL section: what is neutralized
     and testable, and what risk remains non-zero. A playbook that claims
     zero residual risk is advertising.

  All example content is fictional. Fill every <PLACEHOLDER>. Delete these
  comments.
-->

# Push & Deploy Playbook — <repository>

## 0. Secrets / PII gate — blocking, run before EVERY push

<!-- Each check: the command, and the only acceptable output. If any check
     fails, the push does not happen — there is no "just this once". -->

**No tracked secret or data file.** Output must be empty:

```sh
git ls-files | grep -iE '\.(env|sql|dump|pem|key)$|snapshot|backup'
```

**No hardcoded credential in tracked content.** Output must be empty
(tune the pattern to your stack; keep `.example` files excluded):

```sh
git grep -nIE '(api[_-]?key|secret|token|passw)[[:alnum:]_]*\s*[:=]\s*["'\''][A-Za-z0-9_/+-]{16,}' -- ':!*.example' ':!*.md'
```

**Every secret externalized, key by key.** For each key the app needs,
one line in the table — with the command that proves it is external:

| Key | Lives in | Control command (output must be empty) |
|---|---|---|
| `<API_KEY_NAME>` | <env store / vault service> | `git grep -l <API_KEY_NAME>_VALUE \|\| true` → nothing; `git log -S '<a distinctive fragment>' --oneline` → nothing |
| `<DB_PASSWORD>` | <where> | <command> |

**Real-data confinement.** Production dumps and exports live in
`<path outside every git repo>`; verify none is tracked:
`git ls-files | grep -i '<dump dir name>'` → empty. Scratch work happens on
a separate local database; the production datasource is configured
read-only. Keys are deposited by a human only — never pasted into a chat,
a prompt, or a committed file.

## 1. Branch and pull request — never the default branch

- All work leaves the machine as `feat/<topic>` (or `fix/<topic>`) + PR.
- On repositories owned by someone else, this is absolute: branch + PR,
  never their default branch, never a force-push.
- Verify before pushing: `git branch --show-current` is not `<default>`.

## 2. Pre-push review

- The diff is reviewed by someone (or some agent) who did not write it.
- Review verdict recorded: GO / NO-GO / GO-WITH-CONDITIONS — a
  GO-WITH-CONDITIONS lists its conditions, and they are met before push.

## 3. Deploy

1. <step — e.g. tag the release: `git tag v<version>`>.
2. <step — e.g. run the deploy command / merge the release PR>.
3. <step — e.g. run migrations, with the warning from §5 in mind>.

## 4. Publish THEN verify

<!-- The deploy is not the end of the procedure; the verification is. -->
- `<command or URL check>` — the new version is the one live.
- `<one real user path exercised>` — e.g. create and reopen a saved view
  with a test account.
- Write the release entry in `RELEASES.md` (see release-registry.md) —
  including the go verbatim you received before §3.

## 5. Rollback

- Redeploy the previous tag: `git checkout v<previous>` + deploy.
- Restore the pre-deploy backup if data changed.
- ⚠️ **Destructive migrations make rollback partial.** If §3 dropped or
  rewrote columns, say so HERE, per migration, with what is lost on
  rollback. A rollback plan that ignores migrations is a rollback plan
  that fails at 2 a.m.

## 6. Honest residual

<!-- Split what the gate neutralizes from what remains. Deferring a
     security finding is allowed only with a due date and a confirmation
     step; a deferred finding without both is deemed OPEN. -->

- **Neutralized (testable):** <e.g. no secret in tree or history — checked
  by the §0 commands on every push>.
- **Residual, non-zero:** <e.g. the old dump may exist on retired
  hardware; §0 patterns cannot catch every credential format>.
- **Deferred findings:** <finding> — due <date>, confirmed done by <who,
  how>. *(No date + no confirmation = still open.)*

<!--
  See ../docs/en/core/12-secrets-and-pii.md for the incident classes this
  gate exists to prevent, and release-registry.md for the entry §4 feeds.
-->
