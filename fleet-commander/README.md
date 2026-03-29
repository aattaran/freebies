# Fleet Commander

Interactive agent fleet builder for Claude Code. Pick roles, models, and effort levels -- then dispatch coordinated agent teams that work in parallel.

## What It Does

Instead of one Claude Code agent doing everything sequentially, Fleet Commander lets you deploy a **team** of specialized agents that divide and conquer:

- **Planners** decompose the task and produce a roadmap
- **Coders** implement in parallel across different files/modules
- **Debuggers** test and investigate issues
- **Reviewers** audit code quality and security
- **Researchers** gather documentation and context
- **Scouts** quickly explore the codebase

## Quick Start

After installing, just tell Claude Code:

> "Deploy 6 agents to refactor the auth module -- 2 planners, 2 coders, 2 debuggers"

Or use the interactive flow:

> "Use fleet-commander to set up a team"

The skill walks you through 5 quick steps:
1. **Task** -- what should the fleet work on?
2. **Roles** -- planner, coder, debugger, reviewer, researcher, scout
3. **Counts** -- how many of each?
4. **Model + Effort** -- two-character codes (e.g., `h1` = Haiku low, `o3` = Opus high)
5. **Confirm** -- review and launch

## Model Shorthand

Two characters: `<model><effort>`

| Code | Model | Effort |
|------|-------|--------|
| h1 | Haiku | Low |
| s2 | Sonnet | Medium |
| s3 | Sonnet | High |
| o3 | Opus | High |
| o4 | Opus | Max |

## Execution Phases

Agents run in coordinated phases, not all at once:

1. **Planners + Researchers + Scouts** run first, produce context
2. **Coders** receive the plan, implement in parallel
3. **Debuggers + Reviewers** verify the output
4. **Review loop** (optional) triggered by Critical issues only

## Installation

### Quick Install

```bash
# From this directory
chmod +x install.sh
./install.sh
```

### Manual Install

```bash
# Copy the skill
mkdir -p ~/.claude/skills/fleet-commander
cp skills/fleet-commander/SKILL.md ~/.claude/skills/fleet-commander/SKILL.md

# Copy the review skill
mkdir -p ~/.claude/skills/fleet-review
cp skills/fleet-review/SKILL.md ~/.claude/skills/fleet-review/SKILL.md

# Copy agent definitions
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/

# Copy commands
mkdir -p ~/.claude/commands
cp commands/*.md ~/.claude/commands/
```

### Windows (PowerShell)

```powershell
.\install.ps1
```

## After a Fleet Run

Use `fleet-review` to analyze results and get optimized config for next time.

## License

MIT
