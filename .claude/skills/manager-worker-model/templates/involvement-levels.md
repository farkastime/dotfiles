# Involvement Levels

Two settings, asked once per project and written to the project's
`CLAUDE.md`. Never asked again unless the Product Owner asks to change them.

---

## Part 1 — Present this to the Product Owner

> Before we start, two questions about how involved you want to be. I'll
> record the answers in this project's `CLAUDE.md` and won't ask again.
>
> **1. Technical involvement** — which decisions come to you *before* the work,
> rather than being made by a worker and reported after?
>
> | Level | Name | You are consulted on |
> |---|---|---|
> | **0** | Autonomous | Nothing but true blockers — missing credentials, ambiguous requirements, destructive operations. Workers name things, pick schemas, and structure code as they judge best. You see the PR. |
> | **1** | Interfaces | What is hard to change later and visible from outside: public API shapes, CLI flags, database schemas, file formats, new dependencies. Internal structure and naming stay with the worker. |
> | **2** | Architecture | Level 1, plus how things are organized — module boundaries, which file something lives in, what abstraction gets introduced. Asked before implementation. |
> | **3** | Conventions | Level 2, plus naming and patterns — what things are called, which existing pattern is followed, error handling and logging style. |
> | **4** | Full review | Level 3, plus the implementation approach for each task, reviewed before code is written. Slow by design. |
>
> Level 1 is a good default for most real work. Level 0 suits prototypes.
>
> **2. Testing involvement** — a Test Engineer writes the test plan for every
> PR before any code is written. Do you want to approve it first?
>
> | Value | Behavior |
> |---|---|
> | **review** | The plan is presented to you, and no worker starts until you approve it. |
> | **autonomous** | The plan is written and work proceeds. You can still read it in the PR. |

---

## Part 2 — Write this block into the project's `CLAUDE.md`

```markdown
## Manager/Worker Model

**Involvement level:** <N> — <name>
<one line on what that means for this project>

**Testing involvement:** review | autonomous

**Required skills**
- Reviewers: `superpowers:verification-before-completion`

Set <YYYY-MM-DD>. Change by telling the Engineering Manager.
```

---

## Rules that hold at every level

**Formatting and syntax are never escalated.** The project's formatter and
linter decide. There is no level at which the Product Owner is asked about
indentation or quote style.

**The level is a default, not a ceiling.** A worker that hits something
genuinely consequential escalates regardless — level 0 does not mean silently
picking the wrong database. Judgment may always escalate upward, never
downward.

**Test-driven development is unconditional.** The Test Engineer is dispatched
for every trunk at both testing-involvement values. The setting controls only
whether the Product Owner approves the plan before work starts.

**Workers get no TDD skill by default.** They implement against tests the Test
Engineer wrote. A per-worker "use TDD" instruction would invite exactly the
self-authored tests the Test Engineer exists to replace.
