# Cloud environment

The Section E branch of `/setup-jkit`. The cloud folder is `cloud/` inside a `.scratch` tracker, and `cloud/` at the repo root for any other tracker.

## Questions

One question at a time. Skip a question the Cloud use line already answers, and confirm that answer in one line instead.

> Which provider or implementation runs the cloud agents? (recommended: the Cloud use line in `~/.agents/JKIT.md`)

> How does a fresh machine get ready? (recommended: it clones this repo and the tracker, runs `cloud/install.sh`, and that script writes `~/.agents/JKIT.md`)

When the provider answer names something, set the Cloud use line in `~/.agents/JKIT.md` to the same words.

## Guidance

Write a short brief for the provider they named:

- Which repos a fresh machine clones: the planner git URL and this workspace's repo and tracker git URLs, from `~/.agents/JKIT.md`.
- The boot file: `cloud/install.sh`.
- Skills: link jkit into `~/.agents/skills`, plus any other home skills directory the user says that provider reads.

When you do not know where that provider runs a setup script, ask the user and record their answer. Write console steps only after the user supplies them.

## Record

Write `cloud/spec.md` and `cloud/state.md` from the templates below, in the user's words. Show the drafts before writing.

Then ask:

> Write the install script now? (recommended: **yes**)

On **yes**, read the `setup-cloud-env` skill and follow it. On **no**, leave the install-script line in `state.md` open.

Done when `spec.md` and `state.md` match the confirmed drafts, and the install script exists or its state line is still open.

## `cloud/spec.md`

```markdown
# Cloud spec

- **Provider:** <provider or implementation>
- **Boot:** <how a fresh machine starts, including the setup script path>
- **Clones:** <planner, repo, and tracker git URLs>
- **Skills:** <home skills directories>
- **Data:** services on this machine only. Shared and production data stay unused. Secrets stay out of this folder.
- **Config:** `cloud/install.sh` inlines the shared values from `~/.agents/JKIT.md` and writes `$HOME/.agents/JKIT.md`. Checkout paths are discovered when the script runs.
```

## `cloud/state.md`

```markdown
# Setup state

- [ ] Spec recorded
- [ ] Install script written
- [ ] Config block matches `~/.agents/JKIT.md`
- [ ] Ran on a fresh machine
```

Check a line when that part is done. Leave "Ran on a fresh machine" open until the user says a fresh machine completed it.
