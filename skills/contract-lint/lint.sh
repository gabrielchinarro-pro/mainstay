#!/usr/bin/env bash
#
# lint.sh — validate a screen contract before it is frozen.
#
# PART OF: the `contract-lint` skill.
# TRIGGER: invoked by an agent or human before setting a contract to `frozen`,
#          and in CI on any pull request touching vault/contracts/.
#
# WHAT IT DOES:
#   Checks one contract Markdown file for structural completeness:
#     - frontmatter present, all required keys present, type == contract;
#     - all twelve required sections present (headings "## 1." .. "## 12.");
#     - no mandatory section is empty;
#     - if status is `frozen`: both signature keys true, both section-12
#       checkboxes ticked, frozen_on is a real date.
#   Prints one clear message per problem. Exits non-zero on any failure so it
#   can block a merge or a freeze.
#
# HOW TO WIRE IT:
#   Standalone CLI: `./lint.sh <contract-file>`.
#   In CI, run it over each changed contract; a non-zero exit fails the job.
#   It can also back the contract-lint check inside pre-commit-tests.sh.
#
# EXIT CODES:
#   0  contract passed every check
#   1  bad usage / file not found
#   2  contract failed one or more checks
#
set -euo pipefail

# --- help -------------------------------------------------------------------
usage() {
  cat <<'EOF'
lint.sh — validate a screen contract before it is frozen.

USAGE:
  lint.sh <path-to-contract.md>
  lint.sh --help

CHECKS:
  - frontmatter block present, type: contract, all required keys present;
  - all twelve sections present (## 1. .. ## 12.);
  - no mandatory section is empty;
  - if status is `frozen`: signatures consistent and frozen_on is a date.

EXIT CODES:
  0  passed
  1  bad usage / file not found
  2  failed one or more checks
EOF
}

# --- parse args -------------------------------------------------------------
if [ "$#" -ne 1 ]; then
  usage >&2
  exit 1
fi

case "$1" in
  -h|--help) usage; exit 0 ;;
esac

FILE="$1"

if [ ! -f "$FILE" ]; then
  echo "error: contract file not found: $FILE" >&2
  exit 1
fi

# --- accumulators -----------------------------------------------------------
PROBLEMS=0
problem() {
  echo "FAIL: $1" >&2
  PROBLEMS=$((PROBLEMS + 1))
}

# --- read the frontmatter block --------------------------------------------
# The frontmatter is the first block delimited by lines containing only '---'.
FIRST_LINE="$(sed -n '1p' "$FILE")"
if [ "$FIRST_LINE" != "---" ]; then
  problem "no frontmatter: the file must start with a '---' line."
  FRONTMATTER=""
else
  # Lines 2..(second '---'). awk: print between first and second '---'.
  FRONTMATTER="$(awk '
    /^---[[:space:]]*$/ { d++; next }
    d == 1 { print }
    d >= 2 { exit }
  ' "$FILE")"
  if [ -z "$FRONTMATTER" ]; then
    problem "frontmatter block is empty or not closed by a second '---'."
  fi
fi

# helper: read a frontmatter value for a key (strips quotes and whitespace)
fm_value() {
  printf '%s\n' "$FRONTMATTER" \
    | awk -v k="$1" -F: '
        $1 == k {
          sub(/^[^:]*:[[:space:]]*/, "", $0)
          gsub(/^[ \t]+|[ \t]+$/, "", $0)
          gsub(/^"|"$/, "", $0)
          print
          exit
        }'
}

fm_has_key() {
  printf '%s\n' "$FRONTMATTER" | grep -Eq "^[[:space:]]*$1[[:space:]]*:"
}

# --- check 1: required frontmatter keys ------------------------------------
REQUIRED_KEYS="type screen version status signed_product signed_engineering frozen_on related_decisions"
for key in $REQUIRED_KEYS; do
  if ! fm_has_key "$key"; then
    problem "frontmatter is missing required key: '$key'."
  fi
done

# --- check 2: type is contract ---------------------------------------------
TYPE_VALUE="$(fm_value type)"
if [ -n "$TYPE_VALUE" ] && [ "$TYPE_VALUE" != "contract" ]; then
  problem "frontmatter 'type' is '$TYPE_VALUE'; expected 'contract'."
fi

# --- check 3: all twelve sections present ----------------------------------
# Sections are headings of the form "## <n>. <title>".
for n in 1 2 3 4 5 6 7 8 9 10 11 12; do
  if ! grep -Eq "^##[[:space:]]+${n}\.[[:space:]]" "$FILE"; then
    problem "missing section heading: '## ${n}. ...'."
  fi
done

# --- check 4: no mandatory section is empty --------------------------------
# For each section heading found, gather the lines until the next "## " or
# end of file; the section is "empty" if it has no non-blank, non-comment line.
check_section_nonempty() {
  local n="$1"
  local body
  body="$(awk -v n="$n" '
    $0 ~ "^##[[:space:]]+" n "\\.[[:space:]]" { insec = 1; next }
    insec && /^##[[:space:]]/ { exit }
    insec { print }
  ' "$FILE")"

  # Strip blank lines and HTML-comment-only lines, then see if anything remains.
  local meaningful
  meaningful="$(printf '%s\n' "$body" \
    | grep -v '^[[:space:]]*$' \
    | grep -v '^[[:space:]]*<!--' \
    | grep -v -- '-->[[:space:]]*$' || true)"

  if [ -z "$meaningful" ]; then
    problem "section ${n} is present but empty (no content under the heading)."
  fi
}

for n in 1 2 3 4 5 6 7 8 9 10 11 12; do
  if grep -Eq "^##[[:space:]]+${n}\.[[:space:]]" "$FILE"; then
    check_section_nonempty "$n"
  fi
done

# --- check 5: signature consistency when status is frozen ------------------
STATUS_VALUE="$(fm_value status)"
case "$STATUS_VALUE" in
  draft|review|frozen|obsolete|"") : ;;
  *) problem "frontmatter 'status' is '$STATUS_VALUE'; expected one of draft|review|frozen|obsolete." ;;
esac

if [ "$STATUS_VALUE" = "frozen" ]; then
  SIGNED_PRODUCT="$(fm_value signed_product)"
  SIGNED_ENG="$(fm_value signed_engineering)"
  FROZEN_ON="$(fm_value frozen_on)"

  if [ "$SIGNED_PRODUCT" != "true" ]; then
    problem "status is 'frozen' but signed_product is '$SIGNED_PRODUCT' (must be true)."
  fi
  if [ "$SIGNED_ENG" != "true" ]; then
    problem "status is 'frozen' but signed_engineering is '$SIGNED_ENG' (must be true)."
  fi
  if ! printf '%s' "$FROZEN_ON" | grep -Eq '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'; then
    problem "status is 'frozen' but frozen_on is '$FROZEN_ON' (must be a YYYY-MM-DD date)."
  fi

  # Section 12 checkboxes: both must be ticked ("[x]" or "[X]").
  SIG_BLOCK="$(awk '
    /^##[[:space:]]+12\.[[:space:]]/ { insec = 1; next }
    insec && /^##[[:space:]]/ { exit }
    insec { print }
  ' "$FILE")"

  UNCHECKED="$(printf '%s\n' "$SIG_BLOCK" | grep -c -- '- \[ \]' || true)"
  CHECKED="$(printf '%s\n' "$SIG_BLOCK" | grep -ci -- '- \[x\]' || true)"

  if [ "$UNCHECKED" -gt 0 ]; then
    problem "status is 'frozen' but section 12 still has $UNCHECKED unchecked signature box(es)."
  fi
  if [ "$CHECKED" -lt 2 ]; then
    problem "status is 'frozen' but section 12 has only $CHECKED ticked signature box(es); both product and engineering must sign."
  fi
fi

# --- verdict ----------------------------------------------------------------
if [ "$PROBLEMS" -gt 0 ]; then
  echo "" >&2
  echo "contract-lint: $PROBLEMS problem(s) in $FILE — not ready to freeze." >&2
  exit 2
fi

echo "contract-lint: OK — $FILE passed every check."
exit 0
