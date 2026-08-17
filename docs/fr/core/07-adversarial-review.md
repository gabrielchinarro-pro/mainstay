# La revue adversariale

*La recette produit vérifie que le livrable fait ce qu'on a demandé. La revue adversariale paie quelqu'un pour prouver qu'il ne le fait pas ; et elle ne compte pas ses findings : elle les réfute.*

Ce chapitre est nouveau dans la méthode, et il vient entièrement du terrain : aucune version antérieure de cette documentation ne contenait le mot « adversarial ». Pendant ce temps, sur presque tous les chantiers du corpus, une deuxième recette s'était installée à côté de la première : une recette dont le mandat n'est pas de valider, mais de casser. Ce chapitre en donne le protocole complet : les rôles, la contre-vérification des findings, les verdicts gradués, la règle d'arrêt, le gel honnête, et l'extension du même mécanisme aux contrats et aux plans avant leur signature.

> Les faits de terrain cités dans ce chapitre viennent d'un corpus privé : faits datés, compteurs obtenus par commande, vérifiés par audit interne en trois passes contradictoires. Ils ne sont pas rejouables par le lecteur.

## Pourquoi une recette distincte de la recette produit

La recette produit pose une question : *le livrable fait-il ce qu'on a demandé ?* Celui qui la mène cherche la conformité : il déroule le contrat, coche les comportements, confirme. C'est indispensable, et c'est structurellement aveugle : on ne trouve pas ce qu'on ne cherche pas, et celui qui vérifie une attente regarde là où l'attente pointe.

La revue adversariale pose la question inverse : *qu'est-ce qui casse si j'essaie ?* Celui qui la mène cherche la faille : il attaque les entrées, les bords, les états que le contrat n'a pas mis en scène, et il ne rend pas un avis : il rend des défauts reproduits.

Le corpus contient la démonstration que les deux questions ne se recouvrent pas. Sur un chantier d'une fintech, **trois passes de recette menées par deux relecteurs produit avaient rendu GO**. Les deux relecteurs adversariaux qui ont suivi **ont refusé le commit, deux fois**, sur quatre défauts qu'aucune recette n'avait vus : une validation de schéma indûment bloquante, une comparaison trop tolérante, une décision produit silencieusement renversée, une destruction visant la mauvaise cible. Quatre défauts réels, dont un renversement de décision produit, précisément la chose que la recette produit est censée attraper, et qu'elle n'a pas attrapée parce qu'elle vérifiait la présence du comportement attendu, pas l'absence du comportement interdit.

| | Recette produit | Revue adversariale |
|---|---|---|
| Question | Le livrable fait-il ce qui est demandé ? | Qu'est-ce qui casse si j'essaie ? |
| Posture | Confirmer la conformité | Réfuter la conformité |
| Matière | Le contrat, comportement par comportement | Les bords, les entrées hostiles, les invariants, le diff lui-même |
| Sortie | Une checklist cochée | Des défauts *reproduits*, avec la commande qui les reproduit |
| Angle mort | Ce que le contrat n'a pas mis en scène | Le sens métier : d'où la nécessité de garder l'autre recette |

Les deux recettes ne sont pas redondantes ; elles sont complémentaires et **non substituables**. Un GO produit ne vaut pas GO adversarial, et l'inverse est vrai aussi : un adversaire ne sait pas dire si le comportement est *le bon*, seulement s'il tient.

Une règle transverse fonde tout le chapitre, consignée sur plusieurs terrains du corpus :

> **Un palier n'est jamais clos par celui qui l'a construit.**

Ce n'est pas une défiance envers l'agent codeur en particulier : c'est une défiance envers *tout producteur*, humain ou agent, qui note sa propre copie. Le producteur a construit le livrable avec un modèle mental ; il vérifiera avec le même modèle mental, et les trous de l'un sont les trous de l'autre.

## Les rôles

La revue adversariale n'est pas un agent de plus : c'est une topologie. Le terrain a convergé, sur des projets sans lien entre eux, vers le même casting, le [panel de relecture read-only en éventail du chapitre 03](./03-agent-architecture.md) :

| Rôle | Lit | Écrit | Mandat |
|---|---|---|---|
| **Producteur** (codeur) | Tout | **Seul à écrire** | Construire ; livrer sans commiter ; corriger les findings confirmés |
| **Recette produit** | Le livrable, le contrat | Rien | Vérifier la conformité au contrat, comportement par comportement |
| **Relecteur agnostique** | Le livrable, *pas le code* | Rien | Regard neuf ; conteste tout ; doit motiver même un « rien à signaler » |
| **Contradicteur systématique** | Tout, y compris le code et le diff | Rien | Casser ; **reproduire chaque défaut avant de le signaler** |

Trois disciplines tiennent le casting :

1. **Un seul rôle mute le code.** Un relecteur qui « corrige en passant » cesse d'être un relecteur : il devient un second producteur, avec les angles morts d'un producteur.
2. **Le contradicteur reproduit avant de signaler.** Un défaut sans reproduction est une opinion. Le contradicteur livre la commande, l'entrée, l'état qui déclenche le défaut : c'est ce qui rend son finding réfutable, et donc utilisable.
3. **L'agnostique motive même son silence.** Un « rien à signaler » sec est invérifiable : on ne sait pas s'il a regardé. Le terrain exige la liste de ce qui a été contesté et tenu. Sur un chantier de reconstruction de site, c'est l'agnostique (celui qui ne lit pas le code) qui a trouvé quatre défauts réels que la recette et le développeur avaient manqués.

### Le doublement adverse, ratio 1:1, sur le diff non commité

La forme la plus resserrée du dispositif est née sur une fintech du corpus et tient en une règle : **chaque agent codeur est doublé d'un adversaire, un pour un**. Pas un adversaire pour l'équipe, pas une passe adversariale en fin de lot en plus : *aussi* un adversaire par codeur, qui relit **le diff non commité** et peut **refuser le commit**. Le codeur livre sans commiter ; l'adversaire attaque le diff ; on ne commite qu'après son verdict.

Le moment est le cœur de la règle. Le diff non commité est l'instant le moins cher de toute la chaîne pour trouver un défaut : un commit refusé ne coûte rien : pas d'historique à réécrire, pas de branche à démêler, pas de rollback. Chaque étape franchie par un défaut multiplie son prix : dans le commit, il coûte un revert ; dans le lot, une passe de recette ; en production, un incident. Le doublement 1:1 place le contradicteur là où sa trouvaille coûte le moins.

C'est ce doublement qui a produit le fait cité plus haut : les trois GO de recette portaient sur le produit ; les deux refus adversariaux portaient sur le diff.

## La contre-vérification des findings

Un panel adversarial produit du volume : c'est son travail. Le volume brut est inutilisable tel quel : il mélange des défauts réels, des faux positifs plausibles et des sévérités gonflées. La méthode intercale donc une passe obligatoire entre le panel et le producteur : **chaque finding est contre-vérifié contre le code réel avant d'être admis**.

Le protocole, finding par finding :

1. **Reproduire.** Rejouer le scénario allégué sur le vrai code, dans les vraies conditions. Pas sur une lecture du code : sur son exécution.
2. **Statuer.** Confirmé, ou écarté. Il n'y a pas de statut « probablement ».
3. **Justifier l'écart par écrit.** Un faux positif ne disparaît pas : il est écarté *avec sa justification technique*, consignée à côté du finding. « Écarté » sans raison écrite n'existe pas.
4. **Grader ce qui reste.** Majeur (viole le contrat, corrompt des données, casse un invariant) ou mineur ; la sévérité est elle-même contre-vérifiable, pas déclarative.

Le corpus donne la mesure de ce que la passe élimine. Sur une feature pilote sur un SaaS, une revue adversariale multi-agents a produit **45 findings bruts ; 32 ont été confirmés ; 13 faux positifs ont été écartés avec justification technique écrite** : par exemple une protection « manquante » qui était en réalité le choix correct pour l'architecture concernée. Sur un vault d'audit sur la plateforme d'un client, une passe à 30 agents a produit **24 findings, dont 19 confirmés**. Sur un produit en binôme multi-dépôts, un audit pré-préproduction à 13 agents alléguait **7 bloquants : 6 ont été rétrogradés, 1 réfuté** ; zéro bloquant réel, verdict rendu *après* contre-vérification, pas avant.

> **La méthode ne compte pas ses findings : elle les réfute.**

Un compte de findings est une métrique de vanité dans les deux sens. Trop haut, il noie le producteur sous des fantômes : sans la passe de réfutation, treize corrections inutiles auraient consommé le budget des vraies. Trop bas, il rassure à tort : l'absence de findings peut mesurer la paresse de l'attaque, pas la santé du code. Seuls les findings *survivants à la réfutation* portent une information.

La contre-vérification s'applique à l'adversaire lui-même. Sur un cockpit interne d'agence, un lot revu par un adversaire unique a été escaladé vers un panel élargi de 16 agents : le panel a trouvé **6 majeurs que l'adversaire unique avait manqués**, et **rétrogradé 3 faux-majeurs** que ce même adversaire avait gonflés. La leçon vaut règle : un verdict adversarial est une mesure, et une mesure se contre-vérifie : en élargissant le panel quand l'enjeu le justifie, jamais en croyant l'adversaire sur parole.

## La liste brute se conserve

La passe de réfutation crée une obligation d'archivage : **la liste brute des findings, y compris les écartés, se conserve à côté du verdict**, avec les justifications d'écart.

La raison est l'auditabilité. Un triage n'est légitime que s'il peut être contesté : quelqu'un (un humain, un panel élargi, un audit ultérieur) doit pouvoir rouvrir les treize écartés et vérifier que chaque justification tient. Un triage dont il ne reste que le résultat (« 32 confirmés ») est un acte de foi : on sait *combien* ont été écartés, plus *pourquoi*, ni si l'écart était juste.

Le contre-exemple est dans le corpus, et il a fondé la règle. Sur la feature pilote citée plus haut, les compteurs ont été consignés, mais la liste brute des 45, elle, n'a pas été conservée intégralement : **le triage est inauditable a posteriori**. Personne ne peut plus vérifier que les 13 écartés étaient bien des faux positifs. Le chantier a probablement eu raison (les justifications d'époque étaient techniques et datées), mais « probablement » est exactement ce que la méthode refuse de laisser en fondation.

Concrètement : le bilan de revue est un artefact versionné qui tient trois tables : *confirmés et corrigés* (avec la re-mesure, voir ci-dessous), *écartés* (avec justification), *différés* (avec échéance et porteur ; un différé sans date est un écarté qui ne dit pas son nom). Les compteurs en tête ; les lignes en dessous ; rien ne sort de la table.

## Les mesures avant/après, re-jouées dans les mêmes conditions

Un finding confirmé déclenche une correction. Une correction déclenche une re-mesure, et la re-mesure obéit à une règle stricte : **mêmes conditions que la mesure qui a détecté le défaut**. Même environnement, même jeu de données, même commande, même client. Une correction vérifiée par un autre chemin que celui de la détection ne prouve pas que le défaut est clos ; elle prouve qu'un autre chemin passe.

Le terrain tient cette règle à la lettre. Sur un site d'agence reconstruit sur référence figée, le registre des écarts consigne les mesures **avant/après** de la passe adversariale : 18 échecs sur 42 vérifications avant correction, 0 sur 40 après, les deux chiffres obtenus par la même batterie, re-jouée. Sur la feature pilote, chaque correctif du bilan de revue porte la mention « Vérifié » suivie du test exact qui le prouve, avec ses valeurs d'entrée et de sortie.

Deux corollaires :

- **L'orchestrateur remesure lui-même.** Sur un cockpit interne d'agence, la règle est écrite : l'orchestrateur ne croit pas les rapports de ses agents : il re-joue les compteurs finaux de sa propre main avant de prononcer un verdict. Un rapport d'agent est un finding comme un autre : il se contre-vérifie.
- **La mesure est un artefact, pas une phrase.** Les commandes, les sorties et les conditions se consignent : c'est l'objet du [chapitre 08 : La preuve et les sondes](./08-proof-and-probes.md).

## Les verdicts gradués

Une revue adversariale ne rend pas un feu vert ou rien. Elle rend l'un de trois verdicts, et le vocabulaire est canonique dans toute la méthode ([glossaire](../reference/glossary.md)) :

| Verdict | Signification | Ce qui suit |
|---|---|---|
| **GO** | Zéro majeur confirmé après réfutation ; règle d'arrêt atteinte | Le palier peut être clos, par quelqu'un d'autre que son constructeur |
| **GO-SOUS-CONDITIONS** | Des réserves nommées, chacune datée et portée par quelqu'un | Avancer, les conditions au registre ; une condition sans échéance ni porteur requalifie le verdict en NO-GO |
| **NO-GO** | Au moins un majeur confirmé subsiste | Retour au producteur ; nouvelle passe complète après correction |

Le GO-SOUS-CONDITIONS est le verdict le plus utile et le plus dangereux. Utile, parce qu'il évite de bloquer un chantier entier sur des réserves réelles mais bornées. Dangereux, parce qu'il est la porte d'entrée du GO de complaisance : une « condition » vague, sans date et sans porteur, est un NO-GO déguisé en GO. Le corpus en porte l'usage discipliné (un dossier de durcissement à 32 agents a rendu **GO-SOUS-CONDITIONS**, réserves listées, avant qu'une décision structurante ne soit rédigée) et l'usage du NO-GO franc : sur un site personnel, le premier verdict de revue a été **NO-GO à 4 bloquants**, tous corrigés puis re-mesurés avant le GO.

Deux frontières fermes :

- **Un verdict de revue n'est pas un go de mise en production.** Le GO adversarial dit que le livrable tient ; la décision de le mettre devant des utilisateurs est un rituel distinct, humain et explicite (voir le [chapitre 09 : La gate de mise en production et le registre](./09-release-gate-and-registry.md)).
- **Un verdict se prononce sur des findings réfutés, jamais sur des findings comptés.** « 24 findings » n'est ni un GO ni un NO-GO : c'est une matière première.

## La règle d'arrêt : deux passes sèches consécutives

La revue adversariale boucle en rounds : passe d'attaque → réfutation → corrections → re-mesures → nouvelle passe. Il lui faut une règle d'arrêt, sinon elle se ferme au pire moment possible : celui où le relecteur fatigue, c'est-à-dire celui où il baisse la garde.

La règle du terrain :

> **Une passe sèche est une passe complète qui ne produit aucun majeur confirmé. La revue n'est close qu'après deux passes sèches consécutives.**

Une seule passe sèche peut être un coup de chance ou une passe paresseuse ; la seconde la confirme. La clôture devient un fait mesuré (deux zéros de suite dans le journal de boucle) et non un ressenti.

Le cas d'école du corpus : sur une fintech, un composant backend a été livré en diff strictement additif (17 fichiers, 1 578 insertions, **0 suppression**) avec 61 tests verts, et la revue adversariale par rounds n'a été close qu'au sixième round, sur les majeurs confirmés par round : **0, 2, 1, 2, 0, 0**. Les deux zéros finaux sont la règle d'arrêt en action ; le zéro du premier round, à lui seul, n'aurait rien clos, et la suite lui a donné raison : les rounds 2 à 4 ont trouvé cinq majeurs. Sur ce terrain, « confirmé » avait sa propre discipline : un majeur ne comptait que validé par deux réfuteurs sur trois.

La règle est symétrique de la [règle des zones grises](./05-grey-zones-and-divergence.md) : là-bas, on rebalaye après chaque passe parce que chaque passe crée de nouvelles zones grises ; ici, on re-attaque après chaque correction parce que chaque correction peut créer de nouveaux défauts. Dans les deux cas, l'arrêt est un critère, pas une impression.

## Le gel honnête

La règle d'arrêt suppose que le compte descend. Parfois il ne descend pas.

Sur un cockpit interne d'agence, un lot est passé de **13 majeurs au premier round à 21 au deuxième**. Le journal de boucle porte le constat en toutes lettres : *le compte monte, ce n'est pas de la convergence*. Le lot n'a pas été déclaré fini. Il n'a pas non plus été discrètement abandonné. Il a été **gelé par écrit** : verdict « non convergé, gelé » consigné jusque dans le message de commit, état exact du su et de l'ouvert archivé, et interdiction écrite de le rouvrir sans go humain.

C'est le verdict qui manque à la plupart des processus de revue, et c'est pourquoi la méthode lui donne un nom : le **gel honnête**. Une boucle qui ne converge pas dit quelque chose (le périmètre était trop grand, le brief trop flou, l'architecture pas mûre), et un GO arraché à une boucle divergente ne fait pas taire cette information : il la reporte en production, au prix fort.

Une entrée de gel contient quatre choses :

1. **Le constat chiffré** : les comptes par round, et la phrase qui dit pourquoi ce n'est pas de la convergence.
2. **L'état exact** : ce qui est su, ce qui est corrigé et re-mesuré, ce qui reste ouvert.
3. **La condition de reprise** : ce qui doit changer (périmètre, brief, architecture) avant de rouvrir.
4. **Le verrou** : la reprise exige un go humain explicite ; le gel n'expire pas tout seul.

Le gel est un verdict de première classe, au même rang que GO et NO-GO. Une méthode qui ne sait pas geler ne sait dire que « fini » ou « pas encore fini » ; et « pas encore fini », répété assez longtemps sur un lot divergent, finit toujours en GO de complaisance.

## Le durcissement adverse : avant les contrats et les plans

Tout ce qui précède attaque du code. Le terrain a étendu le mécanisme un cran plus tôt : **avant de rédiger un contrat ou d'exécuter un plan structurant, le projet de document passe lui-même une passe adversariale.** Des contradicteurs indépendants attaquent le texte (les faits porteurs sont re-vérifiés contre le code réel, les invariants contestés, les trous de complétude cherchés) et la passe rend un verdict gradué, comme pour du code.

Le corpus en porte l'usage à son échelle la plus lourde : sur une fintech, une décision d'architecture structurante n'a été *rédigée* qu'après un dossier de durcissement produit par une passe multi-agents (32 agents : ancrage sur le code réel, attaque en deux lentilles, critique de complétude, double verdict) rendant **GO-SOUS-CONDITIONS**, les faits porteurs du dossier ayant été re-vérifiés un à un contre le code. La formule de terrain qui résume la discipline : *le durcissement précède l'écriture.*

La logique est la même que pour le diff non commité : attaquer au moment le moins cher. Un contrat faux coûte plus cher qu'un diff faux : tout ce qui se construit dessus hérite du défaut, et le [chapitre 06](./06-prompt-as-contract.md) a montré qu'un contrat figé fait autorité précisément parce qu'on ne le rediscute plus. Ce qui ne sera plus rediscuté doit être attaqué *avant* d'être figé. Un plan d'exécution relève de la même règle : ses affirmations porteuses (« cette branche est fusionnable », « cette donnée existe ») sont des findings en puissance, et elles se contre-vérifient avant l'exécution, pas pendant.

## Le dosage et la limite consignée

La revue adversariale a un coût réel : des rôles en plus, des rounds en plus, des re-mesures. La méthode ne prescrit pas le protocole complet partout. La variable de dosage est celle de toute la méthode : **propriété du code × coût de l'erreur**. Un backend qui touche à l'argent sur un code partagé justifie le doublement 1:1, les rounds et le vote de réfuteurs ; un outil interne jetable sur un code possédé en propre peut se contenter d'un contradicteur unique sur le diff final.

La limite basse existe, et le corpus la consigne au lieu de la cacher : **le chantier le plus léger du corpus a échappé entièrement à la revue adversariale** : aucune passe, aucun verdict. La méthode n'en tire pas une honte mais une règle, la même que pour toute dé-escalade : sauter la revue est un choix qui se prend par écrit, avec la raison (faible enjeu, code jetable, erreur réversible), pas une omission que l'on découvre après coup. Une revue non tenue en silence est une dette ; une revue écartée par écrit est un dosage.

## Voir aussi

- [Chapitre 03 · L'architecture agentique](./03-agent-architecture.md) · le panel de relecture read-only, couche 5
- [Chapitre 05 · Zones grises et divergence](./05-grey-zones-and-divergence.md) · le registre d'écarts, jumeau du bilan de revue
- [Chapitre 06 · Le prompt comme contrat](./06-prompt-as-contract.md) · ce qui se fige se durcit d'abord
- [Chapitre 08 · La preuve et les sondes](./08-proof-and-probes.md) · la mesure comme artefact
- [Chapitre 09 · La gate de mise en production et le registre](./09-release-gate-and-registry.md) · le GO de revue n'est pas un go de production
- [Chapitre 13 · Patterns et anti-patterns](./13-patterns-and-antipatterns.md) · patterns 10 (deux passes sèches) et 11 (gel honnête)
- [Référence · Glossaire](../reference/glossary.md) · GO, NO-GO, GO-SOUS-CONDITIONS, passe sèche, gel honnête, faux positif écarté
