---
name: to-spec
description: Turn the current conversation into a spec and publish it to the effort on the configured tracker. No interview, just synthesis of what's already been discussed.
disable-model-invocation: true
---

Synthesize the conversation and your understanding of the codebase into a spec. Work from what you already know rather than interviewing the user. `/jkit` invokes this when an effort's decisions are made and a spec is worth writing; the user may also run it directly.

**Tracker first.** The tracker doc (path in `AGENTS.local.md` or `AGENTS.md`; run `/setup-jkit` if neither names one) says where specs live and how to publish them. Follow it for the write.

## Process

1. Explore the repo if you haven't already. Use the domain glossary (`CONTEXT.md`) throughout the spec, and respect ADRs in the area you're touching.

2. Sketch the seams where the feature will be tested. Prefer existing seams, and the highest seam possible. Propose any new seam at the highest point you can. The fewer seams the better; the ideal is one. Check with the user that the seams match their expectations.

3. Write the spec with the template below, then publish it per the tracker doc's **Specs** line and link it from the effort's map.
<spec-template>

## Problem Statement

The problem that the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User Stories

A LONG, numbered list of user stories. Each user story should be in the format of:

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

This list of user stories should be extremely extensive and cover all aspects of the feature.

## Implementation Decisions

A list of implementation decisions that were made. This can include:

- The modules that will be built/modified
- The interfaces of those modules that will be modified
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Leave out specific file paths and code snippets; they go stale fast.

Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it within the relevant decision and note briefly that it came from a prototype. Trim to the decision-rich parts — not a working demo, just the important bits.

## Testing Decisions

A list of testing decisions that were made. Include:

- A description of what makes a good test (only test external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests (i.e. similar types of tests in the codebase)

## Out of Scope

A description of the things that are out of scope for this spec.

## Further Notes

Any further notes about the feature.

</spec-template>
