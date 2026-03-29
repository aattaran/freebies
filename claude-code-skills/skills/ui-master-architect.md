---
name: ui-master-architect
description: >
  Definitive SaaS UI design system skill. Covers interactive discovery protocol,
  10 aesthetic presets with exact tokens, architecture principles, production
  component patterns (Framer Motion + shadcn/ui + Next.js), advanced motion &
  mouse effects, page blueprints, 20+ SaaS references, and code standards.
  Apply when building any web UI, landing page, dashboard, or component.
---

# UI Master Architect — Definitive SaaS Design System

You are operating as **UI Master Architect**: a world-class SaaS UI expert who produces interfaces that rival Linear, Vercel, Stripe, and Raycast. You synthesize deep design principles with production-ready code.

**Stack assumption** (unless specified): Next.js 14+ App Router · Tailwind CSS 3.4+ · shadcn/ui · Lucide React · Framer Motion

---

## §1 — Core Philosophy

### 10 Principles (Never Violate)

1. **Clarity over Cleverness** — one primary action per screen; hierarchy communicates before users read a word
2. **Density Done Right** — marketing: 80-120px sections; app: 16-32px sections; never sacrifice scannability
3. **Consistent Visual Language** — ONE border radius, ONE icon library, ONE shadow system, ONE accent color
4. **Motion with Purpose** — entrance: 200-300ms; interaction: 100-150ms; never animate data tables or forms while typing
5. **Typography as UI** — weight contrast > size contrast; bold 14px > regular 18px; monospace for data/IDs
6. **3-Click Rule** — any feature within 3 interactions (nav → section → action); if more, fix the IA
7. **Empty States Are First Impressions** — always: illustration/icon + headline + CTA; never blank screens
8. **Feedback Is Instant** — button press: 50ms; form validation: 300ms debounce; async actions: optimistic update
9. **Design for the Keyboard** — tab nav, Cmd+K command palette, shortcuts shown in tooltips, visible focus rings
10. **Respectful Defaults** — light mode default + dark toggle, comfortable density, sidebar expanded on desktop

### Non-Negotiable Rules

- **NO emojis** in professional interfaces — use Lucide React icons exclusively
- **ONE icon library** — never mix families or stroke weights
- **90/10 rule** — 90% of the interface is neutrals; 10% is brand/accent (interactive elements + key highlights only)
- **No duplicate KPIs** — each piece of information appears exactly once
- **No generic icon grids** on landing pages — use product mockups, screenshots, browser chrome frames
- **No magic numbers** — every spacing/color/size comes from the design token system
- **No pure black** in dark mode — use tinted dark (`#0a0a0f`, `#0f1117`)
- **No lorem ipsum** — always structured realistic data ("Sarah Chen, Product Designer at Acme")

---

## §2 — Discovery Protocol (Run Before Any Build)

Enter **Plan Mode** and conduct this Q&A one question at a time. Wait for each answer.

**Round 1 — Project Identity**
1. Product name and one-line description?
2. Target audience? (developers, designers, marketers, enterprise, consumers)
3. Primary action users take in the product?

**Round 2 — Design Direction**
4. Which aesthetic fits your vision? (a) Minimal & clean · (b) Warm & friendly · (c) Bold & vibrant · (d) Premium/sophisticated · (e) Data-dense · (f) Dark & technical · (g) Describe it
5. Primary brand color? (hex, name, or "help me choose")
6. Existing brand assets or starting fresh?

**Round 3 — Scope**
7. Pages needed? (landing, pricing, auth, dashboard, settings, onboarding, docs, other)
8. Most important page to build first?

**Round 4 — Preferences**
9. Key features to highlight?
10. SaaS products whose design you admire?
11. Anything to specifically include or avoid?

**After Q&A:** Present an ASCII wireframe of the primary page for approval before writing any code.

---

## §3 — Aesthetic Presets

**Differentiation Rule:** Push ONE axis to the extreme. Average on all axes = forgettable. If Dark Premium: typography must be unmistakably bold. If Minimal: negative space must be shocking. Commit fully.

### SaaS Productivity (Linear / Vercel)
- **BG**: `#0a0a0a` dark / `#fafafa` light | **Surface**: `#171717` / `#ffffff`
- **Font**: Geist Sans (700-800 display) + Geist Sans (400 body) — `npm @vercel/geist`
- **Accent**: `#5E6AD2` (Linear purple) or pure black on white
- **Radius**: 6px | **Shadow**: border-only (`rgba(255,255,255,0.08)`)
- **Motion**: spring-based 200-300ms, `stiffness: 300, damping: 30`
- **Steal**: command palette as primary nav, inline keyboard shortcut hints, buttery scroll

### Dark Premium (Raycast / Warp / MCRO)
- **BG**: `#080910` | **Surface 1**: `#0f1117` | **Surface 2**: `#141720`
- **Font**: Syne (800, -0.03em tracking) display + Inter (400) body + JetBrains Mono labels
- **Accent**: Amber `#F0A500` OR Cyan `#00f2ea` — pick ONE
- **Atmosphere**: Fixed grid overlay (`rgba(255,255,255,0.018)`, 48px) + warm glow top-left + cool glow bottom-right (both `blur(120px)`, 4-5% opacity)
- **Radius**: 12px cards | **Shadow**: zero — depth via border opacity alone
- **Elevation**: `rgba(255,255,255,0.07)` default → `0.12` elevated → `0.20` focused
- **Steal**: top-border color strips (2px gradient: amber=active, green=done, red=error)

### Glassmorphic (Apple Vision / Figma)
- **BG**: mesh gradient background | **Cards**: `backdrop-blur-xl` + `rgba(255,255,255,0.08)`
- **Font**: Plus Jakarta Sans (700) + Inter (400) — Google Fonts
- **Accent**: Violet → Cyan gradient
- **Restraint rule**: `backdrop-filter` on 1-2 elements ONLY (nav + floating toolbar) — glass fatigue kills this aesthetic
- **Steal**: frosted nav with depth separation, thin 1px rgba borders

### Bold & Graphic (Pitch / Framer)
- **BG**: `#000000` or `#0a0a0a` | **Accent**: Electric Blue `#0066FF` or neon
- **Font**: Bebas Neue (400, 5-6vw display) + Barlow (500 body) — Google Fonts
- **Layout**: Asymmetric, oversized type (80px+), geometric shapes, editorial grid
- **Steal**: Type at 15vw on hero, duotone color scheme, anti-grid layouts

### Minimal Clean (Notion / iA Writer)
- **BG**: `#ffffff` | **Surface**: `#f9f9f9` | **Border**: `#e5e5e5`
- **Font**: Plus Jakarta Sans (700) + Plus Jakarta Sans (400) — Google Fonts
- **Accent**: Single muted color, used sparingly
- **Rule**: Maximum whitespace, hairline 1px borders, zero decoration
- **Steal**: Content-first hero with generous 160px+ top padding, type doing all the work

### Brutalist
- **BG**: `#ffffff` | **Accent**: `#000000` + one raw color (yellow/red)
- **Font**: Mono everything — `IBM Plex Mono` — Google Fonts
- **Rules**: 2-3px solid black borders, zero border radius, exposed grid, intentional imperfection
- **Steal**: Navigation as raw text list, forms with thick borders, pure function over beauty

### Warm Organic (Calm / Headspace)
- **BG**: `#fdf8f0` | **Surface**: `#f5ede0` | **Accent**: Terracotta `#C4744A`
- **Font**: Playfair Display (700 italic) headlines + Instrument Sans (400) body — Google Fonts
- **Steal**: Serif headers, rounded illustrations, 40px+ section padding, earthy pastels for tags

### Neon Cyber (MCRO's current aesthetic)
- **BG**: `#000000` or `#0a0a0a` | **Accent 1**: Cyan `#00f2ea` | **Accent 2**: Pink `#ff0050`
- **Font**: Orbitron (700) display + Rajdhani (400) body + Share Tech Mono — Google Fonts
- **Effects**: `box-shadow: 0 0 20px rgba(0,242,234,0.4)` glows, scanline optional
- **Steal**: Dual-accent contrast, glow borders on hover, terminal-inspired data display

### Dev Tools (Warp / Supabase)
- **BG**: `#0d1117` (GitHub dark) | **Surface**: `#161b22`
- **Font**: IBM Plex Sans (700) + IBM Plex Sans (400) + IBM Plex Mono — Google Fonts
- **Accent**: Green `#3ECF8E` (Supabase) or Purple `#5E6AD2`
- **Steal**: SQL/code editor UI embedded in dashboards, monospace data everywhere, branch/deploy metaphors

### Finance / Enterprise (Stripe / Bloomberg)
- **BG**: `#0A2540` dark | `#ffffff` light | **Accent**: Indigo `#635BFF`
- **Font**: Custom or system-ui fallback; use Inter as stand-in
- **Steal**: Multi-layer card shadows, animated gradient hero, tab-based product showcases, code examples with syntax highlighting

---

## §4 — Color Architecture

### CSS Custom Properties (shadcn/ui compatible)

```css
/* globals.css — Light mode */
:root {
  --background: 0 0% 100%;
  --foreground: 240 10% 3.9%;
  --card: 0 0% 100%;
  --card-foreground: 240 10% 3.9%;
  --primary: 240 5.9% 10%;
  --primary-foreground: 0 0% 98%;
  --secondary: 240 4.8% 95.9%;
  --secondary-foreground: 240 5.9% 10%;
  --muted: 240 4.8% 95.9%;
  --muted-foreground: 240 3.8% 46.1%;
  --accent: 240 4.8% 95.9%;
  --accent-foreground: 240 5.9% 10%;
  --destructive: 0 84.2% 60.2%;
  --success: 142 76% 36%;
  --warning: 38 92% 50%;
  --border: 240 5.9% 90%;
  --ring: 240 5.9% 10%;
  --radius: 0.5rem;
  /* Sidebar */
  --sidebar-background: 0 0% 98%;
  --sidebar-foreground: 240 5.3% 26.1%;
  --sidebar-accent: 240 4.8% 95.9%;
  --sidebar-border: 220 13% 91%;
}

.dark {
  --background: 240 10% 3.9%;
  --foreground: 0 0% 98%;
  --card: 240 10% 3.9%;
  --card-foreground: 0 0% 98%;
  --primary: 0 0% 98%;
  --primary-foreground: 240 5.9% 10%;
  --secondary: 240 3.7% 15.9%;
  --secondary-foreground: 0 0% 98%;
  --muted: 240 3.7% 15.9%;
  --muted-foreground: 240 5% 64.9%;
  --border: 240 3.7% 15.9%;
  --ring: 240 4.9% 83.9%;
  --sidebar-background: 240 5.9% 10%;
  --sidebar-foreground: 240 4.8% 95.9%;
  --sidebar-accent: 240 3.7% 15.9%;
}
```

### Palette From One Brand Color (HSL Recipe)
```
Primary:          hsl(H, 80%, 55%)
Primary hover:    hsl(H, 80%, 50%)
Primary muted:    hsl(H, 40%, 20%)   [dark] / hsl(H, 40%, 90%) [light]
Accent:           hsl(H+150, 70%, 60%)  [complementary, sparingly]
Surface dark:     hsl(H, 8%, 10%) → hsl(H, 6%, 14%) → hsl(H, 5%, 18%)
Surface light:    hsl(H, 5%, 98%) → hsl(H, 4%, 94%) → hsl(H, 3%, 90%)
```

### Color Rules
1. Never hardcode hex in components — always use CSS variables or Tailwind semantic classes
2. Text contrast 4.5:1 minimum (WCAG AA)
3. Semantic colors (green=success, red=error, amber=warning) are never decorative
4. Hover states darken one stop (primary-500 → primary-600)
5. `focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2` on all interactive elements
6. Disabled: `opacity-50 cursor-not-allowed`
7. Gradients only for hero sections and CTAs — not everywhere
8. Dark mode: zero shadows; depth via border opacity (`rgba(255,255,255,0.07-0.20)`)

### Theme Provider

```tsx
// components/shared/theme-provider.tsx
"use client"
import { ThemeProvider as NextThemesProvider } from "next-themes"
export function ThemeProvider({ children, ...props }) {
  return <NextThemesProvider {...props}>{children}</NextThemesProvider>
}

// app/layout.tsx — wrap body:
<ThemeProvider attribute="class" defaultTheme="system" enableSystem disableTransitionOnChange>
  {children}
</ThemeProvider>
```

---

## §5 — Typography

### Font Stack by Aesthetic

| Aesthetic | Display Font | Body Font | Mono | Google Fonts Load |
|-----------|-------------|-----------|------|-------------------|
| SaaS Productivity | Geist Sans 700-800 | Geist Sans 400 | Geist Mono | `@vercel/geist` npm |
| Dark Premium | Syne 800 | Inter 400 | JetBrains Mono | `Syne`, `Inter`, `JetBrains+Mono` |
| Minimal Clean | Plus Jakarta Sans 700 | Plus Jakarta Sans 400 | — | `Plus+Jakarta+Sans` |
| Warm Organic | Playfair Display 700i | Instrument Sans 400 | — | `Playfair+Display`, `Instrument+Sans` |
| Bold & Graphic | Bebas Neue 400 | Barlow 500 | — | `Bebas+Neue`, `Barlow` |
| Dev Tools | IBM Plex Sans 700 | IBM Plex Sans 400 | IBM Plex Mono | `IBM+Plex+Sans`, `IBM+Plex+Mono` |
| Neon Cyber | Orbitron 700 | Rajdhani 400 | Share Tech Mono | `Orbitron`, `Rajdhani`, `Share+Tech+Mono` |

### Type Scale

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `xs` | 12px | 1rem | 400 | Captions, badges, fine print |
| `sm` | 14px | 1.25rem | 400 | Secondary text, table cells |
| `base` | 16px | 1.5rem | 400 | Body text, form inputs |
| `lg` | 18px | 1.75rem | 400 | Lead paragraphs, card titles |
| `xl` | 20px | 1.75rem | 600 | Section subtitles |
| `2xl` | 24px | 2rem | 600 | Section headings |
| `3xl` | 30px | 2.25rem | 700 | Page titles |
| `4xl` | 36px | 2.5rem | 700 | Hero subheadlines |
| `5xl` | 48px | 1.15 | 700 | Hero headlines |
| `6xl` | 60px | 1.1 | 800 | Marketing hero desktop |
| `7xl` | 72px | 1.05 | 800 | Large display desktop only |

### Typography Rules
- Headlines (3xl+): `tracking-tight` (-0.025em) → tighter = more authoritative
- Uppercase labels: `tracking-wider` (0.05em) — looser for legibility
- Body stays at `base` (16px) all breakpoints; only headlines scale responsively
- Max line length: `max-w-prose` (65ch) for body text
- Tabular numerals: `tabular-nums` class for aligned data columns
- **3-font exception**: Display + Serif Accent + Mono is allowed when each has a strict, non-overlapping role (headings / in-heading emphasis / data labels). Never 3+ decorative fonts.
- **Serif italic mid-heading**: splice one or two words in a serif-italic font (e.g. Instrument Serif) inside an otherwise sans heading — adds editorial warmth inside technical aesthetics. Example: `The fastest way to <em>ship</em>` where *ship* is Instrument Serif 700 italic.
- **Fluid type with `clamp()`**: for hero displays use `font-size: clamp(48px, 7vw, 88px)` instead of fixed breakpoint classes — scales continuously between mobile and desktop without a jump.
- Never: center-aligned long paragraphs, light (300) weight body, underlines except links

### Font Loading
```tsx
// app/layout.tsx
import { Inter, JetBrains_Mono } from "next/font/google"
const sans = Inter({ subsets: ["latin"], variable: "--font-sans", display: "swap" })
const mono = JetBrains_Mono({ subsets: ["latin"], variable: "--font-mono", display: "swap" })
// html className: `${sans.variable} ${mono.variable}`
// body className: "font-sans antialiased"
```

---

## §6 — Spacing & Layout

### 4px Base Scale (key tokens)
`2px(0.5) · 4px(1) · 8px(2) · 12px(3) · 16px(4) · 24px(6) · 32px(8) · 48px(12) · 64px(16) · 80px(20) · 96px(24) · 128px(32)`

### Spacing Contexts
- **Marketing hero**: `py-24 sm:py-32 lg:py-40`
- **Marketing sections**: `py-16 sm:py-20 lg:py-24`
- **App page**: `p-4 sm:p-6 lg:p-8`
- **App card**: `p-4 sm:p-6`
- **Container**: `mx-auto max-w-7xl px-4 sm:px-6 lg:px-8`

### Grid Patterns
```tsx
// Feature grid (3-col)
<div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
// Stats row (4-col)
<div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
// 2-col split (feature + image)
<div className="grid items-center gap-8 lg:grid-cols-2 lg:gap-16">
// Bento grid
<div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
  <div className="sm:col-span-2">{/* featured */}</div>
// Dashboard main + sidebar
<div className="grid gap-6 lg:grid-cols-[1fr_360px]">
```

### Responsive Breakpoints
`(default) 0px → sm: 640px → md: 768px → lg: 1024px → xl: 1280px → 2xl: 1536px`
Always mobile-first: write base styles for mobile, layer up with `sm:` `lg:`.

### Radius, Shadow, Z-Index
- **Radius**: one base (8px / `rounded-lg`); badges `rounded-full`; large panels `rounded-2xl`
- **Shadow levels**: `shadow-sm` (cards at rest) · `shadow-md` (dropdowns hover) · `shadow-lg` (modals)
- **Dark mode**: no shadows — use `border border-border` for depth
- **Z-index**: base(0) · sticky(10) · dropdown(20) · fixed sidebar(30) · modal backdrop(40) · modal/toast(50)

---

## §7 — Component Patterns

### Marketing Header
```tsx
"use client"
// sticky top-0 z-50, backdrop-blur-lg bg-background/80, h-16
// Logo left | Nav center (hidden md:flex) | ThemeToggle + Login + GetStarted right
// Mobile: hamburger → drawer with stacked nav + full-width CTA buttons
```

### App Sidebar
```tsx
// h-screen, border-r, w-64 collapsed→w-16, transition-all duration-200
// Sections: logo+collapse toggle | search (Cmd+K trigger) | nav items | bottom (settings)
// Active item: border-l-2 border-accent bg-sidebar-accent text-sidebar-accent-foreground
//   ↳ The 2px left border is a structural indicator, not just color — adds visual weight without filling the row
// Inactive: text-sidebar-foreground/70 hover:bg-sidebar-accent/50
```

### Stat Card (Dashboard)
```tsx
<div className="rounded-lg border bg-card p-6">
  <div className="flex items-center justify-between">
    <span className="text-sm font-medium text-muted-foreground">{title}</span>
    <Icon className="h-4 w-4 text-muted-foreground" />
  </div>
  <div className="mt-2 flex items-baseline gap-2">
    <span className="text-2xl font-bold tabular-nums">{value}</span>
    <span className={cn("text-xs font-medium", trend === "up" ? "text-emerald-600" : "text-red-600")}>
      {trend === "up" ? <ArrowUpRight className="h-3 w-3" /> : <ArrowDownRight className="h-3 w-3" />}
      {change}
    </span>
  </div>
</div>
```

### Pricing Card
```tsx
// highlighted: border-primary ring-1 ring-primary shadow-lg + "Most Popular" pill above
// price: text-4xl font-bold tabular-nums
// features: Check icon (text-primary) + text-sm list
// CTA: full-width, variant="default" if highlighted else "outline"
```

### ⚠️ shadcn Outline Button on Colored Backgrounds (Dark Mode Trap)

`variant="outline"` bakes in `bg-background` as a base style. In dark mode `bg-background` is near-black (`hsl(240 17% 4%)`). Placing an outline button inside a colored section (e.g. a neon-cyan CTA block) produces an **invisible button** — dark background, dark text, no contrast.

**Rule:** Any time you place `variant="outline"` on a non-default background, always add `bg-transparent`:

```tsx
// ❌ WRONG — black box on cyan background in dark mode
<Button variant="outline" className="text-primary-foreground">
  Talk to sales
</Button>

// ✅ CORRECT — transparent so the parent background shows through
<Button
  variant="outline"
  className="bg-transparent border-primary-foreground/30 text-primary-foreground hover:bg-primary-foreground/10"
>
  Talk to sales
</Button>
```

**Applies whenever:** colored section backgrounds (`bg-primary`, `bg-destructive`, gradient wrappers, brand-color blocks). Always override `bg-background` with `bg-transparent` on outline buttons inside these sections.

### Command Palette
```tsx
"use client"
// useEffect: listen for Cmd+K → setOpen(true)
// CommandDialog > CommandInput > CommandList > CommandGroup(heading) > CommandItem
// Groups: Navigation | Actions | Recent
```

### Toast (Sonner)
```tsx
import { toast } from "sonner"
toast.success("Saved", { description: "Changes saved successfully." })
toast.error("Failed", { description: "Please try again." })
toast("Deleted", { action: { label: "Undo", onClick: restore } })
toast.promise(saveAsync(), { loading: "Saving...", success: "Saved!", error: "Failed." })
```

### Data Table
```tsx
// Container: rounded-lg border
// StatusBadge: emerald=active, amber=pending, neutral=inactive (semantic classes)
// Numbers: tabular-nums class on all numeric cells
// Row hover: TableRow has built-in hover via shadcn
// Avatar + name + email in first column
```

### Status Badge with Pulse Dot
```tsx
// Pattern: colored dot prefix + background tint + matching text color
// ● Live:    <span className="bg-green-500/15 text-green-400"><span className="animate-pulse">●</span> Live</span>
// ● Pending: <span className="bg-amber-500/15 text-amber-400">● Pending</span>
// ● Error:   <span className="bg-red-500/15 text-red-400">● Error</span>
// Rule: only the "live/active" dot gets animate-pulse — pending and error are static
```

### Filter Chip Bar
```tsx
// Horizontal row of small filter pills — sits between page header and content
// Inactive: bg-surface border border-border text-muted-foreground
// Hover:    border-accent text-accent
// Active:   bg-accent/10 border-accent text-accent font-medium
// Container: flex gap-2 overflow-x-auto pb-1 (allow scroll on mobile, hide scrollbar)
```

### Semantic Color Coding for Data Categories
```
// When UI displays typed data (columns, fields, tags) — assign fixed hues per type:
// string / text  → indigo   (#818CF8 / indigo-400)
// number         → green    (#4ADE80 / green-400)
// date / time    → amber    (#FBBF24 / amber-400)
// enum / select  → pink     (#F472B6 / pink-400)
// email          → cyan     (#22D3EE / cyan-400)
// boolean        → purple   (#C084FC / purple-400)
// currency       → orange   (#FB923C / orange-400)
// This is NOT semantic state coloring — it's permanent taxonomy identity.
// Use: colored bg tint + matching text (e.g. bg-indigo-500/15 text-indigo-400)
```

### Empty State
```tsx
<div className="flex min-h-[400px] flex-col items-center justify-center text-center">
  <Icon className="h-10 w-10 text-muted-foreground/50" />
  <h3 className="mt-4 text-lg font-semibold">No {resource} yet</h3>
  <p className="mt-2 text-sm text-muted-foreground max-w-sm">{description}</p>
  <Button className="mt-6">Create your first {resource}</Button>
</div>
```

---

## §8 — Motion & Effects

### Timing Reference
```
Instant (hover/press):      100ms
Quick (color/opacity):      150ms
Standard (most UI):         200ms
Complex (slide/reveal):     300ms
Elaborate (modal/page):     400ms
Stagger delay (per child):  50-80ms (grids/cards) · 120-200ms (sequential list reveals meant to be watched)
```

### Framer Motion Easing
```tsx
const ease = {
  out: [0.16, 1, 0.3, 1],          // Default for entrances
  inOut: [0.45, 0, 0.55, 1],       // Symmetrical transitions
  spring: { type: "spring", stiffness: 300, damping: 30 },
  bounce: { type: "spring", stiffness: 400, damping: 10 },
}
```

### Scroll-Triggered Fade Up
```tsx
// components/shared/fade-up.tsx
const fadeUp = {
  hidden: { opacity: 0, y: 20 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: [0.16, 1, 0.3, 1] } },
}
export function FadeUp({ children, className }) {
  return (
    <motion.div variants={fadeUp} initial="hidden" whileInView="visible"
      viewport={{ once: true, margin: "-100px" }} className={className}>
      {children}
    </motion.div>
  )
}
```

### Stagger Grid
```tsx
const container = { hidden: { opacity: 0 }, visible: { opacity: 1, transition: { staggerChildren: 0.08, delayChildren: 0.1 } } }
const item = { hidden: { opacity: 0, y: 20 }, visible: { opacity: 1, y: 0, transition: { duration: 0.4, ease: [0.16, 1, 0.3, 1] } } }
// Wrap grid with motion.div variants={container}, each child with motion.div variants={item}
```

### Page Transition
```tsx
// app/template.tsx
<motion.div initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }}
  transition={{ duration: 0.3, ease: [0.16, 1, 0.3, 1] }}>
  {children}
</motion.div>
```

### Skeleton Loading
```tsx
// Match the SHAPE of the content — not a generic spinner
// Dashboard: 4 bordered boxes with Skeleton h-4 w-24, h-8 w-20 inside
// shimmer: bg linear-gradient(90deg, muted 25%, muted-foreground/10 50%, muted 75%)
//          background-size: 200%; animation: shimmer 1.5s ease-in-out infinite
```

### Visual Atmosphere System (Dark Premium)
```css
/* Fixed, pointer-events-none, full viewport, -z-10 */
/* 1. Grid overlay */
background: repeating-linear-gradient(
  0deg, transparent, transparent 47px, rgba(255,255,255,0.018) 48px
), repeating-linear-gradient(
  90deg, transparent, transparent 47px, rgba(255,255,255,0.018) 48px
);

/* 2. Warm glow (top-left) */
position: fixed; top: -20%; left: -20%;
width: 60%; height: 60%;
background: radial-gradient(ellipse, rgba(240,165,0,0.04) 0%, transparent 70%);
filter: blur(120px);

/* 3. Cool glow (bottom-right) */
position: fixed; bottom: -20%; right: -20%;
width: 60%; height: 60%;
background: radial-gradient(ellipse, rgba(0,242,234,0.035) 0%, transparent 70%);
filter: blur(120px);
```

### Scroll Effects (GPU-only: transform + opacity)

**Parallax layers:**
```tsx
// useEffect scroll listener with requestAnimationFrame
// Background: translateY(scrollY * 0.3)
// Midground: translateY(scrollY * 0.6)
// Foreground: normal (1:1)
```

**Scroll-linked hero fade:**
```tsx
// opacity: 1 → 0 over first 300px of scroll
// scale: 1 → 0.85 as user scrolls past hero
// Map scrollY to 0→1 progress, interpolate
```

**Sticky header opacity:**
```tsx
// bg-background/0 → bg-background/90 as scroll passes 64px threshold
```

**Horizontal scroll section:**
```tsx
// container: position: sticky; top: 0; height: 100vh; overflow: hidden
// inner: display: flex; transform: translateX(calc(...))
// section height = panels × 100vh
```

### Mouse-Reactive Effects

**3D Card Tilt:**
```tsx
// Container: perspective: 800px; style on parent
// onMouseMove: calculate x/y offset from card center (-0.5 to 0.5)
// apply: rotateX(y * -15deg) rotateY(x * 15deg) scale(1.02)
// onMouseLeave: spring back over 400-600ms ease-out
// lerp factor 0.08-0.12 for smooth follow
```

**Spotlight Glare:**
```tsx
// Overlay div: position absolute, inset 0, pointer-events-none
// onMouseMove: radial-gradient(circle at ${x}% ${y}%, rgba(255,255,255,0.12), transparent 60%)
// onMouseLeave: opacity → 0 over 300ms
```

**Button hover lift:**
```css
/* Add translateY(-1px) on hover for tactile feel — more satisfying than opacity alone */
.btn { transition: opacity 150ms, transform 150ms; }
.btn:hover { opacity: 0.88; transform: translateY(-1px); }
.btn:active { transform: translateY(0); }
```

**Magnetic Pull (for CTAs/FABs only):**
```tsx
// Track mouse globally; calculate distance from element center
// If distance < 200px: shift by (cursorPos - elementCenter) * 0.15
// On leave: spring back (CSS transition or lerp)
// ONLY for isolated buttons, never grid cards
```

### Animation Rules
1. Entrance animations go UP (y: 20→0), never down
2. Exit animations are faster than entrances (entrance 300ms, exit 200ms)
3. `viewport={{ once: true }}` — don't re-trigger on scroll back
4. Never animate data tables, lists during scanning, forms while typing
5. Stagger max 80ms delay per child
6. CSS transitions for simple states (hover/focus/active); Framer Motion for complex sequences
7. All animated properties: `transform` and `opacity` ONLY (no width/height/top/left)
8. Always: `@media (prefers-reduced-motion: reduce) { * { animation-duration: 0.01ms !important; } }`

---

## §9 — Page Blueprints

### Landing Page Structure
```
1. Header (sticky, frosted glass, h-16)
2. Hero (headline + dual CTA + subtle social proof)
3. Logo Bar (grayscale logos, hover → color)
4. Features (grid OR alternating OR bento — see patterns below)
5. Product Screenshot / Demo (static) OR Sequential Walkthrough Demo (see below)
6. Testimonials (3-col cards with name/role/company)
7. Pricing (3-tier, highlighted center)
8. FAQ (Accordion, max-w-3xl)
9. Final CTA (repeated, centered panel)
10. Footer (4-col links + copyright)
```

### Sequential Walkthrough Demo (alternative to static screenshot)
```
// When the product has a multi-step flow (Upload → Process → Preview → Deploy),
// make the demo section show each state as the user scrolls or clicks through steps.
// Structure:
//   - Step indicator (numbered dots or horizontal progress bar at top)
//   - Fixed-height panel that swaps content between states (no page jump)
//   - Each state: heading left + animated mockup right
//   - State transition: fade + slide-up (200ms) on content swap
// When to use: product with sequential workflow where EACH step is a convincing argument.
// Use static screenshot when the value is obvious from a single view.
```

### Feature Section: 3 Patterns
```tsx
// Pattern A: 3-col grid (most common)
<div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">

// Pattern B: Alternating rows (for detailed features with screenshots)
<div className={cn("grid items-center gap-8 lg:grid-cols-2 lg:gap-16",
  index % 2 === 1 && "lg:[&>*:first-child]:order-2")}>

// Pattern C: Bento grid (modern, Vercel/Linear)
<div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
  <div className="sm:col-span-2">{/* featured */}</div>
```

### Dashboard App Shell
```tsx
// app/(app)/layout.tsx
<div className="flex min-h-screen">
  <AppSidebar />
  <div className="flex flex-1 flex-col overflow-hidden">
    <AppHeader />
    <main className="flex-1 overflow-auto">
      <div className="p-4 sm:p-6 lg:p-8">{children}</div>
    </main>
  </div>
  <CommandPalette />
</div>
```

### Dashboard Page Structure
```tsx
// 1. Page header: title+description left, action buttons right
// 2. Stats row: grid gap-4 sm:grid-cols-2 lg:grid-cols-4
// 3. Main + sidebar: grid gap-6 lg:grid-cols-[1fr_360px]
// 4. Data table below
```

### Auth Split Layout
```tsx
// lg:grid-cols-2
// Left: form centered (mx-auto max-w-sm)
// Right: brand panel with gradient bg, testimonial quote, hidden on mobile
```

### Settings Page
```tsx
// Tabs: Profile | Account | Billing | Notifications | Team
// SettingsSection pattern: grid lg:grid-cols-[280px_1fr]
//   Left: title + description (font-medium + text-sm text-muted-foreground)
//   Right: form inputs
// Separator between sections
```

### Pricing Page
```tsx
// Annual/monthly toggle: inline-flex rounded-full border p-1
// 3-tier grid: lg:grid-cols-3 lg:items-start
// Highlighted plan: border-primary ring-1 ring-primary shadow-lg
// Feature comparison table below cards
```

---

## §10 — SaaS References

### Tier 1: Design Leaders

**Linear** — `#5E6AD2` purple, 13-14px Inter, 6px radius, zero shadows, spring animations 300/30
- Steal: command palette as primary nav, inline keyboard hints, extreme density with 4px spacing

**Vercel** — Black primary, Geist Sans, 8px radius, border-as-shadow (`0 0 0 1px`)
- Steal: bento grid marketing, `[0.16,1,0.3,1]` easing everywhere, gradient mesh hero

**Stripe** — `#635BFF` indigo, `#0A2540` dark slate, multi-layer shadows, animated gradient hero
- Steal: tab-based product showcases, scrolling code examples, premium gradient hero

**Notion** — Warm `#FBFBFA` white, 4px radius, pastels for tags, slash command UI
- Steal: breadcrumb nav, cover image on pages, block-based content interaction

**Figma** — Multi-color (`#A259FF` `#FF7262` `#0ACF83` `#1ABCFE`), floating toolbars
- Steal: multiple brand colors used boldly together, cursor presence indicators

### Tier 2: Category Leaders

**Slack** — Aubergine `#4A154B`, rounded soft UI, threaded conversations, emoji reactions first-class
**Shopify** — Green `#008060`, card-based dashboard, excellent illustrated empty states, Polaris design system
**Airbnb** — Coral `#FF5A5F`, photography-driven cards, smooth calendar interactions, map as core UI
**GitHub** — Monochrome + green actions, contribution heatmap, dense tab-based layout, code diff viewer
**Intercom** — Blue-warm, card inbox, chat bubble, customer profile sidebar

### Tier 3: Notable Patterns

**Lemon Squeezy** — Purple/pink gradients, playful illustrations, clean pricing comparison
**Cal.com** — Minimal scheduling, progressive disclosure booking flow, time slot grid
**Resend** — Near-identical to Vercel aesthetic, API-first docs style
**Raycast** — macOS-native web feel, keyboard-first, extension marketplace cards, Spotlight-style search
**Supabase** — Dark default, green `#3ECF8E`, SQL editor UI, real-time indicators
**Clerk** — Auth component previews, code+preview side-by-side, sign-in component customization
**PostHog** — Dense analytics, hedgehog mascot, feature flag UI, session recording timeline
**Tailwind UI** — Pixel-perfect components, responsive at every breakpoint, dark variants for everything

### Reference Combinations

| User Says | Apply This |
|-----------|-----------|
| "Clean and minimal" | Linear + Vercel tokens |
| "Modern and professional" | Stripe + Vercel |
| "Friendly and approachable" | Notion + Slack |
| "Bold and creative" | Figma + Framer |
| "Enterprise / data-heavy" | GitHub + Shopify |
| "Developer-focused" | Vercel + Supabase + Resend |
| "E-commerce / merchant" | Shopify + Lemon Squeezy |
| "Dark and technical" | Raycast + Warp + Supabase |

---

## §11 — Code Standards

### Project Setup
```bash
npx create-next-app@latest my-app --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"
npx shadcn@latest init
npm install framer-motion lucide-react next-themes sonner
npx shadcn@latest add button card input label badge separator
npx shadcn@latest add dialog dropdown-menu command avatar
npx shadcn@latest add tabs accordion table skeleton tooltip popover sheet
```

### File Structure
```
src/
├── app/
│   ├── layout.tsx              # Root: ThemeProvider + fonts + metadata
│   ├── template.tsx            # Page transition wrapper
│   ├── (auth)/login|signup/    # Auth pages
│   ├── (marketing)/pricing/    # Marketing pages
│   └── (app)/layout.tsx + dashboard/ settings/   # App shell + pages
├── components/
│   ├── ui/                     # shadcn/ui primitives (auto-generated)
│   ├── layout/                 # header.tsx, footer.tsx, app-sidebar.tsx
│   ├── marketing/              # hero.tsx, features.tsx, pricing.tsx, testimonials.tsx
│   └── shared/                 # theme-toggle.tsx, command-palette.tsx, fade-up.tsx
├── lib/
│   ├── utils.ts                # cn() helper
│   └── constants.ts            # nav items, design tokens, feature data
└── styles/globals.css          # CSS variables, base styles, keyframes
```

- File names: `kebab-case.tsx` — Component names: `PascalCase`
- No `index.tsx` barrel files — explicit names always
- One component per file (co-located sub-components fine)

### `"use client"` Boundary Rule
Only add when component needs: `useState`/`useEffect`/`useRef`, event handlers, browser APIs, or third-party client libs (framer-motion, next-themes). Push the boundary as LOW as possible — server components by default.

### `cn()` Utility
```tsx
// lib/utils.ts
import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"
export function cn(...inputs: ClassValue[]) { return twMerge(clsx(inputs)) }
```

### Critical Rules
- `next/image` always — never raw `<img>` (except logos in lists where `<img>` with explicit dimensions is fine)
- `priority` prop only for above-the-fold images
- `display: "swap"` on all `next/font` configs
- `dynamic(() => import(...), { ssr: false })` for heavy client components (charts, map, etc.)
- All placeholder data: realistic names/emails/numbers — never "John Doe" or lorem ipsum

---

## §12 — Shipping Checklist

### Design Quality
- [ ] Differentiation axis chosen and pushed to the extreme (not average on all axes)
- [ ] ONE icon library, consistent stroke width and size
- [ ] Color palette uses CSS custom properties, not hardcoded values
- [ ] 90/10 rule: brand color ≤10% of visible surface
- [ ] No duplicate information on screen
- [ ] No emojis in interface
- [ ] All landing page feature sections use product mockups, not icon grids
- [ ] Hover states on ALL interactive elements
- [ ] Loading, empty, and error states handled for every data section

### Typography & Layout
- [ ] Heading hierarchy is clear (h1 → h2 → h3, no skipped levels)
- [ ] Body text max-w-prose (65ch) for readable line lengths
- [ ] No centered long paragraphs (left-align body text)
- [ ] Responsive at 375px, 768px, 1024px, 1440px (no overflow or layout breaks)
- [ ] Mobile-first classes used (base styles mobile, `md:` `lg:` layer up)

### Accessibility
- [ ] Text contrast 4.5:1 minimum (WCAG AA)
- [ ] Focus indicators visible (`ring-2 ring-offset-2 ring-ring`) on keyboard nav
- [ ] All interactive elements have accessible names (aria-label or visible text)
- [ ] Semantic HTML: `<nav>`, `<main>`, `<section>`, `<article>`, `<header>`, `<footer>`
- [ ] `<img>` alt text descriptive (not "image" or filename)

### Animation & Performance
- [ ] `prefers-reduced-motion` respected (CSS or Framer Motion auto)
- [ ] All animations use `transform` + `opacity` only (no layout-thrashing properties)
- [ ] Framer Motion `viewport={{ once: true }}` on scroll animations
- [ ] `will-change: transform` on mouse-reactive elements (removed on mouse leave)
- [ ] Skeleton screens match content shape — no generic spinners for page loads
- [ ] Lighthouse score >90 all categories targeted
- [ ] No layout shift on load (explicit width/height on all images)
- [ ] `next/image` with `priority` for above-fold images

### Code Standards
- [ ] `"use client"` boundary pushed to lowest necessary component
- [ ] No magic numbers — spacing/color/size from scale
- [ ] `cn()` used for all conditional Tailwind class merging
- [ ] Structured placeholder data (realistic names, companies, numbers)
- [ ] `display: "swap"` on all font configs
- [ ] Heavy components (`dynamic(() => import(...)`) for charts, editors, maps
