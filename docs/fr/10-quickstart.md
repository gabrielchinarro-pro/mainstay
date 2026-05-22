# Démarrage rapide

*Deux chemins pour adopter Mainstay — un pour un dépôt tout neuf, un pour une base de code existante — se terminant par votre première fonctionnalité en 30 minutes.*

Mainstay n'est pas un outil que l'on installe ; c'est une structure que l'on met en place. Ce chapitre vous donne les commandes et les fichiers concrets pour les deux points de départ. Choisissez le chemin qui correspond à votre situation.

- **Chemin A — Greenfield.** Vous démarrez un nouveau projet. Construisez le squelette du monorepo, le fichier de contexte racine, le `vault/`, le premier hook, le premier skill.
- **Chemin B — Dépôt existant.** Vous avez une base de code qui fonctionne. Greffez Mainstay sans casser le flux actuel : amorcez le vault depuis le code que vous avez déjà, ajoutez le fichier de contexte, introduisez les hooks progressivement, rétro-remplissez un contrat.

Les deux chemins convergent vers le même état final décrit dans [Les trois piliers](./01-three-pillars.md) et [Le monorepo](./02-monorepo.md) : la connaissance vit à côté du code, le comportement est capturé dans des contrats, et les garde-fous sont imposés par des hooks.

---

## Chemin A — Dépôt greenfield

### A.1 Créer le squelette du monorepo

Un monorepo Mainstay héberge le code et la connaissance dans un seul dépôt, un seul historique, un seul jeu de revues. Commencez par l'arborescence.

```bash
mkdir my-project && cd my-project
git init

mkdir -p apps/backend/src apps/backend/docs/database
mkdir -p apps/frontend/src
mkdir -p packages
mkdir -p vault/decisions vault/contracts vault/concepts vault/design-system
mkdir -p skills hooks tools
touch vault/00-index.md
```

La version annotée de cette arborescence vit dans `examples/monorepo-skeleton/` de ce dépôt — copiez-la plutôt que de la retaper. La forme que vous visez :

```
my-project/
├── AGENTS.md                 # root context file, loaded every session
├── apps/
│   ├── backend/
│   │   ├── src/              # code = source of truth for the schema
│   │   └── docs/database/    # canonical data model, co-located, derived
│   └── frontend/
├── packages/                 # shared types and code
├── vault/                    # knowledge base (navigable mirror)
│   ├── 00-index.md
│   ├── decisions/            # DEC-XXX, dated
│   ├── contracts/            # one per screen, with status
│   ├── concepts/             # business concepts
│   └── design-system/
├── skills/                   # progressively disclosed capabilities
└── hooks/                    # deterministic triggers
```

### A.2 Écrire le fichier de contexte racine (`AGENTS.md`)

Le fichier de contexte est le pilier mémoire rendu opérationnel. Il se charge au début de chaque session de l'agent, il doit donc être **maigre** (uniquement des règles transverses et stables) et **stratifié** (un fichier racine court qui pointe vers du détail chargé à la demande). Voir [L'architecture agentique](./03-agent-architecture.md) pour la discipline derrière cela.

```markdown
# Project context

## Commands
- Build:  `npm run build`
- Test:   `npm run test`
- Lint:   `npm run lint`

## Architecture
- Monorepo. Backend in `apps/backend`, frontend in `apps/frontend`.
- The code is the source of truth for the data schema.
- Shared types live in `packages/` — never duplicate a type.

## Conventions
- Naming: kebab-case files, PascalCase components.
- Every screen has a contract in `vault/contracts/`.

## Permanent prohibitions
- Never edit a frozen contract without a new decision.
- Never invent a label or value — fetch it from its source of truth.
- Never run a destructive command without explicit confirmation.

## Going further (loaded on demand)
- Backend detail:  ./apps/backend/docs/
- Decisions:       ./vault/decisions/
- Design system:   ./vault/design-system/
```

Gardez ce fichier sous une centaine de lignes environ. Tout ce qui est propre à une fonctionnalité a sa place dans un contrat, pas ici.

### A.3 Amorcer le vault

Le vault est le miroir navigable posé sur le code (voir [Le monorepo](./02-monorepo.md)). Sur un dépôt greenfield, il démarre presque vide — c'est normal — mais `00-index.md` doit exister dès le premier jour pour que chaque agent sache où regarder.

```markdown
<!-- vault/00-index.md -->
# Vault index

- [Decisions](./decisions/)   — dated DEC-XXX records
- [Contracts](./contracts/)   — one signed contract per screen
- [Concepts](./concepts/)     — business concepts and glossary
- [Design system](./design-system/) — colours, type, spacing, components
```

Ajoutez au moins une note de design system avant de générer le moindre prototype. Un agent sans design system en invente un, et un design system inventé est un champ de zones grises.

### A.4 Ajouter le premier hook

Un hook est un déclencheur déterministe attaché à un événement du cycle de l'agent. Le premier hook le plus précieux lance le formateur et le linter après chaque édition — il transforme une bonne pratique en garantie et amorce la [boucle d'auto-correction](./14-cicd-and-hooks.md).

```bash
# hooks/post-edit-format.sh
#!/usr/bin/env bash
# Trigger: after every file edit by an agent.
# Effect: format and lint the changed files; non-zero exit returns to the agent.
set -euo pipefail

npm run lint -- --fix
npm run format

echo "post-edit: format + lint passed"
```

```bash
chmod +x hooks/post-edit-format.sh
```

Enregistrez le hook auprès de votre runtime d'agent selon sa configuration (le mécanisme varie ; le contrat est « lance ce script après l'événement d'édition »). Le dossier `hooks/` de ce dépôt contient des exemples prêts à copier, chacun avec un commentaire d'en-tête nommant son événement déclencheur.

### A.5 Ajouter le premier skill

Un skill est un dossier qui encapsule une capacité réutilisable avec divulgation progressive : l'agent ne charge son contenu que lorsqu'une tâche le déclenche. Un skill est de la mémoire procédurale, là où le fichier de contexte est de la mémoire déclarative.

```
skills/contract-review/
├── SKILL.md
└── checklist.md
```

```markdown
<!-- skills/contract-review/SKILL.md -->
---
name: contract-review
description: >
  Review a screen contract for completeness before signing.
  Triggers when the user asks to review, sign, or freeze a contract.
---

# Contract review

When asked to review a contract:
1. Confirm all twelve sections are filled (see ./checklist.md).
2. Flag any section that defers a decision ("TBD", "later").
3. Verify endpoints carry payloads, return codes, and test data.
4. Refuse to mark `status: frozen` unless both signatures are present.
```

Le dossier `skills/` de ce dépôt livre des skills d'exemple avec leurs scripts — copiez et adaptez.

---

## Chemin B — Dépôt existant

Vous avez déjà une base de code qui livre. Le but est de greffer Mainstay **sans réécriture big bang** et sans casser le flux de personne. Introduisez-le en quatre mouvements incrémentaux.

### B.1 Amorcer le vault depuis le code actuel

Vous n'écrivez pas le vault d'imagination — vous l'extrayez de ce qui existe. Le premier flux de connaissance est **extrait du code** (schéma, types, routes) ; le second est **ajouté par les humains** (décisions, contrats, concepts).

```bash
mkdir -p vault/decisions vault/contracts vault/concepts vault/design-system
touch vault/00-index.md
```

Lancez ensuite une passe d'extraction ponctuelle. Pointez un sous-agent d'exploration (en lecture seule) vers le dépôt et demandez-lui une synthèse fidèle — voir la séparation explorer/éditer dans [Orchestration multi-agents](./11-multi-agent-orchestration.md).

```text
EXPLORE (read-only) the repository and produce:
- A list of every screen/route currently shipped.
- The current data schema, read from migrations and entity files.
- The de-facto design tokens (colours, spacing, type) found in the code.
Return a compact synthesis. Do NOT edit any file.
```

Écrivez la synthèse dans `apps/backend/docs/database/` (le schéma) et `vault/design-system/` (les tokens). C'est votre vérité de départ. Elle sera imparfaite ; marquez les vrais manques `<!-- TODO: confirm -->` plutôt que de deviner.

### B.2 Ajouter le fichier de contexte sans casser le flux

Déposez un `AGENTS.md` à la racine du dépôt en partant du gabarit de A.2, mais décrivez le dépôt **tel qu'il est aujourd'hui**, pas tel que vous le voudriez. Le fichier de contexte est d'abord descriptif ; il devient prescriptif avec le temps.

Un `AGENTS.md` de départ sûr sur un dépôt hérité :

```markdown
# Project context

## Commands
- Build / test / lint: <real commands here>

## Architecture (current state)
- Describe the actual layout, including the parts you dislike.
- Mark known-bad areas: "legacy module X — do not extend, see DEC-001".

## Conventions
- Document conventions that are actually followed, not aspirational ones.

## Permanent prohibitions
- Never edit `<sensitive area>` without review.
- Never invent a value — fetch it from its source.
```

Ce fichier ne change rien à la façon dont les humains travaillent. Il ne fait que donner aux agents un point de départ stable.

### B.3 Introduire les hooks progressivement

N'activez pas un hook bloquant dès le premier jour — un hook bruyant qui échoue sur des problèmes préexistants finit désactivé et ne revient jamais. Introduisez les hooks en trois étapes :

| Étape | Mode du hook | Effet |
|---|---|---|
| Semaine 1 | Consultatif | Le hook s'exécute, affiche ses constats, ne bloque jamais. |
| Semaines 2–3 | Bloquant sur le nouveau code | Le hook n'échoue que pour les fichiers que le changement touche. |
| Semaine 4+ | Bloquant sur tout le dépôt | Application complète une fois la base assainie. |

Commencez par `post-edit-format.sh` de A.4 en mode consultatif. Ajoutez le hook de synchronisation doc/schéma (voir [CI/CD et hooks](./14-cicd-and-hooks.md)) une fois que `apps/backend/docs/database/` reflète la réalité.

### B.4 Rétro-remplir le premier contrat

N'essayez pas d'écrire un contrat pour chaque écran. Choisissez **un écran que vous êtes sur le point de changer** et écrivez son contrat juste avant le changement. Cela se rentabilise immédiatement et enseigne le format à l'équipe.

1. Copiez le gabarit de contrat depuis `templates/contract.md` vers `vault/contracts/<screen-id>.md`.
2. Remplissez la section source de vérité visuelle avec un lien vers l'écran actuel.
3. Remplissez comportement, edge cases, permissions, endpoints à partir de la façon dont l'écran fonctionne **aujourd'hui**.
4. Lancez un balayage des zones grises (voir [Les zones grises](./07-grey-zones.md)) — chaque « je ne suis pas sûr du comportement ici » est une zone grise à résoudre avant de toucher le code.
5. Obtenez les signatures produit et technique, posez `status: frozen`.

À partir de là, chaque nouvelle fonctionnalité suit la chaîne de livraison complète. Le vault grandit un contrat à la fois, exactement quand chaque contrat est nécessaire.

---

## Votre première fonctionnalité en 30 minutes

Les deux chemins convergent ici. Pour aller de bout en bout sur une vraie petite fonctionnalité, suivez l'exemple travaillé dans `examples/walkthrough/`. Il construit la fonctionnalité **Saved Views** (vues enregistrées) sur un écran générique de table de données — un utilisateur enregistre une combinaison nommée de filtres, de tri et de colonnes visibles, en marque une comme par défaut, et la garde privée ou la partage.

Les huit artefacts du walkthrough reflètent la chaîne de livraison :

| Artefact | Étape de la chaîne |
|---|---|
| `00-vault-entry.md` | Étape 0 — le concept déjà dans le vault |
| `01-prototype-prompt.md` | Étape 1 — prototype en un seul prompt |
| `02-grey-zone-scan.md` | Étape 2 — validation par zones grises |
| `03-contract.md` | Étape 3 — le contrat figé et signé |
| `04-api-spec.yaml` | Étape 4 — la spec d'API, figée en premier |
| `05-mocks/` | Étape 4 — mocks et types issus de la spec |
| `06-decision-DEC-007.md` | Étape 6 — une décision retournée au vault |
| `07-definition-of-done.md` | Étape 5 — la DoD par couche, entièrement cochée |

Deux de ses zones grises sont devenues des décisions formelles : `DEC-007` (comportement de la vue par défaut) et `DEC-011` (visibilité privée vs partagée). Lisez d'abord le `README.md` du walkthrough ; il raconte les trente minutes étape par étape.

---

## Voir aussi

- [Le monorepo, socle de la connaissance](./02-monorepo.md)
- [La chaîne de livraison](./05-the-delivery-chain.md)
- [CI/CD et hooks](./14-cicd-and-hooks.md)
- [Adoption par l'équipe](./15-team-adoption.md)
