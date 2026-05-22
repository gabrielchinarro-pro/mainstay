# Glossaire

*Chaque terme de Mainstay, défini et relié au chapitre qui le couvre.*

Les termes sont listés par ordre alphabétique. Chaque entrée donne une définition d'un paragraphe et un lien vers le chapitre où le terme est traité en entier.

---

### Architecte d'infrastructure agentique

La personne responsable du harnais lui-même — les fichiers de contexte, skills, hooks, serveurs MCP, topologie des sous-agents et niveaux d'orchestration. La méthode n'a pas de nom stable pour ce rôle ; celui-ci est le nom de travail. L'architecte conçoit l'infrastructure qui rend les agents fiables et surveille les métriques de santé pour la garder saine. Voir [Adoption par l'équipe](./15-team-adoption.md).

### Banc d'évaluation (eval harness)

L'exécuteur qui passe les cas d'évaluation — tâches de référence, tests de conformité, sondes de garde-fous, jeux de régression — contre un agent et note les résultats. Il est à l'évaluation d'agent ce que la CI est au test de code, et il verrouille la promotion d'un nouveau prompt ou modèle. Voir [Tester et évaluer les agents](./13-testing-and-evaluating-agents.md).

### Boucle d'auto-correction

Le cycle créé par les hooks et la CI : l'agent édite, un hook teste, un échec revient à l'agent avec une sortie actionnable, l'agent fait une correction minimale, le hook s'exécute à nouveau. Elle se referme quand le hook passe, et elle permet à un agent de tourner sans surveillance. Voir [CI/CD et hooks](./14-cicd-and-hooks.md).

### Bras droit (lieutenant)

Le niveau d'orchestration intermédiaire — un modèle de milieu de gamme qui fait le travail structuré là où le cadre est déjà posé par un contrat ou un plan : implémenter un écran, écrire des handlers contre une spec d'API, raccorder les endpoints. Le cheval de trait de la chaîne. Escalade l'ambiguïté vers le chef d'orchestre au lieu de deviner. Voir [Orchestration multi-agents](./11-multi-agent-orchestration.md).

### Chef d'orchestre (conductor)

Le niveau d'orchestration supérieur — un modèle haut de gamme utilisé à la demande pour le travail qui ne peut pas être délégué : décisions d'architecture, conception des contrats, arbitrage des zones grises, planification. Cher par token, utilisé avec parcimonie. Voir [Orchestration multi-agents](./11-multi-agent-orchestration.md).

### Chaîne de livraison

Le chemin en sept étapes du vide à la production : vault → prototype → balayage des zones grises → contrat → construction parallèle contract-first → definition of done → retour au vault. Chaque cycle laisse l'infrastructure plus riche. Voir [La chaîne de livraison](./05-the-delivery-chain.md).

### Contract-first

L'approche de construction dans laquelle le contrat figé et la spec d'API sont la vérité partagée, et où front et back se développent en parallèle contre elle plutôt que séquentiellement. Le front démarre sur des mocks dérivés de la spec ; le back avance derrière des feature flags. Voir [La chaîne de livraison](./05-the-delivery-chain.md).

### Contrat

Une spécification assortie de critères d'acceptation pour un écran ou un livrable — pas un brief vague que l'agent interprète. Il énonce le comportement, les edge cases, les endpoints, les permissions, les copies et les données de test, et porte une signature produit et une signature technique. L'agent sait ce que l'on attend ; vous savez quoi vérifier. Voir [Le prompt comme contrat](./06-prompt-as-contract.md).

### Definition of done (DoD)

La checklist par couche qui décide si un travail est complet. « Presque fait » n'existe pas. *Contrat fait* : sections renseignées, les deux signatures, figé. *Back fait* : code, tests, spec d'API à jour, intégration vérifiée, performance mesurée. *Front fait* : tous les états implémentés, tous les endpoints consommés, erreurs gérées, permissions appliquées, conforme au pixel. Voir [La chaîne de livraison](./05-the-delivery-chain.md).

### Dérive de contexte

La tendance d'un agent, pendant une session longue ou sous-contrainte, à vagabonder au-delà du périmètre demandé — sur-correction, « amélioration » de code non demandé, fait de toucher des zones non liées. Mesurée comme les éditions hors périmètre sur le total des éditions. Contrée par des interdits de clôture dans les prompts et des sessions courtes. Voir [Observabilité et métriques](./12-observability-and-metrics.md) et [Protocoles de défaillance](./08-failure-protocols.md).

### Dette de cohérence

Le coût qui s'accumule quand on laisse deux sources de vérité ou plus diverger — une note, un contrat et du code qui se contredisent. Elle est invisible jusqu'au jour où tout casse en même temps, ce qui en fait la dette la plus chère d'un projet. La règle d'or de la divergence existe pour la prévenir. Voir [Les sources de vérité](./04-sources-of-truth.md).

### Divulgation progressive

Le principe selon lequel un agent ne charge le détail d'une capacité que lorsqu'une tâche le déclenche. Cela permet à un projet de porter des dizaines de skills sans saturer le contexte par défaut. Le mécanisme derrière la couche skills. Voir [L'architecture agentique](./03-agent-architecture.md).

### Exécutant (runner)

Le niveau d'orchestration léger — le modèle capable le moins cher, utilisé pour les routines déterministes : formatage, refactorings mécaniques, extraction d'une synthèse, régénération de mocks. Tourne en permanence et souvent en parallèle. Ne fait aucun jugement. Voir [Orchestration multi-agents](./11-multi-agent-orchestration.md).

### Fichier de contexte

Un fichier chargé automatiquement au début de chaque session de l'agent, par convention `AGENTS.md` à la racine du monorepo. C'est le pilier mémoire rendu opérationnel. Il doit être maigre (uniquement des règles transverses et stables — rechargées à chaque tour) et stratifié (un fichier racine court pointant vers des fichiers spécialisés chargés à la demande). Voir [L'architecture agentique](./03-agent-architecture.md).

### Garde-fou

Ce que l'agent ne doit jamais faire, écrit explicitement et placé hors de portée de son interprétation. Un agent comble toujours le vide qu'on lui laisse, et rarement comme on l'espérait — les garde-fous ferment ce vide. Le troisième pilier. Voir [Les trois piliers](./01-three-pillars.md).

### Hook

Un déclencheur déterministe attaché à un événement du cycle de l'agent — formater et linter après chaque édition, lancer les tests avant un commit, vérifier la synchro doc/schéma après une migration. Un hook ne demande rien au modèle ; il s'exécute. Les hooks transforment une bonne pratique en garantie et créent la boucle d'auto-correction. Voir [CI/CD et hooks](./14-cicd-and-hooks.md).

### Mainstay

La méthode que ce dépôt documente — une méthode de livraison logicielle pilotée par agents, bâtie sur trois piliers (mémoire, contrat, garde-fous). Le nom évoque l'étai qui maintient un mât droit : l'infrastructure qui tient debout la production d'un agent. Voir [Introduction](./00-introduction.md).

### Modification chirurgicale

Un mode de prompt qui corrige un point précis et referme par l'interdit capital « aucune autre modification que celle-ci », ce qui empêche l'agent de retravailler ce qui marchait déjà. À opposer à la refonte intégrale. Voir [Le prompt comme contrat](./06-prompt-as-contract.md).

### Monorepo

Un dépôt unique hébergeant à la fois le code et la base de connaissances, partageant un historique et un jeu de revues. Une modification de schéma et sa documentation voyagent dans le même commit et fusionnent ensemble, de sorte que la connaissance ne peut pas prendre de retard sur le code. Voir [Le monorepo](./02-monorepo.md).

### Prototype

La première version exécutable d'un écran, produite en une seule requête de génération (avec deux à quatre passes internes). Il est comparé au contrat dans un balayage de zones grises, et une fois validé devient la base du contrat signable. Voir [La chaîne de livraison](./05-the-delivery-chain.md).

### Prototype validé

Un prototype qui a passé son balayage de zones grises et qui est accepté comme source de vérité visuelle. Il devient alors la base du contrat signable. Voir [Les sources de vérité](./04-sources-of-truth.md).

### Raccord par vagues

Connecter front et back endpoint par endpoint plutôt que tout d'un coup à la fin — un remplacement progressif et vérifiable des mocks par les endpoints réels. Cela transforme l'intégration d'une seule phase finale risquée en une activité continue et à faible risque. Voir [La chaîne de livraison](./05-the-delivery-chain.md).

### Refonte intégrale

Un mode de prompt qui repart d'un écran à zéro et interdit de réutiliser le code existant. Utilisé quand des retouches accumulées ont rendu le code existant incohérent, au point que de petits changements cassent sans cesse des choses non liées. À opposer à la modification chirurgicale. Voir [Le prompt comme contrat](./06-prompt-as-contract.md).

### Registre des zones grises

L'enregistrement courant des zones grises trouvées pendant les balayages et de leur résolution — chacune statuée soit comme une décision formelle, soit comme une note documentée de contrat. C'est aussi la donnée source de la métrique de taux de zones grises. Voir [Les zones grises](./07-grey-zones.md).

### Serveur MCP

Un serveur qui expose un accès structuré et défini par contrat à une ressource externe — une base de données, une API métier, un outil interne. Au lieu de coller des données dans le prompt, l'agent interroge la source à la demande. La couche d'accès de l'architecture. Voir [L'architecture agentique](./03-agent-architecture.md).

### Skill

Un dossier qui encapsule une capacité réutilisable — un fichier d'instructions (`SKILL.md`), parfois des scripts et des gabarits — chargé sous divulgation progressive. Un skill est de la mémoire procédurale (un savoir-faire), là où le fichier de contexte est de la mémoire déclarative (faits et règles). Voir [L'architecture agentique](./03-agent-architecture.md).

### Sonde de garde-fou (guardrail probe)

Un cas d'évaluation qui essaie de faire faire à l'agent quelque chose d'interdit — éditer un contrat figé, inventer une valeur manquante, déborder du périmètre d'une modification chirurgicale — et qui ne réussit que si l'agent refuse ou escalade. Voir [Tester et évaluer les agents](./13-testing-and-evaluating-agents.md).

### Source de vérité

L'autorité unique pour une classe de fait. Le code est la source de vérité du schéma et des contrats techniques ; le vault pour les conventions et les décisions ; le prototype validé pour l'interface visible ; le contrat pour le comportement. Quand deux divergent, la supérieure gagne et l'inférieure est mise à jour aussitôt. Voir [Les sources de vérité](./04-sources-of-truth.md).

### Sous-agent

Une instance d'agent dédiée avec son propre contexte, à laquelle on assigne un rôle. Le pattern le plus rentable sépare l'exploration (lecture seule, renvoie une synthèse compacte) de l'édition (applique le changement avec un contexte propre), préservant le contexte de l'agent d'édition. Voir [Orchestration multi-agents](./11-multi-agent-orchestration.md).

### Spec d'API

La spécification versionnée de l'interface du back — endpoints, payloads, codes de retour. Dans la construction contract-first, elle est figée *en premier* et devient la vérité technique partagée contre laquelle front et back construisent tous les deux. Voir [La chaîne de livraison](./05-the-delivery-chain.md).

### Synthèse (synthèse compacte)

La sortie d'un sous-agent d'exploration : une réponse, pas une transcription. Elle renvoie des conclusions et les quelques faits qui les soutiennent, nomme les sources plutôt que de les coller, et fait remonter toute ambiguïté explicitement. Une passation qui renvoie tout ce qu'elle a lu n'est pas une synthèse. Voir [Orchestration multi-agents](./11-multi-agent-orchestration.md).

### Tâche de référence (golden task)

Une tâche fixe et représentative dont le résultat attendu est connu et bon, utilisée pour tester la *méthode* en régression. Quand vous changez un gabarit de prompt, un fichier de contexte ou le modèle, vous relancez la suite de référence pour confirmer que rien n'a régressé. Une bonne tâche de référence est petite, stable, représentative et assez déterministe pour être notée. Voir [Tester et évaluer les agents](./13-testing-and-evaluating-agents.md).

### Itérations par écran

La métrique de santé phare : le nombre de passes de génération qu'un écran demande. La cible est un. Une valeur élevée ne veut pas dire que l'agent a échoué — elle veut dire que le contrat en amont était vague. Voir [Observabilité et métriques](./12-observability-and-metrics.md).

### Jeu de régression

Le corpus accumulé des défaillances passées d'un agent, figées en cas d'évaluation. Chaque erreur du monde réel — un libellé inventé, une dérive de périmètre, un état manqué — est capturée comme un cas pour qu'elle ne puisse pas se reproduire. Lancé chaque fois que quoi que ce soit affectant le comportement de l'agent change. Voir [Tester et évaluer les agents](./13-testing-and-evaluating-agents.md).

### Vault

La couche de connaissance navigable à l'intérieur du monorepo, qui héberge les décisions, les contrats d'écrans, les concepts métier et les liens entre eux. Il indexe et donne du sens, mais ne contredit jamais le code — pour les faits techniques, le code gagne. Le vault est une couche de sens posée sur la couche de vérité, pas une vérité concurrente. Voir [Le monorepo](./02-monorepo.md).

### Zone grise

Tout ce que l'agent a tranché de lui-même parce que ni le prototype ni le contrat ne le précisaient — un état vide inventé, un tri arbitraire, un message d'erreur non validé, une permission supposée. Pas un bug ; une décision prise dans l'ombre par quelqu'un sans autorité. Détectée en comparant le produit au contrat élément par élément. Écrite « grey » partout dans Mainstay. Voir [Les zones grises](./07-grey-zones.md).

---

## Voir aussi

- [Les trois piliers](./01-three-pillars.md)
- [L'architecture agentique](./03-agent-architecture.md)
- [FAQ technique](./16-faq.md)
- [Démarrage rapide](./10-quickstart.md)
