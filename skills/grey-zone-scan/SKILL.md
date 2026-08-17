---
name: grey-zone-scan
description: >-
  Run a systematic grey-zone scan of a freshly generated prototype against its
  contract or brief. Use immediately after a prototype generation, and again
  after every iteration pass, to find every element the agent decided on its
  own because no source specified it. Produces a grey-zone ledger.
---

# Grey-Zone Scan

A grey zone is anything in the build that the agent settled by itself because
neither the prototype brief nor the contract specified it: an empty state filled
its way, an invented hover, an arbitrary sort order, an unapproved error
message, an assumed permission. It is neither a bug nor a correct answer: it is
an unauthorised default decision. This skill finds them, all of them, before
they reach integration.

## When to run this

- Right after a prototype is generated from a creation prompt.
- After **every** iteration pass on that prototype: each pass creates new grey
  zones, so each pass needs its own scan.
- Before a contract is frozen.

## The protocol

Compare the build to its reference (the contract, or the brief if no contract
exists yet), while it is fresh. For **every observable element**, ask one
question: *did the reference specify this explicitly?*

- **Yes** → move on.
- **No** → it is a grey zone. Record it.

The sweep is systematic: zone by zone, state by state, interaction by
interaction. Do not eyeball it. Walk the checklist.

## Steps

1. **Identify the inputs.**
   - The contract or brief file (the reference).
   - A short prototype-notes file: a plain-text description of what the
     generated build actually shows and does, observed directly (run it, look
     at it; do not describe from memory).

2. **Scaffold the ledger.** Run the helper script to create a grey-zone ledger
   pre-populated with the checklist sweep:

   ```sh
   ./scan.sh --contract <path-to-contract> --notes <path-to-prototype-notes> \
             --screen <screen-id> --out <path-to-ledger>
   ```

   The script writes a ledger Markdown file with one section per checklist
   category and an empty ledger table to fill.

3. **Walk the checklist.** Open [`checklist.md`](./checklist.md) and go through
   every item. For each item, compare what the build does to what the reference
   specified.

4. **Record every grey zone.** For each element the reference did **not**
   specify, add a row to the ledger table:
   - a sequential id (`GZ-01`, `GZ-02`, ...),
   - the observable element (concrete: what you saw),
   - "In contract?" = `no` (only `no` rows belong in the ledger),
   - the chosen outcome (see below),
   - a decision link or `n/a`,
   - status `open` until resolved.

5. **Resolve each grey zone.** Every grey zone gets exactly one of **two**
   outcomes, never a third:
   - **`decision`**: a formal `DEC-XXX` note in the vault, dated and
     justified, when the stake is broad or sets a rule.
   - **`contract`**: a noted, documented decision recorded inline in the
     contract, when the stake is local to this screen.

   You never write "decide later". Fifteen open grey zones are fifteen bombs
   that detonate together at integration.

6. **Close the loop.** Update the lower sources so no two truths coexist:
   write the decision, update the contract, then the code. Mark the ledger row
   `resolved` and link the decision.

## Output

A grey-zone ledger at the `--out` path, every row resolved before the contract
is frozen. See [`../../templates/grey-zone-ledger.md`](../../templates/grey-zone-ledger.md)
for the ledger format.

## Files in this skill

- `SKILL.md`: this file.
- `scan.sh`: scaffolds a grey-zone ledger from the checklist. Run `--help`.
- `checklist.md`: the sweep checklist to walk during the scan.
