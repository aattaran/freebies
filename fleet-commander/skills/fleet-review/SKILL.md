---
name: fleet-review
description: Review fleet execution results — analyze calibration metrics, summarize outcomes, and recommend optimized fleet composition for next run.
triggers:
  - fleet review
  - review fleet results
  - how did the fleet do
  - fleet calibration
  - optimize fleet
---

# Fleet Review

Analyze the results of a fleet-commander run and produce actionable recommendations.

## When to Use

After a fleet-commander run completes, or when the user wants to review past fleet performance and optimize for next time.

## Process

### Step 1 — Find the Calibration Report

Look in the current conversation for the most recent `=== Fleet Report ===` block. If not found in context (e.g., context window rolled over), ask the user to paste it.

### Step 2 — Analyze Per-Agent Metrics

For each agent in the report:
- Was the model right-sized, overkill, or insufficient?
- Was the effort level appropriate for the complexity reported?
- Did any agents report BLOCKED or NEEDS_CONTEXT?
- Did Phase 4 review loops trigger?

### Step 3 — Summarize Outcomes

Report:
- **Task completion:** How many agents finished successfully vs blocked/failed?
- **Model efficiency:** Which groups were over/under-provisioned?
- **Phase flow:** Did the phased execution work smoothly, or did review loops trigger?
- **Cost assessment:** Were expensive models (Opus) used where cheaper ones would suffice?

### Step 4 — Recommend Next Configuration

Produce an optimized fleet config for a similar task. Apply these rules:

- **easy + few turns (<=5)** → downgrade model one tier (o->s, s->h) and/or reduce effort
- **hard + many turns (>=12)** → upgrade model one tier (h->s, s->o) and/or increase effort
- **BLOCKED agents** → upgrade to next model tier + add a planner if none existed
- **right-sized** → keep as-is

Output format:
```
Recommended for next similar task:
  <count>x <role> — <model><effort> (<rationale>)
  <count>x <role> — <model><effort> (<rationale>)
  ...
```

### Step 5 — Compare Against Original Task (Optional)

If the original task description is available in context, check:
- Did the fleet's combined output fully address the task?
- Are there gaps that no agent covered?
- Were any subtasks redundant?

## Output Format

```
=== Fleet Review ===

**Completion:** X/Y agents succeeded
**Issues:** <summary of blocks/failures, or "None">

**Model Efficiency:**
  [agent-id] <model><effort> — <verdict: overkill / right-sized / insufficient>
  ...

**Recommended Next Config:**
  <count>x <role> — <model><effort> (<rationale>)
  ...

**Task Coverage:** full | partial | gaps identified
**Gaps:** <any uncovered aspects, or "None">
```
