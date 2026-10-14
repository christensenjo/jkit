# Personal docs

Three docs the daily and planning skills read. Seed each from its template, then fill it in with the user.

## Planner repo

A private repo (for example `<username>/daily-planner`) holding `/daily-planner`'s files, `workspaces.md` and the default `stack.md`:

```
daily-planner/
  README.md
  stack.md
  workspaces.md
  daily/
    old/
```

Record its local path in `~/.agents/jkit.md` so skills can find it. `jkit.md` holds only machine-specific settings - paths that differ per machine. Everything that should match across machines (tools, workspaces, people) lives in a synced repo.

```markdown
# jkit

- Planner repo: <absolute local path>
```

## `workspaces.md` (planner repo)

The primary work repos `/daily-planner` runs `/daily-work` in.

```markdown
# Workspaces

| Workspace | Local path | Scratch repo |
| --------- | ---------- | ------------ |
| <name>    | <path>     | <username>/<repo>-scratch |
```

## `stack.md` (planner repo, optional override in `.scratch/docs/stack.md`)

The user's current tools. A workspace copy overrides the planner's for that workspace.

```markdown
# Stack

- **Personal assistant:** <bot that may run /daily-planner>
- **1:1 harness:** <tool for hands-on agent work>
- **Cloud agents:** <where parallel agents run, and their model>
- **IDE:** <editor>
- **Comms sources:** <email, texts, chat the assistant can read>
```

## `people.md` (`.scratch/docs/people.md`)

Who matters in this workspace. `/daily-work` names people from it and uses it to pick which messages reach Comms.

```markdown
# People

## <Name>
- **Role:** <role>
- **Owns / decides:** <areas>
- **Reach via:** <email, chat handle, phone>
- **Notes:** <working style, current threads>
```