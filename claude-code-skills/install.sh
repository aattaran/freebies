#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/skills"

echo "Installing Claude Code skills to $SKILLS_DIR"
echo ""

# Directory-based skills
SKILL_DIRS=(code review debug bulletproof audit orchestrate tokenopt skill-optimizer mcp-router skill-lookup)

for skill in "${SKILL_DIRS[@]}"; do
    mkdir -p "$SKILLS_DIR/$skill"
    cp "$SOURCE_DIR/$skill.md" "$SKILLS_DIR/$skill/SKILL.md"
    echo "  Installed: $skill"
done

# Standalone skills (no subdirectory)
STANDALONE=(ui-master-architect backend-architect)

for skill in "${STANDALONE[@]}"; do
    cp "$SOURCE_DIR/$skill.md" "$SKILLS_DIR/$skill.md"
    echo "  Installed: $skill"
done

echo ""
echo "Done. ${#SKILL_DIRS[@]} directory skills + ${#STANDALONE[@]} standalone skills installed."
echo ""
echo "Skills are active immediately in new Claude Code sessions."
echo "Invoke them with /review, /debug, /audit, /code, /bulletproof, etc."
