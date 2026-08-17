# Profil S · Solo compressé

*Une tête, un livrable, un cycle en jours. Les fonctions de la méthode sont toutes conservées ; leurs artefacts sont réincarnés en plus léger, et chaque allègement est une décision, pas un oubli.*

> Les faits de terrain cités dans ce profil viennent d'un corpus privé : faits datés, compteurs obtenus par commande, vérifiés par audit interne en trois passes contradictoires. Ils ne sont pas rejouables par le lecteur.

## Quand l'utiliser

Vous êtes une seule personne avec des agents, sur un seul livrable, avec un cycle qui se compte en jours, et le code est à vous, ou le périmètre est gelé et vérifiable par commande. À cette échelle, la méthode complète est un surpoids ; la version compressée en garde toutes les fonctions sous des formes qui tiennent dans une session.

Le test est celui de toute la méthode :

> **propriété du code × coût de l'erreur**

Code possédé, erreur coûteuse (un site public, une mise en ligne, un push vers un dépôt partagé) → ce profil. Code possédé, erreur *réversible*, chantier qui tient dans une seule tête → même ce profil est peut-être de trop : relisez [« Quand ne PAS utiliser Mainstay »](../00-preface.md#quand-ne-pas-utiliser-mainstay) et ses quatre non-négociables. Dès que le code cesse d'être à vous, changez de profil ([Run & audit](./run-and-audit.md)), quel que soit le nombre de jours.

## Rituels minimum

1. **Un journal de décisions unique** (ou, en équivalent strict, le trio {prompt de reprise vivant, compte-rendu daté, décisions verrouillées inline}). Une décision par entrée, numérotée, datée, avec sa raison. C'est le vault entier, réduit à un fichier.
2. **Une sauvegarde nommée par étape avant toute itération risquée.** Un instantané qui porte le nom de l'étape, pas « backup2-final ». C'est ce qui rend l'itération réversible, et donc tentable.
3. **Une revue adversariale minimale avant toute publication.** Quelqu'un (un agent fera l'affaire) essaie de casser le livrable avant qu'il ne sorte. Si la revue est multi-agents, les findings sont contre-vérifiés et les faux positifs écartés avec justification, comme au [chapitre 07](../core/07-adversarial-review.md). Sur un site personnel du corpus, le premier verdict de cette revue fut un NO-GO à quatre bloquants : tous corrigés, puis re-mesurés.
4. **Le go humain explicite avant toute mise en ligne ou tout push.** La règle ne se comprime pas avec l'échelle : la [gate de mise en production](../core/09-release-gate-and-registry.md) tient en une phrase consignée, mais elle tient.
5. **Après chaque incident, la règle entre au journal, avec sa cause.** L'incident non converti en règle se reproduira ; c'est le gabarit « interdit (cause : incident daté) » des [trois piliers](../core/01-three-pillars.md), en version une-ligne.
6. **Historiser par bandeau d'obsolescence daté** : marquer, jamais réécrire ni supprimer. Un document dépassé qui le dit reste une pièce d'archive ; un document réécrit en silence est un mensonge documentaire ([protocoles de défaillance](../core/11-failure-protocols.md)).
7. **Le périmètre gelé se rend vérifiable par commande.** « Ne touche à rien d'autre » est un vœu ; « l'état git doit rester vide à la fin de la session » est un test rejouable. Sur le terrain, c'est la seconde forme qui a tenu.

## Artefacts obligatoires

| Artefact | Forme minimale | Ce qu'il remplace |
|---|---|---|
| Le journal | Un `DECISIONS.md` à la racine, ou prompt de reprise + compte-rendu daté | `vault/decisions/`, les handoffs, l'index |
| L'historique | Git minimal, ou à défaut des instantanés nommés | Les sauvegardes de branche, les tags |
| La sortie du poste | Un script de déploiement rejouable OU un playbook de push avec gate secrets/PII | Le pipeline CI/CD |

Sur l'historique, le corpus est sans ambiguïté : **deux terrains ont travaillé sans git du tout, et leur historique est irrécupérable**. Personne ne peut plus y répondre à « pourquoi ce fichier est-il dans cet état ». Git minimal (un `git init`, des commits aux étapes) coûte cinq minutes et ferme cet angle mort définitivement.

Sur la sortie du poste : dès que le code quitte votre machine, la gate secrets/PII n'est pas négociable. Un contrôle par commande avant chaque push, pas une relecture à l'œil ([chapitre 12 · Secrets et données personnelles](../core/12-secrets-and-pii.md)).

## Ce qu'on s'autorise à laisser tomber

Tout ce qui suit se laisse tomber **parce que sa fonction est conservée sous une autre forme** : c'est un choix de dosage, consigné, pas une négligence. Le terrain appelle cette version « compressée » : fonctions conservées, artefacts réincarnés.

| Fonction | Incarnation canonique | Incarnation solo compressée |
|---|---|---|
| Mémoire ([vault](../core/02-vault-and-sources-of-truth.md)) | `vault/` versionné, frontmatter, index | Quelques fichiers MD à la racine + la mémoire persistante de l'agent |
| Décisions | `vault/decisions/DEC-XXX` | Sections « Décisions verrouillées » datées, portées par le journal |
| [Zones grises](../core/05-grey-zones-and-divergence.md) | Registre séparé, colonnes, statuts | L'escalade « bloquer et demander » : l'agent a interdiction de deviner, et tient une liste « en attente de toi » |
| Contrat | Contrat d'écran douze sections, double signature | Le prompt de reprise fait contrat et passation à la fois ([chapitre 06](../core/06-prompt-as-contract.md)) |
| Definition of done | Checklist par couche | Recette manuelle cochable + preuves consignées (commande, requête, capture) |
| Retour au vault | Étape 6 de la [chaîne](../core/04-delivery-chain.md) | Mise à jour des MD racine, bandeaux d'obsolescence datés |
| Handoffs | Handoffs datés multiples | **Un seul** prompt de reprise vivant |
| Gates nommées, métriques | G1→G5, tableau de bord | Le go humain consigné ; rien d'autre |

Deux remarques d'honnêteté. D'abord, la ligne « zones grises » ne supprime pas le protocole : elle en déplace le moment. Au lieu d'un balayage a posteriori consigné dans un registre, l'agent est contraint *en amont* de bloquer sur tout ce que le brief ne dit pas : la zone grise est attrapée avant d'exister. Ensuite, le chantier le plus léger du corpus a entièrement échappé à la revue adversariale (aucune passe, aucun verdict), et la méthode en a tiré une règle plutôt qu'une honte : sauter un rituel est un choix qui s'écrit, avec sa raison. Un rituel non tenu en silence est une dette ; un rituel écarté par écrit est un dosage.

## Quand ce profil ne suffit plus

La compression est un état, pas une identité. Trois signaux commandent la bascule, et la bascule se prend comme tout le reste : par décision datée au journal.

| Signal | Bascule | Pourquoi |
|---|---|---|
| Un second humain entre dans le chantier | [Profil P](./product-build.md) | Le journal narratif rappelle, il ne transmet pas ; il faut un vault et des contrats que l'autre peut lire sans vous |
| Le code cesse d'être à vous : un client, une plateforme vivante | [Profil R](./run-and-audit.md), immédiatement | La variable de dosage a changé de valeur ; le nombre de jours ne compte pas |
| Le cycle passe des jours aux semaines, les livrables se multiplient | [Profil P](./product-build.md) | Un seul prompt de reprise vivant ne porte pas plusieurs chantiers ; la mémoire compressée sature |

En cas de doute entre deux profils, la préface tranche : prenez le plus léger et durcissez par décision datée.

## Risques documentés à cette échelle

Le profil compressé a un mode de défaillance principal, et le corpus le documente au lieu de le taire.

**Le retour au vault craque en fin de chantier.** Quand la pression monte, la dernière chose que l'on documente est la dernière chose que l'on a faite, c'est-à-dire souvent la plus sensible. Sur une feature pilote sur un SaaS, le chantier le plus sensible de tout le lot (la sécurité) est resté invisible de la documentation : douze entrées au statut git non documentées, dont la fermeture d'une faille de scoping. Le code était bon ; la trace n'existait pas. La parade tient en une règle : **la session ne se ferme pas tant que le journal ne porte pas la dernière décision**, et le prompt de reprise est précisément le fichier qui rend cette clôture vérifiable ([conduite de session](../core/10-session-conduct.md)).

**Le journal narratif dérive.** Un `DECISIONS.md` est un registre tant qu'il reste une décision par entrée, datée ; il devient un récit dès qu'on y écrit des paragraphes d'ambiance. Le compromis « registre → journal » est assumé à cette échelle, mais il a une clause de sortie : dès qu'un second humain entre dans le chantier, ou que le cycle passe des jours aux semaines, basculez vers le [profil P](./product-build.md) : le journal ne transmet pas, il rappelle.

**L'absence d'historique est irréversible.** C'est le seul risque de cette liste qui ne se rattrape pas après coup ; d'où sa place dans les artefacts obligatoires, pas dans les options.

## Terrain d'origine

Un site personnel passé de l'étude à la mise en ligne en deux jours (22 décisions datées sur trois jours de journal), et une feature pilote sur un SaaS livrée en une semaine environ de jours actifs, les deux dans le corpus privé.

## Voir aussi

- [Préface](../00-preface.md) : la variable de dosage, et quand ne pas utiliser Mainstay du tout
- [Chapitre 04 · La chaîne de livraison](../core/04-delivery-chain.md) : ce que la compression resserre
- [Chapitre 07 · La revue adversariale](../core/07-adversarial-review.md) : la contre-vérification des findings, même en solo
- [Chapitre 09 · La gate de mise en production](../core/09-release-gate-and-registry.md) : le go humain, à toutes les échelles
- [Chapitre 10 · La conduite de session](../core/10-session-conduct.md) : le prompt de reprise, artefact central de ce profil
- [Chapitre 12 · Secrets et données personnelles](../core/12-secrets-and-pii.md) : la gate secrets/PII du playbook de push
- [Profil P · Produit en construction](./product-build.md) : la bascule quand le chantier grandit
