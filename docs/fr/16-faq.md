# FAQ technique

*Des réponses tranchantes et concrètes aux questions que les équipes posent en adoptant Mainstay.*

Ce sont des questions techniques avec des réponses techniques. Chaque réponse est courte et concrète. Là où un sujet a un chapitre entier, la réponse y renvoie.

---

### 1. Pourquoi la connaissance doit-elle vivre dans un monorepo et pas dans un wiki ?

Tout ce qui est hors du dépôt dérive du code mécaniquement : le code change dans un commit, le wiki non, et des mois plus tard l'agent lit une vérité qui ment. Dans un monorepo, code et connaissance partagent un historique, un jeu de revues et une fusion. Une mise à jour de doc devient une condition de la fusion, imposée par un hook — elle ne peut donc pas être oubliée. Voir [Le monorepo](./02-monorepo.md).

### 2. Et si une partie de la connaissance ne peut vraiment pas vivre dans le dépôt ?

Une partie de la connaissance vit légitimement ailleurs — une base de données vivante, un service de métriques, une API partenaire. Vous ne copiez pas cela dans le dépôt ; vous l'exposez à travers un serveur MCP pour que l'agent l'interroge à la demande avec un contrat d'outil défini. La règle est plus étroite que « tout dans le dépôt » : la *source de vérité du schéma* est le code, et les *conventions et décisions durables* vivent dans le vault. L'état externe transitoire est accédé, pas copié.

### 3. Quelle taille doit faire le fichier de contexte ?

Aussi petite que possible. Tout ce qu'il contient est rechargé à chaque tour et consomme du contexte. Gardez le fichier racine pour des règles transverses et stables — commandes, architecture, conventions, interdits permanents — et visez environ moins de 100 lignes. Le détail d'une fonctionnalité a sa place dans le contrat de cette fonctionnalité, pas dans le fichier de contexte. Stratifiez-le : un fichier racine court qui pointe vers des fichiers spécialisés chargés à la demande. Voir [L'architecture agentique](./03-agent-architecture.md).

### 4. De quel modèle ai-je besoin pour faire tourner Mainstay ?

Mainstay est agnostique du modèle. Tout l'enjeu de la méthode est qu'une infrastructure solide avec un modèle ordinaire bat un modèle brillant sur une infrastructure bancale. Vous n'avez pas besoin d'un modèle — vous avez besoin de trois niveaux : un chef d'orchestre haut de gamme pour les décisions, un bras droit de milieu de gamme pour le travail structuré, un exécutant léger pour les routines. Voir [Orchestration multi-agents](./11-multi-agent-orchestration.md).

### 5. « Un seul prompt pour le prototype » n'est-il pas irréaliste ?

C'est réaliste précisément quand le brief est bon. La règle du prompt unique est une *mesure*, pas une contrainte : si l'agent a besoin de quatre passes, le contrat en amont était vague. La génération unique fait quand même tourner deux à quatre passes internes — structure, implémentation, polish, vérification cross-viewport. Vous ne demandez pas une passe de modèle ; vous demandez une *requête*, et vous utilisez le nombre d'itérations comme signal de qualité.

### 6. Comment gérer une énorme base de code héritée ?

On ne fait pas bouillir l'océan. Amorcez le vault depuis le code existant avec un sous-agent d'exploration en lecture seule, puis adoptez la méthode un écran à la fois — écrivez chaque contrat juste avant de changer cet écran. Introduisez les hooks en mode consultatif d'abord pour qu'ils n'échouent pas sur des problèmes préexistants. Voir le chemin B du [Démarrage rapide](./10-quickstart.md).

### 7. Mainstay ne marche-t-il que pour les applications web ?

Non. Le walkthrough utilise un écran web parce que les écrans sont faciles à montrer, mais la méthode est agnostique du domaine. Les piliers (mémoire, contrat, garde-fous), la chaîne et le protocole des zones grises s'appliquent à tout logiciel : une CLI, un pipeline de données, un système embarqué. « Écran » se généralise en « unité livrable » ; « prototype » se généralise en « première version exécutable ».

### 8. Comment chiffrer une construction orchestrée ?

Estimez les tokens par tâche, puis multipliez par le prix du niveau — pas le prix du niveau supérieur pour tout. Le travail de décision va au chef d'orchestre cher ; l'implémentation structurée au bras droit de milieu de gamme ; les routines à l'exécutant bon marché. Dans le modèle de coût illustratif de [Orchestration multi-agents](./11-multi-agent-orchestration.md), router chaque tâche vers son niveau coûte environ 5× moins que d'utiliser le modèle haut de gamme partout.

### 9. Et si produit et technique sont en désaccord sur un contrat ?

Ce désaccord est la revue de contrat qui fait son travail. Un contrat ne peut pas être figé sans les deux signatures, et c'est exactement le mécanisme qui fait remonter le « bon côté produit, infaisable côté technique » *avant* deux semaines de travail, pas après. Le désaccord est résolu en revue — généralement en ajustant le contrat ou en consignant une décision — et ce n'est qu'alors que le contrat est figé.

### 10. Comment arrêter la dérive de contexte ?

Trois choses. Refermez chaque prompt par un interdit de périmètre (« aucune autre modification que celle-ci »). Gardez les sessions courtes — une longue session accumule du bruit. Utilisez la séparation explorer/éditer pour que le contexte de l'agent d'édition ne soit jamais dépensé sur la recherche. Mesurez-la : la métrique de dérive de contexte vous dit quand les prompts manquent de leur interdit de clôture. Voir [Observabilité et métriques](./12-observability-and-metrics.md).

### 11. Qu'est-ce exactement qu'une zone grise, et pourquoi en faire une obsession ?

Une zone grise, c'est tout ce que l'agent a tranché de lui-même parce que ni le prototype ni le contrat ne le précisaient — un état vide inventé, un tri arbitraire, un message d'erreur non validé. Ce n'est pas un bug ; c'est une décision prise dans l'ombre par quelqu'un sans autorité. Quinze zones grises non résolues, ce sont quinze bombes qui explosent ensemble à l'intégration. Voir [Les zones grises](./07-grey-zones.md).

### 12. Quand lance-t-on un balayage de zones grises ?

Après chaque passe de prototype — pas une fois. Chaque itération crée de nouvelles zones grises, donc on rebalaye après chacune. Le balayage est mécanique : pour chaque élément observable, demandez « le contrat le demandait-il explicitement ? ». Non signifie zone grise.

### 13. Modification chirurgicale ou refonte intégrale ?

Modification chirurgicale quand vous corrigez un point précis — elle change une chose et interdit de toucher au reste. Refonte intégrale quand des retouches accumulées ont rendu le code existant incohérent — elle repart de zéro et interdit de réutiliser l'ancien code. Le signal d'une refonte, c'est que de petits changements cassent sans cesse des choses non liées. Voir [Le prompt comme contrat](./06-prompt-as-contract.md).

### 14. Front puis back, ou en parallèle ?

Toujours en parallèle, jamais séquencé. Figez d'abord la spec d'API versionnée comme vérité technique partagée. Le front démarre sur des mocks et des types dérivés de la spec ; le back avance derrière des feature flags et peut fusionner en production avant que le front ne soit prêt. Le raccord se fait par vagues, endpoint par endpoint — un remplacement progressif et vérifiable, pas une phase finale risquée.

### 15. Que veut dire « fait » ?

« Presque fait » n'existe pas. Fait est par couche et vérifié par checklist. *Contrat fait* : toutes les sections renseignées, les deux signatures, figé. *Back fait* : code, tests, spec d'API à jour, intégration vérifiée contre un stub, performance mesurée sur volume réaliste. *Front fait* : tous les états implémentés, tous les endpoints consommés, cas d'erreur gérés, permissions appliquées, conforme au pixel.

### 16. Les hooks ralentissent-ils l'agent ?

L'inverse. Un hook retire une décision que l'agent prendrait sinon et pourrait se tromper. Le hook format-et-lint fait que l'agent ne pense jamais au style ; le hook de tests fait qu'un commit cassé n'entre jamais dans l'historique. Les hooks créent aussi la boucle d'auto-correction, qui permet à l'agent de tourner sans surveillance. Voir [CI/CD et hooks](./14-cicd-and-hooks.md).

### 17. En quoi tester un agent diffère-t-il de tester du code ?

Le test de code répond à « l'artefact marche-t-il ? ». L'évaluation d'agent répond à « l'agent honore-t-il le contrat et les garde-fous ? ». Un agent peut écrire du code correct tout en ignorant un garde-fou ou en débordant de son périmètre — une construction verte qui a quand même échoué à la méthode. Vous avez besoin des deux : une suite de tests de sortie et un banc d'évaluation avec des tâches de référence et des sondes de garde-fous. Voir [Tester et évaluer les agents](./13-testing-and-evaluating-agents.md).

### 18. Qu'est-ce qu'une sonde de garde-fou ?

Un test qui essaie de faire faire à l'agent quelque chose d'interdit — éditer un contrat figé, inventer une valeur manquante, déborder du périmètre d'une modification chirurgicale — et qui ne réussit que si l'agent refuse ou escalade. Un garde-fou jamais sondé est un garde-fou dont vous espérez seulement qu'il marche.

### 19. Deux sources de vérité se contredisent — que fais-je ?

Appliquez la règle d'or de la divergence : la source d'autorité supérieure gagne, et l'inférieure est mise à jour immédiatement pour que deux vérités ne coexistent jamais. L'ordre d'autorité est le code (vérité technique) et le prototype validé (vérité visuelle) au-dessus du contrat, le contrat au-dessus du code applicatif. N'en choisissez jamais une silencieusement — faites remonter la divergence. Voir [Les sources de vérité](./04-sources-of-truth.md).

### 20. Combien de sous-agents dois-je utiliser ?

Aussi peu que la tâche le demande. Un sous-agent ne mérite sa place que lorsque le contexte économisé par la délégation dépasse le contexte dépensé sur la passation. Un changement sur deux fichiers n'en a besoin d'aucun. Une grande exploration qui se comprime en une synthèse courte en a besoin d'un. Découper une seule décision indivisible entre plusieurs agents la fragmente — ne le faites pas.

### 21. La génération a planté en plein milieu — dois-je régénérer ?

Non. Régénérer détruit du travail validé. Lisez l'artefact, trouvez la cause exacte (une erreur de syntaxe, un import manquant, une boucle de rendu), appliquez la plus petite correction qui restaure la sortie, et ne touchez à rien d'autre. Si cela ne suffit pas, revenez au dernier point stable et réappliquez les changements un par un avec un test entre chaque. Voir [Protocoles de défaillance](./08-failure-protocols.md).

### 22. Comment savoir si la méthode marche vraiment ?

Mesurez-la. Itérations par écran tendant vers 1, taux de zones grises sous ~0,15, ratio de reprise sous 0,10, vélocité qui monte pendant que la reprise baisse — cette dernière paire signifie que le vault compose et que l'infrastructure devient plus intelligente à chaque cycle. Une méthode que vous ne mesurez pas est une méthode à laquelle vous ne pouvez pas vous fier. Voir [Observabilité et métriques](./12-observability-and-metrics.md).

---

## Voir aussi

- [Démarrage rapide](./10-quickstart.md)
- [Les zones grises](./07-grey-zones.md)
- [Orchestration multi-agents](./11-multi-agent-orchestration.md)
- [Glossaire](./17-glossary.md)
