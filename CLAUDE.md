# Claude Tooling

Personal Claude Code toolkit. Files at repo root get installed to `~/.claude/` via `install.sh`.

**This repo is NOT a `.claude/` directory.** Toolkit files live at the repo root and get mapped into `~/.claude/` at install time. Don't confuse repo structure with runtime structure.

## Commands

- Install/update toolkit: `./install.sh` (idempotent, re-run after changes)
- No build step, no tests currently

## Rules

- NEVER put toolkit files inside `.claude/` in this repo — they'll be picked up as project config instead of toolkit source
- NEVER add project-specific config (MCP servers, release workflows) to the toolkit — those belong in each project's own `.claude/settings.json`
- NEVER run `/gsd:update` — it pulls vanilla GSD from npm and overwrites our customized version. We manage GSD updates manually through this repo
- GSD is vendored, not forked. We own these files. Review upstream changes manually before incorporating
- The plugin system is intentionally not used — raw file installation gives full control over `settings.json`
- User-level only: toolkit installs to `~/.claude/` and cascades via resolution order (enterprise > personal > project)
- Use deep-ideation (Double Diamond + parallel web research) before committing to a direction on anything non-trivial

## Key context

See @install.sh for the mapping from repo directories to `~/.claude/` paths.
