#!/usr/bin/env bash
#
# pre-commit-tests.sh — run the test suite before a commit.
#
# TRIGGER EVENT: before a commit (Git pre-commit hook, or an agent
#                "before commit" lifecycle hook).
#
# HOW TO WIRE IT:
#   Git: set `git config core.hooksPath hooks` and call this from a `pre-commit`
#   dispatcher, or symlink it: `ln -sf ../../hooks/pre-commit-tests.sh
#   .git/hooks/pre-commit`.
#   Agent runtime: register on the "before commit" event.
#
# WHAT IT DOES:
#   Detects the project's test runner (npm/pnpm/yarn test, pytest, go test,
#   cargo test, make test) and runs it. A failing test suite blocks the commit
#   with a non-zero exit. If no runner is detected, it prints a clear message
#   and exits 0 — it does not block a repo that has no tests yet.
#
# EXIT CODES:
#   0  tests passed, OR no test runner detected (documented graceful no-op)
#   1  the test suite failed — commit must be blocked
#
set -euo pipefail

usage() {
  cat <<'EOF'
pre-commit-tests.sh — run the test suite before a commit.

USAGE:
  pre-commit-tests.sh [--allow-empty]

OPTIONS:
  --allow-empty   Exit 0 when no test runner is found (this is the default
                  behaviour; the flag is accepted for explicitness).
  -h, --help      Show this help and exit.

EXIT CODES:
  0  tests passed, or no runner detected
  1  the test suite failed — commit blocked
EOF
}

case "${1:-}" in
  -h|--help) usage; exit 0 ;;
  --allow-empty|"") : ;;
  *) echo "error: unknown argument '$1' (run --help)" >&2; exit 1 ;;
esac

if REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"; then
  :
else
  REPO_ROOT="$(pwd)"
fi

have() { command -v "$1" >/dev/null 2>&1; }

# has_npm_test_script — true if package.json declares a "test" script that is
# not the npm-init placeholder.
has_npm_test_script() {
  [ -f "${REPO_ROOT}/package.json" ] || return 1
  grep -Eq '"test"[[:space:]]*:' "${REPO_ROOT}/package.json" || return 1
  ! grep -Eq '"test"[[:space:]]*:[[:space:]]*"[^"]*no test specified[^"]*"' \
      "${REPO_ROOT}/package.json"
}

RUNNER=""
RUNNER_DESC=""

# --- detect the test runner, most specific first ---------------------------
if has_npm_test_script; then
  if [ -f "${REPO_ROOT}/pnpm-lock.yaml" ] && have pnpm; then
    RUNNER="pnpm test"; RUNNER_DESC="pnpm (package.json test script)"
  elif [ -f "${REPO_ROOT}/yarn.lock" ] && have yarn; then
    RUNNER="yarn test"; RUNNER_DESC="yarn (package.json test script)"
  elif have npm; then
    RUNNER="npm test --silent"; RUNNER_DESC="npm (package.json test script)"
  fi
elif { [ -f "${REPO_ROOT}/pytest.ini" ] || [ -f "${REPO_ROOT}/pyproject.toml" ] \
       || [ -d "${REPO_ROOT}/tests" ]; } && have pytest; then
  RUNNER="pytest"; RUNNER_DESC="pytest"
elif [ -f "${REPO_ROOT}/go.mod" ] && have go; then
  RUNNER="go test ./..."; RUNNER_DESC="go test"
elif [ -f "${REPO_ROOT}/Cargo.toml" ] && have cargo; then
  RUNNER="cargo test"; RUNNER_DESC="cargo test"
elif [ -f "${REPO_ROOT}/Makefile" ] && have make \
     && grep -Eq '^test[[:space:]]*:' "${REPO_ROOT}/Makefile"; then
  RUNNER="make test"; RUNNER_DESC="make test target"
fi

# --- graceful no-op when nothing is detected -------------------------------
if [ -z "$RUNNER" ]; then
  echo "pre-commit-tests: no test runner detected" \
       "(npm/pnpm/yarn test, pytest, go test, cargo test, make test)."
  echo "pre-commit-tests: nothing to run — allowing the commit."
  exit 0
fi

# --- run the suite ----------------------------------------------------------
echo "pre-commit-tests: running ${RUNNER_DESC} ..."
cd "$REPO_ROOT"

# Run the runner; capture its exit status without tripping `set -e`.
set +e
# shellcheck disable=SC2086  # RUNNER is an intentional multi-word command.
$RUNNER
TEST_STATUS=$?
set -e

if [ "$TEST_STATUS" -ne 0 ]; then
  echo "" >&2
  echo "pre-commit-tests: the test suite FAILED (exit ${TEST_STATUS})." >&2
  echo "pre-commit-tests: commit blocked. Fix the failing tests and re-commit." >&2
  echo "pre-commit-tests: to inspect, run: ${RUNNER}" >&2
  exit 1
fi

echo "pre-commit-tests: test suite passed — commit allowed."
exit 0
