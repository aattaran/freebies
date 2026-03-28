---
name: debug
description: >
  Systematic debugging protocol. Reproduce, isolate, binary search
  for root cause, fix, and verify no regressions. Avoids guessing.
  Use when investigating bugs, errors, unexpected behavior, test failures,
  or anything described as "not working". Also applies when the user says
  "debug", "fix error", "why is this broken", or "investigate issue".
---

# Debugging Protocol

Apply this when investigating a bug or unexpected behavior.

## Step 1: Define the Problem

- What is the EXACT symptom? (error message, wrong output, unexpected behavior)
- What is the EXPECTED behavior?
- When did it start? (recent commit, deployment, dependency update?)
- Is it reproducible? Under what conditions?

Do not guess the cause yet. Observe first.

## Step 2: Reproduce

- Find the shortest path to reproduce the bug
- If you cannot reproduce it, gather more context before proceeding
- Note the exact inputs, environment, and sequence of actions

## Step 3: Isolate

Narrow down the problem space using binary search:

- Trace the data flow from input to the point of failure
- Add targeted logging or read intermediate values at key checkpoints
- Is the input correct? Check. Is the transformation correct? Check. Is the output correct? Check.
- Bisect: which layer is producing the wrong result?

Common isolation questions:
- Is this a frontend or backend issue? Check the API response directly.
- Is this a data issue or a code issue? Check the database directly.
- Is this a recent regression? Check git log for recent changes to affected files.
- Is this environment-specific? Compare configs between working and broken environments.

## Step 4: Root Cause

Once isolated, identify the ACTUAL root cause, not just the proximate trigger:
- Why did this happen, not just what happened?
- Is this a single bug or a symptom of a deeper design issue?
- Are there other places in the codebase with the same pattern that might also be broken?

## Step 5: Fix

- Fix the root cause, not the symptom
- Make the minimal change that resolves the issue
- Do not refactor surrounding code as part of a bug fix
- If the fix is in a shared utility, check all callers

## Step 6: Verify

- Confirm the original reproduction case now works
- Run the existing test suite -- no new failures
- Check for related edge cases that might have the same underlying issue
- If the bug was in error handling, test both the happy path and the error path

## Rules

- Never apply a fix you cannot explain
- Never fix by adding a workaround on top of broken code
- If the bug involves timing/concurrency, prove the fix handles the race condition, do not just make it less likely
- If you are stuck after 3 attempts, step back and re-examine your assumptions about the root cause
