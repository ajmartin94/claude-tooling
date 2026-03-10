# Personal Claude Code Toolkit: Ideation Summary

## Problem Definition

**Situation:** Working Claude Code environment (GSD + deep-ideation + hooks + status line) exists in the HeySous project. No way to reuse it across projects without manual copying or running vanilla GSD installer (which lacks personal extensions).

**Desired outcome:** One repo (`claude-tooling`) is the canonical source for the Claude Code environment. One script installs to `~/.claude/`. Re-running updates it. The toolkit is used to develop itself.

**Core tension:** Getting the setup decoupled from project-specific artifacts while keeping installation simple enough to trust. Long-term: staying on top of ecosystem changes and incorporating them into the toolkit.

## Landscape Overview

### Distribution patterns in the ecosystem
- **Raw file install to ~/.claude/** — the dominant approach (GSD, SuperClaude, Trail of Bits, zircote/.claude). Battle-tested, full control.
- **Plugin system** — exists but too new. Namespacing (`/toolkit:skill-name`), limited settings.json control, and GSD's file-based workflow incompatible with plugin cache model. Not right for this use case yet.
- **npx installer** (GSD pattern) — good UX but no uninstall, creates update/conflict problems.
- **Trail of Bits claude-code-config** — closest prior art. Self-installing via Claude Code command, idempotent re-runs, opinionated defaults. Lighter than what we need (no orchestration system).

### GSD ecosystem findings
- **27k+ stars, 129 open issues, actively maintained**
- **Top pain point: cost.** Multi-agent orchestration is expensive. GSD 2.0 fork exists entirely for model routing (Haiku for validation, Opus for architecture).
- **"Bulldozer for a flower" gap** — nothing between `/gsd:quick` and full orchestration. Most common complaint.
- **Core insights worth preserving:** File-based state (PROJECT.md, STATE.md, .planning/), fresh subagent contexts per task, atomic git commits.
- **Windows compatibility issues** in multiple open issues.

### Cross-tool config trends
- **AGENTS.md** becoming a real standard (Linux Foundation, 20k repos, Google/OpenAI/Cursor backed). Worth awareness for future cross-tool portability.
- **Unified config managers** (Ruler, rulesync, LNAI) are too new and fragmented to depend on.
- **Dotfiles pattern** for AI config is emerging — developers treating AI assistant config as first-class alongside shell/git config.

## Approaches Considered

### Approach A: Plugin system
Package toolkit as a Claude Code plugin with marketplace distribution.
- **Pros:** Built-in install/update, version tracking, marketplace discovery.
- **Cons:** Namespaced skills, can't control settings.json fully, plugin cache incompatible with GSD's file-based workflow. GSD itself hasn't migrated to plugins.
- **Verdict:** Not right for phase 1. Worth revisiting when plugin system matures.

### Approach B: Raw file installer (chosen)
Bash script that syncs toolkit files to `~/.claude/`, generates settings.json, idempotent re-runs for updates.
- **Pros:** Full control, short skill names, any settings, proven pattern across ecosystem.
- **Cons:** No built-in update mechanism, DIY version tracking.
- **Verdict:** Right for a personal toolkit. Simple, trustworthy, battle-tested.

### Approach C: npm package with install command (SuperClaude pattern)
Publish to npm, `npx claude-tooling install`.
- **Pros:** Version management, cross-platform, familiar DX.
- **Cons:** Overkill for single-user toolkit, still writes to ~/.claude/ anyway.
- **Verdict:** Consider later if toolkit gets shared more broadly.

## Recommended Direction (Implemented)

**Phase 1 (current):**
1. Extract universal files from HeySous .claude/ into claude-tooling repo
2. Write `install.sh` that syncs to `~/.claude/` with idempotent re-runs
3. Bootstrap: use the toolkit to develop the toolkit

**Phase 2 (next, built with toolkit):**
- STANDARDS.md capturing preferences and conventions
- Automated changelog watcher for GSD upstream and other dependencies
- Feedback loop mechanism (`/toolkit-feedback` or similar)
- Tiered execution modes (addressing GSD's biggest pain point)

**Phase 3 (future):**
- Per-project configuration profiles
- Cron job management for Claude Code
- Visual CLI helpers
- Devcontainer setup
- Cross-tool support (AGENTS.md generation)

## Open Questions
- Does `$HOME` in settings.json hook commands expand correctly at runtime? (needs testing)
- Should we track our own file manifest (like GSD's gsd-file-manifest.json) for update detection?
- How to handle GSD upstream updates — manual diff review or automated changelog analysis?

## Key Sources
- [Claude Code Skills Docs](https://code.claude.com/docs/en/skills)
- [Claude Code Hooks Guide](https://code.claude.com/docs/en/hooks-guide)
- [Claude Code Plugins Docs](https://code.claude.com/docs/en/plugins)
- [GSD Repository](https://github.com/gsd-build/get-shit-done)
- [GSD 2.0 Cost Saver Fork](https://github.com/itsjwill/GSD-2.0-Get-Shit-Done-Cost-saver-)
- [Trail of Bits claude-code-config](https://github.com/trailofbits/claude-code-config)
- [zircote/.claude](https://github.com/zircote/.claude) — 100+ agents, 60+ skills
- [SuperClaude Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework)
- [AGENTS.md Standard](https://agents.md/)
- [Anthropic Official Skills](https://github.com/anthropics/skills)
