# Merge Policy

## Conditions de merge

1. **CI verte** — Tous les jobs passent (backend, frontend, e2e si applicable)
2. **Review approuvee** — Au moins 1 approbation
3. **Pas de conflits** — La branche est a jour avec la base
4. **Checklist PR completee** — Tous les items coches

## Strategie de merge

- **Squash merge** pour les feature branches -> `main`
- **Merge commit** pour les release branches -> `main` (preserve l'historique)
- **Rebase** pour les hotfix branches

## Branches protegees

| Branche | Regles |
|---------|--------|
| `main` | PR obligatoire, CI requise, review requise |
| `release/*` | PR obligatoire, CI requise + E2E full |
