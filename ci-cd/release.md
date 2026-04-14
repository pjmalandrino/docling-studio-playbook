# Release Pipeline

## Declencheur

Push d'un tag matchant `v*` (ex: `v0.4.0`).

## Jobs

### Docker Build & Push

```yaml
strategy:
  matrix:
    target: [remote, local]

steps:
  - Checkout
  - Setup QEMU (multi-arch)
  - Setup Docker Buildx
  - Login ghcr.io
  - Docker metadata:
    - Tags: X.Y.Z-{target}, X.Y-{target}, latest-{target}
  - Build & push:
    - Platforms: linux/amd64, linux/arm64
    - Target: ${{ matrix.target }}
    - Cache: GitHub Actions cache
```

## Images produites

Pour chaque release `vX.Y.Z`, 6 tags sont publies :

| Tag | Contenu |
|-----|---------|
| `X.Y.Z-remote` | Version exacte, mode remote |
| `X.Y-remote` | Derniere patch du minor, mode remote |
| `latest-remote` | Derniere release, mode remote |
| `X.Y.Z-local` | Version exacte, mode local (avec modeles IA) |
| `X.Y-local` | Derniere patch du minor, mode local |
| `latest-local` | Derniere release, mode local |

## Registry

Images publiees sur `ghcr.io` (GitHub Container Registry).
