---
name: backend-architect
description: >
  Universal backend architecture blueprint. Invoke when building any Node.js/TypeScript backend:
  REST API, GraphQL, microservice, or serverless. Covers structure, error handling, validation,
  DB patterns, auth, security, testing, and a go-live checklist. Eliminates the most common
  backend errors by design.
triggers:
  - backend architect
  - build api
  - build backend
  - rest api
  - express app
  - fastify app
  - nestjs
  - backend service
alwaysApply: true
---

# Backend Architect — Master Blueprint

> Apply this blueprint in full before writing a single line of backend code.
> Every section is mandatory. Skip nothing.

---

## Section 1 — Discovery Protocol

Before writing code, answer these 6 questions:

1. **Scale tier** — prototype / startup / production / enterprise?
2. **Transport** — REST / GraphQL / tRPC / WebSocket / mixed?
3. **Database** — relational (Postgres/MySQL) / document (MongoDB) / edge (D1/Turso)?
4. **Auth type** — stateless JWT / stateful session / hybrid / API key / OAuth2?
5. **Deployment** — serverless (Vercel/CF Workers) / container (Docker/Cloud Run) / VPS?
6. **Language** — plain JS / TypeScript strict / mixed?

→ Choose a **Stack Preset** from Section 2 based on your answers.

---

## Section 2 — Stack Presets

### Preset A: TypeScript REST + Postgres (Production Standard)
- **Framework:** Fastify (or Express 5)
- **ORM:** Prisma + Zod for validation
- **Auth:** Better Auth (sessions) or JWT (stateless APIs)
- **Logger:** Pino (structured JSON)
- **Testing:** Vitest + Supertest (integration-first)
- **Rate limit:** `@fastify/rate-limit` with Redis store

### Preset B: TypeScript REST + MongoDB (Document / Flexible Schema)
- **Framework:** Express 5 + `express-async-errors`
- **ODM:** Mongoose with Zod validation layer
- **Auth:** JWT (HS256) + refresh tokens in DB
- **Logger:** Pino
- **Testing:** Vitest + Supertest

### Preset C: tRPC + Prisma (Full-Stack Type Safety)
- **Framework:** tRPC v11 + Zod schemas
- **ORM:** Prisma (Postgres or SQLite)
- **Auth:** Better Auth or Lucia
- **Testing:** Vitest + `@trpc/client` test client
- **Cache:** Upstash Redis for KV + rate limit

### Preset D: Edge / Serverless (Hono + D1/Turso)
- **Framework:** Hono (CF Workers / Deno / Bun compatible)
- **DB:** Drizzle ORM + Turso/D1
- **Auth:** JWT only (no sessions — stateless required)
- **Logger:** `console.log` to structured JSON (no Pino)
- **Testing:** Vitest + Miniflare (Workers emulator)

### Preset E: NestJS Enterprise
- **Framework:** NestJS with strict mode TS
- **ORM:** TypeORM or Prisma
- **Auth:** Passport.js + JWT / OAuth2
- **Validation:** `class-validator` + `class-transformer`
- **Logger:** Winston or Pino via `nestjs-pino`
- **Testing:** Jest + Supertest + TestingModule

---

## Section 3 — Project Structure (Non-Negotiable)

```
src/
├── app.ts               # Express/Fastify app factory (no listen() here)
├── server.ts            # Entry point: app.listen() + graceful shutdown
├── config/
│   └── index.ts         # All env vars parsed + validated with Zod here
├── modules/             # Feature-based modules (NOT type-based folders)
│   └── users/
│       ├── users.router.ts      # Route definitions only
│       ├── users.controller.ts  # HTTP parsing → service call → response
│       ├── users.service.ts     # Business logic (pure, testable)
│       ├── users.repository.ts  # DB queries (Prisma/Drizzle calls)
│       ├── users.schema.ts      # Zod schemas for this module
│       └── users.test.ts        # Integration test for this module
├── middleware/
│   ├── auth.ts           # JWT/session verification
│   ├── rateLimiter.ts    # Rate limiting config
│   └── errorHandler.ts   # Central error handler (MUST be last)
├── lib/
│   ├── db.ts             # DB client singleton
│   ├── logger.ts         # Pino instance
│   └── redis.ts          # Redis client (if used)
└── types/
    └── express.d.ts      # Augment req.user etc.
```

**Anti-pattern — never do this:**
```
src/
├── controllers/   ← type-based: breaks locality, forces cross-folder jumps
├── services/
├── models/
└── routes/
```

---

## Section 4 — Middleware Ordering (Order Matters — Do Not Reorder)

```typescript
// app.ts — EXACT order required
app.use(helmet())                         // 1. Security headers FIRST
app.use(cors(corsOptions))                // 2. CORS before body parsing
app.use(express.json({ limit: '10kb' })) // 3. Body parsing with size limit
app.use(rateLimiter)                      // 4. Rate limit before auth
app.use(requestLogger)                    // 5. Log all requests
app.use('/api', router)                   // 6. Routes
app.use(notFoundHandler)                  // 7. 404 catch-all
app.use(errorHandler)                     // 8. Error handler LAST (4 args)
```

**Why this order:**
- Helmet before everything → headers set before any response
- CORS before body parse → preflight OPTIONS returns before reading body
- Rate limit before auth → bots blocked before expensive auth DB query
- Error handler LAST → catches errors from all previous middleware

---

## Section 5 — Error Handling (The Complete Pattern)

### 5.1 — AppError class (extend built-in Error)

```typescript
// lib/errors.ts
export class AppError extends Error {
  constructor(
    public readonly message: string,
    public readonly statusCode: number = 500,
    public readonly isOperational: boolean = true,
    public readonly code?: string,
  ) {
    super(message);
    this.name = 'AppError';
    Error.captureStackTrace(this, this.constructor);
  }
}

export class NotFoundError extends AppError {
  constructor(resource = 'Resource') {
    super(`${resource} not found`, 404, true, 'NOT_FOUND');
  }
}

export class ValidationError extends AppError {
  constructor(message: string, public readonly errors?: unknown) {
    super(message, 400, true, 'VALIDATION_ERROR');
  }
}

export class UnauthorizedError extends AppError {
  constructor(message = 'Unauthorized') {
    super(message, 401, true, 'UNAUTHORIZED');
  }
}
```

### 5.2 — Async wrapper (eliminate try/catch boilerplate in routes)

```typescript
// lib/asyncHandler.ts
import { Request, Response, NextFunction, RequestHandler } from 'express';

export const asyncHandler = (fn: RequestHandler): RequestHandler =>
  (req, res, next) => Promise.resolve(fn(req, res, next)).catch(next);

// Usage in router:
router.get('/users/:id', asyncHandler(usersController.getById));
```

### 5.3 — Central error handler (Express: MUST have 4 args)

```typescript
// middleware/errorHandler.ts
import { Request, Response, NextFunction } from 'express';
import { AppError } from '../lib/errors';
import { logger } from '../lib/logger';
import { ZodError } from 'zod';
import { Prisma } from '@prisma/client';

export function errorHandler(
  err: unknown,
  req: Request,
  res: Response,
  _next: NextFunction, // MUST accept 4th arg even if unused
): void {
  if (err instanceof ZodError) {
    res.status(400).json({
      type: 'https://httpstatuses.com/400',
      title: 'Validation Error',
      status: 400,
      errors: err.flatten().fieldErrors,
    });
    return;
  }

  if (err instanceof Prisma.PrismaClientKnownRequestError) {
    if (err.code === 'P2002') {
      res.status(409).json({ type: 'https://httpstatuses.com/409', title: 'Conflict', status: 409 });
      return;
    }
    if (err.code === 'P2025') {
      res.status(404).json({ type: 'https://httpstatuses.com/404', title: 'Not Found', status: 404 });
      return;
    }
  }

  if (err instanceof AppError && err.isOperational) {
    res.status(err.statusCode).json({
      type: `https://httpstatuses.com/${err.statusCode}`,
      title: err.message,
      status: err.statusCode,
      ...(err.code && { code: err.code }),
    });
    return;
  }

  // Unknown / programmer error — log full stack, return 500
  logger.error({ err, req: { method: req.method, url: req.url } }, 'Unhandled error');
  res.status(500).json({
    type: 'https://httpstatuses.com/500',
    title: 'Internal Server Error',
    status: 500,
  });
}
```

### 5.4 — Catch unhandled rejections + uncaught exceptions

```typescript
// server.ts
process.on('unhandledRejection', (reason) => {
  logger.fatal({ reason }, 'Unhandled promise rejection — exiting');
  process.exit(1);
});

process.on('uncaughtException', (err) => {
  logger.fatal({ err }, 'Uncaught exception — exiting');
  process.exit(1);
});
```

### 5.5 — Graceful shutdown

```typescript
// server.ts
const server = app.listen(port, () => logger.info(`Server on port ${port}`));

const shutdown = async () => {
  logger.info('Shutting down gracefully...');
  server.close(async () => {
    await db.$disconnect();
    await redis.quit();
    logger.info('Clean shutdown complete');
    process.exit(0);
  });
  setTimeout(() => { logger.error('Force shutdown after timeout'); process.exit(1); }, 10_000);
};

process.on('SIGTERM', shutdown);
process.on('SIGINT', shutdown);
```

---

## Section 6 — Input Validation (Zod — Never Skip)

```typescript
// modules/users/users.schema.ts
import { z } from 'zod';

export const CreateUserSchema = z.object({
  email: z.string().email().max(255).toLowerCase(),
  password: z.string().min(8).max(128),
  name: z.string().min(1).max(100).trim(),
});

export type CreateUserInput = z.infer<typeof CreateUserSchema>;

// In controller — always use safeParse, never parse() at boundaries
export const createUser: RequestHandler = asyncHandler(async (req, res) => {
  const result = CreateUserSchema.safeParse(req.body);
  if (!result.success) {
    throw new ValidationError('Invalid input', result.error.flatten().fieldErrors);
  }
  const user = await userService.create(result.data);
  res.status(201).json(user);
});
```

**Rules:**
- `safeParse` at HTTP boundaries — never `parse()` (it throws and leaks schema internals)
- `parse()` inside service layer where data is already trusted/validated
- Define schemas co-located with the module that owns them
- Use `.strict()` to reject unknown fields from user input

---

## Section 7 — Database Patterns

### 7.1 — Repository pattern (isolate DB from business logic)

```typescript
// modules/users/users.repository.ts
import { prisma } from '../../lib/db';

export const usersRepository = {
  async findById(id: string) {
    return prisma.user.findUnique({ where: { id }, select: { id: true, email: true, name: true, createdAt: true } });
  },
  async findByEmail(email: string) {
    return prisma.user.findUnique({ where: { email } });
  },
  async create(data: { email: string; name: string; passwordHash: string }) {
    return prisma.user.create({ data, select: { id: true, email: true, name: true, createdAt: true } });
  },
};
```

### 7.2 — Transactions (wrap all multi-step writes)

```typescript
const result = await prisma.$transaction(async (tx) => {
  const user = await tx.user.create({ data: userData });
  await tx.auditLog.create({ data: { userId: user.id, action: 'created' } });
  return user;
});
```

### 7.3 — Connection pool (never rely on defaults)

```typescript
// lib/db.ts
export const prisma = new PrismaClient({
  log: process.env.NODE_ENV === 'development' ? ['query', 'warn', 'error'] : ['error'],
});
// DATABASE_URL: ?connection_limit=10&pool_timeout=20
```

### 7.4 — Never SELECT * in production

```typescript
// BAD — leaks passwordHash and internal fields
const user = await prisma.user.findUnique({ where: { id } });

// GOOD — explicit projection
const user = await prisma.user.findUnique({
  where: { id },
  select: { id: true, email: true, name: true, createdAt: true },
});
```

### 7.5 — Drizzle patterns

```typescript
// Relational query — single SQL, no N+1
const usersWithPosts = await db.query.users.findMany({
  with: { posts: { where: eq(posts.published, true) } },
  limit: 20,
});

// Prepared statements for repeated queries
const getUserById = db.select().from(users).where(eq(users.id, sql.placeholder('id'))).prepare('get_user');
```

---

## Section 8 — Authentication Patterns

### 8.1 — JWT (stateless APIs)

```typescript
// RS256 for production — HS256 only for single-service internal tokens
export function signAccessToken(payload: { sub: string; role: string }) {
  return jwt.sign(payload, process.env.JWT_PRIVATE_KEY!, {
    algorithm: 'RS256',
    expiresIn: '15m',       // short-lived access
    issuer: 'api.yourdomain.com',
    audience: 'api.yourdomain.com',
  });
}

export function verifyAccessToken(token: string) {
  return jwt.verify(token, process.env.JWT_PUBLIC_KEY!, {
    algorithms: ['RS256'],  // whitelist — rejects alg:none and HS256
    issuer: 'api.yourdomain.com',
    audience: 'api.yourdomain.com',
  });
}
// Refresh token: 7d, stored in DB, rotated on every use
```

### 8.2 — Sessions (stateful — web apps)

```typescript
// Use Better Auth or Lucia — never DIY session management
import { betterAuth } from 'better-auth';
import { prismaAdapter } from 'better-auth/adapters/prisma';

export const auth = betterAuth({
  database: prismaAdapter(prisma, { provider: 'postgresql' }),
  emailAndPassword: { enabled: true, minPasswordLength: 8 },
  session: { expiresIn: 60 * 60 * 24 * 7 }, // 7 days
  rateLimit: { enabled: true, window: 60, max: 5 },
});
```

### 8.3 — Auth middleware

```typescript
export const requireAuth = asyncHandler(async (req, _res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) throw new UnauthorizedError('Missing token');
  try {
    req.user = verifyAccessToken(token) as { sub: string; role: string };
    next();
  } catch {
    throw new UnauthorizedError('Invalid or expired token');
  }
});

export const requireRole = (role: string) =>
  asyncHandler(async (req, _res, next) => {
    if ((req.user as any)?.role !== role) throw new AppError('Forbidden', 403, true, 'FORBIDDEN');
    next();
  });
```

### 8.4 — OAuth2 (always validate state)

```typescript
// Generate + store state before redirect
const state = crypto.randomBytes(32).toString('hex');
req.session.oauthState = state;

// Validate in callback — prevents CSRF
if (req.query.state !== req.session.oauthState) {
  throw new AppError('OAuth state mismatch', 400, true, 'OAUTH_STATE_INVALID');
}
```

---

## Section 9 — Security Hardening (Every API, No Exceptions)

### 9.1 — Helmet

```typescript
app.use(helmet({ contentSecurityPolicy: true, hsts: { maxAge: 31536000, includeSubDomains: true } }));
```

### 9.2 — CORS whitelist (never `origin: '*'` in production)

```typescript
const ALLOWED_ORIGINS = (process.env.ALLOWED_ORIGINS || '').split(',').filter(Boolean);

app.use(cors({
  origin: (origin, callback) => {
    if (!origin || ALLOWED_ORIGINS.includes(origin)) return callback(null, true);
    callback(new AppError('CORS not allowed', 403, true));
  },
  credentials: true,
}));
```

### 9.3 — Rate limiting (Redis store for distributed systems)

```typescript
import rateLimit from 'express-rate-limit';
import RedisStore from 'rate-limit-redis';

export const rateLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, max: 100,
  standardHeaders: true, legacyHeaders: false,
  store: new RedisStore({ client: redis }),
  handler: (_req, res) =>
    res.status(429).json({ type: 'https://httpstatuses.com/429', title: 'Too Many Requests', status: 429 }),
});

// Auth endpoints: stricter (5/min)
export const authLimiter = rateLimit({ windowMs: 60_000, max: 5, store: new RedisStore({ client: redis }) });
```

### 9.4 — SQL injection prevention

```typescript
// NEVER string concatenation
// BAD:
db.query(`SELECT * FROM users WHERE email = '${email}'`);

// GOOD — Prisma (parameterized by default):
prisma.user.findUnique({ where: { email } });

// GOOD — raw with Prisma (tagged template = parameterized):
prisma.$queryRaw`SELECT * FROM users WHERE email = ${email}`;

// GOOD — Drizzle (always parameterized):
db.select().from(users).where(eq(users.email, email));
```

### 9.5 — Config validation at startup (fail fast)

```typescript
// config/index.ts
import { z } from 'zod';

const ConfigSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']),
  DATABASE_URL: z.string().url(),
  JWT_PRIVATE_KEY: z.string().min(100),
  JWT_PUBLIC_KEY: z.string().min(100),
  REDIS_URL: z.string().url().optional(),
  PORT: z.coerce.number().default(3000),
});

export const config = ConfigSchema.parse(process.env); // throws at startup if invalid
```

---

## Section 10 — Logging (Pino — Never console.log)

```typescript
// lib/logger.ts
import pino from 'pino';

export const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  ...(process.env.NODE_ENV === 'development' && {
    transport: { target: 'pino-pretty', options: { colorize: true } },
  }),
  redact: ['req.headers.authorization', 'body.password', 'body.token'],
  base: { service: 'api', version: process.env.npm_package_version },
});
```

**Log level rules:**
- `fatal` — programmer error / unknown crash (exit after)
- `error` — operational error (4xx/5xx), include `err` object with stack
- `info` — business events (user created, order placed)
- `debug` — development only (never in production logs)
- Never log: passwords, tokens, PII, full request bodies

---

## Section 11 — API Response Shape

```typescript
// Successful responses
res.status(200).json(data);                     // GET
res.status(201).json(created);                  // POST (resource created)
res.status(204).send();                         // DELETE / idempotent PUT
res.status(202).json({ jobId });                // Async accepted

// Paginated
res.status(200).json({ data: items, meta: { total, page, pageSize, totalPages } });

// Errors — RFC 9457 Problem Details
res.status(400).json({
  type: 'https://httpstatuses.com/400',
  title: 'Validation Error',
  status: 400,
  errors: { email: ['Must be a valid email'] },
});
```

---

## Section 12 — Testing (Integration-First)

```typescript
// modules/users/users.test.ts
import { describe, it, expect, afterAll } from 'vitest';
import request from 'supertest';
import { app } from '../../app';
import { prisma } from '../../lib/db';

describe('POST /api/users', () => {
  afterAll(async () => {
    await prisma.user.deleteMany({ where: { email: { contains: '@test.com' } } });
    await prisma.$disconnect();
  });

  it('creates user with valid data', async () => {
    const res = await request(app).post('/api/users')
      .send({ email: 'ali@test.com', password: 'securePass1!', name: 'Ali' });
    expect(res.status).toBe(201);
    expect(res.body).toMatchObject({ email: 'ali@test.com' });
    expect(res.body).not.toHaveProperty('passwordHash'); // never leak hash
  });

  it('returns 400 for invalid email', async () => {
    const res = await request(app).post('/api/users')
      .send({ email: 'not-an-email', password: 'securePass1!', name: 'Ali' });
    expect(res.status).toBe(400);
    expect(res.body.errors?.email).toBeDefined();
  });

  it('returns 409 for duplicate email', async () => {
    await request(app).post('/api/users').send({ email: 'dup@test.com', password: 'Pass1!', name: 'A' });
    const res = await request(app).post('/api/users').send({ email: 'dup@test.com', password: 'Pass1!', name: 'B' });
    expect(res.status).toBe(409);
  });
});
```

**Testing rules (goldbergyoni/javascript-testing-best-practices):**
- Integration tests through HTTP — not unit-mocked controllers
- Real database — never mock the ORM (mocks hide migration bugs)
- Test edge cases: null, empty, max-length, duplicate, unauthorized
- Each test owns its data: seed → test → teardown
- Test all error flows: 400, 401, 403, 404, 409, 500
- Name tests as behavior: `it('returns 400 for invalid email')` not `it('validates')`

---

## Section 13 — Anti-Patterns Table (Never Do These)

| Anti-Pattern | Why It Fails | Correct Pattern |
|---|---|---|
| `cors({ origin: '*' })` in prod | Any origin accesses your API | Whitelist `ALLOWED_ORIGINS` env var |
| `catch(err) { console.log(err) }` | Swallows error, sends 200 | Re-throw or `next(err)` |
| `JSON.parse(userInput)` without try/catch | Crashes on malformed JSON | Use `zod.safeParse` |
| `router.get('/', async () => {...})` without wrap | Unhandled rejection crashes process | Wrap with `asyncHandler` |
| `process.exit()` on handled errors | Kills healthy server | Only exit on `uncaughtException` |
| `SELECT *` from DB | Leaks passwordHash, internal fields | Always explicit `select` |
| JWT `algorithm: 'HS256'` with public key | JWT confusion attack | `RS256` + `algorithms: ['RS256']` whitelist |
| `.env` in git | Secrets exposed | `.gitignore`, use secret manager |
| `express.json()` without size limit | DoS via huge payloads | `{ limit: '10kb' }` |
| Sync file I/O in route handler | Blocks Node.js event loop | `fs.promises.*` always |
| Type-based folder structure | Cognitive overhead, bad DX | Feature-based modules |
| No `unhandledRejection` handler | Silent crashes in async code | Always register in `server.ts` |
| Rolling your own session management | Auth bugs, session fixation | Use Better Auth or Lucia |

---

## Section 14 — Go-Live Checklist

```
STRUCTURE
[ ] Feature-based modules (not type-based controllers/services/models)
[ ] 3-layer: controller → service → repository
[ ] app.ts creates app, server.ts calls listen()
[ ] Config validated at startup with Zod — fails fast on missing vars

MIDDLEWARE (exact order — never reorder)
[ ] helmet() → cors() → json(limit) → rateLimiter → logger → routes → 404 → errorHandler

ERROR HANDLING
[ ] AppError class with isOperational flag
[ ] asyncHandler wraps every async route handler
[ ] errorHandler has 4 params (err, req, res, _next) — registered LAST
[ ] ZodError and Prisma P2002/P2025 handled in errorHandler
[ ] process.on('unhandledRejection') exits with code 1
[ ] process.on('uncaughtException') exits with code 1
[ ] Graceful shutdown: SIGTERM/SIGINT close server + DB pool + Redis

VALIDATION
[ ] All req.body validated with Zod safeParse before service layer
[ ] All req.params / req.query coerced with Zod
[ ] Config env vars parsed with Zod at startup

DATABASE
[ ] Repository isolates all DB calls from service/controller
[ ] Multi-step writes use prisma.$transaction
[ ] Connection pool size set explicitly in DATABASE_URL
[ ] No SELECT * — always explicit field selection
[ ] Parameterized queries only (no string interpolation in SQL)

AUTH
[ ] JWT: RS256, 15m access token, 7d refresh stored in DB
[ ] JWT verify uses algorithms whitelist (no alg:none attacks)
[ ] Sessions: Better Auth or Lucia (never DIY)
[ ] OAuth: state + nonce validated on callback
[ ] Auth endpoints have stricter rate limits (5/min vs 100/15min)

SECURITY
[ ] Helmet with HSTS enabled
[ ] CORS whitelist via ALLOWED_ORIGINS env var
[ ] Rate limiting with Redis store (distributed across instances)
[ ] No secrets in code, .env in .gitignore
[ ] npm audit --production clean
[ ] express.json({ limit: '10kb' })

LOGGING
[ ] Pino with structured JSON output
[ ] Secrets redacted in pino config
[ ] Request logging middleware active
[ ] Errors logged with full err object (includes stack)

API DESIGN
[ ] RFC 9457 error format: { type, title, status, errors? }
[ ] HTTP 201 for create, 204 for delete, 200 for get/list
[ ] Paginated endpoints: { data: [], meta: { total, page, pageSize } }
[ ] No stack traces in production error responses

TESTING
[ ] Integration tests via Supertest against real test DB
[ ] Happy path + min 2 error paths per endpoint
[ ] afterAll cleans up test data
[ ] npm test passes clean with zero failures
```
