# claude-tooling

My personal Claude Code operating system. A curated, version-controlled toolkit that installs to `~/.claude/` and gives every project access to the same environment — structured workflows, custom skills, and smart defaults.

## Why

The value in AI-assisted development isn't the code — it's the curation. Anyone can rebuild a workflow in an afternoon. The hard part is knowing what to build, keeping it current as the ecosystem evolves at breakneck speed, and feeding real-world experience back into the system.

This repo is where that happens. One source of truth. One install command. Every project benefits.

## What's Inside

- **GSD (Get Shit Done)** — A spec-driven development workflow with structured phases, parallel subagent execution, atomic commits, and state tracking that survives context resets. Vendored and customized from [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done).
- **Deep Ideation** — A Double Diamond exploration skill for researching the landscape before committing to a direction. Dispatches parallel research agents, synthesizes findings, and produces actionable summaries.
- **Hooks** — Status line with context usage tracking, GSD update checker, and a context monitor that warns the agent when the window is running low.

## Quick Start

```bash
git clone <this-repo> ~/claude-tooling
cd ~/claude-tooling
./install.sh
```

That's it. Start Claude Code in any project — `/gsd:help` and `/deep-ideation` are available immediately.

Re-run `./install.sh` after pulling changes to update your environment.

## Roadmap

- Automated changelog watching for upstream dependencies
- Feedback capture skill for logging toolkit improvements during active projects
- Per-project configuration profiles
- Cron job management for Claude Code
- CLI visual helpers
- Devcontainer setup

## License

Personal toolkit. Not currently intended for distribution, but built on MIT-licensed components (GSD).
