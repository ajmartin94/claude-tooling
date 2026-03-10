# Claude Tooling

Personal Claude Code toolkit. One repo, one install, every project gets the full environment.

## What This Repo Is

This is the canonical source for my Claude Code setup — skills, agents, commands, hooks, and the GSD workflow. The `install.sh` script syncs everything to `~/.claude/` for user-level availability across all projects.

**This repo is NOT a `.claude/` directory.** Toolkit files live at the repo root (agents/, commands/, skills/, etc.) and get mapped into `~/.claude/` at install time. This prevents Claude Code from picking them up as project config during toolkit development.

## Repo Layout

```
agents/          → ~/.claude/agents/       (GSD subagent definitions)
commands/gsd/    → ~/.claude/commands/gsd/ (GSD slash commands)
get-shit-done/   → ~/.claude/get-shit-done/ (GSD core: bin, templates, refs, workflows)
hooks/           → ~/.claude/hooks/        (status line, context monitor, update checker)
skills/          → ~/.claude/skills/       (deep-ideation, future skills)
install.sh       → run to sync + generate settings.json
.planning/       → ideation docs, stays in repo
.claude/         → this repo's own project-level settings (not part of the toolkit)
```

## Install / Update

```bash
./install.sh
```

Idempotent. Re-run after any changes to push updates to `~/.claude/`.

## Key Decisions

- **No plugins.** The plugin system namespaces skills and can't fully control settings.json. Raw file installation gives full control.
- **GSD is vendored, not forked.** We took GSD's files as a starting point and own them going forward. Upstream GSD changes are reviewed manually before incorporating.
- **User-level only.** The toolkit installs to `~/.claude/` and cascades into all projects via Claude Code's resolution order (enterprise > personal > project). Projects can override or extend via their own `.claude/`.
- **Deep-ideation is a custom skill** for structured exploration using the Double Diamond method with parallel web research. Use it before committing to a direction on anything non-trivial.

## What NOT To Do

- Don't put toolkit files inside `.claude/` in this repo — they'll get picked up as project config.
- Don't add project-specific config (MCP servers, release workflows) to the toolkit. Those belong in each project's own `.claude/settings.json`.
- Don't run `/gsd:update` — that pulls vanilla GSD from npm and overwrites our customized version. We manage GSD updates manually through this repo.

## Future Direction

This toolkit will grow to include: automated dependency/changelog watching, per-project configuration profiles, cron job management, CLI visual helpers, devcontainer setup, and a feedback loop for capturing improvements during active project use. See `.planning/ideation/personal-claude-toolkit.md` for the full ideation summary.
