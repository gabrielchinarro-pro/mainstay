#!/usr/bin/env bash
#
# grey-zone-reminder.sh — remind to run a grey-zone scan after a prototype
#                         artifact changes.
#
# TRIGGER EVENT: after a prototype generation artifact changes — an agent
#                "after edit" hook scoped to prototype files, or a Git
#                post-commit / pre-commit hook.
#
# HOW TO WIRE IT:
#   Agent runtime: register on "after edit" with a path filter for your
#   prototype artifacts (see PROTOTYPE_PATTERNS below).
#   Git: call it from a post-commit dispatcher so it prints after each commit
#   that touched a prototype.
#
# WHAT IT DOES:
#   When a prototype artifact has changed, it prints the grey-zone scan
#   checklist as a reminder. It is purely advisory: it NEVER blocks. A grey
#   zone is anything the agent decided on its own because no source specified
#   it, and the moment to catch them is right after generation, before they
#   reach a contract.
#
# EXIT CODES:
#   0  always — this hook never blocks anything
#
set -euo pipefail

usage() {
  cat <<'EOF'
grey-zone-reminder.sh — print the grey-zone scan reminder after a prototype
                        artifact changes.

USAGE:
  grey-zone-reminder.sh [file ...]   check the given files (any prototype hit
                                     prints the reminder)
  grey-zone-reminder.sh              check the staged set, then the last
                                     commit, for prototype artifacts
  grey-zone-reminder.sh --force      print the reminder unconditionally
  grey-zone-reminder.sh --help       show this help

This hook is advisory. It always exits 0 and never blocks a commit or an edit.
EOF
}

FORCE=0
FILE_ARGS=()
for arg in "$@"; do
  case "$arg" in
    -h|--help) usage; exit 0 ;;
    --force)   FORCE=1 ;;
    *)         FILE_ARGS+=("$arg") ;;
  esac
done

# Patterns that identify a prototype generation artifact. Adjust to your repo.
PROTOTYPE_PATTERNS='
(^|/)prototypes?/
(^|/)examples/walkthrough/01-prototype
\.prototype\.
prototype-notes
'

matches_prototype() {
  # $1 = a newline-separated list of paths. Returns 0 if any path matches.
  local list="$1" pattern
  while IFS= read -r pattern; do
    [ -n "$pattern" ] || continue
    if printf '%s\n' "$list" | grep -Eq "$pattern"; then
      return 0
    fi
  done <<EOF
$PROTOTYPE_PATTERNS
EOF
  return 1
}

# --- decide whether a prototype artifact changed ---------------------------
SHOULD_REMIND=0
TRIGGER_NOTE=""

if [ "$FORCE" -eq 1 ]; then
  SHOULD_REMIND=1
  TRIGGER_NOTE="(forced)"
elif [ "${#FILE_ARGS[@]}" -gt 0 ]; then
  JOINED="$(printf '%s\n' "${FILE_ARGS[@]}")"
  if matches_prototype "$JOINED"; then
    SHOULD_REMIND=1
    TRIGGER_NOTE="(prototype file passed as argument)"
  fi
elif git rev-parse --git-dir >/dev/null 2>&1; then
  STAGED="$(git diff --cached --name-only --diff-filter=ACMR 2>/dev/null || true)"
  LAST="$(git diff-tree --no-commit-id --name-only -r HEAD 2>/dev/null || true)"
  if [ -n "$STAGED" ] && matches_prototype "$STAGED"; then
    SHOULD_REMIND=1
    TRIGGER_NOTE="(prototype file in staged changes)"
  elif [ -n "$LAST" ] && matches_prototype "$LAST"; then
    SHOULD_REMIND=1
    TRIGGER_NOTE="(prototype file in the last commit)"
  fi
fi

if [ "$SHOULD_REMIND" -eq 0 ]; then
  # Nothing prototype-related changed — stay silent, never block.
  exit 0
fi

# --- print the reminder -----------------------------------------------------
cat <<EOF

────────────────────────────────────────────────────────────────────────
  GREY-ZONE SCAN REMINDER  ${TRIGGER_NOTE}
────────────────────────────────────────────────────────────────────────
  A prototype artifact just changed. Before this build feeds a contract,
  run a grey-zone scan. A grey zone is anything the agent decided on its
  own because neither the prototype brief nor the contract specified it.

  Run the scan now — and again after every iteration pass:

    skills/grey-zone-scan/scan.sh \\
      --contract <path-to-contract-or-brief> \\
      --notes    <path-to-prototype-notes> \\
      --screen   <screen-id> \\
      --out      <path-to-ledger>

  Then walk the sweep:

    [ ] Zones        — layout, ordering, truncation, counts, copy
    [ ] States       — loading, empty, error, partial, disabled, selected
    [ ] Interactions — hover, focus, validation, confirmations, feedback

  Every grey zone gets exactly one of TWO outcomes — never a third:
    - decision : a formal DEC-XXX in the vault, dated and justified
    - contract : a noted decision recorded inline in the contract
  Never "decide later". Open grey zones detonate together at integration.

  Full procedure: skills/grey-zone-scan/SKILL.md
────────────────────────────────────────────────────────────────────────

EOF

# Advisory only — always succeed.
exit 0
