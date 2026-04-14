# Release Pipeline

## Trigger

Push of a tag matching `v*` (e.g., `v0.4.0`).

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

## Published images

For each release `vX.Y.Z`, 6 tags are published:

| Tag | Contents |
|-----|----------|
| `X.Y.Z-remote` | Exact version, remote mode |
| `X.Y-remote` | Latest patch of minor, remote mode |
| `latest-remote` | Latest release, remote mode |
| `X.Y.Z-local` | Exact version, local mode (with AI models) |
| `X.Y-local` | Latest patch of minor, local mode |
| `latest-local` | Latest release, local mode |

## Registry

Images published to `ghcr.io` (GitHub Container Registry).
