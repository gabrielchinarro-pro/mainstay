#!/usr/bin/env bash
#
# doc-schema-sync.sh — block a commit that changes the schema without updating
#                      the canonical data-model docs.
#
# TRIGGER EVENT: before a commit (Git pre-commit hook, or an agent
#                "before commit" lifecycle hook).
#
# HOW TO WIRE IT:
#   Git: set `git config core.hooksPath hooks` and call this from a `pre-commit`
#   dispatcher (see hooks/README.md), or symlink it as `.git/hooks/pre-commit`.
#   Agent runtime: register on the "before commit" event.
#
# WHY THIS HOOK EXISTS — THE CANONICAL HOOK:
#   The code is the source of truth for the data schema. The human-readable
#   model lives in `apps/backend/docs/database/`, co-located with the backend.
#   Knowledge is never "to do later" — it is a condition of delivery. So: if a
#   commit touches schema or migration files, this hook BLOCKS the commit unless
#   the canonical data-model docs were updated in the SAME change. Knowledge and
#   code travel in one commit, or not at all.
#
# WHAT COUNTS AS A SCHEMA CHANGE (staged files matching any of):
#   - apps/backend/**/migrations/**         (migration files)
#   - **/*.migration.*  or  **/migration_*  (migration files by name)
#   - apps/backend/**/entities/**           (entity / model definitions)
#   - **/schema.{sql,prisma}                (declarative schema files)
#   Adjust SCHEMA_PATTERNS below to match your repository layout.
#
# WHAT COUNTS AS THE CANONICAL DOCS:
#   Any staged file under  apps/backend/docs/database/.
#
# EXIT CODES:
#   0  no schema change staged, OR schema change staged WITH doc update
#   1  schema change staged WITHOUT a matching doc update — commit blocked
#   2  not a git repository (cannot inspect the staged set)
#
set -euo pipefail

usage() {
  cat <<'EOF'
doc-schema-sync.sh — keep schema changes and canonical data-model docs in sync.

USAGE:
  doc-schema-sync.sh           run against the staged changes
  doc-schema-sync.sh --help    show this help

It blocks a commit that modifies schema/migration files unless the canonical
docs under apps/backend/docs/database/ were updated in the same staged change.

EXIT CODES:
  0  in sync (or nothing relevant staged)
  1  schema changed without a doc update — commit blocked
  2  not a git repository
EOF
}

case "${1:-}" in
  -h|--help) usage; exit 0 ;;
  "") : ;;
  *) echo "error: unknown argument '$1' (run --help)" >&2; exit 1 ;;
esac

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "doc-schema-sync: not inside a git repository — cannot inspect staged" \
       "changes. Skipping." >&2
  exit 2
fi

# The canonical docs directory.
DOCS_DIR="apps/backend/docs/database/"

# Glob patterns (egrep) that identify a schema/migration change.
# Edit these to match your repository's actual layout.
SCHEMA_PATTERNS='
apps/backend/.*/migrations/
(^|/)migration[s]?_
\.migration\.
apps/backend/.*/entities/
(^|/)schema\.(sql|prisma)$
'

# The staged file set (added, copied, modified, renamed — not deleted).
STAGED="$(git diff --cached --name-only --diff-filter=ACMR || true)"

if [ -z "$STAGED" ]; then
  echo "doc-schema-sync: no staged files — nothing to check."
  exit 0
fi

# --- which staged files are schema changes? --------------------------------
SCHEMA_HITS=""
while IFS= read -r pattern; do
  [ -n "$pattern" ] || continue
  hits="$(printf '%s\n' "$STAGED" | grep -E "$pattern" || true)"
  if [ -n "$hits" ]; then
    SCHEMA_HITS="${SCHEMA_HITS}${hits}
"
  fi
done <<EOF
$SCHEMA_PATTERNS
EOF

# De-duplicate.
SCHEMA_HITS="$(printf '%s' "$SCHEMA_HITS" | grep -v '^$' | sort -u || true)"

if [ -z "$SCHEMA_HITS" ]; then
  echo "doc-schema-sync: no schema or migration files staged — OK."
  exit 0
fi

# --- did the canonical docs change in the same commit? ---------------------
DOC_HITS="$(printf '%s\n' "$STAGED" | grep -F "$DOCS_DIR" || true)"

if [ -n "$DOC_HITS" ]; then
  echo "doc-schema-sync: schema change staged, and the canonical docs were" \
       "updated in the same commit — OK."
  echo "  schema files:"
  printf '%s\n' "$SCHEMA_HITS" | sed 's/^/    - /'
  echo "  doc files:"
  printf '%s\n' "$DOC_HITS" | sed 's/^/    - /'
  exit 0
fi

# --- block: schema changed, docs did not ------------------------------------
echo "" >&2
echo "doc-schema-sync: COMMIT BLOCKED." >&2
echo "" >&2
echo "  These staged files change the data schema:" >&2
printf '%s\n' "$SCHEMA_HITS" | sed 's/^/    - /' >&2
echo "" >&2
echo "  ...but no file under '${DOCS_DIR}' was updated in the same commit." >&2
echo "" >&2
echo "  The code is the source of truth for the schema, and the canonical" >&2
echo "  human-readable data model under '${DOCS_DIR}' must move with it." >&2
echo "  Knowledge is a condition of delivery, never a follow-up task." >&2
echo "" >&2
echo "  TO UNBLOCK:" >&2
echo "    1. Update the canonical docs under '${DOCS_DIR}' to reflect the" >&2
echo "       schema change (regenerate them if your repo automates this)." >&2
echo "    2. Stage the doc change:  git add ${DOCS_DIR}" >&2
echo "    3. Commit again." >&2
echo "" >&2
exit 1
