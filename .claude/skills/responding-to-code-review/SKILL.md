---
name: responding-to-code-review
description: Use when a reviewer has left comments on a pull request and you are preparing responses, including when the volume is large, when the reviewer is in a hurry, or when comments mix questions with suggestions
---

# Responding to Code Review

## Overview

A review is a conversation the reviewer owns. Your job is to answer everything,
change nothing they did not ask for, and leave the record in their hands.

**The reviewer decides when a thread is finished. You never do.**

## The Four Rules

1. **Change code only when explicitly asked.** A question is not a request.
2. **Write one grouped response document**, split into substantive and
   educational.
3. **Reply to every comment briefly**, pointing into that document.
4. **Never resolve a thread.** Not one. Not ever.

## Rule 4 Has No Exceptions

This is the rule agents break while sounding reasonable. Both baseline tests
invented the same principled-sounding exception — *"resolve when no judgment
remains"* — and resolved threads anyway.

**Do not resolve a thread even when:**

- It was a typo and there is "nothing left to discuss"
- You made exactly the change requested
- The reviewer is busy and you are "reducing their queue"
- The thread is "purely informational"
- You are "just tidying up"
- The reviewer said "get through these quickly"

A resolved thread tells the reviewer *they already looked at this*. If you
resolve it, they will not look. That is the whole cost, and it does not shrink
because the change was small.

**Reducing the reviewer's queue is not your job. Answering is.**

## What Counts As "Explicitly Asked"

| Reviewer wrote | Change code? |
| --- | --- |
| "Change X to Y" / "Remove this" / "Rename to Z" | Yes |
| "This is wrong — it should be Y" | Yes |
| "Shouldn't this be configurable?" | **No — propose it** |
| "Wouldn't a dataclass be simpler?" | **No — propose it** |
| "I wonder if this belongs elsewhere" | **No — propose it** |
| "Should we also handle X?" | **No — propose it** |
| "What does this do?" | No |
| "Remind me how X works" | No |

A question mark means propose. Grammatical questions that are functionally
suggestions still get proposed, not applied — the reviewer is mid-review, and
a diff that shifts under them costs more than a round trip.

**Propose** means: state your recommendation and reasoning in the document,
list it under proposed changes, and change nothing until they answer.

## Never Expand Scope

Answer what was asked. Do not:

- Write a new doc because several questions were about tooling
- Fix unrelated things you noticed while in the file
- Refactor adjacent code
- Add tests beyond the case named

Baseline testing produced exactly this failure: six "what does this do?"
comments became a proposal to write and commit a new documentation file. The
reviewer asked what a flag did. Answer that.

If unrequested work seems genuinely worth doing, put it in the document as a
suggestion for a follow-up. Do not do it.

## Verify Before You Disagree

When you think the reviewer is wrong, **check before saying so**. Run the code,
read the docs, test the claim.

Then say what you found, plainly, with the evidence. Never accept a wrong
premise to be agreeable, and never assert the reviewer is wrong from memory.

This also applies to your own prior claims: if a comment questions something you
asserted earlier, re-verify it. Reviews are where confidently-wrong statements
surface.

## The Response Document

One comment on the PR. Two required parts:

**Part 1 — Substantive.** Comments that challenge the implementation, propose
changes, or find problems. For each: whether they are right, what you propose,
what you need from them.

**Part 2 — Educational.** Comments asking how something works. Answer properly
— these are usually the majority and deserve real explanations, not deflection.

**Part 3 — Proposed changes.** Two lists: ready to apply, and needs their
decision. Nothing here is applied yet.

Lead with what changed your mind. A review that found real problems should say
so in the first paragraph.

## Inline Replies

One to three sentences each, ending with a link to the relevant document
section. The thread carries the answer; the document carries the reasoning.

Reply to **every** comment, including the ones you agree with completely.
Silence reads as missed.

## Order of Operations

1. Read every comment before writing anything
2. Verify claims you intend to dispute
3. Write the document, post it
4. Reply to each comment with a section link
5. Wait for the reviewer

Do not apply even the obvious changes until they respond. They are still
reading.

## Red Flags — Stop

- "I'll resolve this one, it's just a typo"
- "Resolving the ones I fixed keeps the queue clean"
- "They said hurry, so I'll batch a single reply"
- "This suggestion is obviously right, I'll just do it"
- "While I'm in here I'll also..."
- "They're probably right" (without checking)

All of these mean: reply, propose, leave it open.

## Common Mistakes

| Mistake | Instead |
| --- | --- |
| Resolving threads you addressed | Leave every thread open |
| Applying soft suggestions | Propose, wait |
| One summary comment, no per-thread replies | Both — document and replies |
| Deflecting "how does X work" as off-topic | Answer it properly |
| Agreeing to be agreeable | Verify, then say what you found |
| Fixing unrelated things you noticed | Note as follow-up |
