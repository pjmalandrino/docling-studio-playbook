# Documentation (MkDocs)

## Stack

- **MkDocs** avec theme **Material**
- Deploye sur **GitHub Pages** via GitHub Actions (`docs.yml`)

## Structure

```
docs/
  index.md                  # Page d'accueil
  getting-started.md        # Guide de demarrage
  architecture.md           # Vue d'ensemble architecture
  PROCESSES.md              # Index des 19 processus
  CONTRIBUTING.md           # Guide de contribution
  git-workflow/
    commit-conventions.md
    code-review-checklist.md
    merge-policy.md
  architecture/
    coding-standards.md
    adr-guide.md
    adr-template.md
  release/
    deployment-checklist.md
    rollback-playbook.md
  operations/
    incident-response.md
    security-response.md
    monitoring-checklist.md
  community/
    onboarding.md
    issue-triage.md
    roadmap-template.md
  audit/
    # 12+ axes d'audit qualite
```

## Navigation (mkdocs.yml)

Le site est organise en sections :
1. Home
2. Getting Started
3. Architecture
4. Contributing
5. Development (Coding Standards, Commits, Reviews, Merge, ADR)
6. Release (Deployment, Rollback)
7. Operations (Incident, Security, Monitoring)
8. Community (Onboarding, Issue Triage, Roadmap)
9. Audit (12 axes de qualite)

## Deployment

Le workflow `docs.yml` build et deploie automatiquement sur push vers `main`.

```bash
# Local preview
mkdocs serve

# Build
mkdocs build
```
