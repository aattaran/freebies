---
name: skill-optimizer
description: >
  Evaluate and improve all Claude Code skill files (.md prompts) using the
  3-Round Climb protocol. Checks for structural issues (broken frontmatter,
  PowerShell wrappers, missing descriptions), runs inline evals, mutates
  failing skills, and deploys winners. Use when optimizing skills, running
  skill evals, or improving prompt quality across the skill collection.
---

# Skill Optimizer Protocol

Systematically evaluate and improve all Claude Code skill files. Runs a 3-Round Climb loop per skill: mutate → eval → compare → deploy winner.

## Skill Locations

Scan both directories for `.md` files with skill content:

- **Project skills**: `./skills/*/SKILL.md`
- **Global skills**: `~/.claude/skills/*/SKILL.md` and `~/.claude/skills/*.md` (standalone)

## Phase 1: Inventory & Triage

For each skill file found:

1. Read the file
2. Check structural health:
   - Has valid YAML frontmatter (`---` delimiters, `name`, `description`)?
   - Is `description` displaying correctly (not `@"` or empty)?
   - No PowerShell wrapper artifacts (`@"` prefix, `"@ | Out-File` suffix)?
   - `triggers` attribute NOT used (unsupported in Claude Code — use `description` keywords instead)?
3. Check content quality:
   - Does the skill provide actionable instructions (not just vague guidelines)?
   - Are there structured templates, examples, or checklists where appropriate?
   - Does it handle error cases and edge scenarios?
   - Is it shell-agnostic (dual-mode Bash + cmd.exe) if it uses shell commands?
4. Score: assign baseline out of 15 (3 eval categories × 5 expectations each)

**Skip** skills already at 100% unless the file was modified since last optimization run.

## Phase 2: Fix Structural Issues First

These are free wins — fix before evaluating content:

| Issue | Fix |
|-------|-----|
| PowerShell `@"` wrapper | Strip `@"` from line 1 and `"@ \| Out-File...` from last line |
| Missing YAML frontmatter | Add `---` block with `name` and `description` |
| Empty/broken description | Write a description with use-case keywords for skill matching |
| `triggers` attribute | Remove it; move trigger keywords into `description` instead |
| Hardcoded paths | Replace with `<your project root>` or env var references |
| Windows-only commands | Add Step 0 shell detection + dual-mode commands |

## Phase 3: 3-Round Climb (Content Optimization)

For each skill that didn't reach 100% after structural fixes:

### Eval Suite

Load evals from `<skill>-workspace/evals.json` if it exists. Otherwise, generate 3 evals with 5 expectations each covering:

1. **Protocol coverage** — does it address all phases/steps it claims?
2. **Edge case handling** — does it handle errors, false premises, unusual inputs?
3. **Skill matching** — does the description contain keywords for discoverability?

### Grading Method: Inline Analysis

Read the SKILL.md content and grade each expectation directly against the text. Do NOT spawn executor agents — inline grading is faster and more reliable.

### Loop

```
v_best = v0 (current file)
for round in 1..3:
  Analyze failures → generate mutated prompt (v_next)
  Grade v_next against eval suite
  if v_next score > v_best score:
    v_best = v_next
  if v_best score == 100%:
    break  # converged
  if score dropped or plateaued for 2 consecutive rounds:
    break  # degradation early exit
Deploy v_best (only if it strictly beats v0)
```

## Phase 4: Bookkeeping

After each skill:

1. Save workspace artifacts:
   - `<skill>-workspace/history.json` — version history with scores
   - `<skill>-workspace/evals.json` — eval suite used
   - `<skill>-workspace/v0/SKILL.md` — original backup
   - `<skill>-workspace/v1/SKILL.md` — winning version (if changed)

2. Update `global_optimization_log.md`:
   - Summary table row (skill, baseline, final, rounds, result)
   - Detailed results section (what failed, what changed, why it worked)

## Phase 5: Summary Report

After all skills processed, output:

- Total skills scanned / improved / skipped / not found
- Average baseline → final score
- Issue categories found and fixes applied
- Any skills that need manual attention

## Key Rules

- **Read before writing** — always read the current skill file before proposing changes
- **Preserve content** — structural fixes should not alter the protocol/instructions
- **Enhanced descriptions win** — pack the `description` field with use-case keywords
- **No triggers attribute** — Claude Code doesn't support it; description is the matching mechanism
- **Workspace for rollback** — always save v0 backup before deploying changes
- **Log everything** — append results to `global_optimization_log.md` for tracking over time
