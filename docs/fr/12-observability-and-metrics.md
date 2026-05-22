# Observabilité et métriques

*Une méthode que vous ne pouvez pas mesurer est une méthode que vous ne pouvez pas améliorer. Ce chapitre définit sept métriques de santé de Mainstay, chacune avec une formule, une méthode de collecte, une plage cible et une lecture de ce qu'une mauvaise valeur signifie.*

Mainstay avance une affirmation forte : le nombre d'itérations dont un agent a besoin est une mesure directe de la qualité du brief en amont. Cette affirmation ne tient que si vous mesurez. Ce chapitre transforme les principes de la méthode en chiffres que vous pouvez collecter depuis le monorepo et depuis votre runtime d'agent, et montre un concept de tableau de bord qui les réunit dans une seule vue.

Mesurez la **méthode**, pas le modèle. Chaque métrique ci-dessous répond à la question « l'infrastructure fait-elle son travail ? » — pas « le modèle est-il intelligent ? ».

---

## Les sept métriques

### 1. Itérations par écran

La métrique phare. Mainstay dit qu'un prototype devrait émerger en une seule génération ; plus d'itérations signifie que le brief était vague.

**Formule :**

```
iterations_per_screen = number_of_generation_passes / 1 screen
```

Comptez une *passe* comme une requête complète de génération ou de modification, pas les passes internes de structure/polish à l'intérieur d'une seule génération.

- **Collecter :** comptez les cycles de prompt rattachés à un identifiant d'écran (par ex. `saved-views-panel`) dans les logs de votre runtime d'agent, ou comptez les commits liés au contrat avant `status: frozen`.
- **Cible :** 1, avec génération multi-passes interne. Une valeur de 2–3 est acceptable sur des écrans véritablement inédits.
- **Mauvaise valeur (≥4) :** le contrat ou le design system était incomplet. La correction est en amont, pas dans l'agent — rebalayez les zones grises avant le prochain écran.

### 2. Taux de zones grises

À quel point l'agent a dû décider de lui-même.

**Formule :**

```
grey_zone_rate = grey_zones_found / observable_elements_scanned
```

Un *élément observable* est tout ce qu'un balayage de zones grises inspecte : un état, une interaction, une chaîne de copie, un état vide, un survol.

- **Collecter :** depuis l'artefact de balayage des zones grises rempli pour chaque écran (voir [Les zones grises](./07-grey-zones.md) et `examples/walkthrough/02-grey-zone-scan.md`).
- **Cible :** sous 0,15 — moins d'un élément sur sept laissé à la discrétion de l'agent.
- **Mauvaise valeur (>0,30) :** le contrat est sous-spécifié. Chaque zone grise est une décision prise dans l'ombre par quelqu'un sans autorité. Un taux élevé prédit des échecs d'intégration.

### 3. Vélocité

Débit de la chaîne de livraison.

**Formule :**

```
velocity = screens_reaching_definition_of_done / sprint
```

Ne comptez que les écrans qui ont passé la DoD complète par couche, pas les écrans « presque faits » — « presque fait » n'existe pas.

- **Collecter :** comptez les contrats dont la checklist `07-definition-of-done` est entièrement cochée dans la période.
- **Cible :** établissez une référence sur vos trois premiers sprints, puis surveillez la tendance, pas le chiffre absolu.
- **Mauvaise valeur (tendance déclinante) :** soit le vault s'appauvrit (les agents hésitent), soit les zones grises sont reportées (la dette s'accumule). Croisez la lecture avec les métriques 2 et 4.

### 4. Dérive de contexte

À quelle distance l'agent a vagabondé du contrat pendant une session.

**Formule :**

```
context_drift = edits_outside_contract_scope / total_edits
```

Une *édition hors périmètre du contrat* est tout changement que l'agent a fait et que le contrat ou le prompt ne demandait pas — sur-correction, « amélioration », fait de toucher du code non lié.

- **Collecter :** comparez le changeset de l'agent au périmètre énoncé par le contrat ; un relecteur ou un hook tague les morceaux hors périmètre.
- **Cible :** sous 0,05.
- **Mauvaise valeur (>0,15) :** le prompt manquait d'un interdit de clôture (« aucune autre modification que celle-ci »), ou la session a tourné trop longtemps sans réancrage. Voir le protocole de dérive dans [Protocoles de défaillance](./08-failure-protocols.md).

### 5. Délai du contrat

Combien de temps un contrat met à passer de `draft` à `frozen`.

**Formule :**

```
contract_lead_time = frozen_on - draft_created_on   (in working days)
```

- **Collecter :** depuis le frontmatter du contrat — la différence entre la date de création du `draft` et `frozen_on`.
- **Cible :** 1–3 jours ouvrés pour un écran typique. Assez long pour balayer les zones grises et obtenir deux signatures ; assez court pour que le contrat ne pourrisse pas.
- **Mauvaise valeur (>10 jours) :** le contrat est coincé dans un désaccord (souvent produit vs technique) ou personne ne possède la signature. Un contrat à l'arrêt bloque toute la construction parallèle.

### 6. Ratio de reprise

Quelle part du travail livré a dû être refaite.

**Formule :**

```
rework_ratio = edits_to_already-done_code / total_edits
```

Le *code déjà fait* est du code derrière un écran dont la DoD a été cochée.

- **Collecter :** attribuez les commits à un écran ; comptez les commits arrivant après la date de DoD de cet écran.
- **Cible :** sous 0,10.
- **Mauvaise valeur (>0,25) :** la definition of done a été appliquée mollement, ou des zones grises ont fait surface après la livraison. Une reprise élevée, c'est de la dette de cohérence payée tard, au pire prix.

### 7. Latence de signature

L'écart entre le moment où un contrat est prêt à signer et l'arrivée des deux signatures.

**Formule :**

```
signature_latency = max(signed_product_at, signed_engineering_at)
                    - contract_ready_for_review_at   (in working days)
```

- **Collecter :** depuis les horodatages de revue/signature dans l'historique du contrat ou l'enregistrement de la PR.
- **Cible :** sous 2 jours ouvrés.
- **Mauvaise valeur (>5 jours) :** la signature n'est pas encore un rituel — voir [Adoption par l'équipe](./15-team-adoption.md). Sans les deux signatures vous ne pouvez pas figer, et un contrat non figé n'est pas un contrat.

---

## Lire les métriques ensemble

Aucune métrique n'a de sens seule. Les paires qui racontent une histoire :

| Si vous voyez... | ...lisez-le comme |
|---|---|
| Itérations élevées + taux de zones grises élevé | La phase de contrat est sous-investie. |
| Vélocité basse + délai du contrat long | La signature est le goulot, pas la construction. |
| Dérive de contexte élevée + reprise élevée | Les prompts manquent d'interdits de clôture ; les sessions tournent trop longtemps. |
| Taux de zones grises bas + reprise élevée | Les zones grises sont *manquées*, pas résolues — rebalayez plus fort. |
| Vélocité qui monte + reprise qui baisse | Le vault compose ; l'infrastructure devient plus intelligente. |

La dernière ligne est l'état cible décrit à l'étape 6 de la chaîne de livraison : chaque cycle laisse l'infrastructure plus riche, de sorte que le prochain écran démarre d'un meilleur point.

---

## Un concept de tableau de bord

Un tableau de bord de santé Mainstay tient dans une seule table, rafraîchie par sprint. Voici une maquette avec des valeurs **illustratives**.

```
MAINSTAY HEALTH — Sprint 14 (illustrative figures)

Metric                  Value     Target      Status
─────────────────────── ───────── ─────────── ────────
Iterations / screen     1.4       1–3         OK
Grey-zone rate          0.11      < 0.15      OK
Velocity                6 screens baseline    OK (▲ +1)
Context drift           0.18      < 0.05      ALERT
Contract lead time      2.1 days  1–3 days    OK
Rework ratio            0.09      < 0.10      OK
Signature latency       1.3 days  < 2 days    OK

ACTION: context drift above target — audit recent prompts for
missing closing prohibitions; cap session length.
```

Le travail du tableau de bord est de rendre un mauvais chiffre impossible à ignorer. L'unique ALERT ci-dessus pointe l'équipe vers une cause précise et corrigeable.

---

## Une idée de script de collecte

Vous n'avez pas besoin d'une plateforme. La plupart des métriques sont dérivables du monorepo lui-même, parce que les contrats, les décisions et l'historique y vivent tous. Un petit script peut produire la forme de données que le tableau de bord consomme.

**Forme de données (un enregistrement JSON par écran) :**

```json
{
  "screen": "saved-views-panel",
  "iterations": 1,
  "observable_elements": 28,
  "grey_zones": 3,
  "draft_created_on": "2026-05-12",
  "frozen_on": "2026-05-14",
  "ready_for_review_on": "2026-05-13",
  "signed_product_at": "2026-05-14",
  "signed_engineering_at": "2026-05-14",
  "edits_total": 41,
  "edits_out_of_scope": 2,
  "edits_after_dod": 3,
  "dod_complete": true
}
```

**Idée de script (pseudocode) :**

```text
for each contract file in vault/contracts/:
    read frontmatter -> dates, status
    read linked grey-zone scan -> grey_zones, observable_elements
    query git log filtered by screen tag -> edit counts, timing
    emit one JSON record (shape above)
aggregate records per sprint -> compute the seven metrics
render the dashboard table
```

Lancez-le comme une étape de CI (voir [CI/CD et hooks](./14-cicd-and-hooks.md)) pour que le tableau de bord se rafraîchisse chaque fois que la branche principale bouge. Les métriques calculées automatiquement sont regardées ; celles qui exigent un export manuel ne le sont pas.

---

## Voir aussi

- [Les zones grises](./07-grey-zones.md)
- [La chaîne de livraison](./05-the-delivery-chain.md)
- [Tester et évaluer les agents](./13-testing-and-evaluating-agents.md)
- [CI/CD et hooks](./14-cicd-and-hooks.md)
