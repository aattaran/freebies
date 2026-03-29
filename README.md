# Freebies

Free tools for Claude Code power users. Each package is self-contained with install scripts for macOS/Linux and Windows.

## Available Packages

### [Claude Code Skills Pack](./claude-code-skills/)

12 production-tested skills that make Claude Code write better code, catch more bugs, and ship faster.

**Includes:**
- **code** -- disciplined implementation protocol (read before write, trace dependencies, handle errors)
- **review** -- 4-pass code review that fixes issues in-place
- **debug** -- systematic debugging (reproduce, isolate, root cause, fix, verify)
- **bulletproof** -- rigorous 5-phase protocol for critical-path code
- **audit** -- full security + quality + performance + tech debt audit
- **orchestrate** -- multi-agent coordination for parallel workstreams
- **tokenopt** -- optimize prompts and LLM API calls for cost/speed
- **backend-architect** -- complete Node.js/TypeScript backend blueprint
- **ui-master-architect** -- SaaS UI design system (Next.js + Tailwind + shadcn/ui)
- **skill-optimizer** -- evaluate and improve your own skill files
- **mcp-router** -- auto-route tasks to the right MCP server
- **skill-lookup** -- search and install community skills

**Install:** `cd claude-code-skills && ./install.sh` (or `.\install.ps1` on Windows)

---

### [Fleet Commander](./fleet-commander/)

Deploy coordinated agent teams in Claude Code. Instead of one agent doing everything, dispatch planners, coders, debuggers, and reviewers that work in parallel.

**Features:**
- 6 specialized roles: planner, coder, debugger, reviewer, researcher, scout
- Model + effort selection per role (Haiku/Sonnet/Opus x low/med/high/max)
- Phased execution: plan first, implement in parallel, review at the end
- Post-run analysis with `fleet-review`

**Install:** `cd fleet-commander && ./install.sh` (or `.\install.ps1` on Windows)

---

## Requirements

- [Claude Code](https://claude.ai/code) CLI installed
- Skills directory at `~/.claude/skills/` (created automatically by install scripts)

## License

MIT

## Author

[@aattaran](https://x.com/aattaran)
