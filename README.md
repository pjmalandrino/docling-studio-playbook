# oss-playbook

**Everything between `git init` and `v1.0.0`, in Markdown.**

A complete collection of ready-to-use Markdown templates and process guides for solo open-source maintainers. Copy what you need, adapt it to your stack, ship with confidence.

---

## Highlight: Release Audit Framework

The centerpiece of this playbook. A structured quality gate you run on a release branch before merging to main.

**12 audits. Weighted scoring. GO / NO-GO verdicts.**

```
Audit the current release branch following 04-quality/release-audit/master.md
using the profile profiles/fastapi-vue/profile.md
```

| # | Audit | Focus |
|---|-------|-------|
| 01 | [Clean Architecture](04-quality/release-audit/audits/01-clean-architecture.md) | Layer boundaries, dependency flow |
| 02 | [DDD](04-quality/release-audit/audits/02-ddd.md) | Bounded contexts, entities, ubiquitous language |
| 03 | [Clean Code](04-quality/release-audit/audits/03-clean-code.md) | Naming, function size, readability |
| 04 | [KISS](04-quality/release-audit/audits/04-kiss.md) | Simplicity, no over-engineering |
| 05 | [DRY](04-quality/release-audit/audits/05-dry.md) | Duplication, factorization |
| 06 | [SOLID](04-quality/release-audit/audits/06-solid.md) | 5 SOLID principles |
| 07 | [Decoupling](04-quality/release-audit/audits/07-decoupling.md) | Front/back separation, contracts |
| 08 | [Security](04-quality/release-audit/audits/08-security.md) | OWASP basics, secrets, injection, CORS |
| 09 | [Tests](04-quality/release-audit/audits/09-tests.md) | Coverage, quality, e2e |
| 10 | [CI / Build](04-quality/release-audit/audits/10-ci-build.md) | Pipeline, containers, health checks |
| 11 | [Documentation](04-quality/release-audit/audits/11-documentation.md) | Changelog, versioning, dead code |
| 12 | [Performance](04-quality/release-audit/audits/12-performance.md) | N+1, memory leaks, async, resources |

Each checklist item has a **weight** (1–3). Score = passing weight / total weight x 100.

| Score | Verdict |
|-------|---------|
| >= 80 | **GO** — release approved |
| 60–79 | **GO CONDITIONAL** — 0 CRIT, remediation plan for MAJ |
| < 60 | **NO-GO** — fix and re-audit |

Any unresolved `[CRIT]` = **NO-GO** regardless of score.

Stack profiles with ready-to-run shell commands are included for **FastAPI + Vue**, **Django + React**, and **Spring Boot + Angular**. See a [full example report](examples/sample-audit-report.md).

---

## The full playbook

The release audit is one of 7 sections. Here's the complete toolkit:

```
01-foundation/          Project bootstrap — README, CONTRIBUTING, LICENSE, SECURITY, GitHub templates
02-architecture/        Architecture Decision Records, coding standards, tech stack profiles
03-git-workflow/        Branching strategy, commit conventions, code review, merge policy
04-quality/             Release audits (12 checklists), test strategy, bug reports
05-release/             Release process, versioning, deployment checklist, rollback playbook
06-community/           Onboarding, governance, issue triage, roadmap, communication
07-operations/          Incident response, security response, monitoring

profiles/               Stack-specific configurations (FastAPI, Django, Spring Boot...)
examples/               Filled-in examples so you can see what the output looks like
```

### Quick map

| I need to... | Go to |
|--------------|-------|
| Bootstrap a new project with all the right files | [01-foundation](01-foundation/) |
| Record an architecture decision | [02-architecture](02-architecture/) |
| Set up a git workflow and review process | [03-git-workflow](03-git-workflow/) |
| Audit a release branch before shipping | [04-quality/release-audit](04-quality/release-audit/) |
| Define my test strategy | [04-quality](04-quality/) |
| Ship a release with confidence | [05-release](05-release/) |
| Onboard my first contributor | [06-community](06-community/) |
| Handle a security incident | [07-operations](07-operations/) |

---

## How to use

### Option 1 — Fork and trim

```bash
git clone git@github.com:pjmalandrino/oss-playbook.git
cp -r oss-playbook/01-foundation/ my-project/docs/
# Pick the sections you need, delete the rest
```

### Option 2 — Cherry-pick templates

Browse the sections, copy individual `.md` files into your project, and fill in the blanks. Every template has clear `<!-- REPLACE -->` markers.

### Option 3 — Use with an AI assistant

Point Claude Code, Cursor, or any AI coding tool at a template:

```
Follow the release process defined in docs/05-release/release-process.md
to ship version 2.1.0
```

---

## Why this exists

Starting an OSS project is easy. *Running* one is not. Beyond the code, you need:

- A clear architecture decision trail
- A git workflow that scales from solo to team
- Code review standards that don't live only in your head
- A release process that catches regressions before users do
- Community guidelines that attract contributors and repel chaos
- An incident playbook for when things go wrong in production

Most maintainers build these docs ad hoc, scattered across wikis, Notion pages, and tribal knowledge. This repo puts them all in one place — structured, templatized, and ready to fork.

---

## Contributing

PRs welcome — see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

You can contribute:

- **New stack profiles** (Rails, NestJS, Go+HTMX, etc.)
- **New templates** for uncovered processes
- **Improvements** to existing checklists and guides
- **Translations** (the playbook is in English, but sections can be translated)
- **Real-world examples** (anonymized)

---

## License

MIT — use it however you want.
