---
name: research
description: Investigate a question against high-trust primary sources and capture the findings as a Markdown file in the repo. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
---

Spin up a **background agent** to do the research, so you keep working while it reads.

Its job:

1. Investigate the question against **primary sources** — official docs, source code, specs, first-party APIs — not a secondary write-up of them. Follow every claim back to the source that owns it.
2. Write the findings to a single Markdown file, citing each claim's source.
3. Save it per the tracker doc: for a `/jkit` research ticket, at the effort's research path (`.scratch/efforts/<effort>/research/<name>.md` locally), linked from the ticket. For a one-off question outside any effort, in `.scratch/docs/research/<name>.md`. If the project has no tracker doc, match where the repo already keeps such notes, and say where.
