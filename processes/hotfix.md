# Hotfix Process

## Quand utiliser

Bug critique en production necessitant un patch immediat, sans attendre le cycle de release normal.

## Etapes

### 1. Creer la branche hotfix depuis le tag

```bash
git checkout vX.Y.Z
git checkout -b hotfix/X.Y.Z+1
```

### 2. Corriger et commiter

```bash
# Appliquer le fix
git commit -m "fix(scope): description du fix critique"
```

### 3. PR vers main

- La CI valide le fix
- Review acceleree (1 approbation minimum)

### 4. Tag apres merge

```bash
git checkout main && git pull
git tag vX.Y.Z+1
git push origin vX.Y.Z+1
```

Le tag declenche automatiquement le build et push Docker.

## Points d'attention

- Un hotfix ne contient **que** le fix, rien d'autre
- Mettre a jour le `CHANGELOG.md` avec la section hotfix
- Verifier que les E2E passent avant de tagger
