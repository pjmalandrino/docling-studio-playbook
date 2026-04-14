# Rollback Process

## Quand utiliser

Incident post-deploy qui ne peut pas etre corrige rapidement par un hotfix.

## Etapes

### 1. Identifier la derniere version stable

```bash
git tag --list 'v*' --sort=-version:refname | head -5
```

### 2. Redeployer l'image Docker precedente

```bash
# Pull l'image de la version stable
docker pull ghcr.io/<org>/<repo>:X.Y.Z-<target>

# Redemarrer avec cette version
docker compose down
# Mettre a jour le tag dans docker-compose.yml ou .env
docker compose up -d
```

### 3. Valider le rollback

- Verifier les health endpoints
- Lancer les tests E2E @smoke
- Confirmer que le probleme est resolu

### 4. Post-mortem

- Documenter l'incident
- Creer un hotfix pour la version problematique
- Ne jamais re-tagger une version existante
