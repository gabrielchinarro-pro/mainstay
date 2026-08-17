# Préface — D'où vient cette méthode, et quand ne pas s'en servir

*Mainstay est une pratique mise en théorie, pas une théorie mise en pratique. Cette préface donne la thèse, les preuves, les limites — et votre point d'entrée en quatre questions.*

## La thèse : l'inversion

Tout le monde observe le modèle. La partie se joue ailleurs.

Une seule phrase porte toute la thèse :

> Le meilleur modèle du monde, posé sur une infrastructure bancale, donnera toujours un projet bancal. Une infrastructure solide, même servie par un modèle ordinaire, livre des chantiers entiers en quelques semaines.

Votre énergie ne va pas dans le modèle. Elle va dans les trois piliers : mémoire, contrat, garde-fous. Tout, dans cette documentation, découle d'une manière ou d'une autre de ce choix. C'est une inversion : là où l'industrie compare des cerveaux, Mainstay construit ce qui les entoure — et c'est ce qui fait la différence entre une démo impressionnante et du logiciel en production.

## D'où vient cette méthode

### La pratique a précédé la doctrine

L'ordre des dates compte. Le protocole de production en huit étapes a été exécuté pour la première fois sur un lot réel le 13 mai 2026. Le dépôt que vous lisez a été publié le 22 mai 2026 — neuf jours plus tard. Le canon a ensuite continué d'absorber des patterns venus du terrain, commits datés à l'appui, début juin 2026. Rien ici n'a été écrit puis essayé ; tout a été essayé puis écrit.

Cette chronologie n'est pas un détail de fierté. Elle explique la forme de la documentation : les règles portent leurs causes, les interdits citent leurs incidents, et les violations de la méthode par la méthode elle-même sont consignées — parce que ce sont elles qui ont fondé les règles.

### Ce que le terrain a prouvé

Sur un e-commerce hérité en production, cinq jours séparent le premier commit sous la méthode de la bascule de l'ensemble des boutiques du client en production — du 4 au 9 juin 2026. Le premier commit se qualifie lui-même de « Mainstay light » : la méthode y est entrée en version allégée, et c'est la version allégée qui a tenu. Ce même terrain tient depuis un registre sous une règle simple — aucune mise en production sans entrée, aucune entrée sans mise en production : 239 entrées et 193 tags de version entre juin et août 2026, où le go humain est consigné jusqu'au verbatim du décideur. Y compris ses deux absences. Les deux mises en production sans go demandé sont citées dans le registre, entrée par entrée, et sont précisément à l'origine du protocole de gate qui les rend désormais impossibles en silence. Une réconciliation datée a par ailleurs réaligné le registre sur l'état réel du serveur — vérifié serveur, pas mémoire.

La discipline de preuve, sur ce terrain, a rattrapé de l'argent réel. Une TVA absente sur des frais de port — 146 commandes, 2 655,70 € concernés en agrégat — a été corrigée avec une sonde mesurant le vrai chemin de code : 44 cas de figure vérifiés, zéro changement du prix payé par le client. Un callback de paiement cassé a été réparé avec recréation de deux commandes clients, 920,35 € au total, recetté sur harnais réel. Aucun montant individuel par commande n'est publié, nulle part.

Sur une fintech, un composant backend a été livré en diff strictement additif — 17 fichiers, 1 578 insertions, zéro suppression — avec 61 tests verts, et la revue adversariale par rounds n'a été close qu'après deux passes consécutives sans défaut majeur, six rounds au total. C'est sur cette même fintech que la relecture adversariale a montré ce qu'elle attrape et que la recette classique rate : trois passes de recette par deux relecteurs produit avaient rendu GO ; les deux relecteurs adversariaux ont refusé le commit deux fois, sur quatre défauts qu'aucune recette n'avait vus — une validation de schéma indûment bloquante, une comparaison trop tolérante, une décision produit silencieusement renversée, une destruction visant la mauvaise cible.

Les verdicts adversariaux eux-mêmes ne sont pas crus sur parole. Sur un produit en binôme multi-dépôts, un audit de treize agents avant préprod a contre-vérifié chacun des sept bloquants allégués : six rétrogradés, un réfuté. Sur le même terrain, un risque de privilège nommé dès la décision d'architecture — un jeton jamais qualifié de lecture seule — a été soldé par un jeton scopé lecture seule, commit daté du 4 août 2026 à l'appui. La contre-vérification se répète ailleurs : sur une feature pilote d'un SaaS, une revue adversariale multi-agents a produit 45 findings bruts dont 32 confirmés — treize faux positifs écartés avec justification technique écrite ; sur un vault d'audit posé sur la plateforme d'un client, trente agents ont produit 24 findings dont 19 confirmés. La méthode ne compte pas ses findings : elle les réfute.

Elle consigne aussi ses non-convergences. Un lot dont le compte de défauts majeurs *montait* entre deux rounds — treize, puis vingt et un — a été gelé par écrit, avec la phrase « ce n'est pas de la convergence » et l'interdiction écrite de le rouvrir sans go humain. Déclarer un gel honnête plutôt qu'une fin de chantier est un verdict de la méthode, pas un échec de la méthode.

À l'autre bout de l'échelle, un site personnel est passé de l'étude à la mise en ligne en deux jours — étude le 6 août, en ligne le 7, consolidation le troisième jour — avec 22 décisions numérotées, datées et attribuées sur trois jours de journal, une boucle d'agents relecteurs de six rondes qui a corrigé 25 findings dont deux bloquants, et une revue adversariale dont le premier verdict fut un NO-GO à quatre bloquants — tous corrigés, puis re-mesurés. Sur ce même site, la règle « aucun chiffre sans source vérifiée » a rattrapé, avant publication, trois chiffres publics faux et une incohérence arithmétique ; l'erreur, sa vérification et la règle qui en découle sont consignées — sans que les chiffres fautifs soient republiés.

Enfin, la supervision promise par cette documentation est structurée, pas absente. Sur tous les terrains, la règle est le go humain explicite, consigné jusqu'au verbatim du décideur, avant toute mise en production, tout envoi client et toute création de compte. Ses violations connues sont elles-mêmes dans les registres — où elles ont produit la règle.

### Le statut de ces preuves

Toutes les preuves ci-dessus proviennent d'un corpus privé : des faits datés, des compteurs obtenus par commande sur les artefacts eux-mêmes, vérifiés par un audit interne en trois passes contradictoires — preuves, complétude, publiabilité. Elles ne sont pas rejouables par le lecteur : les dépôts sont ceux de clients ou de produits privés, et ils le resteront. Ce que cette documentation s'interdit en échange : aucun chiffre invérifiable même en interne n'est publié, aucun exemple fictif ne porte un chiffre présenté comme réel, et aucune formulation ne permet d'identifier un client. Vous êtes libre de ne pas croire ces chiffres. Vous n'êtes pas libre d'y trouver une invention : chacun a une pièce datée derrière lui.

## Quand ne PAS utiliser Mainstay

La méthode complète est un surpoids quand trois conditions sont réunies :

1. **Vous possédez le code.** Personne d'autre ne dépend de vos choix, personne ne vous audite, aucun contrat ne vous lie.
2. **L'erreur est réversible.** Un défaut se corrige en re-livrant ; il ne coûte ni argent client, ni données, ni confiance.
3. **Le chantier tient dans une seule tête.** Une personne peut porter l'état complet du système sans se le transmettre.

Quand les trois sont vraies à la fois, le vault, les contrats d'écran, le registre des zones grises et les gates nommées sont des frais généraux sans contrepartie. Le corpus en porte deux démonstrations, en sens opposés.

**Le contre-exemple par le succès : le bot à spec unique.** Un bot de commande possédé en propre a été tenu sans rien de l'appareil Mainstay : un unique fichier de spécification de 736 lignes écrit *avant* la première ligne de code, une carte d'interface de 781 lignes, et une allowlist de vérifications syntaxiques passée sur chaque fichier. Zéro vault, zéro décision numérotée, zéro registre des zones grises, zéro registre de mises en production — et pourtant un MVP utilisé le jour même de la spec, une v1 en dépôt le lendemain, onze commits en trois jours. La spec exhaustive en un fichier a joué à elle seule le rôle de contrat, de carte d'interface et de mémoire. Sur un produit possédé, réversible et mono-tête, c'est suffisant — et c'est plus rapide.

**Le contre-exemple par l'échec : l'exosquelette mort en un jour.** L'inverse est tout aussi documenté : l'outillage sans les rituels est du poids mort. Un exosquelette de pilotage multi-contextes — 77 fichiers créés en quatorze minutes — n'a jamais vécu un deuxième jour : aucun fichier modifié depuis sa création, git jamais initialisé malgré sa propre « règle cardinale », zéro instance de la revue hebdomadaire qu'il prescrivait, journal arrêté au jour de sa naissance. Un squelette complet qui n'a jamais fait un deuxième battement. La leçon est frontale : installer la structure ne crée pas la pratique. Si vous n'êtes pas prêt à faire tourner les rituels, ne construisez pas l'outillage. (Cet étage est publié tel quel, avec son échec, en [annexe non normative](./reference/portfolio-layer.md).)

### Ce qui reste non négociable, même là

Même sur le plus petit chantier possédé et réversible, quatre disciplines ne se négocient pas — parce que le maillon qui casse est le même à toutes les échelles : la clôture n'arrive jamais d'elle-même.

1. **Le go humain avant tout envoi, publication ou push.** Le bot à spec unique lui-même n'a jamais envoyé un email fournisseur sans preuve consignée de l'envoi.
2. **Une trace datée des décisions, fût-elle une ligne.** Le même bot a accumulé huit commits de correction sans un seul pourquoi consigné — et c'est exactement le savoir qui manque à la reprise.
3. **Le retour à la spec après divergence.** La spec du bot a divergé du code dès le jour de sa v1 : une capacité encore déclarée hors périmètre dans la spec était déjà implémentée dans le code. Un bandeau d'obsolescence daté coûte une ligne et évite le mensonge documentaire — marquer plutôt que réécrire.
4. **Une vérification rejouable minimale.** Chez le bot, l'allowlist de vérifications syntaxiques est précisément le rituel qui a survécu à tout le reste. Le vôtre peut être aussi petit — mais il doit exister et se rejouer d'une commande.

### La variable de dosage

La variable qui commande le niveau d'outillage n'est ni la taille du code, ni la durée du chantier. C'est :

> **propriété du code × coût de l'erreur**

C'est la leçon conjointe des deux extrêmes du corpus : la méthode complète, durcie, sur un vault d'audit posé sur du code qu'on ne possède pas — et une spec unique sur un produit possédé, réversible, mono-tête. Un script de trois cents lignes qui touche la production d'un client mérite plus d'appareil qu'un produit de trente mille lignes que vous êtes seul à pouvoir casser.

| | Erreur réversible | Erreur coûteuse |
|---|---|---|
| **Code possédé** | Spec unique + les quatre non-négociables | Profil solo compressé, registre réel |
| **Code d'autrui / plateforme vivante** | Profil run & audit, allégé par décision écrite | Méthode complète, durcie |

## Choisir son profil en quatre questions

La méthode est la même partout ; seule l'incarnation change. Quatre questions suffisent à trouver la vôtre.

1. **Le code est-il à vous, ou à quelqu'un d'autre ?** Code d'un client, plateforme vivante, coût d'erreur élevé → [Profil R — Run & audit](./profiles/run-and-audit.md). L'unité de travail y est le ticket ou la passe d'audit, pas l'écran, et le backup horodaté précède toute écriture.
2. **Construisez-vous un produit, ou faites-vous tourner et auditez-vous l'existant ?** Construction écran par écran ou lot par lot, avec prototype possible → [Profil P — Produit en construction](./profiles/product-build.md). C'est la chaîne canonique : proto → zones grises → contrat figé → build → retour au vault.
3. **Êtes-vous seul, ou plusieurs signataires réels ?** Au moins deux signataires humains distincts — produit et technique —, des enjeux financiers ou réglementaires, des chantiers parallèles massifs → [Profil E — Équipe & flotte](./profiles/team-fleet.md). Ce profil n'enlève rien au cœur ; il ajoute des gates nommées, des attestations et le séquencement de vagues.
4. **Le cycle se compte-t-il en jours, ou en mois ?** Une seule tête, un seul livrable, un cycle en jours → [Profil S — Solo compressé](./profiles/solo-compressed.md). Fonctions conservées, artefacts réincarnés : le vault devient un journal, la DoD une recette cochable avec preuves.

Prenez la première question dont la réponse vous désigne un profil — l'ordre est celui du coût de l'erreur. En cas de doute entre deux profils, prenez le plus léger et durcissez par décision datée : c'est le sens de la variable de dosage, et c'est ce que le terrain a réellement fait.

## Comment lire la suite

Le parcours court : cette préface, puis [les trois piliers](./core/01-three-pillars.md), [la chaîne de livraison](./core/04-delivery-chain.md), [les zones grises](./core/05-grey-zones-and-divergence.md), et votre profil. C'est assez pour comprendre la méthode et la défendre. Le reste — [la revue adversariale](./core/07-adversarial-review.md), [la preuve et les sondes](./core/08-proof-and-probes.md), [la gate de mise en production](./core/09-release-gate-and-registry.md) — se lit quand le besoin vous y accroche.

## Voir aussi

- [Les trois piliers](./core/01-three-pillars.md)
- [La chaîne de livraison](./core/04-delivery-chain.md)
- [La revue adversariale](./core/07-adversarial-review.md)
- [Les profils](./profiles/solo-compressed.md) — solo compressé, [run & audit](./profiles/run-and-audit.md), [produit en construction](./profiles/product-build.md), [équipe & flotte](./profiles/team-fleet.md)
- [L'étage pilotage multi-contextes — annexe non normative](./reference/portfolio-layer.md)
