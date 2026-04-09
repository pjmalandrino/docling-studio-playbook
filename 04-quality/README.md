# 04 — Quality

Everything related to verifying and maintaining code quality.

## What's here

| Resource | Purpose |
|----------|---------|
| [release-audit/](release-audit/) | 12-checklist release audit framework with weighted scoring |
| [test-strategy-template.md](test-strategy-template.md) | Define your testing approach |
| [bug-report-template.md](bug-report-template.md) | Structured bug report for internal tracking |
| [e2e-status-template.md](e2e-status-template.md) | End-to-end test execution status report |
| [executive-summary-template.md](executive-summary-template.md) | High-level quality summary for stakeholders |

## Release audit quick start

The release audit is the centerpiece of this section. Run it on a release branch before merging to main.

```
# Full audit with AI assistant
Audit the current release branch following 04-quality/release-audit/master.md
using the profile profiles/<your-stack>/profile.md
```

See [release-audit/master.md](release-audit/master.md) for the full orchestrator documentation, or check [examples/sample-audit-report.md](../examples/sample-audit-report.md) for a filled-in example.
