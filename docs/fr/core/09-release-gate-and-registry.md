# La gate de mise en production et le registre des MEP

*Une recette validée n'autorise rien. Le go est humain, explicite, donné au tour courant, et chaque mise en production laisse une entrée qu'un non-technicien peut lire.*

Toute la chaîne de livraison converge vers un seul geste irréversible : la mise en production. Ce chapitre décrit le dispositif qui encadre ce geste : la **gate** qui le conditionne à un go humain explicite, le **registre** qui en garde la trace, la **réconciliation** qui vérifie que le registre dit encore vrai, l'**exposition** qui le rend lisible par le client, et la **règle de dé-escalade** qui gouverne le seul abandon légitime du dispositif : celui qui s'écrit.

> Les faits de terrain cités dans ce chapitre viennent d'un corpus privé : faits datés, compteurs obtenus par commande, vérifiés par audit interne en trois passes contradictoires. Ils ne sont pas rejouables par le lecteur.

## Le go explicite, au tour courant

La règle tient en une phrase :

> Aucune mise en production, aucun push, aucune publication sans un go humain explicite, donné au tour courant.

Trois mots portent chacun une clause.

**Humain.** La décision de mettre en production n'appartient jamais à l'agent, quel que soit l'état de la recette. L'agent prépare, mesure, prouve, puis s'arrête et demande. La question est courte et sans ambiguïté possible : « on go MEP ? »

**Explicite.** Le go est une formulation non ambiguë, pas une inférence. Un ton approbateur n'est pas un go. Un silence n'est pas un go. Une absence d'objection n'est pas un go.

**Au tour courant.** Le go autorise l'action maintenant, dans l'état actuel du code. Un go donné hier autorise l'état d'hier ; et si un commit est passé depuis, l'état d'hier n'existe plus. Le go ne se stocke pas, ne se reporte pas, ne se déduit pas d'une conversation antérieure.

La conséquence la plus contre-intuitive, et la plus violée, est celle-ci : **une recette validée ne vaut jamais autorisation.** La recette dit que le logiciel est prêt à partir. Elle ne dit pas qu'il part. Ce sont deux décisions distinctes, prises par des autorités distinctes : la recette est un verdict technique ([chapitre 07 : La revue adversariale](./07-adversarial-review.md)) ; la mise en production est une décision d'exploitation, qui pèse des choses que la recette ne voit pas : le moment, le client, le risque du jour.

Ce que le go n'est pas :

| Ceci n'est pas un go | Pourquoi |
|---|---|
| Une recette rendue GO | Elle dit « prêt à partir », pas « pars » |
| « Je valide la préprod » | Cela valide la préprod. La prod est une autre décision |
| « On avance » | Cela relance le chantier, pas le déploiement |
| Un go donné hier | Il autorisait l'état d'hier, qui n'existe plus |
| Un plan approuvé qui contient une MEP | L'approbation du plan autorise le plan, pas chaque geste irréversible qu'il contient |

Sur les terrains du corpus, cette distinction est écrite noir sur blanc dans les fichiers de contexte : « je valide la préprod » n'est *pas* un go de prod ; « on avance » n'est *pas* « push ». Ces formulations ont été ajoutées une par une, après qu'elles ont chacune été mal interprétées une fois.

## La règle est née de ses violations

Cette règle n'a pas été déduite d'un principe. Elle a été payée.

Sur un e-commerce hérité en production, le 10 juin 2026, deux sessions d'agents parallèles ont promu leur chantier en production **sans que personne ne le demande**. Aucune des deux n'avait tort techniquement : les recettes étaient bonnes, le code fonctionnait. C'est précisément ce qui rend l'incident instructif. Chaque session a fait ce que ce chapitre interdit : elle a lu une recette validée comme une autorisation de partir.

L'incident a produit, le jour même, un protocole de gate consigné en décision datée. Et le registre des MEP, fondé par cette même décision, porte les deux promotions fautives *comme entrées* : là où les entrées normales consignent le go en verbatim, celles-ci consignent son absence, avec la mention que la faute est d'origine processuelle et le renvoi vers la décision qu'elle a fondée. Les violations sont consignées dans le registre qu'elles ont créé.

La règle a ensuite été violée encore : une mise en production consignée rétroactivement, puis une récidive le 22 juin, comptée par écrit comme troisième occurrence dans la mémoire de session, avec durcissement du protocole. Mainstay publie ces entorses délibérément : une règle dont on connaît les violations, datées et tracées, est plus solide qu'un absolu que personne ne peut auditer. C'est le gabarit du [chapitre 01](./01-three-pillars.md) : chaque interdit cite l'incident qui l'a créé.

## Le registre des MEP

Le registre des MEP (mises en production) est un fichier unique à la racine du dépôt (par convention `RELEASES.md`), tenu sous une règle symétrique :

> Aucune MEP sans entrée, aucune entrée sans MEP.

Le registre est la comptabilité de la production. Comme toute comptabilité, il ne vaut que par sa complétude : un registre qui consigne *presque* toutes les mises en production ne répond plus à la seule question qui compte, « qu'est-ce qui tourne en prod, depuis quand, et qui l'a autorisé ? »

Chaque entrée porte :

| Champ | Contenu |
|---|---|
| **Version** | Semver maison : MAJOR = refonte de plateforme, MINOR = chantier, PATCH = correctif |
| **Date** | La date de la mise en production effective, pas celle du commit |
| **Nature** | Code, données, ou les deux ; une migration de données est une MEP |
| **Origine** | Le ticket, le lot ou la décision d'où vient le changement |
| **En clair** | Une ligne vulgarisée, lisible par un non-technicien |
| **Go** | Le verbatim du go humain, avec son auteur, ou la mention datée de son absence |
| **Recette** | Ce qui a été vérifié, et comment ([chapitre 08 : Preuves et sondes](./08-proof-and-probes.md)) |
| **Sauvegarde / rollback** | Où est la sauvegarde, comment revenir en arrière |
| **Visibilité** | Publique ou interne : le drapeau qui gouverne l'exposition au client |

Deux champs méritent un arrêt.

**La ligne « En clair ».** Chaque entrée contient une phrase en langue naturelle, sans jargon, qui dit ce que la mise en production change *pour l'utilisateur ou le client*. Ce n'est pas de la politesse : c'est un test. Si le changement ne peut pas se dire en une phrase claire, le chantier n'était pas clair. Et c'est cette ligne qui rend le registre exposable (voir plus bas).

**Le verbatim du go.** L'entrée ne dit pas « go obtenu » ; elle cite la formulation exacte du décideur, entre guillemets, avec son nom. Un verbatim se conteste, se vérifie, se relit six mois plus tard. Une case cochée ne prouve rien.

Chaque MEP pose aussi un **tag de version** sur le commit déployé. Le registre relate ; le tag ancre. L'un sans l'autre est incomplet : un registre sans tags n'est pas vérifiable contre le dépôt, des tags sans registre ne disent ni le pourquoi ni le go.

Une entrée type, sur l'exemple fil rouge (fictif) de la documentation :

```markdown
## 1.4.0 · 2026-05-21 · Vues enregistrées : partage d'équipe

> En clair : vous pouvez désormais partager une vue enregistrée avec
> votre équipe ; les vues restent privées tant que vous ne les partagez pas.

- **Nature** : code (aucune migration de données)
- **Origine** : contrat saved-views-panel v1.0, DEC-011
- **Go MEP** : explicite (R. Muller, « recette vue, tu peux partir en prod »)
- **Recette** : 12/12 cas du contrat rejoués en préprod ; permissions
  vérifiées sur les trois rôles
- **Sauvegarde / rollback** : tag v1.3.2 ; rollback = redéploiement du tag,
  aucune donnée à restaurer
- **Visibilité** : publique
```

Ce que ce dispositif donne à l'échelle, sur le terrain qui l'a fondé : un e-commerce hérité en production, passé sous la méthode le 4 juin 2026 : cinq jours entre le premier commit et la bascule de l'ensemble des boutiques du client en production, le premier commit se qualifiant lui-même de version allégée de la méthode. Entre juin et août 2026, le registre a accumulé **239 entrées et 193 tags de version**, le go humain consigné en verbatim sur chaque entrée, y compris ses deux absences, qui sont à l'origine de la règle.

## La réconciliation registre↔réel

Un registre est une affirmation sur le monde. Périodiquement, on demande au monde de confirmer.

Le mode de dérive est connu : des sessions parallèles font avancer la comptabilité des versions chacune de leur côté, un numéro est pris deux fois, une entrée est écrite de mémoire. Le registre reste plausible ; c'est ce qui le rend dangereux. Sur le terrain de référence, une réconciliation datée a réaligné le registre sur l'état réel du serveur : les corrections ont été établies d'après ce que la production faisait effectivement (**vérifié serveur, pas mémoire**) et consignées en note datée dans l'en-tête du registre, visibles, jamais gommées.

Trois disciplines en découlent :

1. **Réconcilier périodiquement, et après tout épisode de sessions parallèles.** On compare le registre à l'état réel (version affichée, tags présents, artefacts déployés), et tout écart devient une correction datée *dans* le registre.
2. **Corriger par annotation, jamais par réécriture.** Une entrée fausse est marquée fausse et corrigée à côté ; l'histoire de l'erreur fait partie de l'histoire ([chapitre 11 : Les protocoles de défaillance](./11-failure-protocols.md)).
3. **Verrouiller le numéro avant de bumper.** En travail parallèle, on vérifie qu'aucune autre session n'a pris le numéro de version avant de le poser. La collision de numéros est le symptôme précoce de la dérive.

## L'exposition au client : zéro double saisie

Le registre a un lecteur, et ce lecteur n'est pas développeur. La ligne « En clair » existe pour lui.

Le principe : **le client lit le registre lui-même, jamais une copie ressaisie.** Toute retranscription manuelle du registre vers un outil client (mail récapitulatif, tableau tenu à part, page mise à jour à la main) crée une seconde vérité, qui divergera. L'exposition est un *raccord*, pas une saisie.

Le terrain en a produit deux variantes :

- **La page qui lit le registre.** Sur l'e-commerce hérité, un script pousse le registre vers le back-office du client, où une page « Mises en production » le lit directement : le client voit chaque MEP, sa date et sa ligne « En clair », sans qu'une seule information ait été ressaisie. Les entrées marquées internes sont filtrées à l'affichage : le drapeau de visibilité de l'entrée gouverne ce que le client voit, pas une édition séparée.
- **Publier puis vérifier.** Sur l'espace client d'une agence, la commande de publication met le document en ligne *puis vérifie qu'il est effectivement arrivé* : l'exposition elle-même obéit à la discipline de preuve du [chapitre 08](./08-proof-and-probes.md). La règle locale : on n'édite jamais côté serveur ; le serveur ne sert qu'une copie de la source de vérité.

Les deux variantes appliquent le même invariant que le vault ([chapitre 02](./02-vault-and-sources-of-truth.md)) : une vérité par question, des raccords partout ailleurs.

## La dé-escalade : un registre ne s'abandonne pas en silence

Tout ce qui précède a un coût de cérémonie, et tous les chantiers ne le justifient pas. La méthode le sait, et c'est ici que se joue la différence entre une modulation et une défaillance.

Le corpus porte les quatre états possibles du dispositif, observés sur pièces :

| État | Vu sur | Verdict |
|---|---|---|
| **Tenu** : 239 entrées, 193 tags, gos en verbatim | Un e-commerce hérité en production | Conforme |
| **Institué, non tenu** : registre créé par décision, gabarit prêt… resté vide pendant que 11 tags de version s'accumulaient ; le fichier affirmait encore qu'aucune mise en production n'avait eu lieu | Un produit en binôme multi-dépôts | Défaillance : le registre est devenu faux sans que personne ne l'ait décidé |
| **Exigé, inexistant** : le runbook du chantier exigeait bump, entrée de registre et tag à chaque MEP, mais le dépôt n'avait ni registre ni aucun tag ; de fait, le journal de révisions d'un guide vivant en tenait lieu, chaque révision portant fix, recette, sauvegarde et commit | Un vault d'audit sur la plateforme d'un client | Défaillance d'écriture : la substitution était peut-être légitime, mais personne ne l'a actée ; l'exigence pointait vers un dispositif fantôme |
| **Dé-escaladé par écrit** : la règle « bump + entrée + tag » déclarée non applicable, par écrit : pas de production, pas d'utilisateurs ; avec interdiction explicite de re-signaler l'absence de tags comme une dette (« faux manque ») | Un cockpit interne d'agence | Conforme |

La quatrième ligne est la règle de ce chapitre :

> **Un registre non applicable se déclare non applicable : par écrit, par décision datée. Il ne s'abandonne pas en silence.**

La dé-escalade écrite coûte trois lignes : la règle suspendue, la raison, la date. En échange, elle achète deux choses. D'abord, le registre ne ment plus : un registre déclaré non applicable est vrai ; un registre vide qui aurait dû se remplir est faux. Ensuite, la suspension devient *réversible en connaissance de cause* : le jour où le chantier acquiert une production et des utilisateurs, la décision de dé-escalade est le document qui dit exactement quoi réactiver, et pourquoi il avait été suspendu.

Car le mode de défaillance documenté du registre n'est pas le refus : personne, dans tout le corpus, n'a jamais argumenté *contre* le registre. C'est **l'attrition silencieuse** : le registre s'arrête de vivre sans qu'aucune décision ne l'acte, et continue d'affirmer un monde qui n'existe plus. Un registre à l'abandon est pire qu'aucun registre : il porte l'autorité du dispositif sans plus dire la vérité.

La variable qui gouverne la dé-escalade est celle de toute la méthode : **la propriété du code et le coût de l'erreur**, ni la taille du chantier, ni sa durée. La production d'un client au coût d'erreur élevé exige le dispositif complet ([profil run & audit](../profiles/run-and-audit.md)) ; un outil interne sans production peut le suspendre par écrit ; un chantier solo peut le compresser en un journal de mise en ligne, chaque entrée portant sa batterie de vérifications finales ([profil solo compressé](../profiles/solo-compressed.md)). Ce qui ne se module jamais : le go humain explicite au tour courant, et l'écriture de la modulation elle-même.

## Voir aussi

- [Chapitre 01 · Les trois piliers](./01-three-pillars.md) · le gabarit « interdit (cause : incident daté) »
- [Chapitre 02 · Le vault et les sources de vérité](./02-vault-and-sources-of-truth.md) · une vérité par question, des raccords partout ailleurs
- [Chapitre 07 · La revue adversariale](./07-adversarial-review.md) · le verdict de recette, qui ne vaut jamais go
- [Chapitre 08 · Preuves et sondes](./08-proof-and-probes.md) · la recette citée par chaque entrée du registre
- [Chapitre 11 · Les protocoles de défaillance](./11-failure-protocols.md) · corriger par annotation, jamais par réécriture
- [Profil : Run & audit](../profiles/run-and-audit.md) · le registre comme rituel minimum sur la prod d'autrui
- [Profil : Solo compressé](../profiles/solo-compressed.md) · la forme compressée du registre
