# OhMyOpenAgent Backend-Optimized Configuration

**Profile:** OpenCode Go subscription only | Backend-focused | Intelligence over speed
**Config path:** `~/.config/opencode/oh-my-openagent.json`
**Date:** 2026-05-05

---

## Core Philosophy

Models are developers with different personalities. The right model for the right agent:

- **Claude/Kimi/GLM** = communicative orchestrators (follow complex multi-step instructions)
- **GPT/DeepSeek** = deep specialists (principle-driven autonomous reasoning)
- **Gemini/Qwen** = creative/visual or general-purpose models
- **Fast models** (Flash, Nano, MiniMax) = utility agents (grep, search, retrieval)

For backend work, we prioritize **reasoning and reliability** over speed.

---

## Model Benchmarks (SWE-Pro)

| Model | Score | Best For |
|-------|-------|----------|
| `kimi-k2.6` | **58.6%** | Orchestration, deep coding, agentic workflows |
| `glm-5.1` | **58.4%** | Reasoning, architecture, 8-hour autonomous runs |
| `deepseek-v4-pro` | ~55% | Heavy backend implementation, API design |
| `qwen3.6-plus` | ~52% | General tasks, writing, planning |
| `deepseek-v4-flash` | ~48% | Speed-only utility work |

*Source: OpenCode Go routing guide with SWE-Pro benchmarks*

---

## Agent Configuration Reasoning

### Sisyphus (Main Orchestrator)
**Model:** `opencode-go/kimi-k2.6` (max)
**Fallbacks:** `deepseek-v4-pro` → `qwen3.6-plus` → `glm-5.1`
**Rationale:**
- Kimi K2.6 is the best agentic coder in OpenCode Go (58.6% SWE-Pro)
- Orchestration requires following complex multi-step instructions (~1,100 line prompts)
- Max variant for maximum reasoning depth on backend architecture decisions
- `prompt_append` tells agent to prioritize API design, DB modeling, service architecture

### Hephaestus (Autonomous Deep Worker)
**Model:** `opencode-go/deepseek-v4-pro`
**Fallbacks:** `kimi-k2.6` → `glm-5.1`
**Rationale:**
- Previously pointed to `opencode/gpt-5.5` which is unavailable without OpenAI
- DeepSeek-V4-Pro is the strongest autonomous coder in OpenCode Go after Kimi
- Prompt append guides toward backend patterns: repository pattern, DI, clean architecture
- Built for goal-driven execution without hand-holding

### Oracle (Architecture/Debugging)
**Model:** `opencode-go/glm-5.1` (high)
**Fallbacks:** `kimi-k2.6` → `deepseek-v4-pro`
**Rationale:**
- GLM-5.1 has the best reasoning capability among OpenCode Go models (58.4% SWE-Pro)
- Ideal for architecture decisions, code review, debugging complex backend systems
- Without Claude/GPT access, GLM-5.1 is the strongest alternative for Oracle's role
- Prompt append focuses on data flow, service boundaries, API contracts, scalability

### Prometheus (Strategic Planner)
**Model:** `opencode-go/glm-5.1` (max)
**Fallbacks:** `qwen3.6-plus` → `deepseek-v4-pro`
**Rationale:**
- Planning requires strong reasoning and scope identification
- GLM-5.1's max variant provides deepest reasoning for complex backend projects
- Prompt append: interview-first approach, probe for domain entities and transaction boundaries
- Backend projects often have hidden data model complexity that needs discovery

### Metis (Plan Consultant)
**Model:** `opencode-go/qwen3.6-plus`
**Fallbacks:** `deepseek-v4-pro` → `glm-5.1`
**Rationale:**
- Plan review doesn't require the absolute strongest model
- Qwen 3.6 Plus is capable and cost-effective for gap analysis
- Fallback to stronger models if review needs deeper reasoning

### Momus (Reviewer)
**Model:** `opencode-go/qwen3.6-plus`
**Fallbacks:** `kimi-k2.6` → `glm-5.1`
**Rationale:**
- Code review and verification agent
- Qwen sufficient for most review tasks; fallback to Kimi/GLM for critical reviews

### Atlas (Todo Orchestrator)
**Model:** `opencode-go/deepseek-v4-pro`
**Fallbacks:** `kimi-k2.6` → `deepseek-v4-flash`
**Rationale:**
- Todo management and task breakdown
- DeepSeek-V4-Pro provides good reasoning for task decomposition
- Fallback to faster models for simple todo operations

### Librarian (Docs/Code Search)
**Model:** `opencode-go/deepseek-v4-flash`
**Fallbacks:** `qwen3.6-plus` → `minimax-m2.7-highspeed`
**Rationale:**
- Doc retrieval doesn't need deep reasoning
- Flash model is fast and cheap for search/grep operations
- Don't "upgrade" to Opus — that's hiring a senior engineer to file paperwork

### Explore (Fast Grep)
**Model:** `opencode-go/deepseek-v4-flash`
**Fallbacks:** `minimax-m2.7-highspeed` → `gpt-5-nano`
**Rationale:**
- Speed is everything for codebase exploration
- Flash model is optimized for fast retrieval
- MiniMax highspeed as ultra-fast fallback

### Multimodal Looker (Vision)
**Model:** `opencode-go/kimi-k2.6` (medium)
**Fallbacks:** `qwen3.6-plus` → `gpt-5-nano`
**Rationale:**
- Kimi K2.6 has vision capabilities
- Medium variant sufficient for screenshot/PDF analysis
- Backend work rarely needs vision, but configured for completeness

### Sisyphus-Junior (Category Executor)
**Model:** `opencode-go/deepseek-v4-flash`
**Fallbacks:** `deepseek-v4-pro` → `qwen3.6-plus`
**Rationale:**
- Executes category-specific tasks
- Flash is sufficient for most delegated subtasks
- Fallback to stronger models for complex category work

---

## Category Configuration Reasoning

### `deep` (Deep Coding, Complex Logic)
**Model:** `kimi-k2.6` (medium)
**Fallbacks:** `deepseek-v4-pro` → `glm-5.1`
**Rationale:**
- Backend logic requires intelligence, not speed
- Kimi K2.6 medium provides strong reasoning at lower cost than max
- DeepSeek-V4-Pro and GLM-5.1 as solid fallbacks

### `ultrabrain` (Maximum Reasoning)
**Model:** `glm-5.1` (xhigh)
**Fallbacks:** `kimi-k2.6` → `deepseek-v4-pro`
**Rationale:**
- Hardest problems need the strongest reasoning model
- GLM-5.1 xhigh is the deepest reasoning configuration available
- Kimi K2.6 as first fallback for agentic capability

### `unspecified-high` (General Complex Work)
**Model:** `deepseek-v4-pro`
**Fallbacks:** `kimi-k2.6` → `glm-5.1`
**Rationale:**
- Strong model for complex but not extreme reasoning tasks
- Good balance of capability and cost

### `unspecified-low` / `quick` (Standard/Fast Tasks)
**Model:** `deepseek-v4-flash`
**Rationale:**
- Speed and cost efficiency for simple tasks
- Don't waste expensive models on trivial work

### `visual-engineering` (Frontend/UI)
**Model:** `kimi-k2.6` (medium)
**Fallbacks:** `qwen3.6-plus` → `glm-5.1`
**Rationale:**
- Even though user is backend-focused, visual tasks still occur
- Kimi K2.6 handles UI tasks well; medium variant sufficient

### `artistry` (Creative, Novel Approaches)
**Model:** `glm-5.1` (high)
**Fallbacks:** `qwen3.6-plus` → `kimi-k2.6`
**Rationale:**
- Creative problem-solving benefits from GLM's reasoning
- High variant for creative depth

### `writing` (Docs, Prose)
**Model:** `qwen3.6-plus`
**Fallbacks:** `deepseek-v4-flash`
**Rationale:**
- Qwen is strong at writing and documentation
- Flash fallback for simple text generation

---

## Fallback Strategy

### Runtime Fallback (Global)
```json
{
  "enabled": true,
  "retry_on_errors": [400, 429, 503, 529],
  "max_fallback_attempts": 3,
  "cooldown_seconds": 60,
  "timeout_seconds": 30,
  "notify_on_fallback": true
}
```
**Rationale:**
- Rate limits (429) are the most common failure mode
- 3 attempts with 60s cooldown gives time for rate limits to reset
- Notify user when fallback happens for transparency
- 30s timeout prevents hanging on slow models

### Per-Agent Fallbacks
- All fallbacks use **OpenCode Go models only** (no unavailable providers)
- Fallback chains progress from strongest to still-capable models
- No fallback to `opencode/big-pickle` (free tier) unless explicitly desired

---

## Concurrency Limits

| Model | Limit | Rationale |
|-------|-------|-----------|
| `kimi-k2.6` | 2 | Most expensive/capable model — limit to prevent cost explosion |
| `glm-5.1` | 2 | Second most capable — limit for cost control |
| `deepseek-v4-pro` | 3 | Strong but cheaper than Kimi/GLM — moderate limit |
| `qwen3.6-plus` | 5 | General-purpose — higher concurrency okay |
| `deepseek-v4-flash` | 20 | Cheap utility model — let it run freely |

**Provider concurrency:** `opencode-go: 10` (total parallel tasks across all models)
**Default concurrency:** 5 (reasonable default for most workflows)
**Stale timeout:** 180s (3 minutes before abandoned tasks are cleaned up)

---

## Backend-Specific Prompt Guidance

Agents are told the user works primarily on:
- **API design** — clear interfaces, RESTful principles, contract-first design
- **Database modeling** — schema design, relationships, transactions, normalization
- **Service architecture** — microservices, monoliths, service boundaries
- **Business logic** — domain-driven design, clean architecture, testability

Key directives:
- Prioritize robustness over visual polish
- Use repository pattern, dependency injection, clean architecture
- Focus on data flow, API contracts, scalability
- Probe for domain entities, relationships, transaction boundaries
- Prefer small, testable changes

---

## Anti-Patterns Avoided

| Bad Practice | Why Avoided |
|-------------|-------------|
| Using Opus for Explore/Librarian | Massive cost waste; these need speed, not intelligence |
| Using GPT for Sisyphus without dedicated prompt | GPT doesn't follow 1,100-line orchestration prompts well |
| No fallback configuration | Rate limits break workflow instead of switching models |
| Uniform concurrency | Expensive models need caps; cheap models can run freely |
| Generic prompts | Backend-specific guidance improves code quality significantly |

---

## Verification

Run `bunx oh-my-opencode doctor` to verify:
- All models resolve correctly
- No compatibility fallback warnings
- Config syntax is valid

If you add new subscriptions (Claude, OpenAI, etc.), re-run the installer to unlock stronger fallbacks:
```bash
bunx oh-my-opencode install --no-tui --claude=yes --openai=yes
```

---

## References

- [OhMyOpenAgent Agent-Model Matching Guide](https://raw.githubusercontent.com/code-yeongyu/oh-my-openagent/refs/heads/dev/docs/guide/agent-model-matching.md)
- [OpenCode Go Model Routing Guide](https://medium.com/@jatinkrmalik/opencode-go-oh-my-openagent-the-complete-guide-to-sota-model-routing-without-hitting-limits-49fdc8cb3417)
- [OhMyOpenAgent Configuration Reference](https://github.com/code-yeongyu/oh-my-openagent/blob/HEAD/docs/reference/configuration.md)
- [OhMyOpenAgent Features Documentation](https://github.com/code-yeongyu/oh-my-openagent/blob/HEAD/docs/reference/features.md)
