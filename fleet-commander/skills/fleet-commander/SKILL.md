---
name: fleet-commander
description: "Interactive agent fleet builder. Deploy coordinated teams of agents with custom roles, model selection, and effort levels. Walks through a 5-message configuration flow, then dispatches agents in phased execution. Use when user mentions: deploy fleet, spawn fleet, launch fleet, agent team, multi-agent, parallel agents, deploy a team."
---

# Fleet Commander

Deploy coordinated agent teams with interactive role, model, and effort selection. Five messages from zero to fleet launch.

**Core principle:** The user picks roles, counts, models, and effort levels. The lead agent decomposes the task, dispatches subagents in coordinated phases, and reports calibration metrics afterward.

## Role Registry

| Role | Default | Allowed Tools | Focus |
|------|---------|---------------|-------|
| planner | s2 | Read, Glob, Grep, Bash | Analyze codebase, produce plan. Read-only. |
| coder | o3 | Read, Edit, Write, Bash, Glob, Grep | Implement changes. Full permissions. |
| debugger | s2 | Read, Bash, Glob, Grep | Run tests, trace bugs. Read-only (may edit tests). |
| reviewer | s3 | Read, Glob, Grep | Review correctness, security, quality. Strictly read-only. |
| researcher | h1 | Read, Glob, Grep, WebSearch, WebFetch | Search docs, gather context. Read-only. |
| scout | h1 | Read, Glob, Grep, Bash | Quick codebase recon. Read-only. |

## Model Aliases

- `h` = Haiku (`claude-haiku-4-5-20251001`)
- `s` = Sonnet (`claude-sonnet-4-6`)
- `o` = Opus (`claude-opus-4-6`)

## Effort Levels

| Code | Level | System Prompt Modifier |
|------|-------|----------------------|
| 1 | low | "Be concise. Skip deep analysis. Give direct answers." |
| 2 | med | (no modifier — default behavior) |
| 3 | high | "Think step-by-step. Consider edge cases. Verify your work before reporting." |
| 4 | max | "Think very carefully and methodically. Consider all edge cases, security implications, and failure modes. Verify every assumption. Double-check your work." |

Effort is implemented by prepending the modifier to the subagent's prompt. No env vars or CLI flags.

## Phase Assignments

Each role has a default execution phase:
- **Phase 1:** planner, researcher, scout
- **Phase 2:** coder
- **Phase 3:** debugger, reviewer

## Interactive Flow

You MUST follow this exact 5-message sequence. Ask one question per message. Do not skip or combine messages.

### Message 1 — Task

If the user already described the task in their request, skip this message and use their description. Otherwise ask:

```
What task should the fleet work on?
```

### Message 2 — Roles

```
Pick roles (comma-separated):

  planner    — breaks down tasks, creates plans
  coder      — writes and modifies code
  debugger   — investigates bugs, traces issues
  reviewer   — reviews code quality and correctness
  researcher — searches docs, explores codebases
  scout      — quick recon and discovery

Or type a custom role name.
```

If the user types a role not in the list, run the **Custom Role Sub-flow** (see below) before proceeding.

### Message 3 — Counts

Show only the roles the user selected:

```
How many agents per role?

  <Role1>:  1  2  3  4
  <Role2>:  1  2  3  4
  ...
```

### Message 4 — Model + Effort

```
Model and effort for each group:

  Models:   h = Haiku    s = Sonnet    o = Opus
  Effort:   1 = low      2 = med       3 = high    4 = max

              suggested
  <Role1> (<count>):  <default>    (<model>, <effort> — <rationale>)
  <Role2> (<count>):  <default>    (<model>, <effort> — <rationale>)
  ...

Type one code per role, or "y" to accept suggestions.
```

Use the role defaults from the Role Registry for suggestions. For custom roles, suggest `s2`.

**Haiku warning:** If the user selects `h3` or `h4`, respond: "Haiku doesn't support extended thinking. Effort 3/4 will use careful prompting but consider Sonnet for tasks needing deep reasoning." Then accept the selection.

### Message 5 — Confirm & Launch

```
Fleet ready:

  <count>x <Role> — <Model>, <effort> effort
  ...

  Total: <N> agents
  Phases: <phase summary based on selected roles>

Launch? (y/n)
```

If total agents > 8, add: "Note: max 8 agents run concurrently. Your <N> agents will run in batches."

Wait for "y" before proceeding.

## Custom Role Sub-flow

When the user types an unrecognized role name, ask these 3 questions (one per message):

1. "What should `<role-name>` do?" — user describes in one sentence
2. "Can it modify files? (y/n)" — determines tool set:
   - **y:** Read, Edit, Write, Bash, Glob, Grep
   - **n:** Read, Glob, Grep, Bash
3. "When should it run? (before / parallel / after)" — maps to:
   - **before** = Phase 1 (with planners)
   - **parallel** = Phase 2 (with coders)
   - **after** = Phase 3 (with reviewers)

Default model+effort for custom roles: `s2` (Sonnet, med). The "y" shortcut in Message 4 uses `s2` for custom roles.

Construct a system prompt from the answers:
```
You are a <role-name> agent in a coordinated fleet.
Your purpose: <user's description>
Constraints: <tool set based on file permission answer>
<effort modifier if applicable>
```

## Dispatch Protocol

After the user confirms, execute phases in order.

### Pre-dispatch: Task Decomposition

Before dispatching Phase 2 coders, decompose the task into N independent subtasks (one per coder). If the task cannot be decomposed (e.g., single-file change), all coders receive the full task with instructions to focus on different aspects.

If Phase 1 planners exist, use their output for decomposition. If no planners, decompose the original task yourself.

### Phase 1 — Planners + Researchers + Scouts

Dispatch all Phase 1 agents in parallel. Each gets:
- The original task description
- Their role-specific system prompt (from agent definitions)
- The effort modifier prepended to their prompt

Wait for all Phase 1 agents to complete before proceeding.

### Phase 2 — Coders

Dispatch all coders in parallel. Each gets:
- Their assigned subtask (from decomposition)
- Phase 1 output as context (planner plans, researcher findings, scout reports)
- Their role-specific system prompt
- The effort modifier

Wait for all coders to complete before proceeding.

### Phase 3 — Debuggers + Reviewers

Dispatch all Phase 3 agents in parallel. Each gets:
- The coder outputs (summaries + file change lists)
- The original task description
- Their role-specific system prompt
- The effort modifier

Wait for all Phase 3 agents to complete.

### Phase 4 — Review Loop (Optional)

Triggered ONLY when a reviewer or debugger reports:
- `BLOCKED` status, OR
- `DONE_WITH_CONCERNS` with severity "Critical" in the concerns

**Minor concerns (Important, Minor, suggestions) do NOT trigger the loop.**

If triggered:
1. Re-dispatch coder agents with the next model tier up (h->s, s->o)
2. Include the reviewer's concern text as additional context
3. Re-dispatch reviewers to verify the fix
4. Max 2 iterations. If still unresolved, report all concerns to the user and move on.

### Skipped Phases

- **No Phase 1 roles selected:** Skip Phase 1. Coders receive the original task as context.
- **No Phase 2 roles selected:** Skip Phase 2. Phase 3 agents review the existing codebase against the task.
- **No Phase 3 roles selected:** Skip Phase 3. Fleet completes after Phase 2.
- **Single agent:** No phasing. Dispatch and report.
- **All same role:** Run in that role's default phase. Skip other phases.

### Agent Dispatch Format

When dispatching each agent, use the `Agent` tool with:
- `description`: `"fleet <role>-<n>: <brief task summary>"`
- `model`: The model selected for this group (haiku/sonnet/opus)
- `prompt`: The complete prompt including effort modifier + role instructions + task context
- `subagent_type`: Use the matching fleet agent definition if available (e.g., `fleet-planner`), otherwise `fleet-worker`
- `run_in_background`: true (for parallel dispatch within a phase)

### Agent ID Format

Sequential within role: `<role>-<n>` (e.g., `planner-1`, `planner-2`, `coder-1`).

## Handling Agent Results

Parse each agent's final message for the structured output format:

- **DONE** — proceed to next phase
- **DONE_WITH_CONCERNS** — read concerns. If severity is Critical, trigger review loop. Otherwise note and proceed.
- **BLOCKED** — attempt re-dispatch with more context and next model tier up. If still blocked, report to user.
- **NEEDS_CONTEXT** — provide missing info and re-dispatch same agent.

## Calibration Report

After all phases complete, output a calibration report. Parse `Turns Used:` and `Complexity:` fields from each agent's output by exact label match. If missing, show `?`.

```
=== Fleet Report ===
[<agent-id>]  <model+effort> — <turns> turns, <complexity> — <recommendation>
...

Suggestion: Next similar task -> <optimized config>
```

**Recommendation rules:**
- easy + few turns (<=5) → "downgrade to <lower model+effort>"
- hard + many turns (>=12) → "upgrade to <higher model+effort>"
- otherwise → "right-sized"

**Downgrade path:** o -> s -> h. Effort: 4 -> 3 -> 2 -> 1.
**Upgrade path:** h -> s -> o. Effort: 1 -> 2 -> 3 -> 4.

## Complete Example

```
User: Deploy agents to refactor the auth module

Agent (Message 2):
  Pick roles (comma-separated):

    planner    — breaks down tasks, creates plans
    coder      — writes and modifies code
    debugger   — investigates bugs, traces issues
    reviewer   — reviews code quality and correctness
    researcher — searches docs, explores codebases
    scout      — quick recon and discovery

  Or type a custom role name.

User: planner, coder, debugger

Agent (Message 3):
  How many agents per role?

    Planner:   1  2  3  4
    Coder:     1  2  3  4
    Debugger:  1  2  3  4

User: 2, 2, 2

Agent (Message 4):
  Model and effort for each group:

    Models:   h = Haiku    s = Sonnet    o = Opus
    Effort:   1 = low      2 = med       3 = high    4 = max

                suggested
    Planner  (2):  s2      (sonnet, med — planning needs enough context for MCP-heavy sessions)
    Coder    (2):  o3      (opus, high — implementation needs power)
    Debugger (2):  s2      (sonnet, med — investigation is mid-complexity)

  Type one code per role, or "y" to accept suggestions.

User: y

Agent (Message 5):
  Fleet ready:

    2x Planner   — Sonnet, med effort
    2x Coder     — Opus, high effort
    2x Debugger  — Sonnet, med effort

    Total: 6 agents
    Phases: planners first -> coders parallel -> debuggers verify

  Launch? (y/n)

User: y

Agent: [dispatches Phase 1: planner-1, planner-2]
Agent: [waits for completion, collects plans]
Agent: [decomposes task into 2 subtasks based on planner output]
Agent: [dispatches Phase 2: coder-1, coder-2 with subtask assignments]
Agent: [waits for completion, collects results]
Agent: [dispatches Phase 3: debugger-1, debugger-2 with coder outputs]
Agent: [waits for completion, collects results]
Agent: [outputs calibration report]

  === Fleet Report ===
  [planner-1]  s2 — 3 turns, easy — downgrade to h2
  [planner-2]  s2 — 4 turns, easy — downgrade to h2
  [coder-1]    o3 — 10 turns, medium — right-sized
  [coder-2]    o3 — 12 turns, hard — right-sized
  [debugger-1] s2 — 5 turns, easy — downgrade to h1
  [debugger-2] s2 — 6 turns, easy — downgrade to h1

  Suggestion: Next similar task -> 2xh2 planners, 2xo3 coders, 2xh1 debuggers
```

## Red Flags

**Never:**
- Skip the 5-message flow (even if the user provides everything upfront — confirm before launching)
- Dispatch agents without user confirmation
- Let agents from different phases run simultaneously (phases are sequential)
- Dispatch coders without subtask decomposition
- Ignore BLOCKED or NEEDS_CONTEXT status
- Skip the calibration report
- Combine multiple questions in one message during the flow
