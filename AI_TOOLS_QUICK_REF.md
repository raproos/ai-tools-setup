# AI Tools Quick Reference - Penduka Casino

## MCP Server Status Overview

| # | Server | Type | Status | Notes |
|---|--------|------|--------|-------|
| 1 | Gemini Audit | HTTP | ✅ Active | API docs search |
| 2 | Gemini AI | NPX | ✅ Active | gemini-2.0-flash |
| 3 | DeepSeek | NPX | ⚠️ Needs API Key | Get from deepseek.com |
| 4 | OpenClaw | NPX | ⚠️ Needs Setup | Gateway + token |
| 5 | Filesystem | Built-in | ✅ Active | File operations |
| 6 | GitHub | Built-in | ✅ Active | Repo management |
| 7 | Git | Built-in | ✅ Active | Git commands |
| 8 | Firecrawl | Built-in | ✅ Active | Web scraping |
| 9 | Playwright | Built-in | ✅ Active | Browser automation |
| 10 | Puppeteer | Built-in | ✅ Active | Browser automation |
| 11 | Memory | Built-in | ✅ Active | Knowledge graph |
| 12 | Context7 | Built-in | ✅ Active | Library docs |
| 13 | Seq. Thinking | Built-in | ✅ Active | Chain of thought |

---

## Quick Status Check Commands

### Test Gemini (Working)
```
Use tool: mcp__gemini-audit__search_docs
Query: "chat completion"
```

### Test DeepSeek (Needs API Key)
```
Use tool: mcp__deepseek__list_models
Expected: Error until API key added
```

### Test OpenClaw (Needs Setup)
```
Use tool: mcp__openclaw__openclaw_status
Expected: Error until gateway running
```

---

## Activation Checklist

### DeepSeek (5 minutes)
- [ ] Get API key from https://platform.deepseek.com/
- [ ] Open `C:\Users\Ruben\.qwen\settings.json`
- [ ] Replace `sk-PLACEHOLDER_REPLACE_WITH_YOUR_KEY`
- [ ] Restart Qwen Code
- [ ] Test: `mcp__deepseek__list_models`

### OpenClaw (15 minutes)
- [ ] Install: `npm install -g openclaw`
- [ ] Configure gateway
- [ ] Start gateway: `openclaw start --port 18789`
- [ ] Get auth token from gateway logs
- [ ] Open `C:\Users\Ruben\.qwen\settings.json`
- [ ] Replace `PLACEHOLDER_REPLACE_WITH_YOUR_TOKEN`
- [ ] Restart Qwen Code
- [ ] Test: `mcp__openclaw__openclaw_status`

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

**Gemini API Key is hardcoded in settings.json**
- Key: `AIzaSyAFRvB6slX4ycpI59Wjl2q3FlhigxgRaN0`
- Risk: Medium (visible in plain text)
- Action: Consider moving to environment variable

**DeepSeek & OpenClaw keys are placeholders**
- Status: Safe (no real keys exposed)
- Action: Replace with real keys when ready to use

---

**Updated**: April 12, 2026  
**Total MCP Servers**: 13 (12 active, 2 need activation)
