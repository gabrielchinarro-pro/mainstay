# L'étage pilotage multi-contextes : annexe non normative

*Un étage de pilotage au-dessus des projets : journal de décisions transverse, échéances croisées, routage multi-outils. Statut : proposé, non éprouvé. Le seul terrain qui l'a construit n'a jamais vécu un deuxième jour, et cet échec est publié avec le concept, parce que c'est la condition de sa publication.*

> **Statut : proposé, non éprouvé.** Cette annexe n'est pas un profil de la méthode et n'appartient pas au canon. Elle décrit un dispositif construit une fois, sur un seul terrain, qui n'a jamais été utilisé. Les faits cités proviennent d'un corpus privé (faits datés, compteurs obtenus par commande, vérifiés par audit interne), non rejouables par le lecteur.

---

## Le problème que l'étage veut résoudre

Toute la méthode s'arrête à la frontière du projet. Le vault vit dans le monorepo ; les décisions, les contrats, les registres appartiennent à un chantier. Mais la personne qui pilote plusieurs structures à la fois (plusieurs clients, plusieurs produits, plusieurs sociétés) a des faits qui n'appartiennent à aucun projet : une échéance fiscale qui traverse deux structures, un engagement pris auprès d'un interlocuteur qui travaille sur trois chantiers, une décision de priorité entre deux clients. Aujourd'hui, ces faits vivent dans une tête.

L'étage pilotage propose de leur donner un dépôt : un **exosquelette de pilotage multi-contextes**. Un vault personnel, au-dessus des monorepos de projets, qui applique aux affaires transverses les mêmes disciplines que la méthode applique au code.

## Ce que l'étage propose

Le terrain qui l'a construit avait dessiné quatre dispositifs :

| Dispositif | Forme | Ce qu'il transpose |
|---|---|---|
| Journal de décisions transverse | Une ligne par décision, datée, sans ID, sans statut, sans supersession | La trace datée des décisions, compressée à l'extrême |
| Échéances croisées | Une table des deadlines de toutes les structures, chacune avec son « impact si non atteint » | Le coût de l'erreur rendu explicite, par échéance |
| Intelligence relationnelle | Une fiche par interlocuteur : contexte, engagements, points de friction | La mémoire inter-sessions, appliquée aux personnes |
| Matrice de routage | Quel outil, quel canal, quel dépôt pour quelle classe de tâche | Le fichier de contexte, appliqué à un portefeuille |

L'idée est cohérente avec le reste de la méthode ; chacun de ces dispositifs compresse un invariant qui a fait ses preuves à l'échelle projet : décisions datées, coût d'erreur nommé, mémoire écrite plutôt que mentale, règles de routage explicites. C'est précisément pour cela que l'idée est séduisante. Et c'est précisément pour cela que son échec d'usage doit être publié avec elle.

---

## L'échec d'usage : publié avec le concept

Voici ce qui s'est réellement passé, compteurs à l'appui.

Le seul terrain du corpus qui a construit cet étage l'a construit **en un jour** : 77 fichiers créés en 14 minutes, le 19 avril 2026. Puis :

- **aucun fichier modifié depuis** : quatre mois plus tard, le compte des fichiers touchés après le jour de création est zéro ;
- **git jamais initialisé**, alors que le README de l'exosquelette énonce lui-même le versionnage comme sa « règle cardinale » : le dispositif violait sa première règle dès le premier jour ;
- **aucun rituel jamais instancié** : pas une revue hebdomadaire tenue, journal arrêté au jour de création ;
- **un index pointant vers des fichiers qui n'existent pas**, et une partie de l'outillage exécutable annoncé introuvable ;
- un journal de décisions à 31 entrées datées, toutes du même élan initial.

Le diagnostic tient en une phrase, et elle est déjà dans la préface de cette documentation : **l'outillage sans les rituels est du poids mort.** L'exosquelette a été entièrement construit et n'a jamais fait un deuxième battement. Il a échoué exactement là où la méthode dit que les systèmes échouent : la clôture n'arrive jamais d'elle-même, et un dispositif qu'aucun rituel ne fait battre meurt le jour de sa naissance, quelle que soit la qualité de sa conception.

Il faut mesurer l'ironie, parce qu'elle est la leçon : le même opérateur, les mêmes disciplines, ont fait vivre sur les terrains projets des registres de centaines d'entrées tenus pendant des mois. La différence n'est pas la personne ni l'outillage. La différence est qu'à l'échelle projet, **les rituels ont des déclencheurs externes** : une MEP force une entrée de registre, un incident force une règle, une session force un handoff. L'étage pilotage n'a aucun déclencheur externe : rien ne force jamais un battement. C'est le problème non résolu, et aucun des 77 fichiers ne le résolvait.

---

## Si vous tentez l'étage malgré tout

Cette annexe ne recommande pas l'étage. Si vous le tentez, tentez-le contre la cause de l'échec documenté, pas contre son symptôme :

1. **Commencez par un fichier, pas soixante-dix-sept.** Un journal de décisions une-ligne qui vit vaut mieux qu'une arborescence complète qui meurt. N'ajoutez un deuxième fichier que quand le premier a survécu à un mois d'usage réel.
2. **Attachez chaque dispositif à un déclencheur qui existe déjà.** Une revue « quand j'y pense » n'existe pas. Adossez le battement à un événement qui se produit de toute façon : la fin d'une session de travail, une échéance de facturation, un rituel d'équipe existant.
3. **Git dès la première heure.** Le terrain a violé sa propre règle cardinale au jour un. Un vault de pilotage non versionné n'a ni historique, ni preuve, ni récupération ; il n'est pas un vault.
4. **Datez le verdict.** Fixez à la création une date de revue (trente jours) et une règle : si à cette date le journal n'a pas de nouvelles entrées, l'étage est supprimé, par décision datée. Un exosquelette mort qui reste sur le disque n'est pas neutre : c'est une documentation qui ment sur son propre usage, et la méthode interdit précisément cela ([chapitre 11 · Protocoles de défaillance](../core/11-failure-protocols.md), le bandeau de péremption).

Et si votre besoin réel est plus petit que l'étage (c'est le cas le plus fréquent), la méthode couvre déjà l'essentiel sans nouvel outillage : les handoffs datés portent l'état inter-sessions ([chapitre 10](../core/10-session-conduct.md)), et chaque projet porte ses propres décisions. L'étage ne devient nécessaire que le jour où des faits *n'appartenant à aucun projet* se perdent réellement, et ce jour-là, commencez par le journal une-ligne.

---

## Pourquoi publier un échec

Parce que l'alternative est pire. Publier l'étage sans son échec en ferait une promesse : la seule partie non éprouvée du corpus présentée comme le reste, qui l'est. Le taire entièrement priverait le lecteur d'un contre-exemple que la méthode a payé pour apprendre : la preuve par le vide que les trois piliers ne suffisent pas sans battement, et que le battement ne vient pas de l'outillage.

La méthode se distingue moins par ses réussites que par la façon dont elle consigne ses défaillances : les violations fondent les règles, les gels honnêtes valent mieux que les GO de complaisance, et un exosquelette mort en un jour vaut d'être documenté au même titre qu'un registre de deux cents entrées. Cette annexe est ce principe appliqué à la méthode elle-même.

---

## Voir aussi

- [Préface](../00-preface.md) : quand ne pas utiliser Mainstay ; la variable de dosage
- [Chapitre 10 · La conduite de session](../core/10-session-conduct.md) : ce qui couvre déjà l'inter-sessions
- [Chapitre 11 · Protocoles de défaillance](../core/11-failure-protocols.md) : le marquage de péremption
- [Profils](../profiles/solo-compressed.md) : les quatre profils normatifs de la méthode
