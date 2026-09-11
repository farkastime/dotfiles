# Manager/Worker State

Active work only. A trunk's entry is deleted when its PR merges or is
abandoned; its decisions move to `decisions.md`.

**Intent lives here; git holds truth.** Where they disagree — a branch that
does not exist, a PR already merged — git wins and this file is corrected.

---

## Trunks

### <trunk-branch-name> — PR #<n>

**Why:** <one paragraph: why this trunk exists, why it is scoped this way,
what the Product Owner said when it was agreed>

**Spec:** `.claude/mwm/specs/<trunk>.md` (record: PR body `## Spec`)
**Shape:** A — parallel, declared ownership | B — chained
**Stage:** spec | grounding | briefs | test-plan | awaiting-approval | in-progress | in-review | ready | blocked

| Worker | Task | Owns | Status |
|---|---|---|---|
| <name> | <one line> | <paths> | dispatched / ready / blocked / failed |

**Blocked on PO:** <the question, or none>

---

## Counters

Incremented after every dispatch, every report, and every PR transition.
Numbers derivable from `git` or `gh` are never stored here — they are queried
when asked.

- Agents dispatched — worker: 0, reviewer: 0, test-engineer: 0, respondent: 0, explorer: 0, teacher: 0
- Workers blocked — hard blocker: 0
- Workers blocked — escalated decision: 0
- Questions routed to PO: 0
- Review rounds: 0
- Conflicts resolved: 0
- Fix-workers dispatched: 0
- Test plans revised after PO review: 0
- Assigned tests reported wrong by a worker: 0
- Review comments — change requests: 0, proposals: 0

Escalation counts are worth reading occasionally: constant escalation means
the involvement level is set too high for this work, and none at all over a
long project may mean it is set too low. A test plan repeatedly revised means
the spec was not good enough — a fact about the manager's work, not the Test
Engineer's.
