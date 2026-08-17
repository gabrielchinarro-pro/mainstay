# Profil E · Équipe & flotte

*Plusieurs signataires réels, des enjeux financiers ou réglementaires, des dizaines de sessions parallèles. Ce profil n'enlève rien au cœur ; il ajoute : gates nommées, attestations, doublement adverse, séquencement de vagues.*

> Les faits de terrain cités dans ce profil viennent d'un corpus privé : faits datés, compteurs obtenus par commande, vérifiés par audit interne en trois passes contradictoires. Ils ne sont pas rejouables par le lecteur.

## Quand l'utiliser

Au moins deux signataires humains distincts (produit et technique) engagent leur signature sur les contrats, les enjeux sont financiers ou réglementaires, et le chantier avance par lots parallèles massifs puis par vagues de PR. À cette échelle, la question n'est plus « comment livrer un écran » mais « comment garder des dizaines de sessions, plusieurs humains et une flotte d'agents pointés sur la même vérité ».

Le test de dosage se lit ici par son maximum :

> **propriété du code × coût de l'erreur** : code partagé entre plusieurs responsables, erreur au coût maximal.

Quand l'erreur peut coûter de l'argent réel, une obligation réglementaire ou la confiance d'un client institutionnel, on ne compresse rien : on ajoute. Le terrain de référence est une fintech, où le protocole de production en huit étapes a été exécuté pour la première fois sur un lot réel le 13 mai 2026, neuf jours avant la publication de cette documentation.

## Rituels minimum

1. **Des gates humaines nommées, G1→G5, avec le go consigné jusqu'au verbatim** dans un fichier d'état par plan. Chaque gate a un nom, un gardien, et une trace : qui a dit go, quand, en quels mots. Une gate franchie sans trace n'a pas été franchie.
2. **Double signature produit + technique, puis gel dans `SIGNED/` avec attestation.** À cette échelle, la signature en frontmatter ne suffit plus : les signataires ne sont pas dans la même conversation, l'attestation matérialise l'engagement ([chapitre 04](../core/04-delivery-chain.md)).
3. **Le durcissement adverse précède l'écriture.** Avant de rédiger un contrat ou d'exécuter un plan structurant, le projet de document passe sa propre passe adversariale : faits porteurs re-vérifiés contre le code réel, verdict gradué ([chapitre 07](../core/07-adversarial-review.md)).
4. **Le doublement adverse 1:1 du codeur, sur le diff non commité.** Chaque agent codeur est doublé d'un adversaire qui relit le diff avant commit et peut le refuser. C'est le mécanisme qui a attrapé, sur ce terrain, quatre défauts que trois passes de recette produit avaient laissés passer.
5. **La recette par rounds, arrêt sur deux passes sèches consécutives.** Un round sans majeur confirmé ne clôt rien ; deux de suite, si ([chapitre 07](../core/07-adversarial-review.md)).
6. **Numérotation continue avec registre central, et arbitrage écrit des collisions.** Quand plusieurs sessions créent des décisions en parallèle, deux `DEC-043` finissent par naître ; le registre central attribue les numéros, et la collision qui survient malgré tout se résout par une décision, pas par un renommage silencieux ([chapitre 02](../core/02-vault-and-sources-of-truth.md)).
7. **Isolation worktree + port par session ; PR vault séparées des PR code ; jamais de push sans go.** Chaque session parallèle a son worktree et son port ; la connaissance et le code voyagent dans des PR distinctes, relues par des yeux différents.
8. **Le séquencement de vague, quand un stock de branches s'accumule.** Des dizaines de branches prêtes ne se fusionnent pas en vrac ; une chaîne de rôles ordonne la vague : qui vérifie quoi, dans quel ordre, avec quel critère de passage ([référence · orchestration](../reference/orchestration.md)).

## Artefacts obligatoires

| Artefact | Rôle |
|---|---|
| Charte de collaboration avec matrice de validation à niveaux | Qui valide quoi, à quel niveau d'enjeu ; écrit une fois, opposable ensuite |
| Contrats `CT-*` et lots `LOT-*`, avec registres de zones grises arbitrés P0/P1/P2 | L'unité de travail contractualisée, ses zones grises priorisées et arbitrées |
| Fichiers d'état par plan (gates franchies, findings par round) | La télémétrie humaine du chantier : où en est chaque plan, sur pièces |
| Dossier `SIGNED/` + attestations | Le gel matérialisé |
| Plans d'exécution durcis + documents de séquencement de vague | Ce qui a survécu au durcissement adverse, et l'ordre de fusion |
| Handoffs datés systématiques | Aucune session ne se ferme sans transmettre un état mesuré ([chapitre 10](../core/10-session-conduct.md)) |

## Le système humain

La méthode tourne sur des piliers et des couches, mais tout est opéré par des personnes. Quatre rôles la tiennent : sur un chantier plus petit, une seule personne porte plusieurs casquettes ; ici, ce sont des personnes distinctes, et c'est précisément ce qui définit le profil.

| Rôle | Possède | Signe | Ne peut pas |
|---|---|---|---|
| **Signataire produit** | Le « quoi » de chaque contrat : comportements, copies, personas | La ligne produit | Figer seul : la signature technique est requise |
| **Signataire technique** | Le « constructible » : endpoints, performance, edge cases | La ligne technique | Figer seul : la signature produit est requise |
| **Architecte d'infrastructure agentique** | Le harnais : fichiers de contexte, skills, hooks, topologie des agents, niveaux d'orchestration | Rien | Trancher une question produit ou technique à la place d'un signataire |
| **Contributeurs** | Faire tourner la chaîne : prompts, scans, boucles | Rien | Résoudre seuls une zone grise qui demande une autorité |

La double signature existe pour tuer un piège précis : « validé côté produit, découvert infaisable côté technique deux semaines plus tard ». Le rôle qui monte le plus difficilement en charge est l'architecte d'infrastructure : à taille d'équipe c'est une casquette, à taille de flotte c'est une fonction ; le harnais est devenu une infrastructure partagée dont tout le monde dépend.

Quatre rituels d'équipe maintiennent le système en vie, en plus des huit rituels de chantier ci-dessus :

- **La revue de contrat** : les deux signataires relisent ensemble avant gel ; la sortie est deux signatures ou une liste de manques, jamais un gel partiel.
- **Le triage des zones grises** : le signataire concerné statue chaque zone grise en décision formelle ou note de contrat ; il n'y a pas de troisième issue ([chapitre 05](../core/05-grey-zones-and-divergence.md)).
- **La consignation des décisions** : chaque arbitrage retourne au vault en `DEC-XXX` daté ; le sauter, c'est redécouvrir la même question au prochain lot.
- **L'hygiène du vault**, à cadence calendaire : contrats périmés marqués, décisions remplacées marquées `superseded`, divergences réconciliées. La dette de cohérence est invisible jusqu'à ce que tout casse en même temps.

### Monter en charge

La méthode ne change pas avec l'échelle ; c'est le coût de coordination qui change.

| Étape | Ce qui est vrai | Ce qu'il faut surveiller |
|---|---|---|
| **Deux-trois** ([profil P](./product-build.md)) | Rôles distincts, un vault, signatures en frontmatter | La latence de signature : en faire un rituel rapide, pas une réunion |
| **Équipe** | Gates nommées, `SIGNED/`, doublement adverse | Les signatures qui traînent derrière le code (voir risques) |
| **Flotte** | Dizaines de sessions parallèles, vagues de PR, registre central de numéros | Les collisions : de numéros, de branches, de décisions. Tout ce qui se partage a un registre |

## Ce qu'on s'autorise à laisser tomber

**Rien du cœur.** Ce profil est le seul des quatre où la réponse est vide : chaque rituel des profils inférieurs est conservé, et des rituels s'ajoutent. C'est le sens de la variable de dosage lue par son maximum.

Un seul assouplissement, en connaissance de cause : **« un prompt = un prototype » cesse d'être obligatoire pour l'outillage interne.** Le terrain a créé le précédent du contrat sans prototype : un outil sans écran se contractualise directement, la variante est assumée par écrit au [chapitre 04](../core/04-delivery-chain.md). L'assouplissement est borné : il vaut pour l'outillage, pas pour les écrans que voient les utilisateurs.

## Risques documentés à cette échelle

**Les signatures qui traînent derrière le code.** À flotte élevée, le build va plus vite que les signataires, et la tentation est de construire « en attendant la signature ». Le corpus consigne l'écart, et la règle qu'il a fondée : un contrat non signé ne gèle rien, et ce qui se construit dessus se construit à découvert.

**Les gates allégées oralement, sans ratification.** Un fichier d'état du corpus porte la trace d'une gate assouplie de vive voix, jamais ratifiée par écrit. La règle qui en découle est absolue : **toute levée orale de gate est consignée ou nulle.** Une gate qu'on peut lever d'un mot en réunion n'est pas une gate ; c'est un décor.

**Les modes de défaillance de l'adoption**, observés et corrigés sur le terrain :

| Défaillance | Symptôme | Correction |
|---|---|---|
| Vault traité comme un wiki | La connaissance vit hors dépôt, jamais à jour | Le vault est dans le dépôt, versionné avec le code ; les PR vault existent, séparées des PR code |
| Contrats à signature unique | Le produit valide, la technique découvre l'infaisabilité tard | Deux signatures ou pas de gel |
| « On tranchera plus tard » | Un arriéré de zones grises ouvertes | Deux issues au triage, jamais trois |
| Sous-investir la phase de contrat | Itérations élevées, reprises en chaîne | L'énergie du projet va dans le contrat, pas dans la correction |
| Fichier de contexte obèse | Agents lents, qui perdent le fil | Contexte racine maigre et stratifié ; le détail vit dans les contrats |
| Gates de complaisance | Les gates passent toujours, vite | Le go est verbatim, daté, porté par un nom, et sa levée orale est nulle |

## L'étage au-dessus n'est pas un profil

La tentation existe, à cette échelle, d'ajouter un cinquième étage : un pilotage multi-contextes qui chapeaute plusieurs chantiers. Le corpus en contient une tentative : construite en quatorze minutes, morte en un jour, rituels jamais instanciés. Elle est publiée telle quelle, avec son échec, en [annexe non normative](../reference/portfolio-layer.md) : proposée, non éprouvée. La leçon vaut pour toute la grille : installer la structure ne crée pas la pratique.

## Terrain d'origine

Une fintech (protocole de production en huit étapes, exécuté pour la première fois sur un lot réel le 13 mai 2026), dans le corpus privé.

## Voir aussi

- [Chapitre 02 · Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md) : numérotation continue, garde-fous sous sessions parallèles
- [Chapitre 04 · La chaîne de livraison](../core/04-delivery-chain.md) : la double signature, la variante contrat-sans-prototype
- [Chapitre 06 · Le prompt comme contrat](../core/06-prompt-as-contract.md) : le mega-prompt orchestrateur à gate de sortie
- [Chapitre 07 · La revue adversariale](../core/07-adversarial-review.md) : doublement 1:1, durcissement adverse, deux passes sèches
- [Chapitre 09 · La gate de mise en production et le registre](../core/09-release-gate-and-registry.md) : le go verbatim
- [Chapitre 10 · La conduite de session](../core/10-session-conduct.md) : handoffs datés, état mesuré
- [Référence · Orchestration](../reference/orchestration.md) : worktrees, flotte, vagues
- [Référence · L'étage pilotage multi-contextes](../reference/portfolio-layer.md) : l'annexe non normative
