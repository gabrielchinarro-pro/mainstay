# Profil R · Run & audit

*Le code ne vous appartient pas et une plateforme vivante est en jeu. L'unité de travail est le ticket, le chantier ou la passe d'audit, pas l'écran. Ici, la méthode ne se compresse pas : elle se durcit.*

> Les faits de terrain cités dans ce profil viennent d'un corpus privé : faits datés, compteurs obtenus par commande, vérifiés par audit interne en trois passes contradictoires. Ils ne sont pas rejouables par le lecteur.

## Quand l'utiliser

Le code appartient à un client, ou une plateforme en production avec de vrais utilisateurs est en jeu, et il n'y a rien à prototyper : le système existe déjà, votre travail est de le faire tourner, de le corriger ou de l'auditer. L'unité de travail n'est pas l'écran mais le ticket, le chantier ou la passe d'audit, et chaque écriture peut coûter de l'argent, des données ou la confiance d'un tiers.

Le test est celui de toute la méthode, et c'est ce terrain qui l'a nommé :

> **propriété du code × coût de l'erreur**, pas la taille, pas la durée.

Un script de trois cents lignes qui touche la production d'un client relève de ce profil ; un produit de trente mille lignes que vous êtes seul à pouvoir casser n'en relève pas. Le profil couvre deux variantes : **(a) le run**, tickets et chantiers sur une base héritée en production ; **(b) le vault d'audit**, la méthode appliquée à du code qu'on analyse sans le posséder (voir le module plus bas). Sur le terrain du run, le premier commit sous la méthode se qualifie lui-même de « Mainstay light » : la méthode y est entrée allégée, et c'est la version allégée qui a tenu, puis s'est durcie, incident par incident.

## Rituels minimum

1. **Le go de mise en production est explicite et donné au tour courant** : jamais déduit d'une recette validée, jamais reporté d'une conversation précédente. Une recette verte autorise à *demander* le go ; elle ne le remplace pas ([chapitre 09](../core/09-release-gate-and-registry.md)).
2. **Une entrée de registre par mise en production**, ou, en variante, le journal de révisions d'un guide vivant versionné, où chaque révision porte quatre choses : le fix, la recette, le backup, le commit. Aucune MEP sans entrée, aucune entrée sans MEP.
3. **Un backup horodaté avant toute écriture** sur un serveur ou une préprod. Le backup précède l'écriture ; il ne la suit jamais. C'est la règle numéro un de tous les briefs de ce profil, sans exception consignée.
4. **Un harnais de preuve sur le chemin de code réel avant promotion, et la preuve rejouée après.** On ne prouve pas sur une maquette du système : on sonde le vrai chemin, on promeut, puis on rejoue la même preuve en production ([chapitre 08](../core/08-proof-and-probes.md)). Le terrain tient des recettes chiffrées (seize vérifications sur seize, huit sur huit) consignées avec leurs commandes.
5. **Les interdits nés d'incidents s'inscrivent avec leur cause.** Le fichier de contexte de ce profil est une liste de prohibitions permanentes, chacune datée, chacune causée. Un interdit sans cause sera contourné ; un interdit causé se respecte.
6. **Le registre se réconcilie périodiquement contre l'état réel du serveur.** Vérifié serveur, pas mémoire : une réconciliation datée du corpus a réaligné le registre sur ce qui tournait réellement. Un registre jamais réconcilié est une fiction qui vieillit bien.

## Artefacts obligatoires

| Artefact | Rôle |
|---|---|
| `AGENTS.md` à prohibitions permanentes **causées** | Le garde-fou d'écriture : chaque interdit porte son incident d'origine |
| `vault/decisions/` en `DEC-XXX` | La mémoire inter-sessions ; **avec un registre central des numéros si deux vaults coexistent** : la collision de numérotation est un piège documenté de ce profil |
| `RELEASES.md` + tags, ou guide vivant en semver, auto-challengeable | Le registre : ce qui est parti, quand, sur quel go |
| Scripts de MEP défensifs + un runbook **distinct** du guide | Le guide explique ; le runbook exécute. Le terrain a consigné la distinction en toutes lettres : le guide « n'est pas un runbook » |
| Un dossier de preuves de recette par chantier | La trace rejouable de ce qui a été vérifié, et comment |

## La chaîne, incarnée par le ticket

La [chaîne de livraison](../core/04-delivery-chain.md) ne disparaît pas dans ce profil : chaque maillon survit sous une incarnation adaptée à un système qu'on n'a pas construit.

| Maillon canonique | Incarnation run & audit |
|---|---|
| Étape 0 : le vault | `AGENTS.md` à prohibitions causées + `DEC-XXX` : la mémoire précède le premier ticket |
| Étape 1 : le prototype | Néant. On ne prototype pas un système existant ; on le lit, sondes read-only à l'appui |
| Étape 2 : les zones grises | Le triage du ticket : ce que le ticket ne dit pas se demande, il ne se devine pas |
| Étape 3 : le contrat | Le couple `DEC-XXX` + brief de chantier ; jamais de gel en variante audit |
| Étape 4 : le build | Le fix, précédé de son backup horodaté, confiné à son périmètre |
| Étape 5 : la definition of done | Le harnais de preuve sur le chemin réel, chiffré, rejoué après promotion |
| Étape 6 : le retour au vault | L'entrée de registre + l'interdit causé si l'incident a appris quelque chose |

## Module : le vault d'audit

La variante la plus durcie du profil : appliquer la méthode à du code qu'on **audite sans le posséder**. Le vault n'est plus le socle d'une construction ; c'est une mémoire d'enquête posée à côté de la plateforme d'un client. Quatre règles le distinguent, toutes issues du même terrain :

1. **Lecture seule absolue sur l'existant.** L'audit ne modifie rien de ce qu'il analyse. Pas « on évite » : interdiction structurelle, écrite dans le fichier de contexte, avec la liste des seules zones d'écriture autorisées.
2. **Toute citation du code audité est marquée « vérifié dans l'audit, à revérifier sur le code live ».** Un audit fige un instant ; la plateforme, elle, continue de vivre. Une affirmation d'audit non re-datée au moment de s'en servir est une divergence en puissance ([chapitre 05](../core/05-grey-zones-and-divergence.md)).
3. **Aucun gel de contrat pendant la passe d'audit.** On ne fige pas un contrat sur un système qu'on ne possède pas et qu'on n'a pas fini de comprendre ; le fichier de contexte du terrain l'interdit explicitement. Les livrables de l'audit sont des constats et des décisions, pas des contrats d'écran.
4. **Le code neuf est confiné en packages autonomes** (jamais entrelacé avec le code du client), **et rien ne part en production ni en préproduction sans go**. La frontière entre « à eux » et « à nous » est physique, pas conventionnelle.

Le module hérite de tout le reste du profil : backups horodatés avant chaque écriture autorisée, revue adversariale chiffrée (sur ce terrain, une passe à trente agents a produit 24 findings dont 19 confirmés, les autres écartés avec justification), go explicite pour tout.

## Ce qu'on s'autorise à laisser tomber

**Le prototype et la chaîne par écran.** Aucun prototype n'a été produit sur ces terrains : il n'y a rien à prototyper quand le système existe déjà. La [chaîne de livraison](../core/04-delivery-chain.md) par écran laisse place au cycle ticket → preuve → go → registre. C'est un choix de forme, pas un abandon de fond : chaque maillon (contrat, preuve, gate, retour à la mémoire) survit sous une autre incarnation.

**Le contrat d'écran douze sections.** Remplacé par le couple décision (`DEC-XXX`) + brief de chantier, et, en variante audit, interdit de gel pur et simple. Le contrat d'écran suppose qu'on possède ce qu'on spécifie ; ici on ne le possède pas.

**Les métriques du tableau de bord.** Aucune collectée sur ces terrains. L'observabilité de ce profil est le registre lui-même et sa réconciliation, pas un dashboard ([référence · métriques](../reference/metrics.md), instrument proposé, non éprouvé).

Ce qu'on ne s'autorise **pas** à laisser tomber, même sous la pression d'un audit :

- **La cohérence registre-exigence.** Le corpus consigne la violation : un runbook qui exige bump de version + entrée de registre + tag, sur un dépôt qui compte zéro tag et aucun registre. Une exigence écrite que l'artefact ne suit pas est pire que pas d'exigence : elle apprend aux agents que les règles sont décoratives.
- **Le remote git.** Deux terrains de ce profil ont travaillé sur des dépôts jamais poussés, dont 99 commits de travail client sur un seul poste. Sur du code d'autrui, l'historique non répliqué est un risque que vous faites porter au client sans le lui dire.

## Risques documentés à cette échelle

Les deux entorses ci-dessus (registre exigé mais non tenu, dépôt jamais poussé) sont les risques principaux du profil, et ils partagent une racine : **sur du code d'autrui, la discipline déclarée diverge de la discipline pratiquée dès que personne ne réconcilie**. La parade est le rituel 6 : la réconciliation périodique, datée, contre l'état réel du serveur *et* du dépôt.

S'y ajoute le risque propre au différé : un finding de sécurité découvert pendant l'audit et différé **porte une échéance et une confirmation, sinon il est réputé ouvert**. Le corpus porte un finding critique différé resté sans suivi tracé pendant des semaines ; c'est exactement le trou que la règle ferme ([chapitre 12](../core/12-secrets-and-pii.md)).

## Terrain d'origine

Un e-commerce hérité en production tenu au registre (variante run) et un vault d'audit posé sur la plateforme d'un client (variante audit), les deux dans le corpus privé.

## Voir aussi

- [Préface](../00-preface.md) : la variable de dosage, propriété du code × coût de l'erreur
- [Chapitre 02 · Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md) : le guide vivant semver, la collision de numérotation
- [Chapitre 07 · La revue adversariale](../core/07-adversarial-review.md) : les findings se réfutent, y compris en audit
- [Chapitre 08 · La preuve et les sondes](../core/08-proof-and-probes.md) : le harnais sur le chemin réel, la preuve rejouée
- [Chapitre 09 · La gate de mise en production et le registre](../core/09-release-gate-and-registry.md) : le cœur opérationnel de ce profil
- [Chapitre 11 · Les protocoles de défaillance](../core/11-failure-protocols.md) : la réconciliation
- [Chapitre 12 · Secrets et données personnelles](../core/12-secrets-and-pii.md) : le suivi des findings différés
