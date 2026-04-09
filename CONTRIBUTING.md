# Contributing

Thanks for your interest in the oss-playbook! Here's how you can help.

## Ways to contribute

### New templates or guides

The most impactful contribution. Each section (`01-foundation` through `07-operations`) can be extended with new templates.

1. Identify a gap (check existing files first)
2. Write the template following the conventions below
3. Add a reference in the section's `README.md`
4. Open a PR

### New stack profiles

Create a new profile under `profiles/<stack>/`:

1. Copy an existing profile: `cp -r profiles/fastapi-vue profiles/your-stack`
2. Edit `profile.md` with your stack's paths, tools, and imports
3. Edit `commands.sh` with verification commands for all 12 audits
4. Test the commands against a real project
5. Open a PR

### Improvements

- Better wording, clearer checklists, additional checklist items
- Translations (keep the English version as source of truth)
- Real-world examples (anonymized)

## Conventions

### File naming

| Type | Convention | Example |
|------|-----------|---------|
| Templates (fill-in) | `*-template.md` | `bug-report-template.md` |
| Guides (reference) | descriptive name | `license-guide.md` |
| Processes | descriptive name | `release-process.md` |
| Checklists | `*-checklist.md` | `code-review-checklist.md` |
| Playbooks | `*-playbook.md` | `rollback-playbook.md` |

### Template markers

Use `<!-- REPLACE: description -->` for fields the user must fill in. Use `<!-- REPLACE -->` only when the context is obvious.

### Audit checklist items

Every item in a release audit checklist must have:

| Column | Required | Description |
|--------|----------|-------------|
| `#` | Yes | Hierarchical ID (e.g. `4.1.1`) |
| `Item` | Yes | What to check — one sentence, actionable |
| `Weight` | Yes | `1` (minor), `2` (major), or `3` (critical) |

### Commit messages

Use imperative mood, present tense:

```
add incident response playbook
fix scoring formula in audit 09
improve onboarding guide with setup steps
```

## Pull request process

1. Fork the repo and create your branch from `main`
2. Follow the conventions above
3. Fill in the PR template
4. One approval from the maintainer is required to merge

## Questions?

Open an issue — there are no stupid questions.
