# AI Tools Quick Reference - Penduka Casino

## MCP Server Status Overview

| # | Server | Type | Status | Notes |
|---|--------|------|--------|-------|
| 1 | Gemini Audit | HTTP | ✅ Active | API docs search |
| 2 | Gemini AI | NPX | ✅ Active | gemini-2.0-flash |
| 3 | DeepSeek | NPX | ✅ Active | sk-9b30ee1c... |
| 4 | OpenClaw | NPX | ⚠️ Needs Setup | Gateway + token |
| 5 | GitHub Copilot MCP | NPX | 📋 Documented | Needs PAT token |
| 6 | Filesystem | Built-in | ✅ Active | File operations |
| 7 | GitHub | Built-in | ✅ Active | Repo management |
| 8 | Git | Built-in | ✅ Active | Git commands |
| 9 | Firecrawl | Built-in | ✅ Active | Web scraping |
| 10 | Playwright | Built-in | ✅ Active | Browser automation |
| 11 | Puppeteer | Built-in | ✅ Active | Browser automation |
| 12 | Memory | Built-in | ✅ Active | Knowledge graph |
| 13 | Context7 | Built-in | ✅ Active | Library docs |
| 14 | Seq. Thinking | Built-in | ✅ Active | Chain of thought |

---

## Quick Status Check Commands

### Test Gemini (Working)
```
Use tool: mcp__gemini-audit__search_docs
Query: "chat completion"
```

### Test DeepSeek (Active)
```
Use tool: mcp__deepseek__list_models
Expected: List of available DeepSeek models
```

### Test OpenClaw (Needs Gateway)
```
Use tool: mcp__openclaw__openclaw_status
Expected: Gateway status and health info (after setup)
```

---

## Activation Checklist

### ~~DeepSeek~~ ✅ DONE
- [x] Get API key from https://platform.deepseek.com/
- [x] Update `C:\Users\Ruben\.qwen\settings.json`
- [x] Key: `sk-9b30ee1cab9e4680b654abff1c73fdcd`
- [x] Restart Qwen Code
- [x] Test: `mcp__deepseek__list_models`

### OpenClaw (20 minutes — Free with Ollama)

**Quick Setup (Windows PowerShell):**
```powershell
npm install -g openclaw@latest         # Install OpenClaw
openclaw onboard --install-daemon       # Wizard (choose Ollama for free)
ollama pull qwen2.5                     # Local LLM model
openclaw gateway run --port 18789       # Start gateway
```

**Find Token:** Open `%USERPROFILE%\.openclaw\openclaw.json` → `gateway.auth.token`

**Connect to Qwen Code:**
- Open `C:\Users\Ruben\.qwen\settings.json`
- Replace `PLACEHOLDER_REPLACE_WITH_YOUR_TOKEN` with actual token
- Restart Qwen Code

**Verify:**
```
mcp__openclaw__openclaw_status    # Should show gateway info
mcp__openclaw__openclaw_chat      # Send "hello"
```

**Useful Commands:**
```powershell
openclaw gateway start/stop/restart/status
openclaw doctor                    # Diagnostics
openclaw dashboard                 # Open web UI in browser
```

### GitHub Copilot MCP (5 minutes — Free, Needs PAT Token)

**What it is:** Official GitHub MCP server — 20+ tools for repos, issues, PRs, code search

**Setup:**
1. Get PAT token: https://github.com/settings/tokens (scopes: `repo`, `read:user`, `workflow`)
2. Add to `C:\Users\Ruben\.qwen\settings.json`:
```json
"github-copilot": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your-token" }
}
```
3. Restart Qwen Code

**Also works in VS Code Copilot:**
```json
"github.copilot.chat.mcp.servers": {
  "github": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-github"],
    "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your-token" }
  }
}
```

---

## Configuration File Locations

| File | Purpose |
|------|---------|
| `C:\Users\Ruben\.qwen\settings.json` | **Main config** - MCP servers, model, permissions |
| `C:\Users\Ruben\.qwen\settings.json.orig` | Backup of original settings |
| `C:\penduka\AI_TOOLS_SETUP.md` | **Full documentation** |
| `C:\penduka\QWEN.md` | Project memories & context |

---

## Security Alert ⚠️

**API Keys Hardcoded in settings.json**
- Gemini: `AIzaSyAFRvB6slX4ycpI59Wjl2q3FlhigxgRaN0`
- DeepSeek: `sk-9b30ee1cab9e4680b654abff1c73fdcd`
- Risk: Medium (visible in plain text)
- Action: Consider moving to environment variables

**OpenClaw token is placeholder**
- Status: Safe (no real key exposed)
- Action: Set up gateway when ready

---

**Updated**: April 12, 2026  
**Total MCP Servers**: 14 (12 active, 1 needs setup, 1 documented but not added)
