---
name: audit
description: >
  Full-pass code audit: security (OWASP), code quality, performance,
  and tech debt. Produces actionable findings ranked by severity.
  Use when the user asks to audit code, check for vulnerabilities,
  assess code quality, or identify technical debt.
---

# Code Audit Protocol

Perform a systematic audit of the specified code. Produce findings, not opinions.

## Pass 1: Security

Authentication and Authorization:
- Are all endpoints protected? Which auth method? (JWT, session, API key)
- Is authorization checked at every layer, not just middleware?
- Can User A access User B's resources? (IDOR)
- Are tokens validated properly? (signature, expiration, issuer, scope)

Injection:
- SQL/NoSQL: parameterized queries everywhere? Any string concatenation?
- XSS: is user input encoded on output? Is CSP configured?
- Command injection: any exec/spawn/system with user-controlled input?
- Path traversal: are file paths sanitized and restricted?

Secrets and Data:
- Any hardcoded secrets, API keys, or credentials in source?
- Are error responses leaking stack traces, SQL, or internal paths?
- Is sensitive data (PII, tokens) logged?
- Are secrets in environment variables, not config files checked into git?

Dependencies:
- Any known vulnerabilities in dependencies? (npm audit / pip audit)
- Are dependencies pinned to specific versions?

## Pass 2: Code Quality

Architecture:
- Does the code follow the project's established patterns?
- Is business logic separated from transport/framework code?
- Are there circular dependencies?
- Is the dependency direction correct? (outer layers depend on inner, not reverse)

Error handling:
- Are there empty catch blocks or swallowed errors?
- Do errors propagate with sufficient context?
- Are external failures (network, DB, third-party) handled gracefully?

Testing:
- What is the test coverage for the audited code?
- Are edge cases and error paths tested, or only happy paths?
- Are there integration tests for critical flows?

## Pass 3: Performance

- N+1 queries? Missing indexes? Unbounded queries?
- Missing pagination on list endpoints?
- Large payloads without streaming?
- Expensive operations in hot paths that could be cached?
- Missing timeouts on external calls?
- Connection pool sizing appropriate?

## Pass 4: Tech Debt

- Dead code (unused functions, unreachable branches)?
- Duplicated logic that should be consolidated?
- TODOs, FIXMEs, HACKs -- are any of them actual risks?
- Outdated patterns that conflict with the rest of the codebase?

## Output Format

Report findings as a flat list, each with:
- Severity: CRITICAL / HIGH / MEDIUM / LOW
- Category: Security / Quality / Performance / Debt
- Location: file:line
- Finding: what is wrong
- Recommendation: how to fix it

Sort by severity descending. Group only if it aids readability.
Do not pad the report with "no issues found" sections -- only report actual findings.
