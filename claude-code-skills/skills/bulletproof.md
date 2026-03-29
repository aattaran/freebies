---
name: bulletproof
description: >
  Rigorous multi-pass code review and implementation protocol.
  Traces data flow, audits security, handles all error states,
  and checks for regressions. Use for code that needs high reliability,
  critical paths, financial transactions, or security-sensitive operations.
---

# Bulletproof Code Protocol

Apply this protocol to all code changes in this session.

## Phase 1: Understand Before Touching

- Read all relevant source files before proposing changes.
- Trace the data flow end-to-end: origin -> transport -> destination.
- Identify the exact symptom vs. the assumed root cause -- they are often different.
- Check naming consistency across layers (API, DB, client).
- Confirm reproduction steps and environment context.

## Phase 2: Implement with Discipline

No assumptions. Execute and observe. Do not trust that a function works because it exists.

No silent failures. Every catch block must log context, recover, or propagate.
Empty catch blocks, bare console.log(e), and catch(() => {}) are bugs.

No magic values. Hardcoded IDs, URLs, secrets, and magic numbers must be
replaced with environment variables or named constants.

No happy-path-only code. Handle:
- Null/empty/malformed inputs
- Network failures (timeout, 4xx, 5xx, DNS, SSL)
- Database errors (not found, duplicate, constraint violation, deadlock)
- Race conditions (double submit, stale reads, lost updates)
- Auth failures (expired, revoked, missing scope)
- Business logic edge cases (invalid state, quota exceeded, expired resource)

## Phase 3: Security Audit

- Validate all inputs server-side. Client validation is UX, not security.
- Check authorization at every layer -- can User A access User B's resources (IDOR)?
- Parameterized queries only. No string concatenation for SQL/NoSQL.
- No secrets in source code. No stack traces or internal paths in error responses.
- Verify webhook signatures, JWT signatures, and file content types.
- Check rate limiting on sensitive endpoints.

## Phase 4: Regression Check

- Find all files that import or depend on modified code.
- Verify: Are function signatures unchanged? Return types? Side effects?
- If the DB schema changed: is it backward-compatible? Is there a migration and rollback?
- List any breaking changes explicitly.

## Phase 5: Verify

- Run existing tests. Fix any that break.
- Re-read all files you modified and apply phases 2-4 to your own new code.
- Summarize: what you changed, what you verified, and any remaining risks.
- Scale the rigor to the risk -- a config tweak does not need a full security audit.
