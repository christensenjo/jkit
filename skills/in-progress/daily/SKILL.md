---
name: daily
description: Start, update, or close today's plan in .scratch/DAILY.
argument-hint: Start | Next | Close
disable-model-invocation: true
---

# Daily

Plan the day in the current project's `.scratch/DAILY/`. One file per calendar day, named `YYYY-MM-DD.md`.

This skill writes that file and picks a **slice**. It does not implement tickets. Hand a **takeable** ticket to a new session with the copyable prompt.

Address the user as Joel. Read `docs/agents/people.md` before naming Nate, Seth, or Luke.

## Load

`.scratch/` is gitignored. Open those files by path.

1. Today's path: `<project>/.scratch/DAILY/YYYY-MM-DD.md` (session calendar date).
2. **Read** that path. A hit means the file exists. A missing-file error means it does not. That Read is the only existence check. An empty workspace search is unsearched, not a miss.
3. **Read** yesterday's ISO path, if any.
4. **Read** `docs/agents/issue-tracker.md` when this workspace uses local `.scratch` tickets.

Create the `.scratch/DAILY` directory only after today's Read misses.

Done when today's path has been Read (hit or miss) and yesterday's leftovers are in hand.

## Mode

Pick one after Load:

- **Start** when today's Read missed, or Joel said start.
- **Next** when today's Read hit and the day is still open (he finished something, asked what's left, or named a new constraint).
- **Close** when he is done for the day.

Done when exactly one mode is chosen.

## Scan (Start and Next)

Bounded. Findings become lines on the daily file, not a transcript dump.

- Carry-forward from yesterday: unchecked Errands, unchecked **focus** boxes (candidates for today's Priority when Intent is quiet), Fun/Games, Life Projects, and the **inventory** under Backlog. Yesterday's **landed** focus boxes and checked errands stay off today's file. Old files that still group tickets under Priority: those effort lists are inventory. Fold them into Backlog.
- Cursor chats from the last few days that mention Nate, Seth, or Luke.
- Dated files under `docs/agents/` (weekend threads, handoffs). List that directory with the shell, then Read. It is often gitignored too.
- Every `.scratch/<effort>/issues/*.md`. List those directories with the shell (`Get-ChildItem` / `ls`), then Read each file. Skip `CLOSED`, `DAILY`, and `EVIDENCE`. Read `Status:`, `Type:`, and `Blocked by:`.

Done when every live effort is under Backlog or skipped, and today's focus list is in hand (from Intent, leftover unchecked focus boxes, or yesterday's Still open).

## Takeable

A ticket is **takeable** when all of these hold:

- `Status:` is `ready-for-agent`, or `unclaimed` on a `Type: task` an agent can run alone
- `Status:` is not `resolved`, `wontfix`, or `claimed`
- every id in `Blocked by:` is `resolved` in that same effort (blank is fine)

`ready-for-human`, grilling, and blocked tickets stay on the file. They are not takeable.

Done when every open ticket in scope is labeled takeable or not.

## Write the file

Use the template. Keep Joel's wording. Put today's prompt in **Intent** (Minecraft for an hour, UI only, Views sheet, and so on).

### Focus

**Priority** is only today's **focus**: a short checkbox list of immediately actionable items. They come from Intent. A focus item may be a ticket, a call, a paste, or other work. Link a ticket when one exists. Status words stay off these lines. The marked slice gets `**Marked slice.**` on its box.

Write focus from Intent. When Intent is quiet, keep yesterday's leftover unchecked focus boxes. When both are empty, ask what today's focus is. One question. Skip a full grill on a normal start.

### Inventory

**Backlog** is the parked **inventory**: tickets grouped by effort, with path and status. It is the last section in the file, after Fun/Games, Life Projects, and Comms. Scan it when Joel asks where an effort stands.

Under each effort list tickets by **name**, with path. **Landed** today: `- [x] [Name](path) — …`. **Open** (takeable, waiting, blocked, claimed): `- [Name](path) — Status and who they wait on`. A waiting line when the effort has no open ticket.

Promote an inventory line into focus when Intent or Joel names it.

### Standing lists

Errands and Life Projects keep their own `- [ ]` / `- [x]` boxes. The empty checkbox stays there.

Life Projects stay listed. Recommend one only when he asked for a life-project day or named a first slice.

Fun/Games stay listed. They are a valid slice when Intent says so.

On **Close**, mark landed focus `- [x]` and write `## Still open` from the remaining unchecked focus boxes. That section is tomorrow's focus source. Inventory stays under Backlog.

Done when the file matches the template, Priority is only focus checkboxes, every live effort is under Backlog or skipped, and every landed focus box is `- [x]`.

## Pick

Recommend 1-3 slices. Mark one. Follow Intent. Prefer a takeable ticket linked from a focus box. If Priority has none, say so. Offer Backlog only as an option, unless Intent already pointed there.

Grill when he is unclear about the list or feels blocked. Facts are yours; invoke `/grilling`. Skip grilling on a normal start.

Done when one marked slice is on the table.

## Copyable prompt

Emit this block when a focus box links at least one takeable ticket, or Intent pointed at Backlog and Backlog has one.

```
/wayfinder /loop until you've completed all of the following local /.scratch tickets that are open and takeable:
.scratch/<effort>/issues/<file>.md
```

One path per takeable ticket linked from a focus box. Inventory tickets only when Backlog is in scope.

If the scoped set has no takeable ticket, say that. Write no prompt.

Done when he can paste the prompt into a new agent, or knows there is nothing takeable.

## Template

```markdown
# YYYY-MM-DD

## Intent


## Errands
- [ ] 

## Work

### Priority
- [ ] 

## Fun/Games

## Life Projects

## Comms

## Backlog

#### season-long-ui

#### team-season-seth-views

#### one-team-one-player-views

## Still open
```

`## Still open` is for **Close** (and the next **Start** to read). Leave it out until then.
