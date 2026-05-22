# Mainstay — Index de la documentation (français)

> Un *mainstay*, c'est l'étai qui maintient le mât droit. Mainstay est
> l'infrastructure qui tient debout la production d'un agent IA : mémoire,
> contrats, garde-fous.

Ceci est la documentation française, synchronisée avec la référence anglaise.
Lisez-la dans l'ordre pour la méthode complète, ou allez directement à un
chapitre. Version anglaise de référence : [`../en/README.md`](../en/README.md).

## Chapitres de fond

| # | Chapitre | Ce qu'il couvre |
|---|---|---|
| 00 | [Introduction — Pourquoi Mainstay existe](./00-introduction.md) | Le modèle n'est pas la partie ; l'infrastructure l'est. La promesse. À qui cela s'adresse. Comment lire la documentation. |
| 01 | [Les trois piliers](./01-three-pillars.md) | Mémoire, contrat, garde-fous. Pourquoi chacun, ce qui casse sans lui, comment ils s'imbriquent. |
| 02 | [Le monorepo, socle de la connaissance](./02-monorepo.md) | La connaissance vit à côté du code, versionnée avec lui. Le code est la source de vérité du schéma. Le vault comme miroir navigable. Les deux flux de connaissance. Squelette annoté. |
| 03 | [L'architecture agentique](./03-agent-architecture.md) | Les six couches : fichier de contexte, skills, hooks, MCP, sous-agents, orchestration. Chaque couche concrètement. |
| 04 | [Les sources de vérité](./04-sources-of-truth.md) | La table d'autorité. La règle d'or de la divergence. L'historisation avec le frontmatter. Le réflexe d'escalade. |
| 05 | [La chaîne de livraison](./05-the-delivery-chain.md) | Étapes 0–6 : vault → prototype → balayage des zones grises → contrat → construction parallèle contract-first → DoD → retour au vault. |
| 06 | [Le prompt comme contrat](./06-prompt-as-contract.md) | Anatomie d'un prompt. Modification chirurgicale vs refonte intégrale. Exemple travaillé. Pourquoi chaque section ferme une porte. |
| 07 | [Les zones grises](./07-grey-zones.md) | Définition. Le protocole de détection. Les deux issues. Le rebalayage après chaque passe. Le registre des zones grises. |
| 08 | [Protocoles de défaillance](./08-failure-protocols.md) | Récupération après crash de génération. Faux positifs de transpilation. Dérive de contexte. Discipline de rollback. |
| 09 | [Patterns et anti-patterns](./09-patterns-and-antipatterns.md) | Catalogue complet, chacun avec symptôme / coût / correction. |

## Pratique et opérations

| # | Chapitre | Ce qu'il couvre |
|---|---|---|
| 10 | [Démarrage rapide](./10-quickstart.md) | Adopter Mainstay sur un dépôt greenfield, puis sur un dépôt existant. Commandes concrètes, fichier par fichier. |
| 11 | [Orchestration multi-agents](./11-multi-agent-orchestration.md) | Chef d'orchestre/bras droit/exécutant. Rôles, contextes, passation, modèle de coût, séparation explorer/éditer. |
| 12 | [Observabilité et métriques](./12-observability-and-metrics.md) | Itérations par écran, taux de zones grises, vélocité, dérive de contexte, délai du contrat. Comment les collecter et les lire. |
| 13 | [Tester et évaluer les agents](./13-testing-and-evaluating-agents.md) | Vérifier qu'un agent honore les contrats et les garde-fous. Banc d'évaluation, tâches de référence, jeux de régression. |
| 14 | [CI/CD et hooks](./14-cicd-and-hooks.md) | Intégration continue, le hook de synchro doc/schéma, contrôles bloquants, la boucle d'auto-correction. |
| 15 | [Adoption par l'équipe](./15-team-adoption.md) | Rôles humains, rituels, montée en charge, l'architecte d'infrastructure agentique. |
| 16 | [FAQ technique](./16-faq.md) | ~20 questions-réponses tranchantes. |
| 17 | [Glossaire](./17-glossary.md) | Chaque terme défini, relié. |

## Comment lire ceci

Si vous avez une heure, lisez [00](./00-introduction.md), [01](./01-three-pillars.md),
[05](./05-the-delivery-chain.md) et [07](./07-grey-zones.md). C'est la colonne
vertébrale de la méthode. Le reste est de la profondeur et des opérations.

Si vous voulez adopter Mainstay cette semaine, lisez [10 — Démarrage rapide](./10-quickstart.md)
et copiez les modèles vers lesquels il pointe.
