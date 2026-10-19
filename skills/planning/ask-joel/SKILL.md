---
name: ask-joel
description: Ask which skill fits your situation. A short map of the skills in jkit.
disable-model-invocation: true
---

# Ask Joel

Answer from this map. Name the skill to run and why it fits; if none fits, say so.

## New to jkit? How `/jkit` is used

1. In a repo, run `/setup-jkit` once. It records where tickets live (local `.scratch/` files, GitHub or GitLab) in a tracker doc.
2. Then type `/jkit` with what you want in plain words: "I want to build X", "work the next ticket", "what's the status?", "triage this bug".
3. For a big idea, `/jkit` grills you, then charts an **effort**: a map of where you're headed plus small tickets, which you approve before anything is written.
4. Each ticket gets its own fresh session. `/jkit` hands you a copyable prompt like `/jkit Claim and complete <ticket path>`, and the agent builds it test-first, reviews it, and commits. It never merges or deploys.
5. When the map is done, `/jkit` runs a last grilling and closes the effort once you agree.
## Front door

- **`/jkit`** - plan and build anything in a repo: grill an idea, chart an effort into tickets, work one ticket per session, triage incoming work, review architecture, close an effort. Start here for engineering work. **`/setup-jkit`** runs once per repo first.

## Everyday tools

- **`/daily-planner`** - personal daily plan across workspaces.
- **`/daily-work`** - the day's work in one workspace, with copyable `/jkit` prompts per ticket.
- **`/bruh`** - the last message didn't land; restate it simply, with the missing context.
- **`/handoff`** - a portable summary for a new tool, a new repo, a colleague, or a side task forked mid-phase.
- **`/guided-review`** - walk a draft PR (esp. cloud-agent) chunk by chunk with snippets and per-element confirmation. first draft.
- **`/resolving-merge-conflicts`** - already mid-merge or mid-rebase with conflicts.
- **`/diagnosing-bugs`** - a hard bug, flake or regression that resists a first look.

## Under `/jkit`

Run directly only when you want just that piece: `grilling`, `guided-review`, `domain-modeling`, `codebase-design`, `prototype`, `research`, `tdd`, `code-review`, `to-spec`, `to-tickets`, `triage`, `improve-codebase-architecture`, `writing-for-agents` (for writing skills and agent docs).

## Experimenting

Untried, in `.experimenting/`: `/automate` (design automations for recurring work and life processes), `/teach` (learn a topic over several sessions), `/wizard` (a script that walks you through manual setup steps), and the writing trio `/writing-fragments`, `/writing-shape`, `/writing-beats`.

## Between phases

When a chunk of work ends and you're unsure whether to keep going, start fresh, hand off, send a subagent or summarize, read [PHASE-BOUNDARIES.md](PHASE-BOUNDARIES.md).