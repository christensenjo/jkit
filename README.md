![jkit](assets/banner.png)

# jkit

> [!WARNING]
> I'm still building jkit. Expect significant changes.

Hi there, I'm [Joel](https://joelchristensen.dev). I've been coding since I was 14, and just like every other developer I've been adapting to the breakneck pace at which AI is changing software engineering. jkit is my personal framework of skills and workflows I prefer for AI development.

jkit is largely based on [Matt Pocock's skills](https://github.com/mattpocock/skills). Credit for most of the skill design goes to him. I've also taken some inspiration from [poteto's pstack](https://github.com/cursor/plugins/tree/main/pstack) which I intend on studying further. I'm designing jkit to be public-facing and tool-agnostic so anyone can use it, but it's mostly for myself.

## Getting Started

1. Install via skills.sh `npx skills@latest add christensenjo/jkit`
2. Run `/setup-jkit`. This will guide you through choosing an issue tracker, triage labels, and domain docs, and it writes `~/.agents/JKIT.md` (`$HOME/.agents/JKIT.md`) in this machine's home directory. More on that below.
3. Use `/jkit` with any prompt

## Skills Workflow

The main workflow of jkit revolves around the self-named [`/jkit` skill](skills/planning/jkit/SKILL.md). `/jkit` is based on Matt Pocock's [`/wayfinder`](https://github.com/mattpocock/skills/blob/main/skills/engineering/wayfinder/SKILL.md) but is more action-oriented and is designed to be the only skill you'll need during most day-to-day engineering work. Example usage includes:

**Work a specific ticket**
```
/jkit Claim and complete .scratch/lambda-common-pack/issues/01-extract-shared-modules.md
```

**Pick up the next ready ticket**
```
/jkit Work the next ready ticket in the lambda-common-pack effort.
```

**Check where an effort stands**
```
/jkit What's the status of lambda-common-pack? What's blocked, and what's ready for an agent?
```

**Triage incoming bugs and requests**
```
/jkit What needs my attention? Triage the new tickets.
```

**Knock out a small task**
```
/jkit Small task: bump the Laravel version and fix anything that breaks.
```

**Find architecture improvements**
```
/jkit Review the architecture of the play-by-play import. Where could it be deeper?
```

**Start working on a new effort**
```
/jkit I need to figure out how to implement client-side filtering. Help me to figure out what the most atomic dataset is and plan an approach that won't compromise performance.
```

### Issue Tracker

While it should work with any issue tracker of your choice (GitHub, GitLab, Linear), /jkit defaults to using a simple `.scratch` directory of markdown files in each project. This suggested approach is co-located with the rest of your code, but safely gitignored and scoped for personal use on any team. It can be published as a private git repo parallelized cloud agent access. (Planned: teach Cursor Projects or similar to sync with your issue tracker.)

### Manage Human Context-Load

`/daily-planner` is designed for use with a personal assistant bot such as Grok Bot or OpenAI Dots. Get a go-to daily file that tracks everything in your life at a glance. Each primary workspace you specify then gets a similar `/daily-work` file that tracks short-term tasks to keep productivity high.

### All Skills

<details>
<summary>all skills</summary>

| skill | use it when |
|---|---|
| [`/jkit`](skills/planning/jkit/SKILL.md) | default entry point for engineering work: plan an effort, work a ticket, check status, triage, close an effort. |
| [`/setup-jkit`](skills/planning/setup-jkit/SKILL.md) | you're starting jkit in a repo. records your tracker (`.scratch`, GitHub, GitLab), doc layout, and `~/.agents/JKIT.md` in this machine's home directory. run once per repo. |
| [`/setup-cloud-env`](skills/planning/setup-cloud-env/SKILL.md) | a fresh machine should recreate `~/.agents/JKIT.md`. writes or refreshes that repo's cloud install script. |
| [`/ask-joel`](skills/planning/ask-joel/SKILL.md) | you're new to jkit, or unsure which skill fits or whether to start a fresh chat. |
| [`/to-spec`](skills/planning/to-spec/SKILL.md) | you want a written spec for an effort before it's split into tickets. `/jkit` uses it for you. |
| [`/to-tickets`](skills/planning/to-tickets/SKILL.md) | you want a plan split into thin, vertical tickets, approved by you before anything is written. `/jkit` uses it for you. |
| [`/triage`](skills/planning/triage/SKILL.md) | bugs and requests you didn't write need sorting into agent-ready tickets. `/jkit` uses it for you. |
| [`/tdd`](skills/engineering/tdd/SKILL.md) | you're building behavior test-first, one red-green slice at a time. |
| [`/code-review`](skills/engineering/code-review/SKILL.md) | you want a branch or diff reviewed against your standards and the ticket's spec, side by side. |
| [`/diagnosing-bugs`](skills/engineering/diagnosing-bugs/SKILL.md) | a hard bug, flake, or regression resists a first look. builds a failing loop before theorizing. |
| [`/prototype`](skills/engineering/prototype/SKILL.md) | a logic or UI question is easier to answer with throwaway code than on paper. |
| [`/research`](skills/engineering/research/SKILL.md) | you want a question answered from primary sources, cited, in a markdown file. |
| [`/domain-modeling`](skills/engineering/domain-modeling/SKILL.md) | a domain term is fuzzy or overloaded, or a hard-to-reverse decision deserves an ADR. |
| [`/codebase-design`](skills/engineering/codebase-design/SKILL.md) | you're shaping a module: deep modules, small interfaces, clean seams. |
| [`/improve-codebase-architecture`](skills/engineering/improve-codebase-architecture/SKILL.md) | you have a spare moment to find deepening opportunities, shown in a visual report. |
| [`/resolving-merge-conflicts`](skills/engineering/resolving-merge-conflicts/SKILL.md) | you're mid-merge or mid-rebase with conflicts. resolves by each side's intent, never aborts. |
| [`/grilling`](skills/chat/grilling/SKILL.md) | you want a plan or idea stress-tested, a round of questions at a time. |
| [`/bruh`](skills/chat/bruh/SKILL.md) | the last message didn't land. restates it simply, with the context you were missing. |
| [`/handoff`](skills/chat/handoff/SKILL.md) | you're moving work to a new tool, repo, colleague, or side task and need a portable summary. |
| [`/daily-planner`](skills/productivity/daily-planner/SKILL.md) | you want one daily file tracking everything in your life at a glance. |
| [`/daily-work`](skills/productivity/daily-work/SKILL.md) | you want a workspace's short-term tasks for the day, with a copyable `/jkit` prompt per ticket. |
| [`/writing-for-agents`](skills/writing/writing-for-agents/SKILL.md) | you're writing something agents read: skills, AGENTS.md, docs they're pointed at. |

</details>

<details>
<summary>experimenting (untried/may change a lot)</summary>

| skill | use it when |
|---|---|
| [`/automate`](.experimenting/automate/SKILL.md) | you want to find recurring work or life processes worth automating, and spec them. |
| [`/teach`](.experimenting/teach/SKILL.md) | you want to learn a topic over several sessions, with lessons, references, and learning records. |
| [`/wizard`](.experimenting/wizard/SKILL.md) | a manual setup or cutover only you can do deserves a script that walks you through it. |
| [`/writing-fragments`](.experimenting/writing-fragments/SKILL.md) | you want to gather raw material for a piece by being interviewed. |
| [`/writing-shape`](.experimenting/writing-shape/SKILL.md) | you want raw material shaped into an article, block by block. |
| [`/writing-beats`](.experimenting/writing-beats/SKILL.md) | you want raw material turned into an article as a pick-your-path of beats. |

</details>

## Current Stack

While jkit is designed to be tool agnostic so that others can leverage it however they want, these are the tools I'm currently using. See [tools](.experimenting/tools.md) for what I've tried and the principles behind these picks.

<details>
<summary>my current stack</summary>

| area | tool | notes |
|---|---|---|
| personal assistant / orchestrator | Grok Bot | haven't tried OpenAI Dots yet. |
| cloud development | Cursor Cloud Agents | works well with Grok Bot and Cursor Projects. haven't tried Amp yet. I want to decouple from SpaceXAI though. |
| local harness | T3 Code | reaches every inference provider I need. Delta is great but doesn't support a Cursor subscription. |
| IDE | Zed | far and away the best modern IDE for manual coding. I also track my `.scratch` files here. |
| subscriptions | Cursor, Codex, OpenCode Go | |
| design | Figma, Paper | |
| notes / scratchpad | Sublime Text | |
| DBMS | TablePlus | |

</details>
