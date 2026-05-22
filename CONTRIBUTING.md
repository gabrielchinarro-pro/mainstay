# Contributing to Mainstay

Thank you for considering a contribution. Mainstay is a method, kept as a
public reference. It improves through correction, sharpening, translation, and
new worked examples — and through disagreement aired in the open.

**English** · [Français](#contribuer-à-mainstay-français)

---

## Ways to contribute

- **Corrections** — a wrong claim, a broken link, a code example that does not run.
- **Sharpening** — a chapter that could be clearer, shorter, or more concrete.
- **Translations** — keeping `docs/fr/` in sync with `docs/en/`, or proposing a new language.
- **Examples** — new walkthroughs, skills, hooks, or tools that demonstrate the method.
- **Disagreement** — a reasoned case against a rule. Open an issue; the method expects to be challenged.

## Ground rules

Mainstay practises what it documents. Contributions follow the same discipline.

1. **English is the reference language.** `README.md` and `docs/en/` are
   canonical. Changes to meaning land in English first, then propagate to
   `docs/fr/`. A PR that changes one language without the other is incomplete.
2. **The source of truth wins.** If a change to one chapter contradicts another,
   reconcile both in the same PR. Never leave two truths to coexist.
3. **No real data.** No company, product, partner, or personal names. No
   secrets, tokens, credentials, or internal URLs. Every example is generic or
   fictional. Use placeholders such as `https://api.example.com` and
   `<API_TOKEN>`. The method stays domain-agnostic.
4. **Code must run.** Every code example is minimal, readable, and functional —
   not pseudo-code. Shell scripts must pass `bash -n`. Keep examples small.
5. **Cross-links stay valid.** Internal links are relative and must resolve.
6. **No filler.** Every paragraph teaches something. If a sentence does not
   change what the reader knows or does, cut it.

## Making a change

```bash
# 1. Fork and clone, then create a branch
git checkout -b fix/clearer-grey-zones

# 2. Make your change. If it touches docs/en/, mirror it in docs/fr/.

# 3. Check shell scripts and links before opening a PR
find . -name '*.sh' -exec bash -n {} \;

# 4. Open a pull request using the template
```

### Commit messages

Use short, imperative subjects: `Clarify the grey-zone re-scan rule`,
`Fix broken link in chapter 05`. One logical change per commit where practical.

### Pull requests

Fill in the PR template. State what changed, why, and whether both language
trees were updated. Small, focused PRs are reviewed faster than large ones.

## Style

- Declarative, confident, concrete. Short sentences. Present tense.
- Second person ("you") for instructions.
- British spelling **"grey"** for *grey zones* (a coined term here); American
  spelling elsewhere.
- Tag every code block with a language. Prefer tables and Mermaid diagrams
  where structure helps.
- Terminology is fixed — see [docs/en/17-glossary.md](docs/en/17-glossary.md).
  Do not introduce a synonym for a defined term.

## Reporting issues

Use the issue templates. For a bug in an example, include the file, the command
you ran, and the output. For a documentation issue, link the exact chapter and
section.

## License

By contributing, you agree that your contributions are licensed under the
[MIT License](LICENSE).

---

<a name="contribuer-à-mainstay-français"></a>

# Contribuer à Mainstay (Français)

Merci d'envisager une contribution. Mainstay est une méthode, tenue comme une
référence publique. Elle progresse par la correction, l'affinage, la traduction
et de nouveaux exemples concrets — et par le désaccord exprimé ouvertement.

## Comment contribuer

- **Corrections** — une affirmation fausse, un lien cassé, un exemple de code qui ne tourne pas.
- **Affinage** — un chapitre qui gagnerait à être plus clair, plus court, plus concret.
- **Traductions** — garder `docs/fr/` synchronisé avec `docs/en/`, ou proposer une nouvelle langue.
- **Exemples** — nouveaux fils rouges, skills, hooks ou outils qui illustrent la méthode.
- **Désaccord** — un argument raisonné contre une règle. Ouvrez une issue ; la méthode attend d'être contredite.

## Règles de fond

1. **L'anglais est la langue de référence.** `README.md` et `docs/en/` font foi.
   Toute évolution de sens passe d'abord par l'anglais, puis se répercute dans
   `docs/fr/`. Une PR qui ne touche qu'une seule langue est incomplète.
2. **La source supérieure gagne.** Si un changement crée une contradiction entre
   chapitres, réconciliez les deux dans la même PR. Jamais deux vérités côte à côte.
3. **Aucune donnée réelle.** Aucun nom d'entreprise, de produit, de partenaire
   ou de personne. Aucun secret, jeton, identifiant ou URL interne. Tout exemple
   est générique ou fictif. La méthode reste agnostique du domaine.
4. **Le code doit tourner.** Tout exemple est minimal, lisible et fonctionnel.
   Les scripts shell passent `bash -n`.
5. **Les liens internes restent valides.** Liens relatifs, qui résolvent.
6. **Pas de remplissage.** Chaque paragraphe enseigne quelque chose.

## License

En contribuant, vous acceptez que vos contributions soient publiées sous
[licence MIT](LICENSE).
