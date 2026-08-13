# Métriques — un instrument proposé, non éprouvé

*Sept métriques de santé pour la méthode, chacune avec formule, collecte, cible et lecture. Aucune n'a encore été collectée sur un terrain réel. Ce chapitre est un instrument dessiné, pas un instrument éprouvé.*

## Avant-propos — le statut honnête de ce chapitre

Ce chapitre doit être lu pour ce qu'il est. La méthode a tourné sur une dizaine de terrains réels — e-commerce en production, fintech, produits en construction, audits de plateformes clientes. **Aucune des sept métriques ci-dessous n'a été collectée sur aucun de ces terrains.** Pas une. Les cibles chiffrées (« sous 0,15 », « sous 0,10 ») sont des hypothèses de conception, pas des seuils calibrés par l'usage.

Ce que le terrain mesure réellement est autre chose, et c'est documenté ailleurs : des **compteurs de registres** — entrées de mises en production, tags de version, décisions numérotées ([chapitre 09](../core/09-release-gate-and-registry.md)) ; des **compteurs adversariaux** — findings bruts, confirmés, faux positifs écartés, passes sèches ([chapitre 07](../core/07-adversarial-review.md)) ; et des **mesures avant/après re-jouées dans les mêmes conditions** ([chapitre 08](../core/08-proof-and-probes.md)). Ces compteurs-là existent, sont datés, et ont été vérifiés par audit interne sur un corpus privé.

Alors pourquoi publier ce chapitre ? Parce que l'instrument reste cohérent avec la méthode — chaque métrique découle d'un principe que le terrain a éprouvé par d'autres moyens — et parce qu'un lecteur qui veut instrumenter sa propre pratique mérite un point de départ dessiné plutôt qu'une page blanche. Mais la règle de lecture est ferme : **tout ce qui suit est proposé, rien n'est éprouvé.** Si vous collectez ces métriques sur un terrain réel, vous serez en avance sur les auteurs.

---

## Les sept métriques proposées

### 1. Itérations par écran

La métrique phare de la conception. Mainstay dit qu'un prototype devrait émerger en une seule génération ; plus d'itérations signifie que le brief était vague.

```
iterations_per_screen = number_of_generation_passes / 1 screen
```

Comptez une *passe* comme une requête complète de génération ou de modification, pas les passes internes de structure/polish à l'intérieur d'une seule génération.

- **Collecter :** comptez les cycles de prompt rattachés à un identifiant d'écran dans les logs de votre runtime d'agent, ou les commits liés au contrat avant `status: frozen`.
- **Cible (hypothèse) :** 1, avec passes internes ; 2–3 acceptable sur des écrans véritablement inédits.
- **Mauvaise valeur (≥4) :** le contrat ou le design system était incomplet. La correction est en amont — rebalayez les zones grises avant le prochain écran.

### 2. Taux de zones grises

À quel point l'agent a dû décider de lui-même.

```
grey_zone_rate = grey_zones_found / observable_elements_scanned
```

- **Collecter :** depuis le registre de balayage rempli pour chaque écran ([chapitre 05](../core/05-grey-zones-and-divergence.md)).
- **Cible (hypothèse) :** sous 0,15.
- **Mauvaise valeur (>0,30) :** le contrat est sous-spécifié ; un taux élevé prédit des échecs d'intégration. Un taux *nul* signifie généralement que le balayage a été sauté.

### 3. Vélocité

Débit de la chaîne de livraison.

```
velocity = screens_reaching_definition_of_done / sprint
```

Ne comptez que les écrans qui ont passé la DoD complète par couche — « presque fait » n'existe pas.

- **Collecter :** comptez les contrats dont la checklist de DoD est entièrement cochée dans la période.
- **Cible (hypothèse) :** établissez une référence sur trois sprints, puis surveillez la tendance.
- **Mauvaise valeur (tendance déclinante) :** le vault s'appauvrit, ou les zones grises sont reportées. Croisez avec les métriques 2 et 4.

### 4. Dérive de contexte

À quelle distance l'agent a vagabondé du contrat pendant une session.

```
context_drift = edits_outside_contract_scope / total_edits
```

- **Collecter :** comparez le changeset de l'agent au périmètre énoncé ; un relecteur tague les morceaux hors périmètre.
- **Cible (hypothèse) :** sous 0,05.
- **Mauvaise valeur (>0,15) :** le prompt manquait d'un interdit de clôture, ou la session a tourné trop longtemps sans réancrage. Voir [Protocoles de défaillance](../core/11-failure-protocols.md).

### 5. Délai du contrat

Combien de temps un contrat met à passer de `draft` à `frozen`.

```
contract_lead_time = frozen_on - draft_created_on   (in working days)
```

- **Collecter :** depuis le frontmatter du contrat.
- **Cible (hypothèse) :** 1–3 jours ouvrés — assez long pour balayer et signer, assez court pour que le contrat ne pourrisse pas.
- **Mauvaise valeur (>10 jours) :** le contrat est coincé dans un désaccord, ou personne ne possède la signature. Un contrat à l'arrêt bloque toute la construction parallèle.

### 6. Ratio de reprise

Quelle part du travail livré a dû être refaite.

```
rework_ratio = edits_to_already-done_code / total_edits
```

- **Collecter :** attribuez les commits à un écran ; comptez ceux qui arrivent après la date de DoD.
- **Cible (hypothèse) :** sous 0,10.
- **Mauvaise valeur (>0,25) :** la DoD a été appliquée mollement, ou des zones grises ont fait surface après livraison — de la dette de cohérence payée tard, au pire prix.

### 7. Latence de signature

L'écart entre un contrat prêt à signer et l'arrivée des deux signatures.

```
signature_latency = max(signed_product_at, signed_engineering_at)
                    - contract_ready_for_review_at   (in working days)
```

- **Collecter :** depuis les horodatages de revue dans l'historique du contrat ou la PR.
- **Cible (hypothèse) :** sous 2 jours ouvrés.
- **Mauvaise valeur (>5 jours) :** la signature n'est pas encore un rituel. Sans les deux signatures on ne fige pas, et un contrat non figé n'est pas un contrat.

---

## Lire les métriques ensemble

Aucune métrique n'a de sens seule. Les paires qui diraient quelque chose :

| Si vous voyez... | ...lisez-le comme |
|---|---|
| Itérations élevées + taux de zones grises élevé | La phase de contrat est sous-investie. |
| Vélocité basse + délai du contrat long | La signature est le goulot, pas la construction. |
| Dérive de contexte élevée + reprise élevée | Les prompts manquent d'interdits de clôture ; les sessions tournent trop longtemps. |
| Taux de zones grises bas + reprise élevée | Les zones grises sont *manquées*, pas résolues — rebalayez plus fort. |
| Vélocité qui monte + reprise qui baisse | Le vault compose ; l'infrastructure devient plus intelligente. |

---

## Ce que le terrain compte à la place

En attendant qu'un terrain collecte ces ratios, la méthode ne vit pas sans chiffres — elle vit avec des chiffres d'une autre nature, tenus dans ses registres :

| Ce qui est compté | Où | Ce que ça mesure |
|---|---|---|
| Entrées de MEP, tags, go consignés — et leurs absences | Registre des MEP ([ch. 09](../core/09-release-gate-and-registry.md)) | La discipline de mise en production, violations incluses |
| Findings bruts → confirmés → écartés, par passe | Journaux de boucle ([ch. 07](../core/07-adversarial-review.md)) | La convergence réelle d'un lot — ou son gel honnête |
| Mesures avant/après re-jouées à conditions identiques | Dossiers de preuve ([ch. 08](../core/08-proof-and-probes.md)) | L'effet réel d'un correctif, pas son intention |
| Décisions numérotées, datées, supersedées | Le vault ([ch. 02](../core/02-vault-and-sources-of-truth.md)) | L'apprentissage conservé |

La différence de nature est instructive : les compteurs du terrain sont des **faits d'artefacts** — ils tombent des registres que la méthode impose de toute façon, sans instrumentation supplémentaire. Les sept métriques de ce chapitre exigent au contraire une collecte dédiée. C'est probablement la raison pour laquelle elles n'ont jamais été collectées — et la leçon vaut d'être retenue : une métrique qui demande un export manuel n'est pas regardée.

---

## Un concept de tableau de bord

Si vous instrumentez, le tableau tient dans une seule vue, rafraîchie par sprint. Valeurs **illustratives** :

```
MAINSTAY HEALTH — Sprint 14 (illustrative figures)

Metric                  Value     Target      Status
─────────────────────── ───────── ─────────── ────────
Iterations / screen     1.4       1–3         OK
Grey-zone rate          0.11      < 0.15      OK
Velocity                6 screens baseline    OK (+1)
Context drift           0.18      < 0.05      ALERT
Contract lead time      2.1 days  1–3 days    OK
Rework ratio            0.09      < 0.10      OK
Signature latency       1.3 days  < 2 days    OK
```

La plupart des données sont dérivables du monorepo lui-même — contrats, décisions et historique y vivent. Un script peut lire le frontmatter des contrats, les registres de zones grises et le `git log` filtré par écran, émettre un enregistrement JSON par écran, et agréger par sprint. Lancez-le en étape non bloquante de CI ([CI/CD et hooks](./cicd-and-hooks.md)) : les métriques calculées automatiquement sont regardées ; celles qui exigent un export manuel ne le sont pas.

---

## Voir aussi

- [Chapitre 05 — Zones grises et divergences](../core/05-grey-zones-and-divergence.md)
- [Chapitre 07 — La revue adversariale](../core/07-adversarial-review.md) — les compteurs que le terrain tient réellement
- [Chapitre 08 — La preuve et les sondes](../core/08-proof-and-probes.md)
- [Chapitre 09 — La gate de MEP et le registre](../core/09-release-gate-and-registry.md)
- [Référence — CI/CD et hooks](./cicd-and-hooks.md)
