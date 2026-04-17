---
description: Deeply understand the current branch's changes vs a base branch
argument-hint: <base-branch>
allowed-tools: Bash(git diff:*), Bash(git log:*), Bash(git merge-base:*), Bash(git rev-parse:*), Bash(git status:*), Bash(gh repo view:*), Read, Grep, Glob
---

The user wants you to build a deep understanding of the changes on the current branch relative to the base branch `$1`. Treat this as a research task — your goal is to absorb enough context that you could explain, extend, or review the changes confidently.

If `$1` is empty, detect the default branch by running `gh repo view --json defaultBranch --jq '.defaultBranch'` and use that as the base branch. If detection fails, ask the user.

## Steps

1. Verify `$1` exists as a ref (`git rev-parse --verify $1`). If it doesn't, stop and tell the user.
2. Get the diverge point and scope:
   - `git merge-base $1 HEAD` — where the branch forked
   - `git log --oneline $1..HEAD` — commits on this branch
   - `git diff --stat $1...HEAD` — files touched and size
3. Read the full diff: `git diff $1...HEAD` (use `...` three-dot to diff against the merge-base, not the tip of `$1`).
4. For each meaningful change, go beyond the diff:
   - Read the full changed file so you see the surrounding code, not just the hunk.
   - Trace callers and callees of modified functions/classes (Grep for usages).
   - Read sibling files, tests, and configs that establish the pattern the change follows or breaks.
   - Note any public API, schema, or contract that changed and who depends on it.
5. Build a mental model of:
   - **What the changes do** — behavior, not just code motion.
   - **Why they likely exist** — infer intent from commit messages, new tests, and renamed symbols.
   - **How they fit the architecture** — which layers/modules are involved, what conventions are followed.
   - **Risks and gaps** — untested paths, broken invariants, missing migrations, TODOs.

## Output

Give the user a concise briefing (not a file dump):

- **Summary** — 2–4 sentences on what this branch does.
- **Key changes** — bulleted, grouped by concern (not by file). Reference files as `path:line`.
- **Architectural context** — anything you had to learn from outside the diff to make sense of it.
- **Open questions / risks** — things worth flagging before shipping.

Keep it tight. The user already knows the code exists — they want your synthesis.
