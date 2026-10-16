---
name: setup-cloud-env
description: Write or refresh a repo's cloud install script so a fresh machine recreates ~/.agents/JKIT.md. Run on its own, or from /setup-jkit.
disable-model-invocation: true
---

# Setup cloud env

Write `cloud/install.sh` for this workspace. The script is idempotent and non-interactive. A fresh machine runs it, and the script writes `~/.agents/JKIT.md` (`$HOME/.agents/JKIT.md`) in that machine's home directory. Where that path lives: the `setup-jkit` skill's `personal-docs.md`.

The file shape is the schema in the `setup-jkit` skill's `personal-docs.md`. Shared values are inlined in the script. Local paths are discovered when the script runs.

## Config source

Use the first source that applies:

1. **Local file.** When `~/.agents/JKIT.md` is readable, take the planner git URL, the stack, the cloud-use line, and each workspace's repo and tracker git URLs from it.
2. **Paste.** When this machine cannot read `~/.agents/JKIT.md`, ask the user to paste it, or to give those same fields. Build from that.
3. **First time.** When they have no config, point them at `/setup-jkit` and stop.

Carry git URLs, the stack, and the cloud-use line. Checkout paths are discovered on the fresh machine.

Done when those shared values are in hand.

## Script

The cloud folder is `cloud/` inside a `.scratch` tracker, and `cloud/` at the repo root for any other tracker.

Read `cloud/spec.md` and the existing `cloud/install.sh` when they exist.

- **First write.** Start from [install.sh](./install.sh). Fill the toolchain for this workspace. Inside the marked config block, set the shared values and add one workspace heading per workspace. Keep `norm_url`, `find_checkout`, and the write.
- **Refresh.** Re-running this skill loads the config source again and updates that same block. The rest of the script stays. The block still sets `PLANNER_GIT`, which the verify step checks.

Show the script, or the replaced block on a refresh. Write it when the user approves. `chmod +x` the file.

Done when `cloud/install.sh` is executable, the marked block carries the shared values, and local paths appear only as runtime discovery.

## Requirements

The script meets each of these:

- **Locate by name.** Find each checkout by its directory name and a matching git remote. Search the current directory, its parents, the home directory, and any roots in `REPO_ROOTS`. Record a checkout path only in the `~/.agents/JKIT.md` written at runtime.
- **Toolchain.** Install the languages and package managers this workspace needs. Skip a tool already on `PATH`.
- **This machine's services.** Databases and queues listen here. Before migrating or seeding, confirm the host is local, and stop when it is not.
- **Local-only placeholders.** The script and the files it writes hold local-only values. Tokens and production credentials stay out.
- **Link the tracker.** When the tracker is a separate checkout, link it at the workspace's tracker path (`.scratch/` for a `.scratch` tracker).
- **Skills.** Link each jkit skill directory into `~/.agents/skills`, and into any other home skills directory named in `cloud/spec.md`.
- **Write `~/.agents/JKIT.md`.** Write the shared values from the marked block. Set each local path to the checkout discovered on this machine. Leave the path blank when no checkout is found.
- **Verify.** Check that the toolchain runs, the local service answers, and `~/.agents/JKIT.md` contains the planner git URL. Exit non-zero when a check fails.

## State

Update `cloud/state.md`: check "Install script written" and "Config block matches `~/.agents/JKIT.md`" when the write succeeds. Leave "Ran on a fresh machine" open until the user says a fresh machine completed it.

Done when `state.md` matches what was just written.
