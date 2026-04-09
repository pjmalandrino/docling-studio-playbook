# Choosing a License

A quick guide to picking the right open-source license for your project.

> **Not legal advice.** When in doubt, consult a lawyer. For most projects, the decision is simpler than it seems.

## Decision tree

```
Do you want to allow proprietary use?
├── Yes
│   ├── Do you want contributions back under the same license?
│   │   ├── Yes → Apache 2.0
│   │   └── No  → MIT or BSD-2-Clause
│   └── Are patents a concern?
│       ├── Yes → Apache 2.0
│       └── No  → MIT
└── No (copyleft — derivatives must stay open)
    ├── Library/framework?  → LGPL-3.0
    └── Application/tool?   → GPL-3.0 or AGPL-3.0 (if SaaS)
```

## Common licenses at a glance

| License | Permissive? | Patent grant | Copyleft | Good for |
|---------|-------------|-------------|----------|----------|
| **MIT** | Yes | No | No | Simple projects, maximum adoption |
| **Apache 2.0** | Yes | Yes | No | Projects where patent protection matters |
| **GPL-3.0** | No | Yes | Strong | Projects that must stay open |
| **AGPL-3.0** | No | Yes | Network | SaaS — closes the "server loophole" |
| **LGPL-3.0** | Partial | Yes | Weak | Libraries used by proprietary software |
| **BSD-2-Clause** | Yes | No | No | Similar to MIT, slightly different wording |

## How to apply

1. Pick your license from [choosealicense.com](https://choosealicense.com/)
2. Copy the full text into a `LICENSE` file at the repo root
3. Replace `[year]` and `[fullname]` placeholders
4. Reference the license in your `README.md`

## When you have dependencies

Your license must be **compatible** with your dependencies' licenses. A GPL dependency means your project must also be GPL (or more restrictive). MIT and Apache dependencies are compatible with everything.

## Solo maintainer recommendation

**MIT** — maximum simplicity, maximum adoption, zero friction. Switch to Apache 2.0 if you're in a patent-heavy domain (hardware, ML models, protocols).
