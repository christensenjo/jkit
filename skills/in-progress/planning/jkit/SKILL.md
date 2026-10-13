---
name: jkit
description: All-in-one front door for dev work in a jkit workspace. Reads the prompt, then plans and builds through efforts and tickets on the tracker, invoking whichever jkit skills the work needs.
disable-model-invocation: true
---

`/jkit` takes any dev prompt and does the work: it picks the route below, invokes the skills that route needs, and keeps the tracker current. It acts; it never ends by suggesting a next skill for the user to run.

**Tracker first.** The tracker doc (path in `AGENTS.local.md` or `AGENTS.md`; run `/setup-jkit` if neither names one) says where efforts, maps and tickets live and how to claim, block and resolve them. Follow it for every tracker operation.

**Plan and build.** By default an effort runs all the way to the built change: maps include execution tickets alongside the decision tickets. Keep a map planning-only only when the user asks for that.

**One ticket per session.** Resolve at most one ticket per session; research tickets are the exception. For several tickets at once, give the user one copyable prompt per ticket (`/jkit Claim and complete <ticket path>`) so each runs in its own session.

**Refer by name.** Name maps and tickets by title, with the link wrapped in the name, never a bare number or path.

## Maps and tickets

An **effort** is work too big for one session. Its **map** charts the way from here to the **destination**; its **tickets** are the steps, each sized to one agent session (about 100K tokens).

### Destination

Name it first; it fixes the scope and shapes every ticket. It can be a built change, a spec, a locked decision, or a change made in place like a data migration.

### The map

The map is an **index**: it gists each decision and links the ticket that holds it. A decision lives only in its ticket. Open tickets aren't listed; find them through the tracker's frontier query.

```markdown
## Destination

<one or two lines on what reaching the end looks like>

## Notes

<domain; skills every session should consult; standing preferences for this effort>

## Decisions so far

- [<resolved ticket title>](link) - <one-line gist of the answer>

## Not yet specified

<in-scope fog you can't ticket yet>

## Out of scope

- [<wontfix ticket title>](link) - <gist, and why it's out of scope>
```

### Tickets

A ticket body states the question or job:

```markdown
## Question

<the decision, investigation, or piece of work this ticket resolves>
```

Each ticket has one type and sits on the **frontier** once it's open, unblocked and unclaimed. Claim before any work, because parallel sessions may be editing the tracker at the same time. Record the answer on resolution, and link any assets the work made rather than pasting them in.

### Ticket types

**HITL** tickets are worked live with the human, who speaks for themselves; never answer the human's side yourself. **AFK** tickets are driven by the agent alone.

- **Grilling** (HITL): a decision reached in conversation. The default type. Use `/grilling` and `/domain-modeling`.
- **Prototype** (HITL): a cheap, rough artifact to react to (an outline, a stub, UI or logic via `/prototype`) when the key question is how something should look or behave. Link the prototype from the ticket.
- **Research** (AFK): facts from outside the working directory, such as docs, third-party APIs or knowledge bases. Resolve it with a `/research` subagent that writes `efforts/<effort>/research/<name>.md`, and point the ticket's answer at that file. Several research tickets may resolve in one session.
- **Task** (AFK or HITL): work that does rather than decides. That covers execution tickets that build the destination (use `/implement` or `/tdd`, following the codebase's branch and PR rules), and setup that unblocks a decision (sign up for a service, provision access, move data). When it needs the human, hand them a precise checklist. The answer records what was done and any facts later tickets need.

### Fog of war

Don't chart what you can't yet see. Write coming-but-unclear work under **Not yet specified**, as loosely as the view allows.

- **Ticket it** when you can state the question precisely now, even if it's blocked.
- **Leave it in the fog** when you can't phrase it that sharply yet. Don't pre-slice the fog; one patch may become several tickets or none.

When a resolution makes a patch specifiable, create its tickets and remove that patch from **Not yet specified**. If a decision invalidates other tickets, update them or mark them wontfix.

### Out of scope

Work past the destination isn't fog. When a ticket turns out to sit beyond it, set it to wontfix and add one line under **Out of scope** with its gist and why it's out. Keep it out of **Decisions so far**. Out-of-scope work comes back only as a fresh effort if the destination is redrawn.

## Routes

Pick the first route that fits the prompt. When unsure, ask one question.

### Work a ticket

Prompts like "Claim and complete <ticket>", "Work on <effort>".

1. Load the effort's map, not every ticket body.
2. Use the named ticket, or else the first frontier ticket. Claim it before any other work.
3. Resolve it with the skills its type and the map's Notes call for (see **Ticket types**). Zoom into related or resolved tickets on demand.
4. Record the answer, resolve the ticket, and update the map: add the decision pointer, graduate fog, add newly surfaced tickets, rule out-of-scope work out.
5. If that was the effort's last open ticket, run **Close an effort**.

### Chart or extend an effort

Prompts like "Help me figure out <x>", "Map these changes and create tickets", "Add <x> to <effort>".

1. Grill with `/grilling` and `/domain-modeling` to name the destination. When extending, the destination already exists; confirm the change fits it, or redraw it with the user.
2. Grill breadth-first for the open decisions and the execution work. If the whole job fits one session with nothing to decide, skip the map and take **Small task**.
3. Create or update the map, then the tickets you can specify now, then wire blocking in a second pass.
4. Launch a `/research` subagent for each new research ticket.
5. Stop after charting; resolve tickets in later sessions.

### Small task

One-session work outside any map: merge conflicts, a review comment, a quick fix, "pick up from this handoff doc". Do it directly with the skills it needs (for code, `/implement` or `/tdd`). When it turns out to belong to an effort, file or update a ticket there too.

### Status

Prompts like "Catch me up on <effort>", "Are all the <x> tickets resolved?". Read the map and ticket statuses, and answer: what's decided, what's in progress, what's on the frontier, what's blocked. Change nothing.

### Close an effort

Run when an effort's tickets are all resolved or wontfix, or when the user asks to close it.

1. Grill once more: check the destination against what was built, and look for anything left to decide or implement.
2. Tell the user whether anything is left, with your reasoning, and ask whether they disagree.
3. Only on their agreement, move the effort to closed per the tracker doc. They may keep a finished effort open.

## After every session

Log the session per the tracker doc, then commit tracker changes.
