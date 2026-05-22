---
name: contract-lint
description: >-
  Lint a screen contract before it is frozen. Use whenever a contract is about
  to move to status `frozen`, or in CI before merge. Checks that the frontmatter
  keys are present, all twelve required sections exist, both signatures are
  resolved, and no mandatory section is empty. Blocks the freeze on any failure.
---

# Contract Lint

A contract is the source of truth for a screen's behaviour. It is dangerous to
freeze one that is incomplete — a missing section is a grey zone with a title.
This skill checks a contract file mechanically so a freeze never ships a hole.

## When to run this

- Before changing a contract's `status` to `frozen`.
- In CI, on any pull request that touches `vault/contracts/`.
- After resolving grey zones, to confirm the contract is now whole.

## What it checks

1. **Frontmatter present and complete.** A YAML block delimited by `---`, with
   every required key: `type`, `screen`, `version`, `status`,
   `signed_product`, `signed_engineering`, `frozen_on`, `related_decisions`.
2. **`type` is `contract`.** The file is actually a contract.
3. **All twelve sections present.** Sections 1 through 12, by their heading.
4. **No mandatory section is empty.** A heading with nothing under it but the
   next heading fails.
5. **Signatures consistent.** If `status: frozen`, then both `signed_product`
   and `signed_engineering` must be `true`, both signature checkboxes in
   section 12 must be ticked, and `frozen_on` must be a date — not `null`.

A contract that fails any check is not ready to freeze.

## Steps

1. Run the linter on the contract file:

   ```sh
   ./lint.sh <path-to-contract>
   ```

2. Read the output. The linter prints one line per problem, each naming the
   exact missing key, missing section, empty section, or signature mismatch.

3. Fix every reported problem in the contract file.

4. Re-run until the linter exits `0`. Only then is the contract eligible to be
   frozen.

## Exit codes

- `0` — the contract passed every check; it is structurally ready to freeze.
- `1` — bad usage, or the file does not exist.
- `2` — the contract failed one or more checks; see the printed messages.

## Files in this skill

- `SKILL.md` — this file.
- `lint.sh` — the linter. Run `--help` for usage.

## See also

- [`../../templates/contract.md`](../../templates/contract.md) — the contract
  template this linter expects.
- [`../grey-zone-scan/`](../grey-zone-scan/) — run the grey-zone scan first;
  lint the contract once the grey zones are folded in.
