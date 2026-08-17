---
type: definition-of-done
screen: saved-views-panel
contract: 03-contract.md
completed_on: 2026-05-29
---

# Definition of done · `saved-views-panel`

> Step 5 of the delivery chain. "Almost done" does not exist. *Done* is every
> criterion checked, per layer. This is the per-layer DoD for the Saved Views
> feature, fully checked: every item below is a real, specific criterion for
> *this* feature, not a generic checklist.

## Contract done

- [x] All 12 sections of [`03-contract.md`](./03-contract.md) are filled: no
      placeholder text, no empty section.
- [x] Every grey zone from [`02-grey-zone-scan.md`](./02-grey-zone-scan.md)
      has an outcome: DEC-007, DEC-011, or a contract note in §7/§9.
- [x] DEC-007 and DEC-011 exist in the vault, dated, and are listed in the
      contract's `related_decisions` frontmatter.
- [x] The API spec [`04-api-spec.yaml`](./04-api-spec.yaml) is frozen and
      matches the endpoints in §6 (six operations, seven schemas).
- [x] Product signature present (2026-05-18).
- [x] Engineering signature present (2026-05-18).
- [x] Frontmatter `status: frozen`, `frozen_on: 2026-05-18`.

## Back done

- [x] All six endpoints from §6 implemented: list, create, get, update,
      delete, set-default.
- [x] The frozen API spec is up to date with the implemented endpoints:
      `04-api-spec.yaml` is the served contract, not a stale draft.
- [x] Name uniqueness per user (case-insensitive) enforced; duplicate create
      or update returns `400 validation_failed`.
- [x] Name length 1-60 after trim enforced server-side.
- [x] `visibility` defaults to `private` when omitted on create (DEC-011).
- [x] `PATCH` and `DELETE` return `403 forbidden` for a non-owner of a shared
      view, and `404 not_found` for a private view that is not the caller's.
- [x] `is_default` is computed per calling user; `POST .../default` unsets the
      caller's previous default atomically (DEC-007).
- [x] Deleting the calling user's default view clears that user's default and
      promotes no other view (contract §9 rule 5).
- [x] Every error response conforms to the `Error` schema with a stable
      `code`.
- [x] Unit and integration tests cover each endpoint and each return code in
      §6.7; the suite passes.
- [x] Integration verified against a stub of the front using the §10 fixtures.
- [x] Performance measured on a realistic volume (a workspace with 500 shared
      views): `GET /v1/saved-views` returns in 180 ms at p95, within the
      agreed latency budget.

## Front done

- [x] All five body states implemented and reachable: loading (3 skeletons),
      error, empty, list, create/edit form.
- [x] All six endpoints from §6 are consumed; the front calls no endpoint not
      in the spec.
- [x] Every return code in §6.7 is handled: 401 → re-auth, 403 → owner-only
      message, 404 → not-found handling, 400 → inline form error.
- [x] The view row matches the prototype: single 44px line, 1px separators,
      name with ellipsis truncation, conditional `DEFAULT` / `SHARED` badges.
- [x] Create form pre-selects `Private` (DEC-011); blank name blocked client
      side with `Enter a name.`
- [x] Duplicate-name 400 surfaces `A view with this name already exists.`
- [x] Delete shows the inline `Delete this view?` confirmation before sending.
- [x] On screen open, the user's default view is applied; with no default the
      raw table shows (DEC-007).
- [x] Non-owner of a shared view sees only `Apply` and `Set as default` in the
      3-dot menu; `Edit`/`Delete` are absent.
- [x] Only design-system components and tokens used; no invented copy: every
      string matches contract §5.
- [x] Pixel-conforms to the prototype at 360px, 768px and 1280px.
- [x] The front was built on the generated mocks in [`05-mocks/`](./05-mocks/)
      and wired to the real API endpoint by endpoint (wiring in waves).

## Cycle close: back to the vault

- [x] DEC-007 and DEC-011 are committed in the vault `decisions/` folder.
- [x] The frozen contract is committed in the vault `contracts/` folder.
- [x] The next feature on this screen starts from this richer context.

All three layers checked. The feature is **done**, not "almost done".
