# skills

Joel's personal agent skills. Not published. Iterate here, then promote a skill out of `skills/in-progress/` if it earns a real bucket.

## daily

[skills/in-progress/daily/SKILL.md](skills/in-progress/daily/SKILL.md) plans the day in the current project's `.scratch/DAILY/`.

Invoke it by name: `/daily start`, `/daily next`, `/daily close`. User-invoked only.

Daily files stay in the project (`.scratch/DAILY/YYYY-MM-DD.md`), not in this repo. A new project that wants the same workflow gets its own `.scratch/`.

### Make Cursor see it

Windows (junction, no admin):

```powershell
New-Item -ItemType Directory -Force -Path "$HOME\.cursor\skills" | Out-Null
cmd /c mklink /J "$HOME\.cursor\skills\daily" (Resolve-Path ".\skills\in-progress\daily")
```

Later harnesses can point at the same folder:

- Claude Code: `~/.claude/skills/daily`
- Codex: `~/.agents/skills/daily`
