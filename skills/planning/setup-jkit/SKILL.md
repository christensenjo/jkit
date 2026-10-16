---
name: setup-jkit
description: Configure a repo for the jkit skills, including the tracker, domain docs, and this machine's ~/.agents/JKIT.md. Run once per repo.
disable-model-invocation: true
---

# Setup jkit

Scaffold the per-repo configuration the engineering skills read:

- **Issue tracker** - where efforts and tickets live. Default: `.scratch/`, a gitignored folder inside the repo that is its own private git repo.
- **Triage labels** - the strings for the five canonical triage roles.
- **Domain docs** - `CONTEXT.md` at the repo root; ADRs beside the tracker docs.
- **Machine config** - `~/.agents/JKIT.md`, the only copy of the planner repo, stack, cloud use, and workspace list. See [personal-docs.md](./personal-docs.md).
- **People** - `people.md` in the tracker docs, for this workspace.
- **Cloud environment** - optional. A spec, setup state, and install script in the tracker's cloud folder.
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
- `~/.agents/JKIT.md`. When it is missing, say so. When it is present, check whether this repo is listed under Workspaces.
- `people.md` in the tracker docs folder.
- The tracker's cloud folder, when it exists.
- Prior output of this skill in `.scratch/docs/` or `docs/agents/`.
- Is the `triage` skill installed? This decides whether Section B runs.
- Monorepo signals - `pnpm-workspace.yaml`, a `workspaces` field in `package.json`, or populated `packages/*` with their own `src/`. Their absence means single-context, which is almost every repo.

### 2. Present findings and ask

Summarise what's present and what's missing, then take the sections in order - one section, one answer, then the next. Lead each with the recommended answer so the user can accept it in a word. Skip a section exploration already settled. Section D's first-time branch is the exception: it grills one field at a time until the machine config is settled.

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

**Section D - Machine config.** Follow [personal-docs.md](./personal-docs.md).

- **File present.** Offer to add this repo under Workspaces when it is missing: repo git URL from `git remote`, tracker git URL from Section A, local paths for checkouts on this machine. Leave the other fields as they are.
- **File missing.** Ask one question:

  > Do you already have a `~/.agents/JKIT.md` on another machine? (recommended: **no** on a first setup)

  On **yes**, the user pastes it. Write that paste to `~/.agents/JKIT.md` and fill local paths for checkouts on this machine. On **no**, read the `grilling` skill and follow it. Keep each round to one field, in the field order personal-docs.md lists, and give a recommended answer:

  - Planner git URL: `https://github.com/<login>/daily-planner.git`. Offer to create that private repo when it does not exist.
  - Planner local path: a checkout found on this machine, otherwise blank.
  - Personal assistant, 1:1 harness, IDE, comms sources: the tools the user names. Leave a line blank until they name one.
  - First workspace: this repo. Repo URL from `git remote`. Tracker URL `<login>/<repo>-scratch` for a `.scratch` tracker, otherwise the tracker from Section A. Local paths: checkouts on this machine, otherwise blank. Then ask whether to add another workspace.
  - Cloud use: `none`.

  When the frontier is empty and the user confirms the shared understanding, write `~/.agents/JKIT.md`.

- **`people.md` missing.** Draft one from names in tickets and recent commits, as personal-docs.md shows.

**Section E - Cloud environment.** Skip when Cloud use is `none` and the user does not ask.

> Record a cloud environment for this repo? (recommended: **yes** when Cloud use names a provider, otherwise **no**)

On **yes**, read [cloud.md](./cloud.md) and follow it.

### 3. Confirm

Show drafts of every file step 4 writes, and let the user edit them. Call out two of them: the `AGENTS.md` line lands in a shared, committed file, and `~/.agents/JKIT.md` stays on this machine.

### 4. Write

The **tracker docs folder** is `.scratch/docs/` for a `.scratch` tracker and `docs/agents/` for any other tracker.

The **cloud folder** is `cloud/` inside a `.scratch` tracker. For any other tracker it is `cloud/` at the repo root, committed so a fresh machine can run it.

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
2. Write `people.md` in the tracker docs folder when Section D drafted one.
3. Write `~/.agents/JKIT.md` from the confirmed draft.
4. Write the cloud folder when Section E ran: `spec.md` and `state.md`, and `install.sh` when the user asked for the script.
5. Write the bridge:
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

Tell the user setup is complete and which skills now read these files: `/jkit` and the other engineering skills read the tracker docs; `/daily-planner`, `/daily-work`, and `/setup-cloud-env` read `~/.agents/JKIT.md`. They can edit the tracker docs and `~/.agents/JKIT.md` directly. Re-running this skill is for switching trackers, adding a workspace, or starting over.
