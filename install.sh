#!/usr/bin/env bash
# claude-tooling installer
# Syncs the toolkit to ~/.claude/ for user-level availability across all projects.
# Idempotent — safe to re-run to update.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
DIM='\033[2m'
RESET='\033[0m'

info()  { echo -e "${GREEN}[toolkit]${RESET} $1"; }
warn()  { echo -e "${YELLOW}[toolkit]${RESET} $1"; }
error() { echo -e "${RED}[toolkit]${RESET} $1" >&2; }

# Validate source
if [ ! -f "$REPO_DIR/install.sh" ] || [ ! -d "$REPO_DIR/agents" ]; then
  error "Could not find toolkit files. Run this script from the claude-tooling repo."
  exit 1
fi

info "Installing claude-tooling to ${DIM}$TARGET_DIR${RESET}"
echo ""

# Create target if needed
mkdir -p "$TARGET_DIR"

# Sync directories from repo root into ~/.claude/
# These are fully owned by the toolkit — the installer replaces them on each run.
SYNC_DIRS=(
  "agents"
  "commands"
  "get-shit-done"
  "hooks"
  "skills"
)

for dir in "${SYNC_DIRS[@]}"; do
  if [ -d "$REPO_DIR/$dir" ]; then
    mkdir -p "$TARGET_DIR/$dir"
    if command -v rsync &> /dev/null; then
      rsync -a --delete "$REPO_DIR/$dir/" "$TARGET_DIR/$dir/"
    else
      rm -rf "$TARGET_DIR/$dir"
      cp -r "$REPO_DIR/$dir" "$TARGET_DIR/$dir"
    fi
    info "  Synced ${DIM}$dir/${RESET}"
  fi
done

# Copy standalone files
COPY_FILES=(
  "package.json"
  "gsd-file-manifest.json"
)

for file in "${COPY_FILES[@]}"; do
  if [ -f "$REPO_DIR/$file" ]; then
    cp "$REPO_DIR/$file" "$TARGET_DIR/$file"
    info "  Copied ${DIM}$file${RESET}"
  fi
done

# Generate settings.json
# This owns the global settings. Project-specific settings (MCP servers, etc.)
# should live in the project's .claude/settings.json.
SETTINGS_FILE="$TARGET_DIR/settings.json"

# Back up existing settings if they weren't created by this toolkit
if [ -f "$SETTINGS_FILE" ]; then
  if ! grep -q "gsd-check-update" "$SETTINGS_FILE" 2>/dev/null; then
    BACKUP="$SETTINGS_FILE.backup.$(date +%Y%m%d%H%M%S)"
    cp "$SETTINGS_FILE" "$BACKUP"
    warn "  Backed up existing settings.json to ${DIM}$(basename "$BACKUP")${RESET}"
  fi
fi

cat > "$SETTINGS_FILE" << 'SETTINGS_EOF'
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "node $HOME/.claude/hooks/gsd-check-update.js"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "node $HOME/.claude/hooks/gsd-context-monitor.js"
          }
        ]
      }
    ]
  },
  "statusLine": {
    "type": "command",
    "command": "node $HOME/.claude/hooks/gsd-statusline.cjs"
  }
}
SETTINGS_EOF
info "  Generated ${DIM}settings.json${RESET}"

echo ""
info "Installation complete."
info "Skills, agents, commands, hooks, and GSD workflow are now available globally."
echo ""
echo -e "${DIM}To verify, start Claude Code in any project and try:${RESET}"
echo -e "${DIM}  /gsd:help        — GSD workflow commands${RESET}"
echo -e "${DIM}  /deep-ideation   — Deep ideation skill${RESET}"
