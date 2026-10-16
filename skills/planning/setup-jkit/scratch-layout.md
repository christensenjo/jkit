# `.scratch` layout

Every `.scratch` tracker uses this layout. Folders cluttering the top level get a subfolder instead, so the tree reads at a glance in an editor.

```
.scratch/
  AGENTS.md          tracker rules for agents
  README.md          what this repo is, for humans
  cloud/             cloud environment: spec.md, state.md, install.sh
  docs/              tracker docs: issue-tracker.md, domain.md, triage-labels.md
    adr/             architecture decision records
    evidence/        verification evidence, one folder per run
  daily/             /daily-work output, one YYYY-MM-DD.md per day
    old/             daily files past their first week
  efforts/           one <effort-slug>/ per effort: map.md, spec.md, issues/
    closed/          finished efforts, moved here intact
```

## `.scratch/AGENTS.md`

Seed it with:

- One paragraph: this is the private tracker for `<owner>/<repo>`, not app code, gitignored by the codebase and backed by `<username>/<repo-name>-scratch`. Its contents stay out of shared places (public issues, PR descriptions).
- A pointer to `docs/issue-tracker.md` for the layout, ticket format and commit rules.
- A `## Hard rules` section, empty, for the user's project guardrails.

## `.scratch/README.md`

Two or three lines for humans: what the repo is, which codebase it belongs to, and that agents push to its `main` directly.