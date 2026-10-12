# Future direction (AI slop)

_Last updated October 2026._ Where my AI dev workflow is heading, and why.

## Principles
1. **Model freedom through subscriptions.** Use the best model for the job across providers, through plans I already pay for.
2. **Subscription-only budget.** A fixed monthly ceiling, met with flat, subsidized subscriptions. On-demand/API-rate billing stays off. When a pool runs out, switch tools rather than pay overage.
3. **Cost is a model choice.** Cheap, capable models for delegated workers. Premium or fast modes for hands-on sessions only. Keep context windows lean.
4. **Shared repos stay clean.** Only tool-neutral files (`AGENTS.md`, docs) get committed. Tool-specific config lives in the tool's dashboard or in private repos.
5. **Markdown over SaaS trackers.** Issues are plain markdown, editable in any editor and versioned in git.
6. **Agents only act when asked**, until trust is earned (see trigger phases).
7. **Agents never touch production.** This is a hard rule, enforced technically.
8. **Own the process.** My skills live in this repo, installed tool-neutrally.

## Target workflow
- **Daily driver:** a local harness or editor (T3 Code or Cursor), steered by my skills and the markdown tracker.
- **Delegated work:** a cloud orchestrator (e.g. a Cursor Project) hands well-scoped tickets to cloud agents, which return draft PRs and update the ticket.
- **On the go:** a phone-reachable assistant with visibility into the work handles occasional tasks and can dispatch cloud work when asked.
- **Work/life boundary:** work notifications off by default, OS focus modes, and a dedicated work assistant separate from my personal one.

## Trigger phases
1. **Off:** no autonomous triggers until the cloud environment is dialed in.
2. **Confirm:** the assistant proposes work ("New bug report, start an agent on this ticket?") and waits for a yes.
3. **Autonomous:** only after phase 2 has proven reliable.

## Multi-repo cloud environment
One environment clones three repos into a single workspace:
- **Code repo** (shared with teammates; nothing tool-specific committed)
- **Private tracker repo** (markdown issues plus an `AGENTS.md` contract for how agents pick up and close work)
- **Skills repo** (this one), linked into `~/.agents/skills` by the setup script

The install script and secrets live in the cloud provider's dashboard, not in the code repo.

## Markdown tracker
- One folder per effort, each with a `map.md` plus `issues/NN-*.md` with a status, a type, and what blocks it. Finished efforts move to `CLOSED/`.
- Locally, the tracker repo is cloned *inside* the code repo's gitignored scratch folder. It's a nested independent repo, with no submodules, so it shows up in the editor next to the code.
- It works with `wayfinder`'s local-markdown mode.

## Notes placement
- Daily notes live in a private notes repo, cloned into a gitignored folder inside the tracker workspace, so they appear in the same editor window.
- Being in git makes them reachable by cloud agents (multi-repo env) and by an assistant through GitHub, even with the laptop off.
- Avoid OS junctions/symlinks into synced folders like OneDrive, which are flaky.

## Data: shared dev environment, never prod
- Cloud agents query a **shared dev environment database** that humans also use for feature testing. They connect with a **read-only role**, created once by a human with SQL (`SELECT` grants, default privileges for future tables, `default_transaction_read_only`).
- Agents never run migrations against shared databases. Schema work and tests use a **local database on the agent VM**.
- The dev environment fills itself with the app's **own ingestion/backfill commands**, run through the hosting provider's CLI/API. No raw copies from prod, and sensitive user tables never leave prod.
- Third-party data stays on infrastructure I control. Agent VMs query it live and never store dumps or call upstream data APIs.
- Hosting API tokens given to agents are **scoped to the dev environment only**.
- Watch for confusing resource names (e.g. a database named "dev" that actually belongs to prod) and call them out loudly in agent instructions.

## Skills roadmap
1. Finish `/daily`: make paths configurable, and point it at the notes repo.
2. Write jkit versions of the Pocock skills I rely on (`wayfinder`, `grill-me`, `to-spec`, `to-tickets`, `triage`, `tdd`, `diagnosing-bugs`, `codebase-design`, `handoff`).
3. A deslop skill inspired by pstack's `unslop`.
4. A handoff-to-cloud skill that turns a tracker issue into a cloud agent prompt.
5. A bot-rules doc: no unasked coding, never prod, confirmation phases.
6. Publish this repo once there's more than one skill.

## Open questions
- Should cloud agents use the hosting provider's official CLI or an MCP server? (Leaning toward the CLI plus a scoped token.)
- Is a cloud orchestrator's shared context worth keeping alongside the markdown tracker, or should everything consolidate into the tracker?
- When is the confirmation phase reliable enough to go autonomous?
- Does a phone companion for a local harness (e.g. T3 Code Mobile) earn a place next to the assistant?
