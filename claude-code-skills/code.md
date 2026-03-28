---
name: code
description: >
  Disciplined implementation protocol. Read before writing, trace
  dependencies, handle errors properly, avoid over-engineering.
  For JS/TS and Python full-stack work. Use when writing new code,
  implementing features, modifying existing functions, or any task
  that involves creating or changing source code files.
---

# Implementation Protocol

Apply this protocol when writing or modifying code.

## Before Writing

- Read every file you plan to modify. No exceptions.
- Find existing utilities, helpers, and patterns in the codebase -- reuse them.
- Trace the data flow: where does the input come from, where does the output go?
- Understand the existing error handling pattern -- match it, do not invent a new one.

## While Writing

Write the minimum code that solves the problem correctly.

Error handling:
- Match the project's existing error handling pattern
- Every catch block must log with context, recover, or propagate
- No empty catch blocks. No catch-and-return-null.
- Handle the realistic failure modes: network errors, missing data, auth failures, invalid input

Input validation:
- Validate at system boundaries (API endpoints, user input, external data)
- Trust internal function calls -- do not re-validate data that was already validated upstream
- Server-side validation is security. Client-side validation is UX.

Code style:
- Follow the conventions already in the codebase (naming, structure, patterns)
- No premature abstractions -- three similar lines are better than a helper used once
- No feature flags or backward-compat shims unless explicitly asked
- No added comments, docstrings, or type annotations on code you did not change

## After Writing

- Re-read your changes in context of the surrounding code
- Run existing tests. Fix any that break.
- If you changed a function signature, find all callers and update them
- If you added a dependency, confirm it is necessary and not duplicating an existing one

## JS/TS Specifics

- Strict equality (===) always
- async/await over raw promises unless combining with Promise.all
- Named exports over default exports
- Environment variables for configuration, never hardcoded values

## Python Specifics

- Type hints on function signatures for public APIs
- Context managers for resource cleanup (files, connections, locks)
- f-strings over .format() or % formatting
- pathlib over os.path for file operations
