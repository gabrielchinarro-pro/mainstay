<div align="center">

# Le Panthéon

**Je n'ai pas inventé la collaboration entre agents. J'ai écrit la loi qui la rend livrable.**

La façade du moteur privé qui exécute [Mainstay](README.fr.md) :
les noms, les actes, les gates. Pas le routage.

[English](PANTHEON.md) · **Français**

</div>

---

## Pourquoi ce texte sort aujourd'hui

Le Panthéon tourne en interne depuis un certain temps déjà. L'annonce était calée pour septembre, une fois le moteur rodé sur assez de livraisons pour que chaque règle puisse citer l'incident qui l'a produite — c'est la condition que je m'étais fixée pour publier quoi que ce soit.

Le 31 août 2026, Nous Research a publié Hermes Agent v0.21.0 sous le titre **« The Pantheon Release »** : identités d'agents, communication d'agent à agent, orchestration de sous-agents pilotables en vol.

Je ne me compare pas à Nous Research. Ils ont les modèles, les moyens et la portée ; je suis un opérateur qui livre des projets avec des agents, tous les jours, pour de vrais clients.

**Le calendrier des géants de l'IA m'oblige à accélérer la publication.** Je sors donc la façade maintenant, incomplète et assumée comme telle, plutôt qu'en septembre en ayant l'air de suivre.

## Ce que je revendique, et ce que je ne revendique pas

**Je ne revendique pas l'idée de faire collaborer des agents.** Elle est publique, travaillée par beaucoup, et bien mieux financée ailleurs que chez moi. Faire dialoguer des agents entre eux n'est plus une invention.

**Je revendique la loi qui les gouverne.** Un protocole où chaque fonction porte un nom unique, où chaque acte d'exécution a une forme écrite, où les gates irréversibles ne se franchissent jamais sans un accord humain explicite, et où chaque règle cite l'incident qui l'a produite. Pas un framework : une jurisprudence.

La différence tient en une phrase. **Faire parler des agents entre eux est un problème d'ingénierie. Les empêcher de faire des dégâts en votre nom est un problème de droit.** Le second est le mien.

## Les actes — la méthode

| Acte | Ce que c'est | La règle |
|---|---|---|
| **L'Augure** | L'annonce avant exécution | Rien ne se lance sans prendre les auspices : problème détecté, composition convoquée, gates prévues, ce qu'on attend de l'humain. Cinq lignes, avant la première action. |
| **L'Arène** | La boucle adversariale | On n'en sort pas sur « ça a l'air bon ». On en sort sur une passe sèche confirmée par une passe à angles neufs — ou sur un gel honnête, consigné par écrit. |
| **Le Rubicon** | Les gates irréversibles | Push, mise en production, envoi, création de compte, écriture serveur. Personne ne les franchit sans accord explicite de l'humain. **Aucun override ne bat le Rubicon** — pas même celui qui l'a écrit. |
| **Les Tables** | Les décisions gravées | Numérotées, datées, attribuées. On supersède, on n'efface jamais. Une décision annulée reste lisible avec ce qui l'a annulée. |
| **Le Flambeau** | Le passage de main | L'état passe d'une session à la suivante sans tomber : mesuré et non déduit, décisions verrouillées, première action ordonnée. Ce qui est périmé est marqué périmé. |
| **L'Enseigne** | Le statut de session | Dit **qui a la main** — l'humain, le monde extérieur, la flotte d'agents, ou personne — jamais l'avancement. Un opérateur qui pilote dix sessions voit d'un coup d'œil les trois qui l'attendent. |

## Les rôles — un nom par fonction

La règle fondatrice tient en une ligne : **un nom par fonction, jamais deux.** Elle interdit surtout son contraire — « l'agent machin », redéfini à chaque session, qui ne veut plus rien dire au bout de trois.

Un vocabulaire compact est de l'infrastructure. *« Némésis sur le diff »* est une spécification complète en quatre mots : qui intervient, sur quoi, avec quel mandat.

| Nom | Fonction |
|---|---|
| **Janus** | L'orchestrateur aux deux visages : l'un lit le problème, l'autre lit le projet. Ouvre, route, referme. |
| **Héphaïstos** | La forge. Produit le code, et **ne juge jamais son propre ouvrage**. |
| **Athéna** | Stratégie et arbitrage. Découpe les paliers, tient le registre des écarts, prépare les gates. N'écrit pas de code. |
| **Momus** | Le dieu du blâme. Conteste tout, ne corrige rien. Avis motivé obligatoire — y compris « rien à signaler ». |
| **Argus** | Cent yeux qui ne dorment jamais. Vérification mécanique et répétable. |
| **Protée** | Toutes les formes. Exploration et transverse : ce qui ne rentre dans aucune charte. |
| **Némésis** | La rétribution de l'hubris. Réfute les prétentions au parfait, et double la forge sur tout code non encore validé. |
| **Le Vigile** | La ronde de nuit. Un **script** mécanique, pas un agent — décidé ainsi après un refus adversarial motivé : une surveillance sans supervision ne doit rien pouvoir interpréter. |

## La loi de séparation

Une seule règle tient tout l'édifice : **un palier n'est jamais clos par celui qui l'a construit.**

Toute production traverse au moins un juge indépendant, et les juges ne corrigent rien — ce qui les empêche de devenir producteurs à leur tour. La forge ne valide pas sa forge. Le contradicteur ne répare pas ce qu'il conteste. La recette ne négocie pas ses critères.

C'est ce qui sépare une équipe d'agents d'un agent bavard. **Un modèle qui relit son propre travail retrouve ce qu'il a déjà pensé.** Un modèle mandaté pour le réfuter trouve autre chose. La séparation n'est pas une politesse d'organigramme : c'est la seule chose qui produit une contradiction réelle plutôt qu'une approbation coûteuse.

## Ce qui n'est pas publié, et pourquoi

Ce document est la version minimale — les bases, et rien de plus. Restent privés :

- **le routage** — la cascade qui lit un problème et en déduit seule le type, le profil du projet, la composition à convoquer et les gates à poser ;
- **les modules et les compositions** — un playbook par type de problème, du ticket à l'incident ;
- **les chartes de rôles** — le mandat complet de chaque nom, ce qu'il peut et ce qu'il ne peut pas ;
- **la jurisprudence** — le corpus des décisions, des violations et des preuves.

Ce n'est pas de la rétention commerciale, c'est une constatation. **Ces règles sont une jurisprudence : chacune cite l'incident qui l'a produite.** Cloner les fichiers ne clonerait pas les incidents, et sans eux les règles perdent leurs dents — elles redeviennent des bonnes pratiques qu'on lit et qu'on n'applique pas. Ce qui a de la valeur ici n'est pas le texte des règles, c'est ce qui les a rendues non négociables.

Ce document dit donc **ce que font les étages supérieurs, pas comment les reconstruire.**

## L'étage du dessous

Le rez-de-chaussée est public, libre et complet : **[Mainstay](README.fr.md)**, la méthode de livraison logicielle pilotée par agents — mémoire, contrats, garde-fous. Elle n'attend rien de ce document pour fonctionner. Prenez-la, appliquez-la, livrez avec.

---

## Si ce protocole vous parle

Il est né de projets livrés, pas d'une intuition. Il continue d'être corrigé par eux.

Si vous opérez des agents en production et que ces problèmes sont les vôtres — les gates qu'on franchit par accident, les décisions qu'on ne retrouve plus, les sessions qui perdent le fil, l'agent qui valide son propre travail — **la discussion m'intéresse.** Que vous vouliez l'appliquer, le critiquer, ou m'expliquer pourquoi j'ai tort.

**[gabrielchinarro.com](https://gabrielchinarro.com)**
