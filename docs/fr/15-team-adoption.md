# Adoption par l'équipe

*Mainstay est une méthode, pas un outil ; l'adopter est donc un changement dans la façon dont les gens travaillent — pas une installation. Ce chapitre couvre les rôles humains, les rituels qui maintiennent la méthode en vie, sa montée en charge du solo au multi-équipe, les modes de défaillance qui tuent l'adoption, et un plan de déploiement sur 90 jours.*

La méthode tourne sur trois piliers et six couches d'architecture, mais tout cela est opéré par des personnes. Un vault ne se remplit pas tout seul ; un contrat ne se signe pas tout seul ; une zone grise ne se trie pas par un agent. Ce chapitre porte sur le système humain autour du système technique.

---

## Rôles humains

Mainstay a besoin de quatre rôles. Sur un projet solo, une seule personne porte les quatre casquettes ; en équipe, ce sont des personnes distinctes ; les responsabilités sont les mêmes dans les deux cas.

### Signataire produit

Possède la signature produit sur chaque contrat. Décide ce que l'écran doit faire, ce que disent les copies, quels sont les personas, quels comportements sont requis. Le signataire produit est l'autorité derrière le « quoi ».

- **Signe :** la ligne produit de la section signatures d'un contrat.
- **Trie :** les zones grises qui sont des décisions produit (un état vide manquant, un comportement indéfini).
- **Ne peut pas :** figer un contrat seul — la signature technique est aussi requise.

### Signataire technique

Possède la signature technique. Confirme que le contrat est *constructible* — que les endpoints, les attentes de performance et les edge cases sont techniquement sains. Ce rôle existe pour tuer le piège du « validé par le produit, découvert infaisable par la technique deux semaines plus tard ».

- **Signe :** la ligne technique de la section signatures d'un contrat.
- **Trie :** les zones grises qui sont techniques (une contrainte de performance, un comportement d'état d'erreur).
- **Ne peut pas :** figer un contrat seul — la signature produit est aussi requise.

### Architecte d'infrastructure agentique

Possède le harnais lui-même : les fichiers de contexte, skills, hooks, serveurs MCP, topologie des sous-agents et niveaux d'orchestration. Ce rôle conçoit et règle l'infrastructure qui rend les agents fiables. La méthode n'a pas de nom stable pour lui — « architecte d'infrastructure agentique », ou simplement la personne responsable du système.

- **Possède :** `AGENTS.md` et les fichiers de contexte stratifiés, les dossiers `hooks/` et `skills/`, le modèle d'orchestration (voir [Orchestration multi-agents](./11-multi-agent-orchestration.md)), le banc d'évaluation.
- **Surveille :** les métriques de santé (voir [Observabilité et métriques](./12-observability-and-metrics.md)) et agit sur les mauvaises valeurs.
- **Décide :** quelle classe de modèle tient quel niveau, quand ajouter un hook, quand un skill mérite d'être extrait.

### Contributeurs

Tous ceux qui pilotent des agents pour produire du travail — écrire des prompts, faire tourner la chaîne de livraison, faire les balayages de zones grises. Les contributeurs sont les opérateurs de la méthode au quotidien.

- **Font :** écrire les prompts comme des contrats, faire les balayages de zones grises après chaque passe, garder le vault à jour.
- **Escaladent :** les zones grises qu'ils ne peuvent pas résoudre vers le signataire concerné, sans jamais trancher seuls.

| Rôle | Possède | Signe | Équivalent en projet solo |
|---|---|---|---|
| Signataire produit | Le « quoi » de chaque écran | Signature produit | Le fondateur portant la casquette produit |
| Signataire technique | Le « constructible » de chaque écran | Signature technique | Le fondateur portant la casquette technique |
| Architecte d'infrastructure | Le harnais | — | Celui qui a monté le monorepo |
| Contributeur | Faire tourner la chaîne | — | La personne au clavier |

---

## Rituels

Les rituels sont ce qui empêche la méthode de se dégrader en un dossier de fichiers périmés. Quatre ne sont pas négociables.

### Revue de contrat

Avant qu'un contrat ne soit figé, les signataires produit et technique le revoient ensemble. La revue vérifie que les douze sections sont remplies, qu'aucune décision n'est reportée, et que le contrat est constructible. La sortie, ce sont deux signatures ou une liste de manques. Un contrat n'est jamais figé par une seule personne.

### Triage des zones grises

Après chaque passe de prototype, le contributeur lance un balayage de zones grises. Les zones grises qui ont besoin d'autorité passent au triage : le signataire concerné statue chacune soit comme une **décision formelle** (consignée dans le vault, datée, justifiée), soit comme une **note documentée** sur le contrat. Le triage a exactement deux issues — jamais « trancher plus tard ».

### Consignation des décisions

Quand une zone grise devient une décision formelle, elle est écrite dans `vault/decisions/` comme un enregistrement `DEC-XXX` daté, avec contexte, décision, justification et conséquences. Ce rituel est l'étape 6 de la chaîne de livraison : les décisions retournent au vault pour que la fonctionnalité suivante démarre plus riche. Le sauter signifie que la même zone grise est redécouverte le trimestre prochain.

### Hygiène du vault

À une cadence régulière (un créneau bimensuel marche bien), l'équipe audite le vault : les contrats périmés passés en `obsolete`, les décisions remplacées marquées `superseded`, les divergences entre sources réconciliées par la règle d'or de la divergence. La dette de cohérence est invisible jusqu'à ce que tout casse en même temps ; l'hygiène du vault est la manière de la rembourser un peu à la fois.

---

## Monter du solo au multi-équipe

La méthode ne change pas à mesure que vous montez en charge — c'est le *coût de coordination* qui change.

| Étape | Ce qui est vrai | Ce qu'il faut surveiller |
|---|---|---|
| **Solo** | Une personne, les quatre rôles. Le vault est petit. | La discipline : il est tentant de sauter le balayage de zones grises quand on est aussi le signataire. Ne le faites pas — le balayage attrape ce que vous avez supposé. |
| **Équipe** | Les rôles sont des personnes distinctes. Un monorepo, un vault. | La latence de signature : les contrats attendent désormais d'autres personnes. Faites de la signature un rituel rapide, pas une réunion. |
| **Multi-équipe** | Plusieurs équipes, un monorepo (ou quelques-uns). Beaucoup de contrats en cours. | Les collisions de décisions : deux équipes qui prennent des décisions contradictoires. L'architecte d'infrastructure possède la cohérence inter-équipes ; la règle d'or de la divergence s'applique aussi entre équipes. |

Les choix structurels qui rendent la montée en charge survivable sont déjà dans la méthode : un monorepo signifie une source de vérité unique même avec beaucoup d'équipes ; des fichiers de contexte stratifiés signifient que chaque équipe ne charge que le détail de son sous-système ; les niveaux d'orchestration signifient que le coût reste maîtrisé à mesure que le volume croît.

Le rôle qui monte le plus difficilement en charge est l'architecte d'infrastructure. À la taille solo et équipe, c'est une casquette à temps partiel ; à la taille multi-équipe, c'est une fonction dédiée, parce que le harnais est désormais une infrastructure partagée dont tout le monde dépend.

---

## Modes de défaillance courants de l'adoption

| Mode de défaillance | Symptôme | Correction |
|---|---|---|
| **Vault traité comme un wiki** | Le vault vit hors du dépôt, ou n'est jamais mis à jour. | Le vault est dans le monorepo, versionné avec le code. Les mises à jour de doc sont une condition de fusion (un hook). |
| **Sauter le balayage de zones grises** | Les écrans ont l'air faits, puis cassent à l'intégration. | Le balayage est obligatoire après chaque passe. C'est l'assurance la moins chère de la méthode. |
| **« On tranchera plus tard »** | Un arriéré de zones grises non résolues. | Le triage n'a que deux issues. Les zones grises reportées explosent ensemble. |
| **Contrats à signature unique** | Le produit valide, la technique découvre l'infaisabilité tard. | Les deux signatures ou pas de gel. La double signature existe précisément pour cela. |
| **Sous-investir la phase de contrat** | Itérations par écran élevées, ratio de reprise élevé. | Le contrat est là où va l'énergie du projet. Un brief vague est la seule vraie cause de défaillance de l'agent. |
| **Fichier de contexte lourd** | Les agents sont lents, perdent le fil, atteignent des limites. | Gardez le fichier de contexte racine maigre et stratifié ; le détail des fonctionnalités vit dans les contrats. |
| **Pas de métriques** | Personne ne sait si la méthode marche. | Montez le tableau de bord de santé tôt — les métriques qui ne sont pas collectées ne sont pas améliorées. |

---

## Un plan de déploiement sur 90 jours

Une adoption réaliste est incrémentale. Le plan ci-dessous suppose une équipe qui greffe Mainstay sur une base de code existante (voir le chemin B du [Démarrage rapide](./10-quickstart.md)).

| Phase | Jours | Objectifs | Fait quand |
|---|---|---|---|
| **Fondations** | 1–15 | Créer l'arborescence `vault/`. L'amorcer depuis le code actuel avec un sous-agent d'exploration. Ajouter un `AGENTS.md` maigre. Ajouter le premier hook en mode consultatif. | Le vault existe ; le fichier de contexte est exact ; un hook tourne. |
| **Premier contrat** | 16–35 | Choisir un écran sur le point de changer. Écrire son contrat, lancer un balayage de zones grises, obtenir les deux signatures, le figer. Construire le changement par la chaîne complète. | Un écran a été livré de bout en bout via la chaîne. |
| **Les hooks deviennent bloquants** | 36–55 | Passer le hook format/lint en bloquant. Ajouter le hook de synchro doc/schéma. Ajouter les contrôles bloquants de signatures de contrat et de balayage de zones grises à la CI. | La CI impose la méthode, pas seulement la compilation. |
| **Orchestration et évaluations** | 56–75 | Introduire la séparation chef d'orchestre/bras droit/exécutant. Monter le banc d'évaluation avec une première suite de référence et des sondes de garde-fous. | Le coût par écran baisse ; un nouveau prompt est verrouillé par le banc. |
| **Rituels et métriques** | 76–90 | Faire de la revue de contrat, du triage des zones grises, de la consignation des décisions et de l'hygiène du vault des rituels récurrents. Monter le tableau de bord de santé. | Les quatre rituels sont au calendrier ; le tableau de bord se rafraîchit en CI. |

Au jour 90, la méthode est autoportante : chaque nouvelle fonctionnalité suit la chaîne, le vault compose, les métriques sont surveillées, et les rituels tournent sans que personne n'ait à les défendre.

---

## Voir aussi

- [Démarrage rapide](./10-quickstart.md)
- [La chaîne de livraison](./05-the-delivery-chain.md)
- [Orchestration multi-agents](./11-multi-agent-orchestration.md)
- [Observabilité et métriques](./12-observability-and-metrics.md)
