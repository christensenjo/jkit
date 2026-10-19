---
name: daily-work
description: Start, update, or close a workspace's daily work plan - up to five tasks, comms, backlog, and where recent sessions ran.
argument-hint: Start | Next | Close
disable-model-invocation: true
---

# Daily work

Plan one workspace's work day in the short-term tasks file the tracker doc names. Runs when the user invokes it, or from `/daily-planner`. This skill plans and picks tasks; implementation happens in a fresh session.

## Daily directory

The tracker doc (path in `AGENTS.local.md` or `AGENTS.md`) names it on the Short-term tasks line. Today's file is `YYYY-MM-DD.md` in that directory. A `.scratch` tracker names `.scratch/daily/`.

## Locate

1. Walk up from the current folder to the nearest repo whose tracker doc names a daily directory that exists. Inside a git worktree, resolve the main checkout first (the first entry of `git worktree list`).
2. When none is found, open the workspace from the Workspaces section of `~/.agents/JKIT.md` by the resolution rules in the `setup-jkit` skill's `personal-docs.md`, then ask the user to confirm which workspace to use. When `~/.agents/JKIT.md` is missing, ask the user to run `/setup-jkit` and stop. When the tracker doc names no daily directory, ask the user which directory to use and record it on that Short-term tasks line.

Done when the workspace root and the daily directory are confirmed.

## Load

1. Update the repo that contains the daily directory (`git pull` when it is a git repo).
2. Read the tracker doc, its triage labels, and `people.md` from the paths `AGENTS.local.md` or `AGENTS.md` name.
3. Read the Stack and Cloud sections of `~/.agents/JKIT.md` (`$HOME/.agents/JKIT.md`). When `~/.agents/JKIT.md` is missing, ask the user to run `/setup-jkit` and stop.
4. Read today's file in the daily directory (missing means today hasn't started) and the most recent earlier file there.

## Mode

- **Start** - today's file is missing, or the user said start.
- **Next** - today's file exists and the day is open.
- **Close** - the user is done for the day.

## Housekeeping (Start only)

Move files in the daily directory older than 7 days into `old/` inside it. Delete files in `old/` older than 60 days.

## Scan (Start and Next)

- Carry forward the previous file's unchecked Tasks, with their unchecked subtasks.
- Read every open ticket the way the tracker doc says to fetch tickets. For a `.scratch` tracker, read `.scratch/efforts/*/issues/` and skip `efforts/closed/`: `Status:`, `Type:`, `Blocked by:`, and recent `## Comments`.
- Read the previous file's Sessions to find where recent work ran; open those threads when a task's state is unclear.
- Gather Comms: carry forward still-live bullets, add ticket comments, and - when you have email or messaging access - scan messages since the previous file from people in `people.md`, keeping only consequential items.

Done when every live effort has a one-bullet state and every carried task's state is known.

## Pickable

A ticket is **pickable** when its `Status:` is `ready-for-agent`, or `open` with `Type: task`, and every ticket in `Blocked by:` is `resolved`.

## Write

Follow the template. Keep the user's wording.

- **Tasks** - at most 5 checkboxes. Carried tasks come first; fill remaining slots with pickable tickets that follow from the user's stated focus. Link a ticket by title to its relative path. Nested subtask checkboxes are fine.
- **Comms** - short bullets, people named as `people.md` names them.
- **Backlog** - a `###` heading per live effort and one bullet: what landed, what remains, the next blocker or pickable step.
- **Sessions** - one line per work session: `- <harness>: <thread link or id> - <what it touched>`. Other sessions append here too (see `issue-tracker.md`).

On Close, check finished tasks, leave the rest unchecked for tomorrow, and log the current session under Sessions.

Then commit and push the repo that contains the daily directory, the way the tracker doc says to commit.

Done when the file follows the template, every live effort is in Backlog, and the push succeeded.

## Copyable prompt

When a task links one or more pickable tickets, emit one prompt per ticket, each to run in its own session:

```
/jkit Claim and complete <ticket path>
```

A `.scratch` ticket path looks like `.scratch/efforts/<effort>/issues/<file>.md`.

This becomes a single cloud fan-out prompt once that skill exists (see `.experimenting/under-construction/cloud-fan-out.md` in jkit). When none is pickable, say so and skip the prompt.

## Template

```markdown
# YYYY-MM-DD - <workspace>

## Tasks

- [ ] [<ticket title>](<ticket path>)
    - [ ] <subtask>
- [ ] <task>

## Comms

- <person>, <topic>: <current state>

## Backlog

### <effort>
- <what landed, what remains, next step>

## Sessions

- <harness>: <thread link or id> - <what it touched>
```