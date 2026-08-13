<div align="center">

# Mainstay

**Turn raw model power into shipped software — without the guesswork.**

A method for agent-driven software delivery: the memory, contracts, and
guardrails that keep an AI agent's output upright. Proven in the field before
it was written down.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Docs](https://img.shields.io/badge/docs-en%20%7C%20fr-informational.svg)](docs/en/README.md)
[![Method, not a tool](https://img.shields.io/badge/method-not%20a%20tool-orange.svg)](#what-mainstay-is--and-is-not)

**English** · [Français](README.fr.md)

</div>

---

## Why this exists

Everyone is watching the model. The game is played somewhere else.

A model is a brain. An agent is that brain given hands — it can act, not just
answer. But a brilliant brain with hands, and no memory or rules, does the
wrong thing: fast, and with confidence. What turns that power into shipped
software is not the brain. It is everything you build around it — its
infrastructure. **Mainstay is that infrastructure**, described in enough detail
to clone.

Mainstay is not theory put into practice; it is practice turned into theory.
The protocol was executed on a real batch of work before this repository was
published, and the canon has kept absorbing what the field proved. Three facts,
among those the corpus carries:

- On **a legacy e-commerce platform in production**, five days separate the
  first commit under the method from switching all of the client's shops over
  in production. That platform has since kept a registry under one rule — no
  release without an entry, no entry without a release: 239 entries and 193
  version tags in three months, with the human go recorded down to the
  decision-maker's exact words — including its two absences, which are what
  produced the rule.
- The discipline of proof caught real money there: a missing VAT on shipping
  fees — 146 orders, €2,655.70 in aggregate — fixed with a probe measuring the
  actual code path, 44 cases verified, zero change to the price any customer
  paid.
- On **a fintech**, three product acceptance passes had returned GO; the
  adversarial reviewers refused the commit twice, over four defects no
  acceptance pass had seen. The method does not count its findings: it refutes
  them.

**The status of this evidence:** it comes from a private corpus — dated facts,
counters obtained by running commands against the artifacts, verified by an
internal audit in three adversarial passes — and it is not replayable by the
reader. No figure that could not be verified even internally is published. The
detail and the limits are in [the preface](docs/en/00-preface.md).

> A **mainstay** is the line that holds a ship's mast upright — and, in plain
> English, the thing a system depends on to stay standing.

---

## Mainstay in one diagram

```mermaid
flowchart LR
    V[0 · Vault<br/>knowledge base] --> P[1 · Prototype<br/>one prompt]
    P --> G[2 · Grey-zone scan<br/>prototype vs brief]
    G --> C[3 · Contract<br/>double signature]
    C --> I[4 · Contract-first build<br/>front + back in parallel]
    I --> D[5 · Definition of Done<br/>per layer]
    D --> R[6 · Back to the vault<br/>decisions recorded]
    R -.enriches.-> V
```

Knowledge starts in the **vault**. A prototype is generated in **one prompt**.
The gap between what the agent decided and what the brief asked is swept as
**grey zones**. The validated prototype becomes a signed **contract**. Front and
back build in parallel, **contract-first**. "Done" is defined per layer. The
decisions that emerged flow **back into the vault** — and the next feature
starts smarter.

---

## The three pillars

Every agentic infrastructure stands on three foundations. Remove one and the
agent wobbles.

| Pillar | What it is | What breaks without it |
|---|---|---|
| **Memory** | A single, versioned knowledge base — conventions, decisions, constraints — living *inside* the repo. | The agent reinvents reality every session, and drifts from a documentation that lies. |
| **Contract** | A specification with acceptance criteria, not a vague brief to interpret. | "Almost done" forever; UX-approved, infeasibility discovered two weeks later. |
| **Guardrails** | What the agent must never do, written down, out of reach of its interpretation. | The agent fills every gap you leave — and rarely the way you hoped. |

The principle that ties them together: the best model in the world on a shaky
infrastructure still ships a shaky project. A solid infrastructure, served by an
ordinary model, ships whole features in weeks. **Your energy goes into the three
pillars, not the model.**

---

## Four profiles, one method

The method is the same everywhere; only its embodiment changes. The variable
that governs how much apparatus you need is neither the size of the code nor
the length of the job: it is **code ownership × cost of error**. Four questions
find your profile — the full selector is in
[the preface](docs/en/00-preface.md).

| Profile | For whom | What changes |
|---|---|---|
| [S — Compressed Solo](docs/en/profiles/solo-compressed.md) | One head, one deliverable, a cycle in days. | Functions kept, artifacts reincarnated: the vault becomes a journal, the DoD a checkable acceptance run with proofs. |
| [R — Run & Audit](docs/en/profiles/run-and-audit.md) | Someone else's code, a live platform, a high cost of error. | The method does not compress: it hardens. Timestamped backup before every write, explicit go in the current turn. |
| [P — Product Build](docs/en/profiles/product-build.md) | Building screen by screen, solo or two-to-three. | The full canonical chain: proto → grey zones → frozen contract → build → return to vault. |
| [E — Team & Fleet](docs/en/profiles/team-fleet.md) | Several real signatories, financial or regulatory stakes. | Nothing removed from the core; named gates, attestations, adversarial doubling, wave sequencing added. |

---

## Quickstart

Adopt Mainstay on a fresh repository in five steps. The short reading path —
the spine in one hour — is in [**docs/en/README.md**](docs/en/README.md).

```bash
# 1. Clone Mainstay for its templates, skills, and hooks
git clone https://github.com/gabrielchinarro-pro/mainstay.git

# 2. In your own project, create the knowledge base beside the code
mkdir -p vault/decisions vault/contracts vault/concepts vault/design-system
cp mainstay/templates/vault-index.md      vault/00-index.md
cp mainstay/templates/context-file.md     AGENTS.md      # the root context file

# 3. Install a guardrail hook (blocks merges when docs and schema drift apart)
cp mainstay/hooks/doc-schema-sync.sh      .githooks/pre-commit
chmod +x .githooks/pre-commit && git config core.hooksPath .githooks

# 4. Add your first skill (a reusable, progressively-disclosed capability)
cp -r mainstay/skills/grey-zone-scan      skills/grey-zone-scan

# 5. Write your first contract from the template, then ship a feature by the chain
cp mainstay/templates/contract.md         vault/contracts/your-first-screen.md
```

Then follow a real feature end to end in
[**examples/walkthrough/**](examples/walkthrough/README.md) — a fictional
"Saved Views" screen taken from vault entry to a checked definition of done.

---

## What's in this repo

| Path | What you get |
|---|---|
| [`docs/en/`](docs/en/README.md) · [`docs/fr/`](docs/fr/README.md) | A preface, 13 core chapters, 4 profiles, 6 reference annexes — English and French. |
| [`templates/`](templates/README.md) | Copyable models: context file, contract, decision, release registry, handoff, resume prompt, gates, push playbook, divergence register. |
| [`examples/walkthrough/`](examples/walkthrough/README.md) | One fictional feature, followed from vault to production with every real artifact. |
| [`examples/monorepo-skeleton/`](examples/monorepo-skeleton/) | An annotated directory tree for a Mainstay monorepo. |
| [`skills/`](skills/) | Working example skills with executable scripts. |
| [`hooks/`](hooks/) | Executable hooks — including `doc-schema-sync.sh`, adopted in the field. |
| [`tools/`](tools/) | Deprecated tooling (2026-08), kept for reference. |

---

## Documentation

The short path: [the preface](docs/en/00-preface.md), then
[the three pillars](docs/en/core/01-three-pillars.md),
[the delivery chain](docs/en/core/04-delivery-chain.md),
[grey zones](docs/en/core/05-grey-zones-and-divergence.md), and your profile.
The full index — core, profiles, reference — is in
[**docs/en/README.md**](docs/en/README.md).

---

## What Mainstay is — and is not

Mainstay is a **method**, not a tool. It is agnostic of the model, the language,
and the domain. It does not ship a runtime, a framework, or a dependency to
import. It ships a way of working, plus the templates, skills, hooks, and
examples to put it into practice today.

It does not promise that agents run unsupervised. It makes supervision
structured: on every terrain, the rule is an explicit, recorded human go before
any release — and the violations of that rule are themselves in the registries,
where they produced it.

Take it, adapt it, contradict it. The conversations are what move things forward.

---

## Contributing

Issues, corrections, translations, and new examples are welcome. Start with
[CONTRIBUTING.md](CONTRIBUTING.md) and the
[Code of Conduct](CODE_OF_CONDUCT.md).

## License

[MIT](LICENSE) © 2026 Mainstay contributors.

<div align="center">

*Mainstay describes a method, not a tool. It is agnostic of the model, the
language, and the domain. Take it, adapt it, contradict it.*

[Read the docs →](docs/en/README.md) · [Français →](README.fr.md)

A method by [Gabriel Chinarro](https://gabrielchinarro.com).

</div>
