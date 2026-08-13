# Profil P — Produit en construction

*La chaîne canonique vit ici : proto → zones grises → contrat figé → build → retour au vault. Seul ou à deux-trois, mono ou multi-dépôts — c'est le profil pour lequel la méthode a été écrite.*

> Les faits de terrain cités dans ce profil viennent d'un corpus privé : faits datés, compteurs obtenus par commande, vérifiés par audit interne en trois passes contradictoires. Ils ne sont pas rejouables par le lecteur.

## Quand l'utiliser

Vous construisez un produit écran par écran ou lot par lot, un prototype est possible, et vous êtes seul ou à deux-trois — un binôme avec un développeur partenaire, une petite agence, un fondateur et son premier renfort. C'est le profil de la [chaîne de livraison](../core/04-delivery-chain.md) complète, appliquée telle qu'écrite : deux lots du corpus en portent la preuve — sur un produit en binôme multi-dépôts, la séquence proto → scan de zones grises → contrat v1.0 → v1.1 à double signature → build s'est déroulée dans cet ordre exact ; sur un cockpit interne d'agence, les commits datés montrent le contrat committé *avant* le premier commit de build.

Le test de dosage :

> **propriété du code × coût de l'erreur**

Le code est à vous (ou partagé avec un partenaire nommé), et l'erreur coûte — un produit qui a ou aura des utilisateurs, une préprod qui engage, une référence figée à respecter au pixel. Si le code appartient à un tiers, passez au [profil R](./run-and-audit.md) ; si vous êtes seul sur un livrable en jours, le [profil S](./solo-compressed.md) suffit ; si plusieurs signataires humains distincts entrent en jeu, montez au [profil E](./team-fleet.md).

## Rituels minimum

1. **La chaîne complète, dès qu'il y a un écran** : prototype → scan de zones grises → contrat figé à double signature **avant** le build → definition of done → retour au vault. L'ordre est le rituel ; un contrat signé après le code est une chronique, pas un contrat.
2. **Un palier n'est jamais clos par celui qui l'a construit.** La boucle adversariale tourne jusqu'à convergence — zéro majeur confirmé *et* une tentative de réfutation réelle qui échoue — et si le compte de défauts monte au lieu de descendre, on gèle par écrit : le [gel honnête](../core/07-adversarial-review.md) est un verdict, pas un échec.
3. **Un registre des écarts si la référence est figée ; un registre des zones grises sinon.** Quand on reconstruit contre une référence (un site existant, une maquette au pixel), chaque écart observé reçoit un statut — assumé, corrigé, à arbitrer, ou report **daté** — et dans les deux formes, les arbitrages remontent nominativement à l'humain : l'agent propose un statut, il n'en décide pas ([chapitre 05](../core/05-grey-zones-and-divergence.md)).
4. **Un handoff daté en fin de chantier**, portant un état *vérifié* — mesuré par commande, pas déduit de mémoire — et un bandeau de péremption qui dit jusqu'à quand le croire ([chapitre 10](../core/10-session-conduct.md)).
5. **La gate de go production est distincte de la préprod**, avec registre et tags. Passer la préprod n'autorise rien ; c'est un deuxième go, humain, consigné ([chapitre 09](../core/09-release-gate-and-registry.md)).
6. **Des sondes read-only avant toute décision d'architecture.** Avant de trancher un refactor, on mesure l'existant avec des sondes qui ne modifient rien — la décision s'appuie sur des chiffres relevés, pas sur l'intuition de l'agent ([chapitre 08](../core/08-proof-and-probes.md)).
7. **Tout rituel abandonné l'est par décision datée, jamais par attrition.** Le corpus porte une dé-escalade exemplaire : un registre de releases déclaré non applicable *par écrit*, avec sa raison, dans une décision numérotée. C'est la différence entre un dosage et une dérive.

## Artefacts obligatoires

| Artefact | Rôle |
|---|---|
| Fichier de contexte avec garde-fous « hors interprétation » et gels explicites | Ce que l'agent n'a pas le droit de trancher, et ce qui est figé |
| `vault/` : `decisions/` + `contracts/` + registre des zones grises **ou** registre des écarts + journaux de boucle par lot | La mémoire complète du chantier — y compris l'historique des rounds adversariaux |
| `RELEASES.md` + tags — ou leur dé-escalade écrite s'il n'y a pas encore de production | Le registre, ou la décision datée de ne pas en tenir |
| Notes de recette par lot | Ce qui a été vérifié, par qui, avec quelles mesures |
| Le module multi-dépôts ci-dessous, si la frontière existe | La discipline de la couture |

## Le jumeau : registre des zones grises ou registre des écarts

Ce profil connaît deux formes du même chantier, et chacune a son artefact de divergence. Les confondre coûte cher ; le choix se fait à l'ouverture du chantier, pas en route.

| | Produit neuf | Reconstruction sur référence figée |
|---|---|---|
| La question posée à chaque observation | « Le contrat le demandait-il explicitement ? » | « La référence le montre-t-elle ? » |
| L'artefact | Registre des zones grises | Registre des écarts |
| Les issues | Décision formelle ou note de contrat — jamais une troisième | Assumé, corrigé, à arbitrer, ou report **daté** |
| Qui tranche | Le signataire concerné | L'humain, nominativement — l'agent propose un statut, il n'en décide pas |
| Le piège documenté | Des zones grises statuées mais jamais fermées dans le registre | Le report sans date, zone grise déguisée |

Les deux formes obéissent à la même loi de fond ([chapitre 05](../core/05-grey-zones-and-divergence.md)) : rendre visible la décision invisible, et ne jamais la laisser à celui qui n'a pas autorité pour la prendre.

## Module — multi-dépôts et développeur tiers

Dès que le produit traverse une frontière — plusieurs dépôts, ou un dépôt qui appartient à un partenaire — quatre règles s'ajoutent. Elles ont été éprouvées indépendamment sur deux terrains du corpus : un produit en binôme multi-dépôts et une feature pilote sur un SaaS à quatre dépôts.

1. **La frontière est une décision, pas un état de fait.** Qui possède quoi, où passe la couture, qui a le droit d'écrire où : consigné dans une décision datée du vault, prise *avant* de construire des deux côtés. Sur le produit en binôme, c'est la décision numéro un du chantier.
2. **Les fixtures de la frontière sont byte-identiques et testées des deux bords.** Le même fichier de fixture est committé dans chaque dépôt, et chaque bord porte un test qui vérifie la conformité à l'octet près. Deux copies « équivalentes » divergent toujours ; deux copies testées byte-identiques ne le peuvent pas. C'est le contract-first du [chapitre 04](../core/04-delivery-chain.md), rendu vérifiable par commande.
3. **Les zones grises s'héritent nominativement à travers la frontière.** Une zone grise née d'un côté (« que fait le back si le champ est vide ? ») est inscrite à l'identique, sous le même identifiant, dans le registre de l'autre côté. Sans héritage nominal, chaque dépôt résout la même question dans son coin — différemment.
4. **Sur les dépôts du tiers : branche + PR, jamais main.** Aucune écriture directe sur la branche principale d'un dépôt qui ne vous appartient pas, quelle que soit la confiance. La PR est la gate ; le tiers est le signataire de son propre territoire.

## Ce qu'on s'autorise à laisser tomber

**Les gates nommées G1→G5 et le dossier `SIGNED/`.** La double signature en frontmatter du contrat suffit à deux ou trois : les signataires se parlent, l'attestation formelle n'ajoute que du poids. Elle redevient obligatoire au [profil E](./team-fleet.md), où les signataires ne sont plus dans la même conversation.

**La flotte massive de worktrees et les vagues de livraison.** Deux ou trois chantiers parallèles se pilotent à la main ; le séquencement de vagues est un outil de flotte, pas de trinôme ([référence — orchestration](../reference/orchestration.md)).

**Le banc d'évaluation formel.** Aucun terrain de ce profil n'en a monté un. La boucle adversariale par lot en tient lieu — moins systématique, mais réellement pratiquée.

Chacun de ces abandons suit le rituel 7 : il est actée par une décision datée qui dit ce qu'on laisse tomber et pourquoi. C'est ce qui le distingue d'une négligence — et c'est ce qui permet de le réviser le jour où l'échelle change.

## Risques documentés à cette échelle

**La fossilisation du vault.** Le vault est vivant tant qu'on y écrit ; il fossilise dès que le rythme du build dépasse le rythme de la consignation. Le corpus le montre sur pièces : un registre de releases resté vide malgré onze tags posés, un index en retard sur les fichiers qu'il prétend indexer. Le vault fossile est pire qu'absent — il répond avec assurance des choses fausses. Parade : l'hygiène du vault est un rituel calendaire, et la règle de l'index dans le même commit s'applique ([chapitre 02](../core/02-vault-and-sources-of-truth.md)).

**L'arrêt silencieux du versionnage.** Deux terrains du corpus portent des dizaines de chemins non committés — 85 sur l'un, 123 sur l'autre — accumulés « sur choix » de l'humain, sans qu'aucune décision ne l'acte. La règle qui en découle : **un non-commit prolongé est soit une décision datée, soit une anomalie** — il n'y a pas de troisième statut. Ce qui n'est pas committé n'est ni sauvegardé, ni transmissible, ni auditable ; si c'est voulu, ça s'écrit.

**Le report qui s'éternise.** Le registre des écarts autorise le report *daté* — c'est son quatrième statut. Un report sans date, ou dont la date est passée sans réexamen, est une zone grise qui a appris à se déguiser. Le compteur de résolution du [chapitre 05](../core/05-grey-zones-and-divergence.md) existe précisément parce qu'un terrain a statué des centaines de zones grises… sans jamais en fermer une seule dans le registre.

## Terrain d'origine

Un produit en binôme multi-dépôts, un site d'agence reconstruit sur référence figée et un cockpit interne d'agence — les trois dans le corpus privé.

## Voir aussi

- [Chapitre 04 — La chaîne de livraison](../core/04-delivery-chain.md) — la séquence que ce profil applique telle quelle
- [Chapitre 05 — Zones grises et divergence](../core/05-grey-zones-and-divergence.md) — le registre des zones grises et son jumeau, le registre des écarts
- [Chapitre 06 — Le prompt comme contrat](../core/06-prompt-as-contract.md) — le contrat qui précède le build
- [Chapitre 07 — La revue adversariale](../core/07-adversarial-review.md) — la clôture par un autre que le constructeur, le gel honnête
- [Chapitre 09 — La gate de mise en production et le registre](../core/09-release-gate-and-registry.md) — préprod et prod, deux gates
- [Chapitre 10 — La conduite de session](../core/10-session-conduct.md) — le handoff daté, l'état mesuré
- [Profil E — Équipe & flotte](./team-fleet.md) — quand les signataires deviennent plusieurs
