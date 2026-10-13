# Domain docs

How the engineering skills consume this repo's domain documentation.

## Before exploring, read these

- **`CONTEXT.md`** at the repo root - the project glossary. Or **`CONTEXT-MAP.md`** at the root when it exists; it points at one `CONTEXT.md` per context, so read each one relevant to the topic.
- **ADRs** in the tracker docs folder's `adr/` (`.scratch/docs/adr/` or `docs/agents/adr/`), plus any committed `docs/adr/` the team keeps. Read the ones touching the area you're about to work in.

When a file is missing, proceed silently. `/domain-modeling` creates these lazily, when a term or decision actually gets resolved.

## Layout

Single-context (most repos):

```
CONTEXT.md
.scratch/docs/adr/0001-<slug>.md
```

Multi-context (a `CONTEXT-MAP.md` at the root):

```
CONTEXT-MAP.md
src/<context>/CONTEXT.md
.scratch/docs/adr/<context>/0001-<slug>.md
```

`CONTEXT.md` is committed: the glossary helps every agent and teammate. ADRs live with the tracker docs.

## Use the glossary's vocabulary

When your output names a domain concept (an issue title, a refactor proposal, a hypothesis, a test name), use the term as `CONTEXT.md` defines it, including its listed avoided synonyms. A concept missing from the glossary is a signal: either you're inventing language the project doesn't use, or there's a real gap to note for `/domain-modeling`.

## Flag ADR conflicts

When your output contradicts an existing ADR, surface it explicitly:

> _Contradicts ADR-0007 (event-sourced orders) - but worth reopening because..._