# jkit

Hi there, I'm [Joel](https://joelchristensen.dev). I've been coding since I was 14, and just like every other developer I've been adapting to the breakneck pace at which AI is changing software engineering. jkit is my personal framework of skills and tools that I've liked best and found most effective in my AI development workflow.

jkit is heavily inspired by [Matt Pocock's skills](https://github.com/mattpocock/skills) and [poteto's pstack](https://github.com/cursor/plugins/tree/main/pstack). I've made it public but as of now this is mostly for myself.

> [!WARNING]
> jkit is still a work in progress! Expect breaking changes.

## General AI Principles

- **Use Subscriptions, avoid API rates.** Codex and Cursor subscriptions offer subsidization of cost-per-token. Try to maximize these savings.
- **Prefer simple Markdown for agility.** I prefer to keep issues and other work in a plain-markdown tracker so that I can easily open and manage it myself locally. Expose this to cloud agents by publishing a private GitHub repo. Don't add this sort of stuff to shared projects.
- **Leverage cloud agents to parallelize work. (WIP)** Well-scoped tickets go to cloud agents that can run simultaneously and return draft PRs. Deep, 1:1 work happens locally in my editor/harness of choice.
- **Control agent access.** Slowly increase agent autonomy over specific domains as you become increasingly confident. Protect production environments responsibly.
- **Stay tool-agnostic.** Skills live in `~/.agents/skills` so any harness can use them, and cloud environments clone this repo as necessary to get the same skills.

More detail:
- [Tool exploration](docs/tool-exploration.md): the tools I've tried, what I learned, and where each one stands.
- [Future direction](docs/future-direction.md): principles, target workflow, and the roadmap.

## Skills

### Original

- **`/daily`** _(in progress)_: See the day's errands, work, and fun along with long term plans all at a glance. Carries forward unfinished errands and work, scans the markdown issue tracker for live efforts, labels tickets as "takeable" (ready for an agent and unblocked), marks one slice of work for today, and emits a copyable prompt that hands the takeable tickets to a fresh agent session. Great for organizing mental bandwidth.

### Inspired by others (planned)

jkit versions of skills I use daily, adapted to my workflow:

From [mattpocock/skills](https://github.com/mattpocock/skills):
- `wayfinder`: plan a large effort as a map of decision tickets in the issue tracker _(planned)_
- `grill-me` / `grill-with-docs`: get interrogated about a plan before building it _(planned)_
- `to-spec` and `to-tickets`: turn a conversation into a spec, then into tickets _(planned)_
- `triage`: sort and label incoming issues _(planned)_
- `tdd`: test-driven implementation loop _(planned)_
- `diagnosing-bugs`: structured bug investigation _(planned)_
- `codebase-design`: design and architecture guidance _(planned)_
- `handoff`: hand context off to a fresh session _(planned)_

From [poteto's pstack](https://github.com/cursor/plugins/tree/main/pstack):
- `unslop`: pstack's skill for stripping "AI slop" out of writing. jkit will have my own deslop version _(planned)_


## Joel's Current Tool Stack

### Personal assistant/orchestrator
- *Grok Bot.* Grok Bots are a great way to manage everything in your life from a single place. Haven't tried OpenAI Dots yet.

### Cloud development
- *Cursor Cloud Agents.* Haven't tried Amp yet. These work well with Grok Bot and Cursor Projects.

### Local Harness
- *T3 Code.* Accesses all the inference providers I need. Delta is great but doesn't have Cursor sub support.

### IDE
- *Zed.* Far and away the best modern IDE for manual coding.

### Subscriptions
- *Cursor*
- *Codex*
- *OpenCode Go*

### Design
- *Figma*
- *Paper*

### Notes/Scratchpad
- *Sublime Text*

### DBMS
- *TablePlus*
