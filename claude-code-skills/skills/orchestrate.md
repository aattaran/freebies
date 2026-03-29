---
name: orchestrate
description: >
  Multi-agent coordination protocol. Breaks complex tasks into parallel
  workstreams for multiple Claude Code agents. Defines boundaries,
  shared state, and merge strategy. Use when coordinating parallel agents,
  splitting work across multiple sessions, or breaking a large task into
  independent workstreams.
---

# Multi-Agent Orchestration Protocol

Use this when a task is large enough to benefit from parallel Claude Code sessions.

## Step 1: Decompose the Task

Break the work into independent units that can run in parallel:
- Identify natural boundaries (separate files, modules, services, layers)
- Each unit should be completable without blocking on another unit
- If two units touch the same file, they cannot run in parallel -- merge them or sequence them

## Step 2: Define Agent Workstreams

For each parallel workstream, specify:
- Scope: exact files and functions this agent owns
- Input: what context/files it needs to read (but not modify)
- Output: what files it will create or modify
- Contract: the interface (function signatures, API shape, types) other agents depend on

Contracts must be defined BEFORE agents start. Agents code to the contract, not to each other's implementations.

## Step 3: Identify Shared State

Flag anything that multiple agents touch:
- Shared types/interfaces -- define these first, in a dedicated file
- Database schema -- one agent owns migrations, others read the schema
- Config/env variables -- maintain a single source of truth
- Package dependencies -- one agent owns package.json/requirements.txt changes

## Step 4: Execution Order

1. First: Create shared contracts (types, interfaces, schemas)
2. Then: Launch parallel agents with clear scope boundaries
3. Finally: Integration pass -- verify agents' outputs work together

## Step 5: Merge Strategy

- Each agent works on separate files when possible
- If file overlap is unavoidable, define which agent goes first
- After all agents complete, run the full test suite
- Resolve any integration issues in a final sequential pass

## Rules

- Never have two agents modify the same file simultaneously
- Prefer many small, focused agents over few large ones
- If an agent's scope creeps beyond its boundary, stop and re-decompose
- Always define the integration test that proves all workstreams connect correctly
