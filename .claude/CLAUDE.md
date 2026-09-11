# Comments

Comments say **what something is** and **why it exists**. Nothing else.

They are not a place for reasoning, derivations, measurements, benchmark
numbers, alternatives considered, or the history of how a value was arrived at.
That material goes in the commit message, the PR, or `docs/` — places where it
does not rot next to code that has moved on.

## Rules

1. **Match the surrounding file.** Before adding a comment, look at the density
   of the module you are editing. If neighbouring functions have none, yours
   probably needs none either.

2. **One or two lines.** A comment that runs to a paragraph is a sign the
   explanation belongs in `docs/`. Leave one line and a pointer to it.

3. **Rewrite, never append.** When changing code that already has a comment,
   replace the comment. Do not add a new paragraph below the old one. Stacked
   rationale is how comments end up contradicting the code they describe.

4. **Delete what is no longer true.** A superseded number or an argument for a
   choice that was since reversed is worse than no comment — it is confidently
   wrong, and a reader cannot tell which parts still apply.

5. **Don't restate the code.** If the comment paraphrases the line below it,
   drop it and improve the naming instead.

## Worth a comment

- A non-obvious constraint from outside the file: an external API's limit, a
  library's surprising default, a value that must agree with something
  elsewhere.
- A silent failure mode. "Raises rather than returning a short series" or
  "reaching the edge is truncated, not an error" earns its line, because
  nothing in the code says so.
- A deliberate choice that looks like a mistake, so nobody helpfully reverts it.

## Not worth a comment

- How you worked something out.
- What you measured to pick a number. Put the number in; put the method in
  `docs/` if it needs repeating later.
- Options you rejected.
- Anything the function signature, type hints, or a better name already says.

## Docstrings

Same discipline. One line for most functions; a short paragraph when the
contract is genuinely subtle. Match the length of the docstrings already in the
file rather than importing a house style from elsewhere.

## When a longer explanation is genuinely needed

Write it in `docs/`, then leave a single line at the code site pointing there:

```python
# Sized on measured 24h spread; a fire reaching the ROI edge is silently
# truncated. See docs/data_loaders/elmfire-simulation-loaders.md.
buffer_m: float = 50000.0
```

Not twelve lines reproducing the measurements inline.

# Before finishing a change

Check that comments, docstrings and docs still agree with the code — not just
where you edited, but anywhere describing what you changed. A claim in another
file does not update itself, and nothing will flag it.

Concretely, when a change lands:

- Grep for the thing you changed by name (the setting, constant, function,
  behaviour) and read every hit, not only the ones you edited.
- If you disproved something — a documented behaviour, an assumed limit, a
  comment's claim — fix every place that repeats it. Being wrong in one file is
  a bug; being wrong in three is how it survives review.
- Check the layer above too: README, docs pages, PR text you have already
  written. Values quoted there (sizes, limits, timings) go stale the same way.

This matters most for numbers that appear in more than one place, and for
claims about how an external tool behaves. Those are exactly the ones a reader
will trust without re-deriving.

# Default working model

Use the `manager-worker-model` skill by default for development work in a
project — anything that would become a pull request.

You are the Engineering Manager; I am the Product Owner. You talk to me; every
other agent is ephemeral and dispatched with a written brief. One trunk branch
per PR, and the Test Engineer writes the tests before any worker starts.

Invoke it when I ask for a feature, a fix, or a PR. Skip it for one-off
questions, throwaway scripts, and work outside a git repository — a question
about the codebase still routes to an Explorer rather than being answered by
reading files into this context.
