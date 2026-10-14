# Issue tracker: `.scratch`

Efforts and tickets for this repo live as markdown files in `.scratch/`, a gitignored folder that is its own private git repo (`<username>/<repo-name>-scratch`).

## Committing

Tracker edits go straight to `main` of the `.scratch` repo: pull before editing, then commit and push promptly in small commits named `<effort>: <what changed>`. This rule covers the `.scratch` repo only; codebase changes follow the codebase's own branch and PR rules.

## Layout

- **Effort:** `.scratch/efforts/<effort-slug>/`, holding `map.md`, `spec.md` when there is one, and `issues/NN-<slug>.md` - one ticket per file, numbered from `01`.
- **Closed effort:** moved intact to `.scratch/efforts/closed/<effort-slug>/` when `/jkit` closes it with the user's agreement.
- **Short-term tasks:** the newest `.scratch/daily/YYYY-MM-DD.md`, owned by `/daily-work`. Efforts hold the longer-term work. When today's file is missing, use the newest one and suggest the user run `/daily-work`.
- **Sessions:** after working in this workspace, append one line to today's daily file under `## Sessions`: `- <harness>: <thread link or id> - <what it touched>`. Create the heading when missing.
- **Evidence:** `.scratch/docs/evidence/<YYYYMMDD-HHMM>-<slug>/`, linked from the ticket it supports.

## Ticket format

Header lines under the `# Title`:

```
Status: <state>
Type: <research | prototype | grilling | task>
Blocked by: 02, 03
```

- `Status:` holds exactly one canonical value: `open`, `claimed`, `resolved`, or a triage role from `triage-labels.md`. A new ticket starts `open`.
- Conversation history appends under `## Comments` at the bottom.
- Refer to tickets by title, linked to their path.

## When a skill says "publish to the issue tracker"

Create the file under `.scratch/efforts/<effort-slug>/`, creating folders as needed, then commit and push.

## When a skill says "fetch the relevant ticket"

Read the file at the referenced path, checking `efforts/closed/` when it isn't under `efforts/`.

## Triage

- **Out-of-scope records:** `.scratch/docs/out-of-scope/<concept>.md` for project-wide rejections; effort-level ones go in the map's Out of scope section.
- **Triage comments:** appended under `## Comments`; the state role goes on the `Status:` line.

## Specs

A spec is `.scratch/efforts/<effort>/spec.md`, linked from the effort's `map.md`. It's a document, not a ticket, so it carries no Status line; `/to-tickets` turns it into takeable tickets.

## Effort operations

Used by `/jkit`. The **map** is a file with one **child** file per ticket.

- **Map:** `.scratch/efforts/<effort>/map.md` - the Destination / Notes / Decisions so far / Not yet specified / Out of scope body.
- **Child ticket:** `.scratch/efforts/<effort>/issues/NN-<slug>.md`, with the question in the body.
- **Blocking:** the `Blocked by:` line. A ticket is unblocked when every ticket it lists is `resolved`.
- **Frontier:** tickets in the effort's `issues/` that are open, unblocked and unclaimed; lowest number wins.
- **Claim:** pull, confirm the ticket is still unclaimed, set `Status: claimed`, then commit and push before any other work so parallel agents see it. On a push conflict, rebase and re-check the claim.
- **Research:** `.scratch/efforts/<effort>/research/<name>.md`, linked from the ticket's answer. One-off research outside any effort goes in `.scratch/docs/research/<name>.md`.
- **Resolve:** append the answer under `## Answer`, set `Status: resolved`, append a context pointer (gist + link) to Decisions-so-far in `map.md`, then commit and push.