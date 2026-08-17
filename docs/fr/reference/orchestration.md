# Orchestration multi-agents

*La partie la plus éprouvée de l'orchestration n'est pas l'étagement des modèles ; c'est la séparation des rôles. Un palier n'est jamais clos par celui qui l'a construit.*

L'orchestration recouvre deux disciplines distinctes. La première : router chaque unité de travail vers le bon rôle, et garder le contexte de chaque agent non pollué. La seconde, qui n'existait pas dans les versions antérieures de cette documentation : faire tourner des dizaines de sessions parallèles sur un même dépôt sans qu'elles s'écrasent mutuellement. Ce chapitre couvre les deux, en marquant pour chaque pattern son statut réel : éprouvé sur le terrain, ou grille de lecture proposée.

Les faits de terrain cités ici proviennent d'un corpus privé : faits datés, compteurs obtenus par commande, vérifiés par audit interne en trois passes contradictoires. Ils ne sont pas rejouables par le lecteur.

---

## Les rôles avant les modèles

Ce que le terrain a réellement construit, ce n'est pas une hiérarchie de modèles. C'est une **séparation des rôles**, gouvernée par une règle unique :

> **Un palier n'est jamais clos par celui qui l'a construit.**

La topologie observée sur les chantiers les plus outillés du corpus est un orchestrateur entouré de rôles nommés :

| Rôle | Mandat | Droits d'écriture |
|---|---|---|
| Orchestrateur | Découpe le travail, arbitre, remesure lui-même | Oui, et lui seul clôt |
| Producteur (muteur) | Écrit le code ou l'artefact | Oui, sur son périmètre |
| Recette produit (PO) | Valide fonction et rendu contre le contrat | Non, lecture seule |
| Relecteur agnostique | Relit sans connaître les intentions du producteur | Non, lecture seule |
| Relecteur adversarial | Cherche à casser, en parallèle | Non, lecture seule |

Deux propriétés font tenir cette topologie. D'abord, les relecteurs sont en **lecture seule** : un relecteur qui peut corriger devient un second producteur, et le palier perd son juge. Ensuite, **l'orchestrateur ne croit pas les rapports d'agents** ; il remesure lui-même avant de clore. Sur un cockpit interne d'agence, cette règle est écrite dans le fichier de contexte ; sur un site d'agence reconstruit sur référence figée, un handoff consigne des suites entières re-passées par l'orchestrateur en personne avant clôture. Le protocole complet des rôles adversariaux (contre-vérification des findings, verdicts gradués, règle d'arrêt) est au [chapitre 07 · La revue adversariale](../core/07-adversarial-review.md).

---

## Les trois niveaux : une grille de lecture

Pour router le travail, Mainstay propose une grille en trois niveaux. C'est une grille de lecture (un vocabulaire pour raisonner le routage), pas un dispositif que le corpus aurait fait tourner tel quel.

| Niveau | Classe de modèle | Coût relatif | Possède | Escalade quand |
|---|---|---|---|---|
| Chef d'orchestre | Haut de gamme | Élevé | Décisions, architecture, contrats, arbitrages | Jamais : c'est le sommet |
| Bras droit | Milieu de gamme | Moyen | Implémentation structurée contre un contrat figé | Une ambiguïté non couverte par le contrat |
| Exécutant | Léger | Faible | Routines déterministes entièrement spécifiées | L'instruction exige un jugement |

Le principe qui traverse la grille : **ajustez le prix du token au jugement requis.** Chaque token qu'un modèle haut de gamme dépense en formatage est surpayé ; chaque jugement architectural confié à un modèle léger est sous-payé, et se paiera en zones grises. Un bras droit qui rencontre une ambiguïté escalade au lieu de deviner : deviner produit des zones grises ([chapitre 05](../core/05-grey-zones-and-divergence.md)).

## L'étagement multi-modèles : pattern émergent, une occurrence

L'étagement effectif de *modèles* (des classes de modèles différentes assignées à des rôles différents dans une même topologie) existe sur **une seule occurrence du corpus**, et elle mérite d'être décrite précisément plutôt que généralisée.

Sur un site d'agence reconstruit sur référence figée, la topologie à quatre rôles (pilotage produit, code, contradicteur, recette) assignait les modèles ainsi : les trois rôles de jugement sur le modèle fort, et **seul le rôle mécanique et répétable (la recette : comparaison au pixel contre la référence, contrôles de contrastes, parcours clavier) descendait sur un modèle inférieur**.

La règle qui voyage, si vous tentez l'étagement :

> Ce qui descend d'un niveau de modèle, c'est ce qui est mécanique et répétable. Le jugement ne descend pas.

Le rôle de recette descend parce que son protocole est une grille exécutable : comparer, mesurer, cocher. Le contradicteur ne descend pas : réfuter demande du jugement. Une occurrence n'est pas un canon éprouvé ; c'est un pattern émergent, publié comme tel.

---

## La séparation explorer/éditer

Le pattern de sous-agent le plus rentable n'est pas « plus d'agents » ; c'est de séparer **l'exploration** de **l'édition**.

Lire une grande base de code brûle du contexte. Un agent qui a lu quarante fichiers pour répondre à une question porte quarante fichiers de bruit dans chaque édition suivante. La correction est une division du travail :

- Un **sous-agent d'exploration** tourne en lecture seule et renvoie une **synthèse compacte** : pas les fichiers, la réponse.
- Un **agent d'édition**, dont le contexte n'a jamais été dépensé sur la recherche, applique le changement avec un contexte propre.

La passation est une synthèse, gouvernée par trois règles :

1. **Répondre, ne pas transcrire.** Des conclusions et les quelques faits qui les soutiennent, pas des contenus bruts.
2. **Nommer les sources, ne pas les coller.** Citez le chemin ; laissez l'agent d'édition l'ouvrir seulement s'il le doit.
3. **Faire remonter l'ambiguïté explicitement.** Une zone grise trouvée en exploration se signale ; elle ne se tranche pas en sous-agent.

```text
SYNTHESIS: filter state for the data table

WHERE:    apps/frontend/src/table/use-table-state.ts
SHAPE:    { filters: Filter[], sort: SortSpec, columns: string[] }
OWNER:    the table screen; persisted per-user on save
CONSTRAINT: a saved view stores a snapshot, not a live reference
GREY ZONE: behaviour when a saved column no longer exists is
           unspecified; needs a decision before editing.
NEXT:     editing the panel is safe; resolve the grey zone first.
```

Douze lignes remplacent quarante fichiers. C'est tout l'enjeu de la passation. Ce pattern rejoint le terrain par un autre chemin : le panel de relecture en éventail du [chapitre 07](../core/07-adversarial-review.md) est exactement des sous-agents read-only qui renvoient des synthèses (des findings) à un orchestrateur qui garde son contexte propre pour trancher.

---

## Un modèle de coût (illustratif)

Les chiffres ci-dessous sont **inventés pour l'exemple** : ils montrent la *forme* de l'argument, pas un devis. Scénario : construire un écran de bout en bout.

| Approche | Exploration | Contrat | Implémentation | Format/lint | Total |
|---|---|---|---|---|---|
| Naïve : modèle haut de gamme partout | 2,70 $ | 0,90 $ | 3,60 $ | 1,35 $ | **8,55 $** |
| Orchestrée : chaque tâche à son niveau | 0,09 $ | 0,90 $ | 0,72 $ | 0,045 $ | **1,76 $** |

Dans ce scénario illustratif, l'approche orchestrée coûte environ 5× moins pour la même sortie, parce que les tokens chers ne sont dépensés que sur le vrai travail de décision. La seconde économie est la latence : le travail parallèle bon marché ne fait pas la queue derrière un seul modèle cher.

---

## Travailler en flotte

Au-delà de quelques sous-agents, le terrain a fait tourner autre chose : des **dizaines de sessions parallèles sur un même dépôt**, pendant des semaines. Sur une fintech, une centaine de worktrees actifs a été constatée par commande ; sur un produit en binôme multi-dépôts, sept worktrees se partageaient le back-office. À cette échelle, le problème n'est plus le routage ; c'est la collision. Quatre patterns du corpus la neutralisent.

### Une session = un worktree + un port

Chaque session vit dans son propre worktree git, sur sa propre branche, avec son **port de développement dédié**, et le checkout principal est intouchable.

| Élément isolé | Mécanisme | Ce que ça empêche |
|---|---|---|
| Fichiers | Un worktree par session (`git worktree add`) | Deux sessions qui s'écrasent le même arbre |
| Historique | Une branche nommée par chantier (`agent/<type>/<slug>`) | Des commits croisés inattribuables |
| Runtime | Un port dédié par session, jamais celui du checkout principal | Deux serveurs de dev qui se marchent dessus |
| Dépendances | `node_modules` symlinké depuis le checkout principal | La duplication de l'installation à chaque worktree |

Le cadre de session (slug du worktree, branche, port) se remplit en tête de chaque mega-prompt d'orchestration ([chapitre 06](../core/06-prompt-as-contract.md)). L'isolation n'est pas une optimisation : c'est la condition d'existence du parallélisme. Sans elle, la deuxième session détruit la première.

### Les PR de vault séparées des PR de code

Sur la fintech du corpus, la connaissance et le code voyagent dans des pull requests **séparées** : une PR de code pour le diff applicatif, une PR de vault pour les décisions, contrats et concepts, avec des worktrees dédiés aux PR de vault, et la règle « jamais de push direct sur la branche principale du vault ».

La séparation a deux raisons. Les signataires diffèrent : une PR de vault se relit comme un document (produit peut la signer seul) ; une PR de code se relit comme du code. Et les rythmes diffèrent : une décision peut être adoptée avant, pendant ou après le code qu'elle gouverne ; la coupler à la PR de code fait attendre l'un ou l'autre. La contrepartie se gère : c'est le hook de synchronisation qui garantit que doc et schéma ne divergent pas ([CI/CD et hooks](./cicd-and-hooks.md)).

### Le brief commun d'orchestration

Quand plusieurs sessions travaillent la même vague, chacune reçoit son prompt propre, mais toutes héritent d'un **brief commun** : un fichier unique de règles transverses que chaque prompt de session référence au lieu de les recopier.

Un brief commun observé porte typiquement :

- **la règle de sauvegarde** : copie sidecar nommée et horodatée avant toute écriture risquée ([chapitre 08](../core/08-proof-and-probes.md)) ;
- **les gardes anti-collision** : qui écrit où ; les fichiers qu'aucune session ne touche ;
- **les gestes réservés** : ce qui n'est posté qu'en fin de chaîne, par l'orchestrateur, jamais par une session de travail (réponses aux clients, notamment) ;
- **la chaîne de clôture** : qui recette, qui clôt, dans quel ordre.

Le brief commun est au parallélisme ce que le fichier de contexte est à la session : la mémoire partagée qui évite que chaque prompt réinvente (ou oublie) les règles de coexistence.

### Le séquencement de vague par chaîne de rôles

Une flotte productive accumule un stock de branches finies plus vite qu'on ne les fusionne. Le corpus a produit un artefact dédié à ce moment : le **document de séquencement de vague**. Sur la fintech, un stock de 15 branches a été arbitré par écrit en **18 PR ordonnées** (certaines branches découpées, d'autres fusionnées), avec, pour chaque PR, son ordre, ses dépendances et son risque.

L'arbitrage n'est pas un tri mécanique : il est rendu par une **chaîne de rôles simulée**. Le stock passe par des lectures successives aux mandats distincts (lecture technique de la dépendance et du risque, lecture d'architecture, lecture produit de la valeur), chacune amendant l'ordre proposé. Le plan de vague est lui-même un artefact durci : soumis à des contradicteurs indépendants avant exécution, et amendé sur pièces ([chapitre 07](../core/07-adversarial-review.md), section durcissement adverse).

La règle qui déclenche l'artefact : **quand le stock de branches dépasse ce qu'une tête ordonne de mémoire, l'ordre de fusion devient une décision écrite** (datée, arbitrée, consignée), pas une file implicite.

### La dette de flotte : les limites consignées

Le corpus documente aussi ce que la flotte coûte, et ces limites se publient avec les patterns :

- **La dette de parallélisme.** Une flotte accumule des branches non fusionnées et des checkouts périmés ; le séquencement de vague est né précisément parce que le stock avait dépassé la mémoire d'une tête. Une flotte sans rituel de résorption grossit jusqu'à devenir ingouvernable.
- **Les collisions de numérotation.** Des sessions parallèles qui créent des décisions produisent des numéros en double ; le corpus en porte plusieurs, non résolus pour certains. Le garde-fou est le registre central de numéros ([chapitre 02](../core/02-vault-and-sources-of-truth.md)).
- **La dérive des copies de vault.** Un vault copié dans un worktree et étendu localement diverge du vault principal sans procédure de resynchronisation. Traitez toute copie comme du cache : la vérité reste au vault principal.

---

## Quand NE PAS utiliser de sous-agents

Les sous-agents ne sont pas gratuits : chaque passation peut perdre de l'information et ajoute de la latence. N'orchestrez pas quand :

- **la tâche est petite et autonome** : deux fichiers se lisent à bas coût ; la passation coûterait plus qu'elle ne fait gagner ;
- **le contexte est déjà chargé** : l'agent qui vient de construire l'écran porte déjà le contexte ; un sous-agent neuf le jette ;
- **le travail est une décision indivisible** : découper un jugement architectural le fragmente ;
- **la synthèse serait aussi grande que la source** : alors la zone *est* le travail ; éditez-la directement ;
- **vous chassez un bug subtil et à état** : les passations brisent la chaîne de raisonnement qui trouve la cause.

La règle : un sous-agent mérite sa place quand le **contexte économisé par la délégation dépasse le contexte dépensé sur la passation**. En dessous de cette ligne, un seul agent est plus rapide, moins cher et plus tranchant.

---

## Voir aussi

- [Chapitre 03 · L'architecture agentique](../core/03-agent-architecture.md)
- [Chapitre 06 · Le prompt comme contrat](../core/06-prompt-as-contract.md) : le mega-prompt orchestrateur
- [Chapitre 07 · La revue adversariale](../core/07-adversarial-review.md)
- [Profil · Équipe & flotte](../profiles/team-fleet.md)
- [Référence · CI/CD et hooks](./cicd-and-hooks.md)
