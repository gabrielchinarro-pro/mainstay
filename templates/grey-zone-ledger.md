<!--
  TEMPLATE: grey-zone ledger
  COPY TO: vault/contracts/<screen-id>.grey-zones.md
           (or keep it next to the contract it belongs to)

  A grey zone is anything an agent decided on its own because neither the
  prototype nor the contract specified it. Not a bug, not a correct answer: a
  default decision taken in the shadows by someone without the authority to
  take it: an empty state filled its way, an invented hover, an arbitrary sort,
  an unapproved error message, an assumed permission.

  This ledger tracks every grey zone found in a scan until it is resolved.
  There are only ever TWO valid outcomes, never a third:
   - "decision"  · a formal DEC-XXX in the vault, dated and justified.
   - "contract"  · a noted, documented decision recorded inline in the contract,
                   when the stake is local.
  What you never write is "decide later". Open grey zones detonate together at
  integration time.

  Re-run the scan after every iteration pass: each pass creates new grey zones.

  Fill every <PLACEHOLDER>. Delete these comments.
-->

# Grey-Zone Ledger · `<screen-id>`

- **Scan target:** <prototype build / commit being scanned>.
- **Compared against:** <the contract or brief used as the reference>.
- **Scanned on:** <YYYY-MM-DD>, pass <N>.

## Ledger

<!--
  Columns:
   - ID            · sequential within this screen: GZ-01, GZ-02, ...
   - Observable    · what was seen in the build (concrete, not abstract).
   - In contract?  · "yes" / "no". If "yes", it is not a grey zone; it should
                     not be in this table. Only "no" rows belong here.
   - Outcome       · "decision" or "contract" (the two valid outcomes only).
   - Decision link · the DEC-XXX (and link) when Outcome is "decision";
                     "n/a" when Outcome is "contract".
   - Status        · "open" | "resolved".
-->

| ID | Observable element | In contract? | Outcome | Decision link | Status |
|---|---|---|---|---|---|
| GZ-01 | <what the agent decided on its own> | no | decision | [DEC-XXX](../decisions/DEC-XXX.md) | resolved |
| GZ-02 | <what the agent decided on its own> | no | contract | n/a | resolved |
| GZ-03 | <what the agent decided on its own> | no | <decision/contract> | <link or n/a> | open |

## Resolution log

<!-- One short paragraph per resolved grey zone: what was decided and where it
     was recorded. This is the audit trail. -->
- **GZ-01**: <what was decided, and where (DEC-XXX / contract section)>.
- **GZ-02**: <what was decided, and where>.

<!--
  DONE means: every row's Status is "resolved". No row may stay "open" when the
  contract is frozen. If a new pass runs, append new GZ rows; do not overwrite.
-->
