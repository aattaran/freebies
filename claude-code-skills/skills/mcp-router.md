---
name: mcp-router
description: "Automatically discover and invoke the best MCP server for any task. Scans available mcp__* tools and routes requests to the optimal server based on capability matching."
triggers:
  - scrape website
  - crawl URL
  - design UI
  - generate component
  - create page layout
  - stitch design
  - library docs
  - API reference
  - documentation lookup
  - browser automation
  - click element
  - fill form
  - test web app
  - take screenshot
  - render diagram
  - flowchart
  - sequence diagram
  - cloud infrastructure
  - droplet
  - deploy server
  - cloudflare worker
  - KV store
  - D1 database
  - azure docs
  - microsoft docs
  - hugging face
  - model search
  - ML paper
  - UI component
  - shadcn component
  - send slack message
  - gmail
  - calendar event
  - asana task
  - email campaign
  - use MCP
  - find MCP tool
---

# MCP Auto-Router for Claude Code

Automatically detect when a task would benefit from an MCP server and route to it. This skill works with any Claude Code session that has MCP servers configured.

## How It Works

Claude Code exposes MCP server tools with the naming convention `mcp__<server_name>__<tool_name>`. When you encounter a task, check if any available MCP tools match the need before falling back to manual approaches.

## Server Capability Map

A comprehensive reference of common MCP servers and what they do:

| Server Prefix | What It Does | Use When |
|---------------|-------------|----------|
| `mcp__firecrawl__` | Web scraping, crawling, search | Need to extract content from URLs, scrape websites, search the web |
| `mcp__brightdata__` | Heavy scraping, CAPTCHA bypass | Firecrawl fails/blocks site (Reddit, etc.), need stealth scraping |
| `mcp__stitch__` | Google Stitch AI UI design | Generate UI components/pages from text descriptions |
| `mcp__context7__` | Library documentation | Look up docs, API references, code examples for any library |
| `mcp__plugin_context7_context7__` | Library documentation (plugin) | Same as above, alternate prefix |
| `mcp__plugin_playwright_playwright__` | Browser automation | Click, fill forms, navigate, screenshot, test web apps |
| `mcp__mermaid-mcp__` | Diagram rendering | Create flowcharts, sequence diagrams, entity relationship diagrams |
| `mcp__digitalocean-mcp-local__` | DigitalOcean cloud infra | Manage droplets, databases, Kubernetes, domains, load balancers |
| `mcp__claude_ai_Cloudflare_Developer_Platform__` | Cloudflare infra | Workers, D1 databases, KV stores, R2 buckets |
| `mcp__microsoft-learn__` | Microsoft/Azure docs | Search MS docs, fetch Azure tutorials, find code samples |
| `mcp__claude_ai_Hugging_Face__` | ML models & papers | Search models, datasets, papers, spaces on Hugging Face Hub |
| `mcp__shadcn__` | UI component registry | Search, preview, install shadcn/ui components |
| `mcp__claude_ai_Slack__` | Slack messaging | Send messages, search channels, read threads |
| `mcp__claude_ai_Gmail__` | Gmail | Search emails, read messages, create drafts |
| `mcp__claude_ai_Google_Calendar__` | Google Calendar | List events, create events, find free time |
| `mcp__claude_ai_Asana__` | Asana project management | Search tasks, create tasks, manage projects |
| `mcp__claude_ai_Klaviyo__` | Klaviyo email marketing | Get campaigns, flows, segments, profiles |
| `mcp__jarvis__` | Jarvis AI gateway | Delegate tasks, manage channels, memory, IDE automation |
| `mcp__sequential-thinking__` | Extended reasoning | Break down complex problems step by step |
| `mcp__webmcp__` | Dynamic tool creation | Define new MCP tools at runtime |

## Routing Protocol

### Step 1 -- Identify the Need
Before starting any task, scan for keywords that suggest an MCP server would help:
- **Web content needed?** -- firecrawl or brightdata
- **UI to build?** -- stitch or shadcn
- **Need library docs?** -- context7
- **Browser interaction?** -- playwright
- **Need a diagram?** -- mermaid
- **Cloud infra?** -- digitalocean or cloudflare
- **MS/Azure docs?** -- microsoft-learn
- **ML/AI related?** -- hugging face
- **Communication?** -- slack, gmail, calendar
- **Project management?** -- asana
- **Complex reasoning?** -- sequential-thinking

### Step 2 -- Check Availability
Not all servers are configured in every environment. Before routing, verify the tool exists:
- Check if `mcp__<server>__` tools appear in your available tools list
- If the server isn't available, skip it and try alternatives or proceed manually

### Step 3 -- Select the Best Server
When multiple servers could handle a task:
1. **Specificity wins** -- use the most targeted server (Context7 for docs, not Firecrawl)
2. **Firecrawl before BrightData** for general scraping (faster, cheaper)
3. **BrightData for blocked sites** -- Reddit, sites with aggressive bot detection
4. **Stitch for generation, shadcn for existing components** -- don't confuse these
5. **Context7 for library docs** -- always prefer over web scraping docs sites

### Step 4 -- Execute
Call the tool directly using the `mcp__<server>__<tool>` format. Common patterns:

**Web scraping:**
```
mcp__firecrawl__firecrawl_scrape(url: "https://...", formats: ["markdown"])
mcp__brightdata__scrape_as_markdown(url: "https://reddit.com/...")
```

**Library docs:**
```
mcp__context7__resolve-library-id(libraryName: "react")
mcp__context7__query-docs(libraryId: "/vercel/next.js", topic: "middleware")
```

**Browser automation:**
```
mcp__plugin_playwright_playwright__browser_navigate(url: "http://localhost:3000")
mcp__plugin_playwright_playwright__browser_snapshot()
mcp__plugin_playwright_playwright__browser_click(element: "Submit", ref: "e3")
```

**Diagrams:**
```
mcp__mermaid-mcp__validate_and_render_mermaid_diagram(diagram: "flowchart TD\n  A-->B")
```

**UI components:**
```
mcp__shadcn__search_items_in_registries(query: "data table", registries: ["shadcn"])
mcp__shadcn__get_add_command_for_items(items: ["table"], registries: ["shadcn"])
```

**Cloud infra:**
```
mcp__digitalocean-mcp-local__droplet-list()
mcp__claude_ai_Cloudflare_Developer_Platform__workers_list()
```

### Step 5 -- Handle Failures
- **Tool not found**: Server not configured -- inform the user and suggest adding it to `~/.claude/settings.json`
- **Server error**: Retry once, then try alternative server or manual approach
- **Auth error**: Check if API key/OAuth is configured

## Server Selection Decision Tree

```
Task involves a URL to read/extract?
  |-- Yes -- Is it Reddit or bot-protected? -- BrightData
  |          Otherwise -- Firecrawl
  |
Task involves library/API documentation?
  |-- Yes -- Context7
  |
Task involves generating UI from description?
  |-- Yes -- Stitch
  |
Task involves adding existing UI components?
  |-- Yes -- shadcn
  |
Task involves browser interaction/testing?
  |-- Yes -- Playwright
  |
Task involves creating a diagram?
  |-- Yes -- Mermaid
  |
Task involves cloud infrastructure?
  |-- Yes -- Which provider?
  |          |-- DigitalOcean -- digitalocean-mcp-local
  |          +-- Cloudflare -- Cloudflare_Developer_Platform
  |
Task involves Microsoft/Azure docs?
  |-- Yes -- microsoft-learn
  |
Task involves ML models/papers/datasets?
  |-- Yes -- Hugging Face
  |
Task involves team communication?
  |-- Yes -- Slack / Gmail / Calendar
  |
Task involves project tracking?
  |-- Yes -- Asana
  |
None match -- Proceed without MCP
```

## Important Rules

- **Check availability first** -- not all environments have all servers
- **Prefer specialized over general** -- Context7 for docs beats scraping the docs site
- **Cache results** -- don't re-scrape or re-fetch within the same session
- **Respect rate limits** -- batch operations when possible (firecrawl_crawl > multiple scrapes)
- **Security** -- never pass secrets/credentials through MCP tool arguments in plaintext
- **Fail gracefully** -- if MCP server is down, continue the task manually
