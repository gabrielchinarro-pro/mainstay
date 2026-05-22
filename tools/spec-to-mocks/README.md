# spec-to-mocks

Generate TypeScript types, a typed endpoints list, and JSON mock fixtures from
an OpenAPI 3 spec. This is the **contract-first toolchain** of the Mainstay
delivery chain — see
[`docs/en/05-the-delivery-chain.md`](../../docs/en/05-the-delivery-chain.md),
step 4.

## The contract-first idea

In the Mainstay method, front and back build **in parallel** on the same
contract. The trick that makes this possible:

1. **Freeze the API spec first.** The versioned OpenAPI spec becomes the shared
   technical source of truth before any implementation starts.
2. **Derive, don't wait.** The front does not wait for the back. It generates
   TypeScript types and JSON mock fixtures *from the spec* and builds against
   those.
3. **Wire in waves.** When a real endpoint ships, it replaces its mock — one
   endpoint at a time, verifiable, never a risky big-bang integration.

This tool automates step 2. Run it once the spec is frozen; re-run it whenever
the spec changes. The generated files are disposable build artifacts — they
are never edited by hand.

## What it produces

For an input spec, the generator writes into the output directory:

| File | Contents |
|---|---|
| `types.ts` | One `export interface` per entry in `components.schemas`. |
| `endpoints.ts` | `BASE_URL` plus a typed `ENDPOINTS` const listing every path/operation. |
| `<Schema>.mock.json` | One mock fixture per schema, with plausible placeholder values. |

Supported schema features: `string`, `number`/`integer`, `boolean`, `array`,
`object`, and local `$ref` references. `enum`, `format`, and `example` are
used to pick better placeholder values when present.

## Install and run

Requires Node.js 20+.

```sh
cd tools/spec-to-mocks
npm install
```

Then run it against a spec:

```sh
node generate.mjs --spec <file.yaml> --out <dir>
```

Show the full help:

```sh
node generate.mjs --help
```

### Worked example

Generate the walkthrough mocks from the walkthrough spec:

```sh
node generate.mjs \
  --spec ../../examples/walkthrough/04-api-spec.yaml \
  --out  ../../examples/walkthrough/05-mocks
```

The files in
[`examples/walkthrough/05-mocks/`](../../examples/walkthrough/05-mocks/) were
produced by exactly this command.

## Options

| Flag | Required | Default | Meaning |
|---|---|---|---|
| `--spec <file>` | yes | — | Path to the OpenAPI 3 YAML spec. |
| `--out <dir>` | no | `./generated` | Output directory (created if missing). |
| `--help`, `-h` | no | — | Print usage and exit. |

## Exit codes

| Code | Meaning |
|---|---|
| `0` | Success. |
| `1` | Bad input: file unreadable, invalid YAML, not OpenAPI 3, or no schemas. |
| `2` | Unknown CLI argument. |

The generator validates its input before writing anything, so a bad spec
never leaves a half-generated output directory.
