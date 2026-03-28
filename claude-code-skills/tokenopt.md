---
name: tokenopt
description: >
  Token optimization for both prompt engineering (CLAUDE.md, skills,
  system prompts) and LLM application code (API calls, caching,
  batching, model routing). Use when optimizing prompts for token
  efficiency, reducing API costs, or improving LLM application performance.
---

# Token Optimization Protocol

Two modes: optimizing prompts/skills (mode A) or optimizing LLM application code (mode B). Apply whichever is relevant, or both.

## Mode A: Prompt and Skill Optimization

Analyze the provided prompt, CLAUDE.md, or skill file for token waste.

Cut ruthlessly:
- Remove anything the model already knows (common coding practices, language syntax rules, obvious security advice)
- Remove examples that illustrate obvious points -- only keep examples for non-obvious behavior
- Remove formatting decoration (emoji, horizontal rules, ASCII art, excessive headers)
- Collapse verbose lists into concise rules
- Remove "do not do X" when X is something the model would never do unprompted
- Remove redundant restatements of the same rule in different words

Restructure for efficiency:
- Lead with the most important directives -- models weight earlier content more
- Use terse imperative sentences ("Validate server-side" not "You should always make sure to validate inputs on the server side")
- Group related rules, eliminate overlap between groups
- If a rule only applies sometimes, make it conditional rather than universal
- Prefer "do X" over "do not do Y" -- positive instructions are shorter and clearer

Measure:
- Estimate token count before and after
- Flag any rules that might change behavior if removed -- ask before cutting those

## Mode B: LLM Application Code Optimization

Analyze application code that calls LLM APIs for cost and latency optimization.

Prompt efficiency:
- Are system prompts bloated? Apply Mode A to them.
- Is context being sent that the model does not need for the current task?
- Are few-shot examples necessary, or would a clear instruction suffice?
- Can structured output (JSON mode, tool use) replace parsing free-text responses?

Caching:
- Are identical or near-identical prompts being sent repeatedly? Implement prompt caching.
- For Anthropic API: are cache_control breakpoints placed optimally on static content?
- Is there application-level caching for deterministic queries?

Batching and routing:
- Can multiple small requests be combined into one with structured output?
- Are expensive models being used for tasks a smaller model could handle? (Use Haiku for classification/extraction, Opus for reasoning)
- Is streaming enabled where appropriate to improve perceived latency?

Architecture:
- Is the prompt assembled dynamically with only relevant context, or does it dump everything?
- Are embeddings/retrieval used to select relevant context instead of sending all documents?
- Are tool definitions minimal, or do they include unnecessary descriptions?
- For multi-turn conversations: is the history trimmed or summarized, or does it grow unbounded?

## Output

For Mode A: provide the optimized version with a before/after token estimate.
For Mode B: provide findings as file:line, issue, recommendation, estimated savings.
