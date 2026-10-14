# Tool exploration (AI slop)

_Last updated October 2026._ What I've tried in my AI dev workflow, what I learned, and where each tool stands. Pricing and features change fast; check the sources.

**Status key:** ✅ using · 🧪 evaluating · ⏳ later · ❌ dropped

## Principles
- **Subscriptions over API rates.** Cursor and Codex plans subsidize cost per token, so I work inside a flat monthly budget and keep on-demand billing off. When a pool runs out, I switch tools rather than pay overage.
- **Cost is a model choice.** Cheap, capable models for delegated cloud work; premium or fast modes only for hands-on sessions.
- **Plain markdown for work tracking.** Issues live in a local `.scratch` tracker I can open and edit myself, published as a private repo when cloud agents need it. None of it lands in shared projects.
- **Cloud agents for parallel work (WIP).** Well-scoped tickets go to cloud agents that run side by side and return draft PRs. Deep 1:1 work stays local in my editor or harness.
- **Earn agent autonomy.** Agents act only when asked until a domain has proven reliable, then autonomy widens one domain at a time. Production is off-limits, enforced with scoped credentials, not just instructions.
- **Stay tool-agnostic (WIP).** Skills install to `~/.agents/skills` so any harness can use them, and cloud environments clone this repo to get the same skills.
## The path so far
Cursor desktop → Codex → Delta (Zed) → OpenCode → **T3 Code**. Until recently, all of my work happened on one laptop. Now I'm adding cloud agents for delegated work and a phone-reachable assistant for occasional tasks.

## Harnesses and editors

### Cursor (desktop, cloud agents, Projects): ✅ using
- **Desktop:** my previous long-time AI harness for 1:1 agent-assisted work.
- **Cloud agents:** there's no separate VM charge. They bill at the selected model's rate, drawn from the plan's included usage before any on-demand usage. Cursor's own models get a much larger included pool than third-party models. Lesson learned: a premium default model burned through the third-party pool fast, so set the cloud agent default model deliberately and turn on-demand billing off. ([pricing](https://cursor.com/docs/account/pricing), [cloud agents](https://cursor.com/docs/cloud-agent))
- **Environments:** these can be set up in the dashboard, so no tool-specific config has to land in a shared repo. Multi-repo environments clone several repos into one workspace, for example code + private tracker + skills. ([setup](https://cursor.com/docs/cloud-agent/setup))
- **Projects (beta):** a coordinator agent that plans and delegates to cloud workers and keeps shared context files. "Subscriptions" (Slack, schedules, PRs) let it act without prompting. Turn them off until you want that. It's best treated as an orchestrator plus memory, steered by my own tracker and skills, rather than as the tracker itself. ([docs](https://cursor.com/docs/agent/projects))
- **Rules and skills in the cloud:** account-level user rules apply automatically. `AGENTS.md` and repo rules apply only if committed in a cloned repo. Only `~/.cursor/skills` syncs, not `~/.agents/skills`, so I clone my skills repo in the environment instead. ([rules](https://cursor.com/docs/rules), [skills](https://cursor.com/docs/skills))

### T3 Code: ✅ using (current favorite)
- A harness over Codex, Claude Code, Cursor, Grok, OpenCode and others, running on your own subscriptions with no token resale. It has worktrees and desktop/web/mobile apps. Orchestrator V2 (nightly) adds cross-provider task delegation and scheduled tasks. ([repo](https://github.com/pingdotgg/t3code), [site](https://t3.codes/))
- Gotcha: OpenCode 2 can't coexist with OpenCode 1.x on the same machine. That was my breakage.

### T3 Code Mobile + T3 Connect: ⏳ later
- An iOS companion that controls T3 sessions on your own machine: start runs, browse files, git, diffs, terminal. T3 Connect avoids port forwarding, but the host machine must be on and serving. V2 servers need the TestFlight build. ([App Store](https://apps.apple.com/us/app/t3-code-remote-claude-more/id6787819824), [remote access](https://github.com/pingdotgg/t3code/blob/main/docs/user/remote-access.md))
- High coding fidelity, but no help while the laptop is off.

### Delta (Zed): ❌ dropped (for now)
- I loved the UI, worktrees and multiplayer. It couldn't use my Cursor subscription, and I kept hitting provider limits. Zed itself is still my preferred editor for markdown.

### Codex: ❌ dropped as primary
- Solid, but limited model choice and 5-hour usage windows. Still usable through T3 Code with a ChatGPT subscription.

### OpenCode / OpenCode Go: ❌ dropped
- OpenCode didn't stick as a daily driver. The OpenCode Go subscription overlapped with plans I already had, so I'm cancelling it.

### Amp: ⏳ later
- The free tier runs on your own subscriptions or keys. Cloud VMs ("orbs") are billed by the minute. It's the cheapest route to cloud agents on a ChatGPT subscription, but it's another environment to maintain. ([pricing](https://ampcode.com/pricing))

### Solo: ⏳ later
- A local "meta-harness" cockpit for agents plus dev processes. No cloud agents. Only worth a look if my main harness's rough edges persist. ([site](https://soloterm.com/))

## Assistants

### Grok Bot: 🧪 evaluating
- A "personal assistant" with its own machine, email and GitHub context, and the ability to dispatch cloud agents. It works with my laptop off, which makes it my choice for occasional tasks from my phone. Lesson learned: it should only start coding when asked. Autonomous work should be intentionally allowed. Work goes through a dedicated work bot so the main chat can stay personal if desired.

## Skills and frameworks

### Matt Pocock's skills: ✅ using (primary)
- Planning-first skills (`wayfinder`, `grill-me`, `to-spec`, `to-tickets`, `tdd`, `triage`, …). `wayfinder` supports a **local-markdown** tracker, which is the backbone of my workflow. ([repo](https://github.com/mattpocock/skills))

### poteto's pstack: ❌ dropped as a framework; concepts maybe later
- Cursor's plugin with playbooks, subagents, multi-model roles and verification. Its defaults use expensive models, so run its setup first if you try it. I use its `unslop` skill and may borrow concepts later. ([plugin](https://github.com/cursor/plugins/tree/main/pstack), [mirror](https://github.com/backnotprop/pstack))

### skills.sh / `npx skills`: ✅ using
- Vercel's skills CLI and directory. It installs skills from GitHub into `~/.agents/skills` (tool-neutral) for many harnesses at once and tracks sources in a lock file. ([skills.sh](https://skills.sh/), [repo](https://github.com/vercel-labs/skills))
