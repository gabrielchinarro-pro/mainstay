# 05 · Generated mocks

These files are **generated artifacts**, produced from
[`../04-api-spec.yaml`](../04-api-spec.yaml) by
[`tools/spec-to-mocks`](../../../tools/spec-to-mocks/). Do not edit them by
hand; re-run the generator when the spec changes:

```sh
cd tools/spec-to-mocks && npm install
node generate.mjs --spec ../../examples/walkthrough/04-api-spec.yaml \
                  --out  ../../examples/walkthrough/05-mocks
```

`types.ts` and `endpoints.ts` give the front a typed surface; the
`*.mock.json` fixtures let it render real states before the back exists.
