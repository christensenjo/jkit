---
name: daily
description: Start, update, or close today's plan in /stats/.scratch/DAILY.
argument-hint: Start | Next | Close
disable-model-invocation: true
---

# Daily

Plan Joel's day in `C:\Users\chris\Herd\stats\.scratch\DAILY\`. Joel may call this `/stats/.scratch/DAILY`. One file per calendar day, named `YYYY-MM-DD.md`.

That directory is the only allowed home for daily files. Use the local-machine shell to read and write it because `.scratch` is gitignored and may not exist in an attached worktree. Never substitute the current checkout, a Delta worktree, another clone, or another `.scratch/DAILY`. If the canonical path is unavailable, stop and tell Joel rather than creating the file elsewhere.

This skill writes the plan and picks a **slice**. It does not implement tickets. Hand a **takeable** ticket to a new session with the copyable prompt.

Address the user as Joel. Read `C:\Users\chris\Herd\stats\docs\agents\people.md` before naming Nate, Seth, or Luke.

## Load

1. Get the session calendar date.
2. Read the exact path `C:\Users\chris\Herd\stats\.scratch\DAILY\YYYY-MM-DD.md`. A hit means today's file exists. A missing-file error means it does not. This read is the only existence check.
3. Read yesterday's ISO-date file at the same canonical root, if it exists.
4. Read `C:\Users\chris\Herd\stats\docs\agents\issue-tracker.md` when local `.scratch` tickets are in use.
5. Before any write, verify that the destination's parent is exactly `C:\Users\chris\Herd\stats\.scratch\DAILY`. Create that directory only after today's exact read misses.

Done when today's canonical path has been read, yesterday's carry-forward is in hand, and no alternate destination has been considered.

## Mode

Pick exactly one after Load:

- **Start** when today's read missed, or Joel said start.
- **Next** when today's read hit and the day is open.
- **Close** when Joel is done for the day.

## Scan

Run this bounded scan for Start and Next. Put conclusions in the daily file, not a transcript dump.

- Carry forward yesterday's unchecked Errands and Work items, the Projects list, and useful Backlog state. Leave yesterday's completed Work and checked Errands behind.
- Search Delta threads from the last few days that mention Nate, Seth, or Luke. Use the delta-threads skill.
- List `C:\Users\chris\Herd\stats\docs\agents\`, then read dated handoffs and weekend notes.
- Read every `C:\Users\chris\Herd\stats\.scratch\<effort>\issues\*.md`. Skip `CLOSED`, `DAILY`, and `EVIDENCE`. Read `Status:`, `Type:`, and `Blocked by:`.
- Include every effort with open work under Backlog. Remove an effort only when all of its tickets are resolved or the effort directory is gone.

Done when today's Work list is in hand and every live effort has a current one-bullet Backlog summary.

## Takeable

A ticket is **takeable** when all of these hold:

- `Status:` is `ready-for-agent`, or it is `unclaimed` with `Type: task` and an agent can run it alone.
- Every id in `Blocked by:` is `resolved` in the same effort. Blank is fine.

`ready-for-human`, grilling, blocked, claimed, resolved, and wontfix tickets are not takeable.

Done when every open ticket considered for today's slice is labeled takeable or not.

## Write

Keep Joel's wording and use today's layout.

### Intent

Write one or two concise sentences. Name what Joel is finishing today and the next priority he or Nate has already named. Do not turn Intent into a task list.

### Errands

Use checkboxes. On Start, carry forward only unchecked errands.

### Work

Put today's focus checkboxes directly under `## Work`. There is no Priority subsection. Preserve completed items during Next and Close so the file records the day. Mark exactly one current or completed slice with `**Marked slice.**`.

Work comes from Joel's stated intent. When Intent is quiet, use yesterday's unchecked Work. When both are empty, ask one question about today's focus before writing the file.

Link a ticket when one exists. Status words stay off Work lines.

### Comms

Nest `### Comms` under Work. Record only current, consequential collaborator context in short bullets. Keep ownership and wording consistent with `docs/agents/people.md`.

### Backlog

Nest `### Backlog` under Work. Add a `#### <effort>` heading for every live effort, then one bullet saying what landed, what remains, and the next blocker or takeable step. Bullets make the summaries easy to scan. This is a compact effort summary, not a ticket inventory.

### Projects

`## Projects` is the final section. Copy yesterday's Projects list forward with Joel's wording and order. Preserve its checkbox or numbered-list form. Do not recommend a Project unless Joel asks for a project day or names one as today's slice.

The daily file has no Fun/Games, Priority, Life Projects, or Still open section.

On Close, check every landed Work item and leave unfinished items unchecked in Work. Tomorrow's Start reads those unchecked items directly.

Done when the file follows the template, has substantive Intent and Work content, includes every live effort under Backlog, and lives only at the canonical path.

## Pick

Recommend one to three slices and mark one. Follow Intent. Prefer a takeable ticket linked from Work. If Work has no takeable ticket, say so. Offer Backlog only when Intent points there or Joel asks for options.

Grill only when Joel feels blocked or asks to challenge the list. Skip grilling on a normal Start.

## Copyable prompt

Emit this block when a Work checkbox links at least one takeable ticket, or Intent puts Backlog in scope and Backlog has one:

```
/wayfinder /loop until you've completed all of the following local /.scratch tickets that are open and takeable:
.scratch/<effort>/issues/<file>.md
```

Include one path per scoped takeable ticket. If none are takeable, say that and write no prompt.

## Template

```markdown
# YYYY-MM-DD

## Intent

<What Joel is finishing. What comes next.>

## Errands
- [ ] <errand>

## Work

- [ ] <focus item> **Marked slice.**

### Comms

- <current collaborator context>

### Backlog

#### <live-effort>
- <One-sentence current state.>

## Projects

<Yesterday's Projects list, preserved.>
```
