# Mainstay — Index de la documentation (français)

> Un *mainstay*, c'est l'étai qui maintient le mât droit. Mainstay est
> l'infrastructure qui tient debout la production d'un agent IA : mémoire,
> contrats, garde-fous.

Ceci est la documentation française, synchronisée avec la référence anglaise :
[`../en/README.md`](../en/README.md). La documentation est organisée en quatre
blocs : une préface, treize chapitres de cœur, quatre profils d'échelle et six
annexes de référence.

## La colonne vertébrale en une heure

Cinq lectures suffisent pour comprendre la méthode et la défendre :

1. [La préface](./00-preface.md) — la thèse, les preuves du terrain, quand ne PAS utiliser Mainstay.
2. [Les trois piliers](./core/01-three-pillars.md) — mémoire, contrat, garde-fous.
3. [La chaîne de livraison](./core/04-delivery-chain.md) — du dépôt vide à la production, en boucle.
4. [Zones grises et divergence](./core/05-grey-zones-and-divergence.md) — le cœur de la méthode.
5. **Le profil qui vous correspond** — voir le sélecteur ci-dessous ; un seul des quatre vous concerne.

Le reste est de la profondeur : lisez-le quand un besoin vous y accroche.

## Choisir son profil en quatre questions

La méthode est la même partout ; seule l'incarnation change. Prenez la première
ligne dont la réponse est oui — l'ordre est celui du coût de l'erreur. Le
raisonnement complet est dans [la préface](./00-preface.md#choisir-son-profil-en-quatre-questions).

| Question | Si oui | Profil |
|---|---|---|
| Le code appartient-il à un client, ou une plateforme vivante est-elle en jeu ? | L'unité de travail est le ticket ou la passe d'audit ; backup horodaté avant toute écriture. | [Profil R — Run & audit](./profiles/run-and-audit.md) |
| Construisez-vous un produit, écran par écran ou lot par lot, prototype possible ? | La chaîne canonique : proto → zones grises → contrat figé → build → retour au vault. | [Profil P — Produit en construction](./profiles/product-build.md) |
| Êtes-vous plusieurs signataires réels — produit et technique —, avec des enjeux financiers ou réglementaires ? | Rien de retiré au cœur ; gates nommées, attestations, séquencement de vagues en plus. | [Profil E — Équipe & flotte](./profiles/team-fleet.md) |
| Êtes-vous seul, avec un livrable et un cycle en jours ? | Fonctions conservées, artefacts réincarnés : le vault devient un journal, la DoD une recette cochable. | [Profil S — Solo compressé](./profiles/solo-compressed.md) |

En cas de doute entre deux profils, prenez le plus léger et durcissez par
décision datée.

## Préface

| Chapitre | Ce qu'il couvre |
|---|---|
| [Préface — D'où vient cette méthode, et quand ne pas s'en servir](./00-preface.md) | La thèse d'inversion. Les preuves du terrain et leur statut épistémique. Les trois conditions du surpoids, les quatre non-négociables, la variable de dosage. Le sélecteur de profil. |

## Le cœur — 13 chapitres

| # | Chapitre | Ce qu'il couvre |
|---|---|---|
| 01 | [Les trois piliers](./core/01-three-pillars.md) | Mémoire, contrat, garde-fous. Ce qui casse sans chacun. Le gabarit « interdit (cause : incident daté) ». |
| 02 | [Le vault et les sources de vérité](./core/02-vault-and-sources-of-truth.md) | La connaissance dans le monorepo. La table d'autorité. Les garde-fous du vault sous sessions parallèles. Le guide vivant semver. |
| 03 | [L'architecture agentique](./core/03-agent-architecture.md) | Les six couches, chacune avec son verdict du terrain : deux conservées, trois refondues, une émergente. |
| 04 | [La chaîne de livraison](./core/04-delivery-chain.md) | Étapes 0–6. L'interdit « rien n'est construit tant que le contrat n'est pas figé ». Les variantes contrat-sans-proto et design greffé. |
| 05 | [Zones grises et divergence](./core/05-grey-zones-and-divergence.md) | Le protocole de détection. Les deux issues. Le registre d'écarts comme artefact jumeau. Le compteur de résolution. |
| 06 | [Le prompt comme contrat](./core/06-prompt-as-contract.md) | Anatomie d'un prompt. Chirurgical vs refonte. Le prompt de reprise et le mega-prompt orchestrateur. Mandat d'initiative et posture. |
| 07 | [La revue adversariale](./core/07-adversarial-review.md) | Rôles, contre-vérification des findings, triage des faux positifs, règle des deux passes sèches, gel honnête. |
| 08 | [La preuve et les sondes](./core/08-proof-and-probes.md) | Sondes sur le vrai chemin de code, dossiers de preuve numérotés, preuve rejouée post-MEP, audit de fidélité des mocks. |
| 09 | [La gate de MEP et le registre](./core/09-release-gate-and-registry.md) | Go humain explicite au tour courant. Le registre des MEP. La réconciliation registre↔réel. La dé-escalade écrite. |
| 10 | [La conduite de session](./core/10-session-conduct.md) | Handoffs datés, « état mesuré, pas déduit », péremption explicite, titres à préfixe d'état, fiches mémoire. |
| 11 | [Les protocoles de défaillance](./core/11-failure-protocols.md) | Récupération après crash. Rollback. Réconciliation. Le bandeau d'obsolescence : marquer, ne pas réécrire. |
| 12 | [Secrets et PII](./core/12-secrets-and-pii.md) | Écrit par quatre incidents réels. Gate anti-PII pré-push, externalisation des secrets, suivi des findings différés. |
| 13 | [Patterns et anti-patterns](./core/13-patterns-and-antipatterns.md) | Le catalogue complet, chacun avec symptôme / coût / correction. |

## Les profils — 4 échelles

| Profil | Pour qui | Fichier |
|---|---|---|
| S — Solo compressé | Une tête, un livrable, un cycle en jours. | [solo-compressed.md](./profiles/solo-compressed.md) |
| R — Run & audit | Code d'autrui, plateforme vivante, coût d'erreur élevé. | [run-and-audit.md](./profiles/run-and-audit.md) |
| P — Produit en construction | La chaîne canonique, seul ou à deux-trois, mono ou multi-dépôts. | [product-build.md](./profiles/product-build.md) |
| E — Équipe & flotte | Plusieurs signataires réels, lots et vagues, sessions parallèles massives. | [team-fleet.md](./profiles/team-fleet.md) |

## La référence — 6 annexes

| Annexe | Ce qu'elle couvre |
|---|---|
| [Orchestration multi-agents](./reference/orchestration.md) | Séparation des rôles, panels de relecture, flotte de worktrees. « Un palier n'est jamais clos par celui qui l'a construit. » |
| [Métriques](./reference/metrics.md) | Instrument proposé, non éprouvé — aucune métrique encore collectée sur un terrain réel. |
| [CI/CD et hooks](./reference/cicd-and-hooks.md) | Le hook git `pre-commit` comme voie principale. La garde statique de décision en CI. Le reste marqué prescriptif. |
| [L'étage pilotage multi-contextes](./reference/portfolio-layer.md) | Annexe non normative — proposé, non éprouvé, publié avec son échec d'usage. |
| [FAQ technique](./reference/faq.md) | Des réponses tranchantes aux questions courantes. |
| [Glossaire](./reference/glossary.md) | Chaque terme défini. Le lexique des verdicts tranché : GO / NO-GO / GO-SOUS-CONDITIONS. |

## Anciens chemins

Les chapitres `00-introduction.md` à `17-glossary.md` de la v1 sont conservés en
stubs de redirection — les liens entrants continuent de fonctionner.
