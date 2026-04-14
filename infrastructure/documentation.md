# Documentation (MkDocs)

## Stack

- **MkDocs** with **Material** theme
- Deployed on **GitHub Pages** via GitHub Actions (`docs.yml`)

## Structure

```
docs/
  index.md                  # Home page
  getting-started.md        # Getting started guide
  architecture.md           # Architecture overview
  PROCESSES.md              # Process index (19 processes)
  CONTRIBUTING.md           # Contribution guide
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
    # 12+ quality audit axes
```

## Navigation (mkdocs.yml)

The site is organized into sections:
1. Home
2. Getting Started
3. Architecture
4. Contributing
5. Development (Coding Standards, Commits, Reviews, Merge, ADR)
6. Release (Deployment, Rollback)
7. Operations (Incident, Security, Monitoring)
8. Community (Onboarding, Issue Triage, Roadmap)
9. Audit (12 quality axes)

## Deployment

The `docs.yml` workflow automatically builds and deploys on push to `main`.

```bash
# Local preview
mkdocs serve

# Build
mkdocs build
```
