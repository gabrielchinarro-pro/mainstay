# FAQ technique

*Des réponses tranchantes et concrètes aux questions que les équipes posent en adoptant Mainstay.*

Ce sont des questions techniques avec des réponses techniques. Chaque réponse est courte et concrète. Là où un sujet a un chapitre entier, la réponse y renvoie.

---

### 1. Pourquoi la connaissance doit-elle vivre dans un monorepo et pas dans un wiki ?

Tout ce qui est hors du dépôt dérive du code mécaniquement : le code change dans un commit, le wiki non, et des mois plus tard l'agent lit une vérité qui ment. Dans un monorepo, code et connaissance partagent un historique, un jeu de revues et une fusion. Une mise à jour de doc devient une condition du commit, imposée par un hook — elle ne peut donc pas être oubliée. Voir [Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md).

### 2. Et si une partie de la connaissance ne peut vraiment pas vivre dans le dépôt ?

Une partie de la connaissance vit légitimement ailleurs — une base de données vivante, un service de métriques, une API partenaire. Vous ne copiez pas cela dans le dépôt ; vous l'exposez à travers un serveur MCP pour que l'agent l'interroge à la demande. La règle est plus étroite que « tout dans le dépôt » : la *source de vérité du schéma* est le code, et les *conventions et décisions durables* vivent dans le vault. L'état externe transitoire est accédé, pas copié. Voir [L'architecture agentique](../core/03-agent-architecture.md).

### 3. Quelle taille doit faire le fichier de contexte ?

Aussi petite que possible. Tout ce qu'il contient est rechargé à chaque tour et consomme du contexte. Gardez le fichier racine pour des règles transverses et stables — commandes, architecture, interdits permanents avec leur cause — et visez moins de 100 lignes. Le détail d'une fonctionnalité a sa place dans le contrat de cette fonctionnalité. Stratifiez : un fichier racine court qui pointe vers des fichiers spécialisés chargés à la demande. Voir [L'architecture agentique](../core/03-agent-architecture.md).

### 4. De quel modèle ai-je besoin pour faire tourner Mainstay ?

Mainstay est agnostique du modèle. Tout l'enjeu de la méthode est qu'une infrastructure solide avec un modèle ordinaire bat un modèle brillant sur une infrastructure bancale. Ce qui est éprouvé sur le terrain, c'est la séparation des *rôles* — producteur, recette, relecteurs en lecture seule — pas l'étagement des modèles : celui-ci n'a qu'une occurrence terrain, où seul le rôle mécanique de recette descendait sur un modèle inférieur. Voir [Orchestration multi-agents](./orchestration.md).

### 5. « Un seul prompt pour le prototype » n'est-il pas irréaliste ?

C'est réaliste précisément quand le brief est bon. La règle du prompt unique est une *mesure*, pas une contrainte : si l'agent a besoin de quatre passes, le contrat en amont était vague. La génération unique fait tourner deux à quatre passes internes — structure, implémentation, polish, vérification. Notez la variante assumée par le terrain : pour l'outillage interne, un contrat sans prototype est un précédent documenté. Voir [La chaîne de livraison](../core/04-delivery-chain.md).

### 6. Comment gérer une énorme base de code héritée ?

On ne fait pas bouillir l'océan. Amorcez le vault depuis le code existant avec un sous-agent d'exploration en lecture seule, puis adoptez la méthode un chantier à la fois. Si la base est en production et que l'erreur coûte cher, ce n'est plus une question de taille : c'est le [profil run & audit](../profiles/run-and-audit.md) — registre des MEP, backup avant toute écriture, preuve sur le vrai chemin de code. La variable qui commande le dispositif est la propriété du code et le coût de l'erreur, pas la taille.

### 7. Mainstay ne marche-t-il que pour les applications web ?

Non. Le walkthrough utilise un écran web parce que les écrans sont faciles à montrer, mais la méthode est agnostique du domaine. Les piliers, la chaîne et le protocole des zones grises s'appliquent à tout logiciel. « Écran » se généralise en « unité livrable » ; « prototype » en « première version exécutable ». Le corpus de la méthode couvre un e-commerce hérité, une fintech, un bot, des vaults d'audit — pas seulement des écrans.

### 8. Comment chiffrer une construction orchestrée ?

Estimez les tokens par tâche, puis multipliez par le prix du niveau — pas le prix du niveau supérieur pour tout. Le travail de décision va au modèle cher ; l'implémentation structurée au milieu de gamme ; les routines au léger. Dans le modèle de coût illustratif d'[Orchestration multi-agents](./orchestration.md), router chaque tâche vers son niveau coûte environ 5× moins. Les chiffres sont illustratifs ; le principe — ajuster le prix du token au jugement requis — est la partie durable.

### 9. Et si produit et technique sont en désaccord sur un contrat ?

Ce désaccord est la revue de contrat qui fait son travail. Un contrat ne peut pas être figé sans les deux signatures, et c'est exactement le mécanisme qui fait remonter le « bon côté produit, infaisable côté technique » *avant* deux semaines de travail. Le désaccord se résout en revue — en ajustant le contrat ou en consignant une décision — et ce n'est qu'alors que le contrat est figé. Voir [La chaîne de livraison](../core/04-delivery-chain.md).

### 10. Comment arrêter la dérive de contexte ?

Trois choses. Refermez chaque prompt par un interdit de périmètre (« aucune autre modification que celle-ci »). Gardez les sessions courtes — et passez le relais par un handoff daté plutôt que d'étirer la session ([La conduite de session](../core/10-session-conduct.md)). Utilisez la séparation explorer/éditer pour que le contexte de l'agent d'édition ne soit jamais dépensé sur la recherche. Voir [Protocoles de défaillance](../core/11-failure-protocols.md).

### 11. Qu'est-ce exactement qu'une zone grise, et pourquoi en faire une obsession ?

Une zone grise, c'est tout ce que l'agent a tranché de lui-même parce que ni le prototype ni le contrat ne le précisaient — un état vide inventé, un tri arbitraire, un message d'erreur non validé. Ce n'est pas un bug ; c'est une décision prise dans l'ombre par quelqu'un sans autorité. Quinze zones grises non résolues, ce sont quinze bombes qui explosent ensemble à l'intégration. Voir [Zones grises et divergences](../core/05-grey-zones-and-divergence.md).

### 12. Quand lance-t-on un balayage de zones grises ?

Après chaque passe de prototype — pas une fois. Chaque itération crée de nouvelles zones grises, donc on rebalaye après chacune. Le balayage est mécanique : pour chaque élément observable, « le contrat le demandait-il explicitement ? ». Non signifie zone grise. Et chaque entrée du registre se résout — en décision ou en note de contrat — avant le gel ; sur un système reconstruit contre une référence figée, le registre d'écarts admet en plus le report daté, encadré. Voir [Zones grises et divergences](../core/05-grey-zones-and-divergence.md).

### 13. Modification chirurgicale ou refonte intégrale ?

Modification chirurgicale quand vous corrigez un point précis — elle change une chose et interdit de toucher au reste. Refonte intégrale quand des retouches accumulées ont rendu le code incohérent — elle repart de zéro et interdit de réutiliser l'ancien code. Le signal d'une refonte : de petits changements cassent sans cesse des choses non liées. Voir [Le prompt comme contrat](../core/06-prompt-as-contract.md).

### 14. Front puis back, ou en parallèle ?

Toujours en parallèle, jamais séquencé. Figez d'abord la spec d'API versionnée comme vérité technique partagée. Le front démarre sur des mocks dérivés de la spec ; le back avance derrière des feature flags. Le raccord se fait par vagues, endpoint par endpoint — un remplacement progressif et vérifiable, pas une phase finale risquée. Voir [La chaîne de livraison](../core/04-delivery-chain.md).

### 15. Que veut dire « fait » ?

« Presque fait » n'existe pas. Fait est par couche et vérifié par checklist. *Contrat fait* : sections renseignées, les deux signatures, figé. *Back fait* : code, tests, spec à jour, intégration vérifiée, performance mesurée sur volume réaliste. *Front fait* : tous les états, tous les endpoints, erreurs gérées, permissions appliquées, conforme au pixel. Et un palier n'est jamais clos par celui qui l'a construit — la clôture passe par la revue adversariale. Voir [La revue adversariale](../core/07-adversarial-review.md).

### 16. Les hooks ralentissent-ils l'agent ?

L'inverse. Un hook retire une décision que l'agent prendrait sinon et pourrait se tromper. La voie principale éprouvée est le hook git `pre-commit`, versionné dans le dépôt : il s'applique à l'agent comme à l'humain, et bloque à la frontière où un état devient de l'historique. Les hooks de cycle agent (formater après chaque édition, etc.) sont restés prescriptifs — aucun terrain ne les a adoptés. Voir [CI/CD et hooks](./cicd-and-hooks.md).

### 17. En quoi la revue adversariale diffère-t-elle de la recette produit ?

La recette produit vérifie que le livrable fait ce que le contrat demande. La revue adversariale cherche à le casser — et son mandat interdit la complaisance : findings contre-vérifiés contre le code réel, faux positifs écartés avec justification écrite, correctifs re-mesurés dans les mêmes conditions. Le terrain le prouve : des chantiers validés trois fois en recette produit ont été refusés deux fois par les relecteurs adversariaux, sur des défauts réels. Voir [La revue adversariale](../core/07-adversarial-review.md).

### 18. Que sont GO, NO-GO et GO-SOUS-CONDITIONS ?

Les trois verdicts canoniques d'une revue. **GO** : aucun majeur confirmé, on avance. **NO-GO** : au moins un majeur confirmé, retour au producteur, nouvelle passe après correction. **GO-SOUS-CONDITIONS** : des réserves nommées, chacune datée et portée — une condition sans échéance ni porteur requalifie le verdict en NO-GO. Un verdict se prononce sur des findings réfutés, jamais comptés. Et la revue ne se clôt qu'après deux passes sèches consécutives. Voir [La revue adversariale](../core/07-adversarial-review.md) et le [glossaire](./glossary.md).

### 19. Deux sources de vérité se contredisent — que fais-je ?

Appliquez la règle d'or de la divergence : la source d'autorité supérieure gagne, et l'inférieure est mise à jour immédiatement pour que deux vérités ne coexistent jamais. N'en choisissez jamais une silencieusement — faites remonter la divergence. Et si un artefact est périmé sans pouvoir être mis à jour sur-le-champ, marquez-le périmé par un bandeau daté : le marquage coûte une ligne, le mensonge documentaire coûte un chantier. Voir [Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md).

### 20. Combien de sous-agents dois-je utiliser ?

Aussi peu que la tâche le demande. Un sous-agent ne mérite sa place que lorsque le contexte économisé par la délégation dépasse le contexte dépensé sur la passation. Un changement sur deux fichiers n'en a besoin d'aucun. Une grande exploration qui se comprime en synthèse courte en a besoin d'un. Au-delà — sessions massivement parallèles — le problème change de nature : isolation worktree+port, brief commun, séquencement de vague. Voir [Orchestration multi-agents](./orchestration.md).

### 21. La génération a planté en plein milieu — dois-je régénérer ?

Non. Régénérer détruit du travail validé. Lisez l'artefact, trouvez la cause exacte, appliquez la plus petite correction qui restaure la sortie, et ne touchez à rien d'autre. Si cela ne suffit pas, revenez au dernier point stable — c'est pour cela que la sauvegarde nommée précède toute écriture risquée — et réappliquez les changements un par un. Voir [Protocoles de défaillance](../core/11-failure-protocols.md).

### 22. Comment savoir si la méthode marche vraiment ?

Par ses registres, pas par un tableau de bord. Un registre des MEP où chaque entrée porte son go — et où les violations sont consignées ; des journaux de boucle où les findings convergent vers deux passes sèches — ou vers un gel honnête ; des mesures avant/après re-jouées dans les mêmes conditions. Ce sont les preuves que le terrain tient réellement. Les sept métriques du chapitre dédié restent un [instrument proposé, non éprouvé](./metrics.md) — personne ne les a encore collectées.

### 23. La recette est validée — je peux mettre en production ?

Non. La validation de recette ou de préproduction ne vaut **jamais** autorisation. La mise en production exige un go humain explicite, donné au tour courant, consigné dans le registre des MEP. « On avance » n'est pas un go. Cette règle est née de ses violations — des promotions non demandées, consignées dans le registre qu'elles ont fondé. Voir [La gate de MEP et le registre](../core/09-release-gate-and-registry.md).

### 24. Comment reprendre un chantier des semaines plus tard, ou le passer à quelqu'un ?

Par un artefact daté : le handoff (état des lieux en fin de session) ou le prompt de reprise (le même état, adressé à l'agent suivant). L'état y est *mesuré, pas déduit* — chaque affirmation vérifiable par commande — avec les décisions verrouillées, les pièges connus et la première action imposée. Un artefact périmé se marque périmé, il ne se supprime pas. C'est la pratique la plus universelle du corpus. Voir [La conduite de session](../core/10-session-conduct.md).

### 25. Dois-je appliquer toute la méthode sur tout projet ?

Non — et la méthode le dit elle-même. La variable qui commande le niveau d'outillage n'est ni la taille du code ni la durée du chantier : c'est **la propriété du code et le coût de l'erreur**. Un livrable possédé, réversible, mono-tête peut tenir sur un journal de décisions et une spec unique ([profil solo compressé](../profiles/solo-compressed.md)) ; la production d'un client exige le dispositif complet ([profil run & audit](../profiles/run-and-audit.md)). Ce qui ne se module jamais : le go humain avant tout envoi, la trace datée des décisions, le retour à la spec après divergence, une vérification rejouable minimale. Et tout rituel abandonné l'est par décision datée — jamais par attrition. Voir la [préface](../00-preface.md).

### 26. La méthode s'applique-t-elle à du code que je ne possède pas ?

Oui — c'est même là qu'elle se durcit le plus. Le vault d'audit applique la méthode à l'audit d'une plateforme cliente : lecture seule absolue sur code, base et infra ; citations marquées « vérifié dans l'audit, à revérifier sur le code live » ; aucun gel de contrat dans la passe ; nouveau code confiné en packages autonomes. La méthode devient un dispositif de preuve et de garde-fous d'écriture avant d'être une chaîne de livraison. Voir le [profil run & audit](../profiles/run-and-audit.md).

---

## Voir aussi

- [Préface](../00-preface.md) — le sélecteur de profil en quatre questions
- [Zones grises et divergences](../core/05-grey-zones-and-divergence.md)
- [Orchestration multi-agents](./orchestration.md)
- [Glossaire](./glossary.md)
