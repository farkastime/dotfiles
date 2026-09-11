# Worktree Setup

Stable project knowledge, kept separate from `state.md` because that file is
rewritten constantly.

A fresh worktree contains only tracked files. Everything gitignored — `.env`,
virtualenvs, local config, credentials — is absent and must be put in place
before work begins. Every worker brief carries this file's contents verbatim.

---

## Files to copy from the main checkout

```
<e.g. .env>
<e.g. config/local.yaml>
```

## Commands to run in the fresh worktree

```bash
<e.g. uv sync>
<e.g. npm ci>
```

## Verify setup worked

```bash
<e.g. pytest -q tests/smoke>
```

## Test command

The full suite, run by the reviewer:

```bash
<e.g. pytest -q>
```

---

**A worker whose setup fails reports `failed` and stops.** It does not work
around a broken environment: work that cannot be tested is worse than no work,
because it looks finished.
