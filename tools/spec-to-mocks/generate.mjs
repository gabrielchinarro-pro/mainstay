#!/usr/bin/env node
/**
 * spec-to-mocks
 * =============
 *
 * The contract-first toolchain for the Mainstay method (see
 * docs/en/05-the-delivery-chain.md, step 4). The idea: freeze the API spec
 * FIRST, then derive everything the front needs from it — TypeScript types
 * and JSON mock fixtures — so the front can start without a single line of
 * back-end code.
 *
 * This script reads an OpenAPI 3 YAML file and, for each schema under
 * `components.schemas`, emits:
 *
 *   1. a TypeScript interface          -> <out-dir>/types.ts
 *   2. a JSON mock fixture             -> <out-dir>/<schema>.mock.json
 *
 * It also emits a typed list of the API's paths/operations:
 *
 *   3. a const map of endpoints        -> <out-dir>/endpoints.ts
 *
 * Supported schema features: string, number/integer, boolean, array, object,
 * and `$ref` references to other schemas. `enum`, `format`, and `example`
 * are used to pick better placeholder values when present.
 *
 * Usage:
 *   node generate.mjs --spec <file.yaml> [--out <dir>]
 *   node generate.mjs --help
 *
 * Exit codes: 0 on success, non-zero on bad input or write failure.
 */

import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { resolve, join } from "node:path";
import { parse as parseYaml } from "yaml";

// ---------------------------------------------------------------------------
// CLI parsing
// ---------------------------------------------------------------------------

const HELP = `spec-to-mocks — OpenAPI 3 -> TypeScript types + JSON mocks

USAGE
  node generate.mjs --spec <file.yaml> [--out <dir>]

OPTIONS
  --spec <file>   Path to the OpenAPI 3 YAML spec. Required.
  --out  <dir>    Output directory. Default: ./generated
  --help, -h      Show this help.

OUTPUT
  <out>/types.ts            one interface per components.schemas entry
  <out>/endpoints.ts        a typed const map of paths and operations
  <out>/<Schema>.mock.json  one mock fixture per schema

EXAMPLES
  node generate.mjs --spec ../../examples/walkthrough/04-api-spec.yaml \\
                    --out  ../../examples/walkthrough/05-mocks
`;

/** Parse `argv` into an options object. Throws on unknown flags. */
function parseArgs(argv) {
  const opts = { spec: null, out: "generated", help: false };
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    if (arg === "--help" || arg === "-h") {
      opts.help = true;
    } else if (arg === "--spec") {
      opts.spec = argv[++i];
    } else if (arg === "--out") {
      opts.out = argv[++i];
    } else {
      throw new Error(`Unknown argument: ${arg}`);
    }
  }
  return opts;
}

/** Print a message to stderr and exit non-zero. */
function fail(message) {
  console.error(`error: ${message}`);
  process.exit(1);
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/** Resolve a local `$ref` like "#/components/schemas/SavedView" to its name. */
function refName(ref) {
  const match = /^#\/components\/schemas\/(.+)$/.exec(ref);
  if (!match) {
    throw new Error(`Unsupported $ref (only local schema refs allowed): ${ref}`);
  }
  return match[1];
}

/** Map an OpenAPI property schema to a TypeScript type expression. */
function tsType(schema) {
  if (!schema || typeof schema !== "object") return "unknown";

  // A reference points at another generated interface — use its name.
  if (schema.$ref) return refName(schema.$ref);

  // An explicit enum becomes a TS union of string/number literals.
  if (Array.isArray(schema.enum)) {
    return schema.enum
      .map((v) => (typeof v === "string" ? JSON.stringify(v) : String(v)))
      .join(" | ");
  }

  switch (schema.type) {
    case "string":
      return "string";
    case "integer":
    case "number":
      return "number";
    case "boolean":
      return "boolean";
    case "array":
      return `${tsType(schema.items)}[]`;
    case "object":
      // Inline objects are flattened to a generic record; named objects
      // should be promoted to their own schema for clean output.
      return "Record<string, unknown>";
    default:
      return "unknown";
  }
}

/** Produce a plausible placeholder value for a property schema (for mocks). */
function mockValue(schema, allSchemas, seen) {
  if (!schema || typeof schema !== "object") return null;

  // Follow a reference, guarding against infinite recursion on cyclic specs.
  if (schema.$ref) {
    const name = refName(schema.$ref);
    if (seen.has(name)) return {}; // cycle: stop here
    return mockObject(allSchemas[name], allSchemas, new Set(seen).add(name));
  }

  // Honour an explicit example or the first enum value when given.
  if (schema.example !== undefined) return schema.example;
  if (Array.isArray(schema.enum) && schema.enum.length > 0) return schema.enum[0];

  switch (schema.type) {
    case "string":
      // `format` lets us return a more realistic placeholder.
      if (schema.format === "date-time") return "2026-05-18T09:30:00Z";
      if (schema.format === "date") return "2026-05-18";
      if (schema.format === "uuid") return "00000000-0000-4000-8000-000000000000";
      if (schema.format === "email") return "user@example.com";
      if (schema.format === "uri") return "https://api.example.com/resource";
      return "string";
    case "integer":
    case "number":
      return 0;
    case "boolean":
      return false;
    case "array":
      // Emit a single representative element so the shape is visible.
      return [mockValue(schema.items, allSchemas, seen)];
    case "object":
      return mockObject(schema, allSchemas, seen);
    default:
      return null;
  }
}

/** Build a mock object from an object schema's `properties`. */
function mockObject(schema, allSchemas, seen) {
  const out = {};
  const props = (schema && schema.properties) || {};
  for (const [key, prop] of Object.entries(props)) {
    out[key] = mockValue(prop, allSchemas, seen);
  }
  return out;
}

/** Render one TypeScript interface from an object schema. */
function renderInterface(name, schema) {
  const props = (schema && schema.properties) || {};
  const required = new Set((schema && schema.required) || []);
  const lines = [];

  if (schema && schema.description) {
    lines.push(`/** ${schema.description} */`);
  }
  lines.push(`export interface ${name} {`);
  for (const [key, prop] of Object.entries(props)) {
    if (prop && prop.description) {
      lines.push(`  /** ${prop.description} */`);
    }
    const optional = required.has(key) ? "" : "?";
    lines.push(`  ${key}${optional}: ${tsType(prop)};`);
  }
  lines.push("}");
  return lines.join("\n");
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

function main() {
  let opts;
  try {
    opts = parseArgs(process.argv.slice(2));
  } catch (err) {
    console.error(err.message);
    console.error("\n" + HELP);
    process.exit(2);
  }

  if (opts.help) {
    console.log(HELP);
    process.exit(0);
  }

  if (!opts.spec) {
    fail("--spec is required. Run with --help for usage.");
  }

  // --- Read and parse the spec -------------------------------------------
  const specPath = resolve(process.cwd(), opts.spec);
  let raw;
  try {
    raw = readFileSync(specPath, "utf8");
  } catch {
    fail(`cannot read spec file: ${specPath}`);
  }

  let spec;
  try {
    spec = parseYaml(raw);
  } catch (err) {
    fail(`spec is not valid YAML: ${err.message}`);
  }

  if (!spec || typeof spec !== "object") {
    fail("spec is empty or not an object.");
  }
  if (!spec.openapi || !String(spec.openapi).startsWith("3")) {
    fail("spec is not OpenAPI 3 (missing or wrong `openapi` field).");
  }

  const schemas = (spec.components && spec.components.schemas) || {};
  if (Object.keys(schemas).length === 0) {
    fail("spec has no `components.schemas` — nothing to generate.");
  }

  // --- Prepare the output directory --------------------------------------
  const outDir = resolve(process.cwd(), opts.out);
  mkdirSync(outDir, { recursive: true });

  // --- 1. types.ts -------------------------------------------------------
  const typeBlocks = [
    "// AUTOGENERATED by @mainstay/spec-to-mocks — do not edit by hand.",
    `// Source spec: ${opts.spec}`,
    "",
  ];
  for (const [name, schema] of Object.entries(schemas)) {
    typeBlocks.push(renderInterface(name, schema), "");
  }
  writeFileSync(join(outDir, "types.ts"), typeBlocks.join("\n"));

  // --- 2. endpoints.ts ---------------------------------------------------
  const paths = spec.paths || {};
  const endpointEntries = [];
  // Valid OpenAPI operation verbs. Anything else on a path item (notably the
  // shared `parameters` array) is not an operation and must be skipped.
  const HTTP_METHODS = new Set([
    "get",
    "put",
    "post",
    "delete",
    "patch",
    "options",
    "head",
    "trace",
  ]);
  for (const [path, item] of Object.entries(paths)) {
    for (const method of Object.keys(item)) {
      if (!HTTP_METHODS.has(method)) continue;
      const op = item[method];
      if (!op || typeof op !== "object") continue;
      endpointEntries.push({
        method: method.toUpperCase(),
        path,
        operationId: op.operationId || `${method}_${path}`,
        summary: op.summary || "",
      });
    }
  }
  const baseUrl =
    (spec.servers && spec.servers[0] && spec.servers[0].url) ||
    "https://api.example.com";
  const endpointLines = [
    "// AUTOGENERATED by @mainstay/spec-to-mocks — do not edit by hand.",
    `// Source spec: ${opts.spec}`,
    "",
    `export const BASE_URL = ${JSON.stringify(baseUrl)} as const;`,
    "",
    "export interface Endpoint {",
    "  method: string;",
    "  path: string;",
    "  operationId: string;",
    "  summary: string;",
    "}",
    "",
    "export const ENDPOINTS = [",
    ...endpointEntries.map((e) => `  ${JSON.stringify(e)},`),
    "] as const satisfies readonly Endpoint[];",
    "",
  ];
  writeFileSync(join(outDir, "endpoints.ts"), endpointLines.join("\n"));

  // --- 3. <Schema>.mock.json ---------------------------------------------
  const mockFiles = [];
  for (const [name, schema] of Object.entries(schemas)) {
    const mock = mockObject(schema, schemas, new Set([name]));
    const file = `${name}.mock.json`;
    writeFileSync(
      join(outDir, file),
      JSON.stringify(mock, null, 2) + "\n",
    );
    mockFiles.push(file);
  }

  // --- Report ------------------------------------------------------------
  console.log(`spec-to-mocks: wrote to ${outDir}`);
  console.log(`  types.ts        (${Object.keys(schemas).length} interfaces)`);
  console.log(`  endpoints.ts    (${endpointEntries.length} operations)`);
  for (const f of mockFiles) console.log(`  ${f}`);
}

main();
