#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Fleet Commander to $CLAUDE_DIR"
echo ""

# Skills
mkdir -p "$CLAUDE_DIR/skills/fleet-commander"
cp "$SCRIPT_DIR/skills/fleet-commander/SKILL.md" "$CLAUDE_DIR/skills/fleet-commander/SKILL.md"
echo "  Installed: fleet-commander skill"

mkdir -p "$CLAUDE_DIR/skills/fleet-review"
cp "$SCRIPT_DIR/skills/fleet-review/SKILL.md" "$CLAUDE_DIR/skills/fleet-review/SKILL.md"
echo "  Installed: fleet-review skill"

# Agent definitions
mkdir -p "$CLAUDE_DIR/agents"
for agent in "$SCRIPT_DIR/agents/"*.md; do
    cp "$agent" "$CLAUDE_DIR/agents/$(basename "$agent")"
    echo "  Installed: agent $(basename "$agent" .md)"
done

# Commands
mkdir -p "$CLAUDE_DIR/commands"
for cmd in "$SCRIPT_DIR/commands/"*.md; do
    cp "$cmd" "$CLAUDE_DIR/commands/$(basename "$cmd")"
    echo "  Installed: command $(basename "$cmd" .md)"
done

echo ""
echo "Done. Fleet Commander is ready."
echo ""
echo "Try: 'Deploy 4 agents to implement feature X'"
echo "Or:  'Use fleet-commander to set up a team'"
