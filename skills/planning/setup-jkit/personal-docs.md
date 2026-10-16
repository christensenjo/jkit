# Personal docs

The machine config, the planner repo, and the per-workspace people notes.

## `~/.agents/JKIT.md`

One file per machine, at `~/.agents/JKIT.md`. It holds the planner repo, the stack, cloud use, and the workspace list.

- **This machine.** `/setup-jkit` writes the file. On a first machine, with no file anywhere, it grills each field below and then writes the file. On a later machine, the user pastes the file from the other machine, and setup fills this machine's local paths.
- **A cloud machine.** `cloud/install.sh` in the tracker's cloud folder writes the file at startup. The planner git URL, the stack, the cloud-use line, and each workspace's repo and tracker git URLs are inlined in that script. Checkout paths are discovered when the script runs. `/setup-cloud-env` copies those shared values from this machine's file into the script, and refreshes that block when the file changes.

Local paths exist only in the machine file. When a local path is blank or the directory is missing, use a checkout whose remote matches the git URL, or clone that URL.

Write the file only to `~/.agents/JKIT.md`. The planner repo, tracker repos, and workspace repos do not carry a copy.

### Resolving a checkout

1. Read `~/.agents/JKIT.md`. When it is missing, ask the user to run `/setup-jkit`.
2. Use the local path when it is set and the directory exists.
3. Otherwise find a checkout by the repo's directory name (the last path segment of the git URL) whose remote matches the git URL. Search the current directory, its parents, and the home directory.
4. Otherwise clone the git URL.

Done when the checkout is open, or the user has been asked to run `/setup-jkit`.

### Shape

```markdown
# JKIT

## Planner

- **Git:** <git url>
- **Local:** <absolute path on this machine, or blank>

## Stack

- **Personal assistant:** <bot that may run /daily-planner>
- **1:1 harness:** <tool for hands-on agent work>
- **IDE:** <editor>
- **Comms sources:** <email, texts, chat the assistant can read>

## Workspaces

### <name>

- **Repo:** <git url of the codebase>
- **Tracker:** <git url of the tracker repo>
- **Local repo:** <absolute path on this machine, or blank>
- **Local tracker:** <absolute path on this machine, or blank>

## Cloud

- **Use:** <provider and model, or none>
```

### Field order

When `/setup-jkit` creates the file, it settles these in order, one field per round:

1. Planner git URL
2. Planner local path
3. Personal assistant
4. 1:1 harness
5. IDE
6. Comms sources
7. Each workspace: name, repo git URL, tracker git URL, local repo, local tracker, then whether to add another
8. Cloud use

## Planner repo

A private repo (for example `<username>/daily-planner`) holding `/daily-planner`'s daily files and `projects.md`. Its git URL and this machine's path are fields in `~/.agents/JKIT.md`.

```
daily-planner/
  README.md
  projects.md
  daily/
    old/
```

## `people.md` (tracker docs folder)

Who matters in this workspace. `/daily-work` names people from it and uses it to pick which messages reach Comms.

```markdown
# People

## <Name>
- **Role:** <role>
- **Owns / decides:** <areas>
- **Reach via:** <email, chat handle, phone>
- **Notes:** <working style, current threads>
```
