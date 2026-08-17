# Glossaire

*Chaque terme de Mainstay, défini et relié au chapitre qui le couvre. Le lexique des verdicts est tranché ici : GO, NO-GO et GO-SOUS-CONDITIONS sont le canon.*

Les termes sont listés par ordre alphabétique. Chaque entrée donne une définition d'un paragraphe et un lien vers le chapitre où le terme est traité en entier.

---

### Architecte d'infrastructure agentique

La personne responsable du harnais lui-même : les fichiers de contexte, skills, hooks, briefs communs, topologie des rôles et de la flotte. La méthode n'a pas de nom stable pour ce rôle ; celui-ci est le nom de travail. Voir [Profil · Équipe & flotte](../profiles/team-fleet.md).

### Banc d'évaluation (eval harness)

L'exécuteur qui passe des cas d'évaluation (tâches de référence, sondes de garde-fous, jeux de régression) contre un agent et note les résultats. Statut : prescriptif, non éprouvé sur le terrain. Voir [La preuve et les sondes](../core/08-proof-and-probes.md).

### Bandeau de péremption

La ligne datée posée en tête d'un artefact dépassé : « périmé depuis le [date], remplacé par [chemin] ». On marque, on ne réécrit pas et on ne supprime pas : l'historique reste lisible et la doc cesse de mentir pour une ligne. Voir [Protocoles de défaillance](../core/11-failure-protocols.md).

### Boucle d'auto-correction

Le cycle créé par un contrôle déterministe : l'agent édite, le contrôle s'exécute, l'échec revient avec une sortie actionnable, l'agent corrige minimalement, le contrôle repasse. Son siège réel sur le terrain est le hook git `pre-commit`. Voir [CI/CD et hooks](./cicd-and-hooks.md).

### Bras droit (lieutenant)

Le niveau intermédiaire de la grille d'orchestration : un modèle de milieu de gamme pour le travail structuré dont le cadre est posé par un contrat. Escalade l'ambiguïté au lieu de deviner. Voir [Orchestration multi-agents](./orchestration.md).

### Chaîne de livraison

Le chemin en sept étapes du vide à la production : vault → prototype → balayage des zones grises → contrat → construction parallèle → definition of done → retour au vault. Chaque cycle laisse l'infrastructure plus riche. Voir [La chaîne de livraison](../core/04-delivery-chain.md).

### Chef d'orchestre (conductor)

Le niveau supérieur de la grille d'orchestration : le modèle le plus fort, utilisé avec parcimonie pour ce qui ne se délègue pas (architecture, contrats, arbitrages). Règle terrain associée : l'orchestrateur ne croit pas les rapports d'agents ; il remesure lui-même. Voir [Orchestration multi-agents](./orchestration.md).

### Contract-first

L'approche où le contrat figé et la spec d'API sont la vérité partagée : front sur mocks dérivés de la spec, back derrière des feature flags, raccord par vagues. Voir [La chaîne de livraison](../core/04-delivery-chain.md).

### Contrat

Une spécification assortie de critères d'acceptation (comportement, edge cases, endpoints, permissions, données de test), signée par produit et technique, puis figée. L'agent sait ce que l'on attend ; vous savez quoi vérifier. Voir [Le prompt comme contrat](../core/06-prompt-as-contract.md).

### Dé-escalade

L'abandon *écrit* d'un rituel : une décision datée déclare la règle non applicable au contexte, avec sa raison, et interdit de re-signaler son absence comme dette. C'est ce qui distingue la modulation légitime de la non-tenue silencieuse. Tout rituel abandonné l'est par décision datée, jamais par attrition. Voir [La gate de MEP et le registre](../core/09-release-gate-and-registry.md).

### Definition of done (DoD)

La checklist par couche qui décide si un travail est complet. « Presque fait » n'existe pas : une couche est faite ou elle ne l'est pas. Voir [La chaîne de livraison](../core/04-delivery-chain.md).

### Dérive de contexte

La tendance d'un agent, en session longue ou sous-contrainte, à déborder du périmètre demandé. Contrée par les interdits de clôture, les sessions courtes et le handoff. Voir [Protocoles de défaillance](../core/11-failure-protocols.md).

### Dette de cohérence

Le coût qui s'accumule quand des sources de vérité divergent : une note, un contrat et du code qui se contredisent. Invisible jusqu'au jour où tout casse en même temps. Voir [Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md).

### Divulgation progressive

Le principe selon lequel un agent ne charge le détail d'une capacité que lorsqu'une tâche le déclenche : le mécanisme derrière la couche skills. Voir [L'architecture agentique](../core/03-agent-architecture.md).

### Durcissement adverse

La revue adversariale appliquée *avant* production : un contrat, un plan d'exécution ou une décision structurante est soumis à des contradicteurs avant d'être signé ou exécuté. On durcit le document pendant qu'il coûte une phrase à corriger, pas un chantier. Voir [La revue adversariale](../core/07-adversarial-review.md).

### Exécutant (runner)

Le niveau léger de la grille d'orchestration : le modèle le moins cher qui fait fiablement les routines déterministes entièrement spécifiées. Ne fait aucun jugement. Voir [Orchestration multi-agents](./orchestration.md).

### Faux positif écarté

Un finding de revue contre-vérifié contre le code réel et rejeté, *avec sa justification technique écrite, consignée à côté du finding*. « Écarté » sans raison écrite n'existe pas. La méthode ne compte pas ses findings : elle les réfute. Voir [La revue adversariale](../core/07-adversarial-review.md).

### Fichier de contexte

Le fichier chargé au début de chaque session de l'agent : maigre (règles transverses et stables, interdits avec leur cause), stratifié (un fichier racine court pointant vers des fichiers chargés à la demande). Voir [L'architecture agentique](../core/03-agent-architecture.md).

### Garde-fou

Ce que l'agent ne doit jamais faire, écrit explicitement et hors de portée de son interprétation. Chaque garde-fou majeur cite l'incident qui l'a fait naître. Voir [Les trois piliers](../core/01-three-pillars.md).

### Gate

Un point d'arrêt nommé du chantier qu'aucune progression ne franchit sans un go humain consigné. À l'échelle flotte, les gates sont numérotées et tenues dans un fichier d'état ; toute levée orale d'une gate est consignée ou nulle. La gate terminale de tout chantier est la mise en production. Voir [La gate de MEP et le registre](../core/09-release-gate-and-registry.md) et [Profil · Équipe & flotte](../profiles/team-fleet.md).

### Gel honnête

Le verdict qui clôt une boucle de revue *non convergente* : quand le compte de majeurs monte au lieu de descendre, le lot est gelé par écrit (état consigné, réouverture interdite sans go humain) au lieu d'être déclaré fini. Un verdict de première classe, au même rang que GO et NO-GO. Voir [La revue adversariale](../core/07-adversarial-review.md).

### Go explicite

L'autorisation humaine donnée *au tour courant*, en toutes lettres, avant toute mise en production, push ou publication. La validation de recette ou de préproduction ne vaut jamais go ; « on avance » n'est pas un go. Le go est consigné en verbatim dans le registre des MEP. Voir [La gate de MEP et le registre](../core/09-release-gate-and-registry.md).

### Guide vivant

Un document de synthèse unique, versionné en semver, qui tient lieu de vault éclaté quand le chantier est un audit ou une greffe : journal de révisions tenant lieu de registre, double niveau de lecture, et protocole de challenge embarqué (le prompt pour le vérifier contre le réel est dans le document lui-même). Voir [Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md).

### Handoff

L'artefact daté qui formalise la passation entre sessions : état exact *mesuré, pas déduit*, décisions verrouillées, pièges connus, première action de reprise. Périmé = marqué périmé. La pratique la plus universelle du corpus. Voir [La conduite de session](../core/10-session-conduct.md).

### Hook

Un déclencheur déterministe attaché à un événement du cycle de travail. Il ne demande rien au modèle ; il s'exécute. La voie principale éprouvée est le hook git `pre-commit` versionné dans le dépôt. Voir [CI/CD et hooks](./cicd-and-hooks.md).

### Itérations par écran

Métrique proposée : le nombre de passes de génération qu'un écran demande, cible 1. Une valeur élevée signifie que le contrat en amont était vague. Statut : instrument proposé, non éprouvé. Voir [Métriques](./metrics.md).

### Jeu de régression

Le corpus accumulé des défaillances passées d'un agent, figées en cas d'évaluation pour qu'elles ne se reproduisent pas. Voir [La preuve et les sondes](../core/08-proof-and-probes.md).

### Mainstay

La méthode que ce dépôt documente, livraison logicielle pilotée par agents, bâtie sur trois piliers : mémoire, contrat, garde-fous. Le nom évoque l'étai qui maintient un mât droit. Voir la [préface](../00-preface.md).

### Mandat d'initiative

La section d'un prompt qui fixe ce que l'agent peut décider seul : *verrouillé* (exécuter à la lettre, escalader tout écart) ou *ouvert* (proposer, avec obligation de consigner). Voir [Le prompt comme contrat](../core/06-prompt-as-contract.md).

### Mega-prompt orchestrateur

Le genre de prompt qui installe une session d'orchestration complète : rôles nommés, pipeline en boucle, invariants de session (worktree, port, interdits), gate de sortie en checklist et mandat d'initiative. Voir [Le prompt comme contrat](../core/06-prompt-as-contract.md).

### Modification chirurgicale

Un mode de prompt qui corrige un point précis et referme par l'interdit capital « aucune autre modification que celle-ci ». À opposer à la refonte intégrale. Voir [Le prompt comme contrat](../core/06-prompt-as-contract.md).

### Monorepo

Un dépôt unique hébergeant code et connaissance, partageant historique et revues : une modification de schéma et sa documentation voyagent dans le même commit. Voir [Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md).

### Passe sèche

Une passe de revue complète qui ne produit aucun défaut majeur confirmé. La règle d'arrêt de la revue adversariale : la boucle n'est close qu'après **deux passes sèches consécutives** ; une seule peut être un coup de chance ou une passe paresseuse. Voir [La revue adversariale](../core/07-adversarial-review.md).

### Prompt de reprise

Le genre de prompt qui rouvre un chantier : état daté mesuré (vérifiable par commande), décisions verrouillées, pièges connus, posture attendue, première action imposée. Le jumeau du handoff, adressé à l'agent suivant. Voir [Le prompt comme contrat](../core/06-prompt-as-contract.md) et [La conduite de session](../core/10-session-conduct.md).

### Prototype

La première version exécutable d'un écran, produite en une seule requête de génération. Comparé au contrat dans un balayage de zones grises ; une fois validé, il devient la base du contrat signable, et « proto = vérité » pour le rendu. Voir [La chaîne de livraison](../core/04-delivery-chain.md).

### Prototype validé

Un prototype qui a passé son balayage de zones grises et est accepté comme source de vérité visuelle. Voir [Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md).

### Raccord par vagues

Connecter front et back endpoint par endpoint plutôt que tout d'un coup à la fin : un remplacement progressif et vérifiable des mocks par les endpoints réels. Voir [La chaîne de livraison](../core/04-delivery-chain.md).

### Réconciliation

La vérification périodique qu'un registre dit encore vrai, contre l'état *réel* du système : le serveur, pas la mémoire. Un registre non réconcilié dérive comme un wiki. Voir [La gate de MEP et le registre](../core/09-release-gate-and-registry.md).

### Refonte intégrale

Un mode de prompt qui repart de zéro et interdit de réutiliser le code existant, quand les retouches accumulées ont rendu le code incohérent. Voir [Le prompt comme contrat](../core/06-prompt-as-contract.md).

### Registre d'écarts

L'artefact jumeau du registre de zones grises, pour la reconstruction contre une **référence figée**. Il consigne des *divergences mesurées*, avec quatre statuts : corrigé, assumé (divergence conservée et justifiée), à arbitrer, et report daté vers une passe planifiée. Les arbitrages remontent nominativement à l'humain. Voir [Zones grises et divergences](../core/05-grey-zones-and-divergence.md).

### Registre des MEP

Le fichier unique (par convention `RELEASES.md`) tenu sous la règle symétrique : aucune mise en production sans entrée, aucune entrée sans mise en production. Chaque entrée porte la nature du changement, la recette, le backup/rollback et le go en verbatim ; une ligne vulgarisée la rend lisible par un non-technicien ; un tag de version l'ancre dans l'historique. Voir [La gate de MEP et le registre](../core/09-release-gate-and-registry.md).

### Registre des zones grises

L'enregistrement courant des zones grises trouvées pendant les balayages et de leur résolution : chacune statuée en décision formelle ou en note de contrat avant le gel. Un registre qui enregistre sans résoudre n'est pas un registre : c'est une liste d'attente. Voir [Zones grises et divergences](../core/05-grey-zones-and-divergence.md).

### Report daté

La troisième issue *encadrée* du registre d'écarts : une divergence explicitement reportée vers une passe planifiée, avec date et périmètre. Distinct du « on tranchera plus tard », qui reste interdit : le report daté est outillé, visible et borné ; le report silencieux est une zone grise qui attend l'intégration. Voir [Zones grises et divergences](../core/05-grey-zones-and-divergence.md).

### Serveur MCP

Un serveur qui expose un accès structuré et défini par contrat à une ressource externe. Statut terrain : la méthode *consomme* des serveurs MCP existants ; elle n'en écrit pas. Voir [L'architecture agentique](../core/03-agent-architecture.md).

### Skill

Un dossier qui encapsule une capacité réutilisable, chargé sous divulgation progressive. De la mémoire procédurale, là où le fichier de contexte est de la mémoire déclarative. Voir [L'architecture agentique](../core/03-agent-architecture.md).

### Sonde

Un point de mesure posé sur le **vrai chemin de code** (jamais une réimplémentation, jamais une parole d'agent), qui produit la preuve instrumentée d'un comportement avant qu'on l'affirme. Voir [La preuve et les sondes](../core/08-proof-and-probes.md).

### Sonde de garde-fou (guardrail probe)

Un cas d'évaluation qui essaie de faire faire à l'agent quelque chose d'interdit et ne réussit que si l'agent refuse ou escalade. Voir [La preuve et les sondes](../core/08-proof-and-probes.md).

### Source de vérité

L'autorité unique pour une classe de fait : le code pour le schéma, le vault pour les conventions et décisions, le prototype validé pour le visuel, le contrat pour le comportement. Quand deux divergent, la supérieure gagne et l'inférieure est mise à jour aussitôt. Voir [Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md).

### Sous-agent

Une instance d'agent dédiée avec son propre contexte et un rôle assigné. Patterns rentables : la séparation explorer/éditer, et le panel de relecture read-only en éventail. Voir [Orchestration multi-agents](./orchestration.md).

### Spec d'API

La spécification versionnée de l'interface du back, figée *en premier* dans la construction contract-first. Voir [La chaîne de livraison](../core/04-delivery-chain.md).

### Synthèse compacte

La sortie d'un sous-agent d'exploration : une réponse, pas une transcription ; des conclusions, les sources nommées, l'ambiguïté remontée explicitement. Voir [Orchestration multi-agents](./orchestration.md).

### Tâche de référence (golden task)

Une tâche fixe et représentative au résultat attendu connu, utilisée pour tester la *méthode* en régression quand un prompt, un fichier de contexte ou un modèle change. Voir [La preuve et les sondes](../core/08-proof-and-probes.md).

### Vague

L'échelle de livraison au-dessus du lot : un stock de branches finies, arbitré par écrit en PR ordonnées (dépendances, risques, découpages) par une chaîne de rôles. La vague a son artefact propre, le document de séquencement. Voir [Orchestration multi-agents](./orchestration.md).

### Vault

La couche de connaissance navigable du monorepo : décisions, contrats, concepts. Elle indexe et donne du sens, mais ne contredit jamais le code : une couche de sens posée sur la couche de vérité. Voir [Le vault et les sources de vérité](../core/02-vault-and-sources-of-truth.md).

### Vault d'audit

La méthode appliquée à du code qu'on ne possède pas : lecture seule absolue sur code, base et infra existants ; citations marquées « vérifié dans l'audit, à revérifier sur le code live » ; aucun gel de contrat dans la passe ; nouveau code confiné en packages autonomes. La méthode comme dispositif de preuve et de garde-fous d'écriture avant d'être une chaîne de livraison. Voir [Profil · Run & audit](../profiles/run-and-audit.md).

### Verdict (GO · NO-GO · GO-SOUS-CONDITIONS)

Le lexique canonique des verdicts de revue, tranché ici. **GO** : aucun majeur confirmé. **NO-GO** : au moins un majeur confirmé ; retour au producteur. **GO-SOUS-CONDITIONS** : des réserves nommées, chacune datée et portée par quelqu'un ; une condition sans échéance ni porteur requalifie le verdict en NO-GO. S'y ajoutent deux verdicts d'état : le **gel honnête** (boucle non convergente, gel écrit) et la clôture sur **deux passes sèches**. Tout autre lexique de verdicts (feux tricolores, GREEN/PENDING/RED) n'appartient pas au canon. Voir [La revue adversariale](../core/07-adversarial-review.md).

### Worktree

Un checkout git supplémentaire du même dépôt, dans son propre dossier, sur sa propre branche. L'unité d'isolation du travail en flotte : une session = un worktree + un port dédié, et le checkout principal reste intouchable. Voir [Orchestration multi-agents](./orchestration.md).

### Zone grise

Tout ce que l'agent a tranché de lui-même parce que ni le prototype ni le contrat ne le précisaient. Pas un bug ; une décision prise dans l'ombre par quelqu'un sans autorité. Écrite « grey » partout dans Mainstay. Voir [Zones grises et divergences](../core/05-grey-zones-and-divergence.md).

---

## Voir aussi

- [Les trois piliers](../core/01-three-pillars.md)
- [La revue adversariale](../core/07-adversarial-review.md)
- [FAQ technique](./faq.md)
- [Préface](../00-preface.md)
