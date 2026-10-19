---
name: guided-review
description: When the user wants to manually review or understand a PR, walk them through it chunk by chunk with code snippets, Q&A, and per-element confirmation.
disable-model-invocation: true
---

Walk the user through one pull request until they understand what changed and have decided on each element. This can be done on any PR, at any point in its lifecycle.

## Inputs

Accept a PR URL, a number in the current repo, or "the open / current PR". If none is given, ask once. Resolve the PR with whatever tools the host offers (gh, GitHub/GitLab API, IDE PR panel, browser).

Before the walk, gather: title, body, base into head, draft vs ready, author, commit list, file list with added/removed line counts, and any linked ticket or issue. Always read the real diff over summarizing from memory.

## Orient (once)

Open with a short orientation - under ~10 lines:

1. **Intent** - what the PR claims to do (from title/body/ticket).
2. **Shape** - N commits, M files, rough size; call out generated, lockfile, or rename-heavy noise.
3. **Proposed walk order** - the element list (see below), numbered.

Ask: *"Does this order look right, or should we regroup / skip anything first?"* Wait. Then begin.

## Elements

Slice the PR into **review elements** the user can judge in one breath. Prefer logical hunks over raw files:

- One behavior or acceptance criterion and the files that implement it
- One commit when it is already a clean vertical slice
- One file when the file is the whole story (config, migration, single module)
- A rename/move pair as one element, or a group of these
- Tests that lock a behavior, grouped with that behavior when small enough

Avoid dumping the whole diff. Cap an element's snippet budget: show the decisive hunks, not every line. If an element is huge, subdivide before presenting it.

## Walk (one element at a time)

For each element:

1. **Title the element** - short name + which files/commits it covers.
2. **Explain in plain language** - what changed and why it matters for the PR's intent. Flag surprises (scope creep, missing tests, TODOs, deleted safety checks).
3. **Show concrete snippets** - quote the decisive before/after or new code from the diff. Prefer fenced code with file path and line context the host can provide. Never invent lines that aren't in the PR.
4. **Ask for questions** - invite dig-deeper before they decide. Answer from the diff, the ticket/spec, and the repo; look things up yourself rather than bouncing fact-finding to the user.
5. **Confirm** - wait for an explicit decision before the next element.

Each element should be formatted like so:

```
🔎 **E1 - <element title>**: <1-3 sentence explanation>

<code fence with lang>
// path/to/file.ext (decisive hunk)
...
</code fence>

❓ Questions before you decide? Or pick one:

➡️ approve | request change | skip | dig deeper
```

Only advance on **approve**, **request change**, or **skip**. On **dig deeper**, answer, then re-ask the same element's confirmation.

### Recording decisions

Keep a running log (in the chat; write it into the PR thread or a local note only if the user asks):

| # | Element | Decision | Notes |
|---|---|---|---|
| 1 | ... | approve / change / skip | optional one-liner |

For **request change**, capture a crisp ask the author (or a follow-up agent) could act on - file/hunk + expected fix. Do not push commits or post review comments unless the user explicitly tells you to.

## Close

When every element has a decision (or the user stops early):

1. Reprint the decision table.
2. One-line overall read: safe to approve as-is / approve after N changes / needs rework.
3. Offer next steps as copyable prompts only - e.g. paste a review summary, hand a change list to a coding agent with `/jkit`, or open `/code-review` for Standards+Spec. Do not merge, approve on the forge, or dismiss the draft unless they ask for that specific action.

## Rules of the road

- **Chunk, don't dump.** One element per turn of explanation + confirmation.
- **Snippets over vibes.** Every non-trivial claim about the change should point at a hunk.
- **User decides.** You recommend; they confirm. Never treat silence as approval.
- **Facts are your job.** Ticket text, surrounding call sites, related tests - look them up; don't make the user hunt.
- **Stay in review mode.** No drive-by refactors, no "while we're here" edits, no merging.
- **Draft-agent bias.** Soften trust for cloud-agent PRs: check that tests match the claimed behavior, that scope matches the ticket, and that secrets or env files weren't introduced.
