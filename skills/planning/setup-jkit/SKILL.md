---
name: setup-jkit
description: Configure a repo for the jkit engineering skills - issue tracker (a private `.scratch` repo by default), triage labels, domain docs, and the pointers agents follow to find them. Run once per repo before the other engineering skills.
disable-model-invocation: true
---

# Setup jkit

Scaffold the per-repo configuration the engineering skills read:

- **Issue tracker** - where efforts and tickets live. Default: `.scratch/`, a gitignored folder inside the repo that is its own private git repo.
- **Triage labels** - the strings for the five canonical triage roles.
- **Domain docs** - `CONTEXT.md` at the repo root; ADRs beside the tracker docs.
- **Personal docs** - the planner repo, `workspaces.md`, `stack.md` and `people.md` that the daily skills read.
- **Bridge** - the pointer chain from the committed `AGENTS.md` to the gitignored tracker docs. Search tools skip gitignored files, so agents find tracker docs only through explicit paths.

Explore, present what you found, confirm with the user, then write.

## Process

### 1. Explore

Read whatever exists:

- `git remote -v` - the host and `<owner>/<repo>`. `gh api user --jq .login` - the user's GitHub username.
- `AGENTS.md`, `CLAUDE.md` and `AGENTS.local.md` at the repo root. Does `AGENTS.md` already point at `AGENTS.local.md`? Does either file already hold an `## Agent skills` block?
- `CONTEXT.md` and `CONTEXT-MAP.md` at the repo root.
- `.scratch/` - its layout, whether it is a git repo, and its remote.
- `.gitignore` - are `.scratch/`, `AGENTS.local.md` and `docs/agents/` ignored?
- ADRs in `docs/adr/`, `.scratch/docs/adr/` and `src/*/docs/adr/`.
- `~/.agents/jkit.md` and the planner repo it names; whether this repo is listed in `workspaces.md`; `.scratch/docs/people.md` and `.scratch/docs/stack.md`.
- Prior output of this skill in `.scratch/docs/` or `docs/agents/`.
- Is the `triage` skill installed? This decides whether Section B runs.
- Monorepo signals - `pnpm-workspace.yaml`, a `workspaces` field in `package.json`, or populated `packages/*` with their own `src/`. Their absence means single-context, which is almost every repo.

### 2. Present findings and ask

Summarise what's present and what's missing, then take the sections in order - one section, one answer, then the next. Lead each with the recommended answer so the user can accept it in a word. Skip a section exploration already settled.

**Section A - Issue tracker.** Skills like `to-tickets`, `triage` and `jkit` read and write it. Recommend `.scratch` unless exploration shows the repo already tracks work elsewhere:

- **`.scratch` (recommended)** - markdown efforts and tickets in `.scratch/`, backed by a private repo `<username>/<repo-name>-scratch`.
- **GitHub** - the repo's GitHub Issues, via `gh`.
- **GitLab** - the repo's GitLab Issues, via [`glab`](https://gitlab.com/gitlab-org/cli).
- **Other** - ask for the workflow in one paragraph and record it as prose.

The GitHub and GitLab templates carry a "PRs as a request surface" flag, defaulted off. Leave it off without raising it.

**Section B - Triage labels.** Runs only when `triage` is installed. Ask one question:

> Keep the default triage labels? (recommended: **yes**)

The defaults are the five canonical roles, each label equal to its name: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. On **no** - usually because the tracker already uses other names - collect the overrides so `triage` applies existing labels.

**Section C - Domain docs.** Write **single-context** without asking: one `CONTEXT.md` at the repo root. Offer **multi-context** - a root `CONTEXT-MAP.md` pointing to per-context `CONTEXT.md` files - only when exploration found monorepo signals.

**Section D - Personal docs.** Seed whatever is missing from [personal-docs.md](./personal-docs.md):

- No planner repo: offer to create a private `<username>/daily-planner` and record its path in `~/.agents/jkit.md`.
- This repo missing from `workspaces.md`: offer to add it.
- No `people.md`: draft one with the user from the names in tickets and recent commits.
- `stack.md`: ask only whether this workspace needs its own override.

### 3. Confirm

Show drafts of every file step 4 writes, and let the user edit them. Call out the `AGENTS.md` line separately: it lands in a shared, committed file.

### 4. Write

The **tracker docs folder** is `.scratch/docs/` for a `.scratch` tracker and `docs/agents/` for any other tracker.

**`.scratch` tracker:**

1. Add `.scratch/` to the repo's `.gitignore`.
2. Scaffold the layout in [scratch-layout.md](./scratch-layout.md), with a `.gitkeep` in each empty folder. Move existing `.scratch/` content into the layout effort by effort, after the user approves the moves.
3. Normalize ticket statuses to the canonical set in [issue-tracker-local.md](./issue-tracker-local.md): `unclaimed`, a blank `Status:` or a missing line become `open`; `closed` becomes `resolved`; `out of scope` becomes `wontfix`. Show the counts before rewriting.
4. Run `git init -b main` in `.scratch/` and make the first commit. Offer `gh repo create <username>/<repo-name>-scratch --private --source .scratch --push`, and run it on yes.

**Other trackers:** add `docs/agents/` to the repo's `.gitignore`.

**Every tracker:**

1. Write the tracker docs folder from the seed templates in this skill folder:
   - `issue-tracker.md` from [issue-tracker-local.md](./issue-tracker-local.md), [issue-tracker-github.md](./issue-tracker-github.md) or [issue-tracker-gitlab.md](./issue-tracker-gitlab.md); for "other", write it from the user's description.
   - `domain.md` from [domain.md](./domain.md).
   - `triage-labels.md` from [triage-labels.md](./triage-labels.md), only when Section B ran.
2. Write the bridge:
   - **`AGENTS.md`** (committed, shared with the team): ensure it carries this line, adding it only when missing. Keep it tool-agnostic - it is the only jkit trace in the shared file.

     > Some developers keep a personal, gitignored `AGENTS.local.md` at the repo root for issue tracking and agent process. If it exists, read it and follow it on those questions.

     Create `AGENTS.md` when neither `AGENTS.md` nor `CLAUDE.md` exists. Edit `CLAUDE.md` only when it exists and `AGENTS.md` does not.
   - **`AGENTS.local.md`** (gitignored; add it to `.gitignore`): write or update the `## Agent skills` block in place, keeping the user's other sections:

     ```markdown
     ## Agent skills

     - **Issue tracker:** [one-line summary]. Read `<tracker docs folder>/issue-tracker.md` before any ticket work.
     - **Triage labels:** [one-line summary]. See `<tracker docs folder>/triage-labels.md`.
     - **Domain docs:** `CONTEXT.md` at the repo root; ADRs in `<tracker docs folder>/adr/`. See `<tracker docs folder>/domain.md`.
     ```

     For a `.scratch` tracker, add `.scratch/AGENTS.md` to the issue tracker line. Omit the triage line when Section B didn't run.

### 5. Done

Tell the user setup is complete and which skills now read these files. They can edit the tracker docs directly; re-running this skill is only for switching trackers or starting over.