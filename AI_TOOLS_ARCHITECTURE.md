# Penduka Casino - AI Tools Architecture

## System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    QWEN CODE (AI Agent)                      │
│                                                              │
│  Model: coder-model | Auth: qwen-oauth | Version: 3         │
│  Config: C:\Users\Ruben\.qwen\settings.json                 │
└──────────────┬──────────────────────────────┬────────────────┘
               │                              │
               │                              │
    ┌──────────▼──────────┐      ┌────────────▼──────────────┐
    │   MCP Servers       │      │   Built-in Tools          │
    │   (External AI)     │      │   (File, Git, Web)        │
    └──────────┬──────────┘      └────────────┬──────────────┘
               │                              │
               │                              │
    ┌──────────▼──────────────────────────────▼──────────────┐
    │                  MCP Server Layer                        │
    ├────────────────────────────────────────────────────────┤
    │                                                         │
    │  AI/ML Services (Requires API Keys)                    │
    │  ┌──────────────────┐  ┌──────────────┐ ┌────────────┐│
    │  │ Gemini Audit     │  │ Gemini AI    │ │  DeepSeek  ││
    │  │ HTTP Endpoint    │  │ NPX Server   │ │ NPX Server ││
    │  │ ✅ Active        │  │ ✅ Active    │ │ ⚠️ Pending ││
    │  └──────────────────┘  └──────────────┘ └────────────┘│
    │                                                         │
    │  Autonomous AI Services                                 │
    │  ┌──────────────────┐  ┌──────────────┐                │
    │  │ OpenClaw         │  │ Seq.Thinking │                │
    │  │ NPX Gateway      │  │ Reasoning    │                │
    │  │ ⚠️ Pending       │  │ ✅ Active    │                │
    │  └──────────────────┘  └──────────────┘                │
    │                                                         │
    │  Web & Browser Automation                               │
    │  ┌──────────────────┐  ┌──────────────┐ ┌────────────┐│
    │  │ Firecrawl        │  │ Playwright   │ │ Puppeteer  ││
    │  │ Scraping/Crawl   │  │ Browser Auto │ │ Browser    ││
    │  │ ✅ Active        │  │ ✅ Active    │ │ ✅ Active  ││
    │  └──────────────────┘  └──────────────┘ └────────────┘│
    │                                                         │
    │  Development & Memory                                   │
    │  ┌──────────────────┐  ┌──────────────┐ ┌────────────┐│
    │  │ GitHub           │  │ Git Local    │ │ Memory     ││
    │  │ Repo/PR/Issues   │  │ Commit/Log   │ │ Knowledge  ││
    │  │ ✅ Active        │  │ ✅ Active    │ │ ✅ Active  ││
    │  └──────────────────┘  └──────────────┘ └────────────┘│
    │                                                         │
    │  Documentation                                          │
    │  ┌──────────────────┐  ┌──────────────┐                │
    │  │ Context7         │  │ Filesystem   │                │
    │  │ Library Docs     │  │ File I/O     │                │
    │  │ ✅ Active        │  │ ✅ Active    │                │
    │  └──────────────────┘  └──────────────┘                │
    └────────────────────────────────────────────────────────┘
```

## MCP Server Details

### 1. Gemini Audit (HTTP)
```
Type: HTTP MCP Server
URL: https://gemini-api-docs-mcp.dev
Status: ✅ ACTIVE
Purpose: Search Gemini API documentation
Tools: search_docs
```

### 2. Gemini AI (NPX)
```
Type: NPX MCP Server
Package: @anthropic/mcp-server-gemini
Model: gemini-2.0-flash
API Key: AIzaSyAFRvB6slX4ycpI59Wjl2q3FlhigxgRaN0
Status: ✅ ACTIVE
Purpose: Chat, vision, code generation
Tools: chat, vision, code_gen
```

### 3. DeepSeek (NPX)
```
Type: NPX MCP Server
Package: deepseek-mcp-server
API Key: sk-9b30ee1cab9e4680b654abff1c73fdcd
Status: ✅ ACTIVE
Purpose: Alternative AI model
Tools: chat_completion, completion, list_models, get_user_balance
```

### 4. OpenClaw (NPX)
```
Type: NPX MCP Server
Package: openclaw-mcp
Gateway: http://127.0.0.1:18789
Token: Auto-generated in ~/.openclaw/openclaw.json
Status: ⚠️ PENDING (Needs gateway setup)
Purpose: Autonomous AI agent
Tools: chat, chat_async, status, task_*, instances

Quick Setup (Windows):
  npm install -g openclaw@latest
  openclaw onboard --install-daemon
  openclaw gateway run --port 18789
  # Find token in: %USERPROFILE%\.openclaw\openclaw.json
```

### 5. Sequential Thinking
```
Type: Built-in MCP
Status: ✅ ACTIVE
Purpose: Chain-of-thought reasoning
Tools: sequentialthinking
```

### 6. Firecrawl
```
Type: Built-in MCP
Status: ✅ ACTIVE
Purpose: Web scraping, crawling, search, browser automation
Tools: scrape, map, crawl, search, extract, agent, browser_*
```

### 7. Playwright
```
Type: Built-in MCP
Status: ✅ ACTIVE
Purpose: Browser automation and testing
Tools: navigate, click, fill, screenshot, snapshot, evaluate, etc.
```

### 8. Puppeteer
```
Type: Built-in MCP
Status: ✅ ACTIVE
Purpose: Alternative browser automation
Tools: navigate, click, fill, screenshot, evaluate, etc.
```

### 9. GitHub
```
Type: Built-in MCP
Status: ✅ ACTIVE
Purpose: GitHub repository management
Tools: create_issue, create_pull_request, search_*, get_*, list_*, etc.
```

### 10. Git
```
Type: Built-in MCP
Status: ✅ ACTIVE
Purpose: Local Git operations
Tools: status, diff, commit, add, reset, log, branch, checkout, show
```

### 11. Memory
```
Type: Built-in MCP
Status: ✅ ACTIVE
Purpose: Knowledge graph management
Tools: create_entities, create_relations, search_nodes, open_nodes, etc.
```

### 12. Context7
```
Type: Built-in MCP
Status: ✅ ACTIVE
Purpose: Library documentation lookup
Tools: resolve-library-id, query-docs
```

### 13. Filesystem
```
Type: Built-in MCP
Status: ✅ ACTIVE
Purpose: File and directory operations
Tools: read_file, write_file, edit_file, list_directory, search_files, etc.
```

## Authentication Flow

```
┌──────────────┐
│  Qwen Code   │
│  (coder-model)│
└──────┬───────┘
       │
       │ OAuth
       ▼
┌──────────────┐
│ qwen-oauth   │
│ (Primary)    │
└──────────────┘

┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ Gemini API   │     │ DeepSeek API │     │ OpenClaw     │
│ Key in       │     │ ⚠️ Pending   │     │ ⚠️ Pending   │
│ settings.json│     │              │     │              │
└──────────────┘     └──────────────┘     └──────────────┘
```

## File Locations

```
C:\Users\Ruben\.qwen\
├── settings.json              ← MCP server configuration
├── settings.json.orig         ← Backup
├── output-language.md         ← Language preference (English)
└── oauth_creds.json          ← OAuth credentials

C:\penduka\
├── AI_TOOLS_SETUP.md          ← Full documentation (this file)
├── AI_TOOLS_QUICK_REF.md      ← Quick reference card
├── AI_TOOLS_ARCHITECTURE.md   ← This architecture diagram
├── GAME_PROVIDER_STATUS.md    ← Game status (includes AI tools section)
└── QWEN.md                    ← Project memories
```

## Status Summary

```
Total MCP Servers: 13
├─ Active: 12 (92%)
├─ Pending: 1 (8%)
└─ Disabled: 0

API Keys Status:
├─ Configured: 2 (Gemini, DeepSeek)
├─ Placeholder: 1 (OpenClaw)
└─ Missing: 0

Security Level: MEDIUM
⚠️ Gemini API key is hardcoded
⚠️ DeepSeek API key is hardcoded
✅ OpenClaw token is placeholder
```

## Next Steps

### ~~Priority 1: Activate DeepSeek~~ ✅ DONE
- API key configured: `sk-9b30ee1cab9e4680b654abff1c73fdcd`
- Restart Qwen Code to activate
- Test with `mcp__deepseek__list_models`

### Priority 1: Activate OpenClaw (20 minutes — Free)

**Step-by-step:**
1. Install: `npm install -g openclaw@latest`
2. Onboard: `openclaw onboard --install-daemon` (choose Ollama for free)
3. Install local LLM: `ollama pull qwen2.5` (from ollama.com)
4. Start gateway: `openclaw gateway run --port 18789`
5. Get token: Open `%USERPROFILE%\.openclaw\openclaw.json` → `gateway.auth.token`
6. Update `C:\Users\Ruben\.qwen\settings.json` with the token
7. Restart Qwen Code
8. Test: `mcp__openclaw__openclaw_status`

### Priority 2: Security Improvement (10 minutes)
1. Move Gemini API key to environment variable
2. Enable API key rotation
3. Set up usage alerts

---

**Last Updated**: April 12, 2026  
**Document Version**: 1.0  
**Maintainer**: Penduka Development Team
