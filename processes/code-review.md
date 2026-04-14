# Code Review Checklist

## Avant de soumettre la PR

- [ ] Branch nommee correctement (`feature/`, `fix/`, `hotfix/`)
- [ ] Commits en Conventional Commits
- [ ] Tests ajoutes/mis a jour
- [ ] Tous les tests passent
- [ ] Linting passe (ruff / eslint)
- [ ] `CHANGELOG.md` mis a jour
- [ ] Documentation mise a jour si necessaire
- [ ] Aucun secret commite

## Points de revue

### Fonctionnel
- La feature fait ce qui est demande
- Les cas limites sont geres
- Le comportement est coherent avec le reste de l'app

### Technique
- Respect de la Clean Architecture (pas de fuite de couche)
- Pas de duplication de logique metier
- Les DTOs sont correctement separes des modeles domaine
- Les erreurs sont gerees proprement (pas de `pass` silencieux)

### Securite
- DOMPurify pour tout HTML dynamique (frontend)
- Validation des inputs au niveau API
- Pas de secrets en dur
- Les uploads sont valides (type, taille)

### Performance
- Pas de requete N+1
- Les operations lourdes sont async
- Le rate limiting est en place

## Template PR

Chaque PR utilise le template standardise avec :
- Type (Feature, Bug fix, Hotfix, Documentation, Refactoring, CI/CD)
- Resume en 1-3 phrases
- Issues liees
- Checklist de validation
- Screenshots/preuves si applicable
