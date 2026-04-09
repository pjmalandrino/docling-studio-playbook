# 01 — Foundation

The files every open-source repo needs on day one.

## What's here

| Template | Purpose | Copy to |
|----------|---------|---------|
| [readme-template.md](readme-template.md) | Project README with all standard sections | `README.md` |
| [contributing-template.md](contributing-template.md) | Contributor guide | `CONTRIBUTING.md` |
| [code-of-conduct-template.md](code-of-conduct-template.md) | Community standards | `CODE_OF_CONDUCT.md` |
| [security-template.md](security-template.md) | Vulnerability reporting policy | `SECURITY.md` |
| [changelog-template.md](changelog-template.md) | Release notes format | `CHANGELOG.md` |
| [license-guide.md](license-guide.md) | How to choose the right license | *(reference only)* |
| [github-templates/](github-templates/) | Issue and PR templates | `.github/` |

## How to use

```bash
# Copy everything at once
cp 01-foundation/readme-template.md my-project/README.md
cp 01-foundation/contributing-template.md my-project/CONTRIBUTING.md
cp 01-foundation/security-template.md my-project/SECURITY.md
cp 01-foundation/changelog-template.md my-project/CHANGELOG.md
cp 01-foundation/code-of-conduct-template.md my-project/CODE_OF_CONDUCT.md
cp -r 01-foundation/github-templates/ my-project/.github/ISSUE_TEMPLATE/

# Then search for <!-- REPLACE --> markers and fill them in
grep -rn "REPLACE" my-project/*.md
```
