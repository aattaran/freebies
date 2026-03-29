# Claude Code Skills Pack

12 battle-tested skills that make Claude Code dramatically better at writing, reviewing, debugging, and shipping code. Drop them in and Claude automatically activates them when relevant.

## What's Included

### Code Quality (use these daily)

| Skill | What It Does |
|-------|-------------|
| **code** | Disciplined implementation protocol. Read before writing, trace dependencies, handle errors. Covers JS/TS and Python. |
| **review** | 4-pass code review: implementer audit, debugger, security reviewer, final verification. Fixes issues in-place. |
| **debug** | Systematic debugging: reproduce, isolate, binary search for root cause, fix, verify. No guessing. |
| **bulletproof** | Rigorous 5-phase protocol for critical code: trace data flow, audit security, handle all error states, check regressions. |
| **audit** | Full security (OWASP) + code quality + performance + tech debt audit. Produces ranked, actionable findings. |

### Architecture

| Skill | What It Does |
|-------|-------------|
| **backend-architect** | Complete backend blueprint: project structure, middleware ordering, error handling patterns, auth, DB patterns, security hardening, testing, go-live checklist. For Node.js/TypeScript. |
| **ui-master-architect** | Definitive SaaS UI design system. 10 aesthetic presets, component patterns, motion effects, page blueprints. For Next.js + Tailwind + shadcn/ui. |

### Workflow

| Skill | What It Does |
|-------|-------------|
| **orchestrate** | Multi-agent coordination. Breaks complex tasks into parallel workstreams with clear boundaries and merge strategy. |
| **tokenopt** | Token optimization for prompts and LLM application code. Cuts prompt bloat, optimizes API costs. |
| **skill-optimizer** | 3-Round Climb protocol to evaluate and improve your own skill files. Auto-fixes structural issues. |
| **mcp-router** | Auto-detects which MCP server to use for any task. Routes to the right tool (Firecrawl, Playwright, Context7, etc.). |
| **skill-lookup** | Search and install community skills from the prompts.chat registry. |

## Installation

### Quick Install (recommended)

```bash
# From this directory
chmod +x install.sh
./install.sh
```

### Manual Install

Copy the skill files to your Claude Code skills directory:

```bash
mkdir -p ~/.claude/skills

# Copy each skill
cp skills/code.md ~/.claude/skills/code/SKILL.md
cp skills/review.md ~/.claude/skills/review/SKILL.md
cp skills/debug.md ~/.claude/skills/debug/SKILL.md
cp skills/bulletproof.md ~/.claude/skills/bulletproof/SKILL.md
cp skills/audit.md ~/.claude/skills/audit/SKILL.md
cp skills/orchestrate.md ~/.claude/skills/orchestrate/SKILL.md
cp skills/tokenopt.md ~/.claude/skills/tokenopt/SKILL.md
cp skills/skill-optimizer.md ~/.claude/skills/skill-optimizer/SKILL.md
cp skills/mcp-router.md ~/.claude/skills/mcp-router/SKILL.md
cp skills/skill-lookup.md ~/.claude/skills/skill-lookup/SKILL.md

# Standalone skills (no subdirectory needed)
cp skills/ui-master-architect.md ~/.claude/skills/ui-master-architect.md
cp skills/backend-architect.md ~/.claude/skills/backend-architect.md
```

### Windows (PowerShell)

```powershell
# From this directory
.\install.ps1
```

Or manually:

```powershell
$skillsDir = "$env:USERPROFILE\.claude\skills"

# Directory-based skills
foreach ($skill in @("code","review","debug","bulletproof","audit","orchestrate","tokenopt","skill-optimizer","mcp-router","skill-lookup")) {
    New-Item -ItemType Directory -Force -Path "$skillsDir\$skill" | Out-Null
    Copy-Item "skills\$skill.md" "$skillsDir\$skill\SKILL.md"
}

# Standalone skills
Copy-Item "skills\ui-master-architect.md" "$skillsDir\ui-master-architect.md"
Copy-Item "skills\backend-architect.md" "$skillsDir\backend-architect.md"
```

## How Skills Work

Claude Code automatically loads skills from `~/.claude/skills/`. Each skill has a `description` field in its YAML frontmatter -- Claude matches this against your current task and activates relevant skills automatically.

You can also invoke them directly:
- `/review` -- run a code review
- `/debug` -- start debugging
- `/audit` -- security + quality audit
- `/code` -- disciplined implementation
- `/bulletproof` -- critical path review

## Customization

These are plain Markdown files. Edit them to match your stack, conventions, or preferences. The YAML frontmatter at the top controls when Claude activates the skill.

## License

MIT
