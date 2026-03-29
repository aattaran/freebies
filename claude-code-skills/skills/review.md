---
name: review
description: >
  Multi-pass code review and hardening protocol. Four sequential passes:
  implementer audit, debugger, security reviewer, final verification.
  Fixes issues in-place rather than just listing them. Use when the user
  asks to review code, check changes before pushing, audit recent modifications,
  or harden code quality.
---

# Multi-Pass Code Review & Hardening

You are performing a multi-pass review cycle on the code changes in this session. Execute the following passes sequentially. Each pass adopts a distinct expert mindset and produces concrete actions — not just commentary.

## Pass 1: Implementer Audit
Review all changed/created files for:
- Correctness: Does the logic do what it claims? Trace key code paths.
- Completeness: Are edge cases handled? Missing returns, off-by-ones, null/undefined states.
- Standards: Does it follow the patterns and conventions already in this codebase? (Check surrounding code.)

Fix any issues found before moving on.

## Pass 2: Debugger
Actively try to break the code:
- Run existing tests. If tests exist and any fail, fix them.
- Identify inputs or states that would cause failures: empty collections, boundary values, concurrent access, malformed data.
- Check error handling: Are exceptions caught at the right level? Are error messages useful? Are resources cleaned up?
- Look for silent failures — places where code swallows errors or returns misleading defaults.

Fix any issues found before moving on.

## Pass 3: Security & Robustness Reviewer
Examine changes for:
- Injection risks (SQL, command, XSS, path traversal) in any code that touches user input or external data.
- Secrets, credentials, or sensitive data that shouldn't be hardcoded or logged.
- Unsafe deserialization, unvalidated redirects, or missing auth checks.
- Resource leaks (unclosed handles, missing cleanup, unbounded growth).

Fix any issues found before moving on.

## Pass 4: Final Verification
- Re-read every file you modified during passes 1–3.
- Run tests one final time to confirm nothing regressed.
- If you introduced new logic during fixes, apply passes 1–3 thinking to that new code.

## Rules
- **Do not invent problems.** Only flag and fix real, demonstrable issues.
- **Do not refactor or "improve" code that isn't broken.** Style preferences are not bugs.
- **Do not add comments, docstrings, or type annotations** unless they fix an actual ambiguity that caused a bug.
- After all passes, provide a brief summary: what you found, what you fixed, and what you verified.
