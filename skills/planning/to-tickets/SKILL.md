---
name: to-tickets
description: Break a plan, spec, or the current conversation into tracer-bullet execution tickets with blocking edges, approved by the user, then published to the effort on the configured tracker.
disable-model-invocation: true
---

# To Tickets

Break a plan, spec, or conversation into **tickets**: tracer-bullet vertical slices, each declaring the tickets that **block** it. `/jkit` invokes this when an effort needs execution tickets; the user may also run it directly.

**Tracker first.** The tracker doc (path in `AGENTS.local.md` or `AGENTS.md`; run `/setup-jkit` if neither names one) says where an effort's tickets live, their header format, and how to publish. Follow it for every write.

## Process

### 1. Gather context

Work from the conversation. When the user passes a reference (a spec path, a ticket or map path, an issue URL), fetch it and read its full body and comments. Identify the **effort** the tickets belong to; ask when it's unclear.

### 2. Explore the codebase

If you haven't explored the area yet, do it now. Use the domain glossary (`CONTEXT.md`) in titles and bodies, and respect ADRs in the area you're touching. Look for prefactoring that makes the implementation easier: "make the change easy, then make the easy change."

### 3. Draft vertical slices

<vertical-slice-rules>

- Each slice cuts a narrow but complete path through every layer (schema, API, UI, tests): vertical, not one layer
- A completed slice is demoable or verifiable on its own
- Each slice fits in a single fresh context window
- Prefactoring comes first

</vertical-slice-rules>

Give each ticket its **blocking edges**: the tickets that must resolve before it can start.

**Wide refactors are the exception.** A wide refactor is one mechanical change (rename a column, retype a shared symbol) whose blast radius breaks call sites across the codebase, so no vertical slice can land green. Sequence it as **expand, migrate, contract**:

1. **Expand:** add the new form beside the old so nothing breaks.
2. **Migrate:** move call sites in batches sized by blast radius (per package, per directory), each batch its own ticket blocked by the expand. CI stays green because the old form still exists.
3. **Contract:** delete the old form in a ticket blocked by every migrate batch.

When even the batches can't stay green alone, let them share an integration branch, all blocking a final integrate-and-verify ticket; green is promised only there.

### 4. Get the user's approval

Present the breakdown as a numbered list. For each ticket:

- **Title:** short descriptive name
- **Blocked by:** the tickets that gate it, if any
- **What it delivers:** the end-to-end behaviour it makes work

Ask whether the granularity is right, whether each blocker genuinely gates its ticket, and whether any tickets should merge or split. Iterate until the user approves. Write nothing to the tracker before approval.

### 5. Publish

Publish the approved tickets per the tracker doc, in dependency order (blockers first) so each blocking edge can reference a real identifier:

- Continue the effort's ticket numbering; never reuse a number.
- Set `Type: task` and `Status: ready-for-agent` unless the user says otherwise; these tickets are agent-takeable by construction.
- When the effort has a map, remove any **Not yet specified** fog these tickets now cover.
- Leave any parent ticket or spec unchanged.

Body template, under the tracker doc's header lines:

```markdown
## What to build

<the end-to-end behaviour this ticket makes work, from the user's perspective, not a layer-by-layer list>

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
```

Keep file paths and code snippets out; they go stale fast. The exception is a prototype snippet that encodes a decision more precisely than prose (a state machine, reducer, schema or type shape): inline only its decision-rich parts and note that it came from a prototype.