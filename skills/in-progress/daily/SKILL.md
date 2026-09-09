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

- Carry-forward from yesterday: unchecked Errands, **open** Work, Fun/Games, Life Projects, the Priority / Backlog grouping. Yesterday's **landed** Work and checked errands stay off today's file.
- Cursor chats from the last few days that mention Nate, Seth, or Luke.
- Dated files under `docs/agents/` (weekend threads, handoffs). List that directory with the shell, then Read. It is often gitignored too.
- Every `.scratch/<effort>/issues/*.md`. List those directories with the shell (`Get-ChildItem` / `ls`), then Read each file. Skip `CLOSED`, `DAILY`, and `EVIDENCE`. Read `Status:`, `Type:`, and `Blocked by:`.

Done when every live effort is under Priority, under Backlog, or skipped.

## Takeable

A ticket is **takeable** when all of these hold:

- `Status:` is `ready-for-agent`, or `unclaimed` on a `Type: task` an agent can run alone
- `Status:` is not `resolved`, `wontfix`, or `claimed`
- every id in `Blocked by:` is `resolved` in that same effort (blank is fine)

`ready-for-human`, grilling, and blocked tickets stay on the file. They are not takeable.

Done when every open ticket in scope is labeled takeable or not.

## Write the file

Use the template. Keep Joel's wording. Put today's prompt in **Intent** (Minecraft for an hour, UI only, Views sheet, and so on).

Until the file already names them, seed **Priority** with `season-long-ui`, `team-season-seth-views`, `one-team-one-player-views`. Other live efforts go under **Backlog**. Move an effort when he says to.

Under each effort list tickets by **name**, with path. **Landed** today: `- [x] [Name](path) — …`. **Open** (takeable, waiting, blocked, claimed): `- [Name](path) — Status and who they wait on`. A waiting line when the effort has no open ticket.

Errands and Life Projects keep their own `- [ ]` / `- [x]` boxes. The empty checkbox stays there.

Life Projects stay listed. Recommend one only when he asked for a life-project day or named a first slice.

Fun/Games stay listed. They are a valid slice when Intent says so.

On **Close**, mark landed Work `- [x]` and write `## Still open` from the remaining `-` lines. That section is tomorrow's primary source.

Done when the file matches the template, every open carry-forward item is present, and every landed Work line is `- [x]`.

## Pick

Recommend 1-3 slices. Mark one. Follow Intent. Prefer a takeable Priority ticket. If Priority has none, say so. Offer Backlog only as an option, unless Intent already pointed there.

Grill when he is unclear about the list or feels blocked. Facts are yours; invoke `/grilling`. Skip grilling on a normal start.

Done when one marked slice is on the table.

## Copyable prompt

Emit this block when Priority has at least one takeable ticket, or Intent pointed at Backlog and Backlog has one.

```
/wayfinder /loop until you've completed all of the following local /.scratch tickets that are open and takeable:
.scratch/<effort>/issues/<file>.md
```

One path per takeable ticket. Priority first, then Backlog if it is in scope.

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

#### season-long-ui

#### team-season-seth-views

#### one-team-one-player-views

### Backlog

## Fun/Games

## Life Projects

## Comms

## Still open
```

`## Still open` is for **Close** (and the next **Start** to read). Leave it out until then.
