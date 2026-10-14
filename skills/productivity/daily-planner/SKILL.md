---
name: daily-planner
description: Start, update, or close today's personal plan in the daily-planner repo, and refresh each primary workspace's /daily-work file.
argument-hint: Start | Next | Close
disable-model-invocation: true
---

# Daily planner

Plan the user's day - intent, errands, projects, fun - and link each primary workspace's work plan. Runs when the user invokes it, or when you are the personal assistant named in `stack.md`.

## Load

1. Find the **planner repo** from the path in `~/.agents/jkit.md`. When that file or path is missing, ask the user where their planner repo lives.
2. `git pull` in the planner repo.
3. Read `stack.md`, `workspaces.md`, today's `daily/YYYY-MM-DD.md` (a missing file means today hasn't started), and the most recent earlier file in `daily/`.

Done when today's file has been read or found missing, and the most recent earlier file is in hand.

## Mode

Pick one:

- **Start** - today's file is missing, or the user said start.
- **Next** - today's file exists and the day is open.
- **Close** - the user is done for the day.

## Housekeeping (Start only)

Move files in `daily/` older than 7 days into `daily/old/`. Delete files in `daily/old/` older than 60 days.

## Workspaces

For each workspace in `workspaces.md`, run `/daily-work` in that workspace with the same mode: read its skill file and follow it with that workspace as the root. Each run yields the link to that workspace's daily-work file.

Done when every listed workspace has a current daily-work file, or you've noted why one couldn't be reached.

## Write

Follow the template. Keep the user's wording.

- **Intent** - one short sentence on what today is for. It steers agents, so keep it terse.
- **Errands** - checkboxes. On Start, carry forward only unchecked errands.
- **Work** - one link per workspace from the Workspaces step, nothing else. Tasks live in the daily-work files.
- **Projects** - carry forward verbatim, keeping its numbering and nested checkboxes.
- **Fun & Games** - carry forward verbatim, one `###` heading per game or hobby.

On Close, check finished errands and project items; unchecked items carry to tomorrow.

Then commit and push the planner repo.

Done when the file follows the template, every workspace is linked, and the push succeeded.

## Template

```markdown
# YYYY-MM-DD

## Intent

<One short sentence.>

## Errands
- [ ] <errand>

## Work
- [<workspace>](<daily-work file URL>)

## Projects

1. <project>
    - [ ] <step>

## Fun & Games
### <game or hobby>
- <next thing>
```