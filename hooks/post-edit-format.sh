#!/usr/bin/env bash
#
# post-edit-format.sh — run the formatter and linter after an edit.
#
# TRIGGER EVENT: after a file is edited (agent after-edit / post-tool-use hook),
#                or as a pre-commit step.
#
# HOW TO WIRE IT:
#   Agent runtime: register on the "after edit" / "post tool use" event. Pass
#   the edited file paths as arguments if the runtime can; otherwise the script
#   formats the whole repository's supported files.
#   Git: call it from a pre-commit dispatcher (see hooks/README.md).
#
# WHAT IT DOES:
#   Detects which formatting/linting tools are available (prettier, eslint,
#   ruff, gofmt) and runs the ones that apply. If no tool is found, it prints a
#   clear message and exits 0 — it never breaks a clean checkout.
#
# EXIT CODES:
#   0  formatting/linting ran clean, OR no tooling was found (graceful no-op)
#   1  a linter reported an error the agent must fix
#
set -euo pipefail

usage() {
  cat <<'EOF'
post-edit-format.sh — run formatter + linter after an edit.

USAGE:
  post-edit-format.sh [file ...]

  With file arguments: formats/lints those files (by extension).
  With no arguments:   formats/lints all supported files in the repo.

EXIT CODES:
  0  clean, or no tooling found (graceful no-op)
  1  a linter reported an error
EOF
}

case "${1:-}" in
  -h|--help) usage; exit 0 ;;
esac

# Resolve the repository root if we are inside a git work tree; fall back to cwd.
if REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"; then
  :
else
  REPO_ROOT="$(pwd)"
fi

FILES=("$@")
RAN_ANYTHING=0
LINT_FAILED=0

have() { command -v "$1" >/dev/null 2>&1; }

# Decide whether a runner exists: a local node_modules binary or a global one.
node_bin() {
  # $1 = binary name. Echoes a runnable command, or nothing.
  if [ -x "${REPO_ROOT}/node_modules/.bin/$1" ]; then
    echo "${REPO_ROOT}/node_modules/.bin/$1"
  elif have npx; then
    echo "npx --no-install $1"
  fi
}

# --- JavaScript / TypeScript / Markdown / etc.: prettier -------------------
PRETTIER="$(node_bin prettier || true)"
if [ -n "$PRETTIER" ]; then
  RAN_ANYTHING=1
  echo "post-edit-format: prettier"
  if [ "${#FILES[@]}" -gt 0 ]; then
    # Format only the files prettier understands; ignore unknown extensions.
    if ! $PRETTIER --write --ignore-unknown "${FILES[@]}" 2>/dev/null; then
      echo "post-edit-format: prettier could not format some files (skipped)."
    fi
  else
    $PRETTIER --write . >/dev/null 2>&1 || \
      echo "post-edit-format: prettier formatted what it could."
  fi
fi

# --- JavaScript / TypeScript: eslint ---------------------------------------
ESLINT="$(node_bin eslint || true)"
if [ -n "$ESLINT" ]; then
  RAN_ANYTHING=1
  echo "post-edit-format: eslint"
  TARGETS=()
  if [ "${#FILES[@]}" -gt 0 ]; then
    for f in "${FILES[@]}"; do
      case "$f" in
        *.js|*.jsx|*.ts|*.tsx|*.mjs|*.cjs) TARGETS+=("$f") ;;
      esac
    done
  else
    TARGETS=(".")
  fi
  if [ "${#TARGETS[@]}" -gt 0 ]; then
    if ! $ESLINT --fix "${TARGETS[@]}"; then
      echo "post-edit-format: eslint reported errors that --fix could not resolve." >&2
      LINT_FAILED=1
    fi
  fi
fi

# --- Python: ruff -----------------------------------------------------------
if have ruff; then
  RAN_ANYTHING=1
  echo "post-edit-format: ruff"
  PY_TARGETS=()
  if [ "${#FILES[@]}" -gt 0 ]; then
    for f in "${FILES[@]}"; do
      case "$f" in *.py) PY_TARGETS+=("$f") ;; esac
    done
  else
    PY_TARGETS=(".")
  fi
  if [ "${#PY_TARGETS[@]}" -gt 0 ]; then
    ruff format "${PY_TARGETS[@]}" >/dev/null 2>&1 || \
      echo "post-edit-format: ruff format ran with notices."
    if ! ruff check --fix "${PY_TARGETS[@]}"; then
      echo "post-edit-format: ruff reported lint errors that --fix could not resolve." >&2
      LINT_FAILED=1
    fi
  fi
fi

# --- Go: gofmt --------------------------------------------------------------
if have gofmt; then
  GO_TARGETS=()
  if [ "${#FILES[@]}" -gt 0 ]; then
    for f in "${FILES[@]}"; do
      case "$f" in *.go) GO_TARGETS+=("$f") ;; esac
    done
  else
    while IFS= read -r f; do GO_TARGETS+=("$f"); done < <(
      find "$REPO_ROOT" -name '*.go' -not -path '*/vendor/*' 2>/dev/null
    )
  fi
  if [ "${#GO_TARGETS[@]}" -gt 0 ]; then
    RAN_ANYTHING=1
    echo "post-edit-format: gofmt"
    gofmt -w "${GO_TARGETS[@]}"
  fi
fi

# --- verdict ----------------------------------------------------------------
if [ "$RAN_ANYTHING" -eq 0 ]; then
  echo "post-edit-format: no formatter or linter detected (prettier, eslint," \
       "ruff, gofmt). Nothing to do — exiting clean."
  exit 0
fi

if [ "$LINT_FAILED" -eq 1 ]; then
  echo "" >&2
  echo "post-edit-format: lint errors remain. Fix them, then re-run." >&2
  exit 1
fi

echo "post-edit-format: done — formatting applied, lint clean."
exit 0
