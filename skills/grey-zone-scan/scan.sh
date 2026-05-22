#!/usr/bin/env bash
#
# scan.sh — scaffold a grey-zone ledger for a prototype scan.
#
# PART OF: the `grey-zone-scan` skill.
# TRIGGER: invoked by an agent (or a human) running the grey-zone-scan skill,
#          right after a prototype is generated and after every iteration pass.
#
# WHAT IT DOES:
#   Given a contract/brief file and a prototype-notes file, it writes a
#   grey-zone ledger Markdown file: a header describing the scan inputs, one
#   section per checklist family, and an empty ledger table ready to fill.
#   It does NOT detect grey zones automatically — the human/agent walks the
#   checklist. This script removes the boilerplate so the scan starts faster.
#
# HOW TO WIRE IT:
#   Standalone CLI. Run it from the skill directory, or anywhere with absolute
#   paths. It is also referenced from SKILL.md step 2.
#
# EXIT CODES:
#   0  ledger written
#   1  bad usage / missing required input file
#
set -euo pipefail

# --- defaults ---------------------------------------------------------------
CONTRACT=""
NOTES=""
SCREEN=""
OUT=""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHECKLIST="${SCRIPT_DIR}/checklist.md"

# --- help -------------------------------------------------------------------
usage() {
  cat <<'EOF'
scan.sh — scaffold a grey-zone ledger for a prototype scan.

USAGE:
  scan.sh --contract <file> --notes <file> --screen <id> [--out <file>]

OPTIONS:
  --contract <file>   Path to the contract or brief used as the reference.
  --notes <file>      Path to the prototype-notes file: a plain description of
                      what the generated build actually shows and does.
  --screen <id>       The screen id, e.g. saved-views-panel.
  --out <file>        Where to write the ledger. Defaults to
                      ./<screen>.grey-zones.md in the current directory.
  -h, --help          Show this help and exit.

EXAMPLE:
  scan.sh --contract ./vault/contracts/saved-views-panel.md \
          --notes   ./prototype-notes.md \
          --screen  saved-views-panel \
          --out     ./vault/contracts/saved-views-panel.grey-zones.md

The script writes a ledger skeleton. You then walk checklist.md and fill the
ledger table — one row per element the contract did not specify.
EOF
}

# --- parse args -------------------------------------------------------------
while [ "$#" -gt 0 ]; do
  case "$1" in
    --contract) CONTRACT="${2:-}"; shift 2 ;;
    --notes)    NOTES="${2:-}";    shift 2 ;;
    --screen)   SCREEN="${2:-}";   shift 2 ;;
    --out)      OUT="${2:-}";      shift 2 ;;
    -h|--help)  usage; exit 0 ;;
    *)
      echo "error: unknown argument '$1'" >&2
      echo "run 'scan.sh --help' for usage." >&2
      exit 1
      ;;
  esac
done

# --- validate ---------------------------------------------------------------
fail() { echo "error: $1" >&2; exit 1; }

[ -n "$CONTRACT" ] || fail "--contract is required (run --help)."
[ -n "$NOTES" ]    || fail "--notes is required (run --help)."
[ -n "$SCREEN" ]   || fail "--screen is required (run --help)."

[ -f "$CONTRACT" ] || fail "contract file not found: $CONTRACT"
[ -f "$NOTES" ]    || fail "notes file not found: $NOTES"

if [ -z "$OUT" ]; then
  OUT="./${SCREEN}.grey-zones.md"
fi

if [ -e "$OUT" ]; then
  echo "warning: $OUT already exists." >&2
  echo "         Re-running a scan should APPEND new GZ rows to the existing" >&2
  echo "         ledger, not overwrite it. Edit it by hand, or choose a new" >&2
  echo "         --out path. Not overwriting." >&2
  exit 1
fi

TODAY="$(date +%Y-%m-%d)"

# --- emit the ledger --------------------------------------------------------
{
  echo "# Grey-Zone Ledger — \`${SCREEN}\`"
  echo
  echo "- **Scan target:** prototype build for \`${SCREEN}\`."
  echo "- **Compared against:** \`${CONTRACT}\`."
  echo "- **Prototype notes:** \`${NOTES}\`."
  echo "- **Scanned on:** ${TODAY} — pass <N> (set the pass number)."
  echo
  echo "> A grey zone is anything the agent decided on its own because neither"
  echo "> the prototype nor the contract specified it. Two outcomes only:"
  echo "> \`decision\` (a DEC-XXX in the vault) or \`contract\` (a noted"
  echo "> decision inline in the contract). Never \"decide later\"."
  echo
  echo "## Ledger"
  echo
  echo "| ID | Observable element | In contract? | Outcome | Decision link | Status |"
  echo "|---|---|---|---|---|---|"
  echo "| GZ-01 | <what the agent decided on its own> | no | <decision/contract> | <link or n/a> | open |"
  echo
  echo "## Sweep coverage"
  echo
  echo "Walk every item in the checklist below. Add a ledger row for each"
  echo "element the contract or brief did not specify explicitly."
  echo

  if [ -f "$CHECKLIST" ]; then
    # Inline the checklist families so the ledger is self-contained.
    # Strip the checklist's own top-level title; keep the family sections.
    awk 'NR > 1 && $0 !~ /^# / { print }' "$CHECKLIST"
  else
    echo "<!-- checklist.md not found next to scan.sh; walk the three families"
    echo "     manually: zones, states, interactions. -->"
  fi

  echo
  echo "## Resolution log"
  echo
  echo "- **GZ-01** — <what was decided, and where it was recorded>."
  echo
  echo "<!-- DONE = every ledger row's Status is \"resolved\". No open row may"
  echo "     remain when the contract is frozen. -->"
} > "$OUT"

echo "grey-zone ledger scaffolded: $OUT"
echo "next: open the ledger, walk the sweep, and fill one row per grey zone."
exit 0
