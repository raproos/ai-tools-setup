# Penduka Casino - AI Tools & MCP Server Setup

## Overview
This document covers the AI tools, MCP (Model Context Protocol) servers, and API integrations configured for the Penduka Casino development environment.

---

## 1. Qwen Code Configuration

### Location
`C:\Users\Ruben\.qwen\settings.json`

### Model Configuration
- **Model**: `coder-model`
- **Authentication**: Qwen OAuth (`qwen-oauth`)
- **Settings Version**: 3

### Permissions
The following commands are whitelisted for execution:
- PowerShell commands (findstr, dir, start, tasklist, type, netstat, etc.)
- Node.js execution
- PHP (`c:\xampp\php\php.exe`)
- MySQL (`c:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\mysql.exe`, `c:\xampp\mysql\bin\mysql.exe`)
- Common tools (curl, mkdir, del, tar, timeout, taskkill)
- Build tools (7-Zip, MinGW, Go, GCC)

---

## 2. MCP Servers Configuration

### Location
MCP servers are configured in: `C:\Users\Ruben\.qwen\settings.json` under the `mcpServers` key

---

### 2.1 Gemini API MCP Server

#### Configuration
```json
"gemini-audit": {
  "httpUrl": "https://gemini-api-docs-mcp.dev"
}
```

#### Details
- **Type**: HTTP MCP Server
- **URL**: `https://gemini-api-docs-mcp.dev`
- **Purpose**: Google Gemini API documentation search and code examples
- **Status**: ✅ Configured
- **API Key**: Not required (HTTP endpoint)

#### Usage
- Search Gemini API documentation
- Get code examples for Google GenAI SDKs
- Find method signatures and parameters
- Supports Python, TypeScript, Go, Java SDKs

---

### 2.2 Gemini AI MCP Server

#### Configuration
```json
"gemini": {
  "command": "npx",
  "args": ["-y", "@anthropic/mcp-server-gemini"],
  "env": {
    "GEMINI_API_KEY": "AIzaSyAFRvB6slX4ycpI59Wjl2q3FlhigxgRaN0",
    "GOOGLE_GEMINI_MODEL": "gemini-2.0-flash"
  },
  "disabled": false
}
```

#### Details
- **Type**: NPX MCP Server
- **Package**: `@anthropic/mcp-server-gemini`
- **Model**: `gemini-2.0-flash`
- **Status**: ✅ Enabled & Configured
- **API Key**: Configured (starts with `AIzaSyAFRvB6slX4ycpI59Wjl2q3FlhigxgRaN0`)
- **Capabilities**: 
  - Chat completion
  - Vision/image understanding
  - Code generation
  - Text analysis

#### ⚠️ Security Notice
**API Key is exposed in settings.json**. Consider:
1. Using environment variables instead of hardcoding
2. Restricting API key permissions in Google Cloud Console
3. Rotating the key if compromised

#### Environment Variables
| Variable | Value | Description |
|----------|-------|-------------|
| `GEMINI_API_KEY` | `AIzaSyAFRvB6slX4ycpI59Wjl2q3FlhigxgRaN0` | Google Gemini API key |
| `GOOGLE_GEMINI_MODEL` | `gemini-2.0-flash` | Default model to use |

---

### 2.3 DeepSeek API MCP Server

#### Configuration
```json
"deepseek": {
  "command": "npx",
  "args": ["-y", "deepseek-mcp-server"],
  "env": {
    "DEEPSEEK_API_KEY": "sk-PLACEHOLDER_REPLACE_WITH_YOUR_KEY"
  }
}
```

#### Details
- **Type**: NPX MCP Server
- **Package**: `deepseek-mcp-server`
- **Status**: ⚠️ Configured but **NOT ACTIVATED**
- **API Key**: ❌ **PLACEHOLDER** - Needs real API key

#### Required Setup
1. Get DeepSeek API key from: https://platform.deepseek.com/
2. Replace `sk-PLACEHOLDER_REPLACE_WITH_YOUR_KEY` with actual key
3. Restart Qwen Code to activate

#### Capabilities (Once Activated)
- Chat completion
- Code completion (FIM - Fill In Middle)
- Model listing
- User balance checking
- Conversation management
- Streaming support

#### Environment Variables
| Variable | Value | Description |
|----------|-------|-------------|
| `DEEPSEEK_API_KEY` | `sk-PLACEHOLDER_REPLACE_WITH_YOUR_KEY` | ❌ Needs real key |

#### Available Tools (After Activation)
- `mcp__deepseek__chat_completion` - Chat with DeepSeek
- `mcp__deepseek__completion` - Text/FIM completion
- `mcp__deepseek__list_models` - List available models
- `mcp__deepseek__get_user_balance` - Check API balance
- `mcp__deepseek__reset_conversation` - Reset conversation history
- `mcp__deepseek__list_conversations` - List stored conversations

---

### 2.4 OpenClaw MCP Server

#### Configuration
```json
"openclaw": {
  "command": "npx",
  "args": ["-y", "openclaw-mcp"],
  "env": {
    "OPENCLAW_URL": "http://127.0.0.1:18789",
    "OPENCLAW_GATEWAY_TOKEN": "PLACEHOLDER_REPLACE_WITH_YOUR_TOKEN",
    "OPENCLAW_MODEL": "default",
    "OPENCLAW_TIMEOUT_MS": "300000"
  }
}
```

#### Details
- **Type**: NPX MCP Server
- **Package**: `openclaw-mcp`
- **Status**: ⚠️ Configured but **NOT ACTIVATED**
- **Gateway URL**: `http://127.0.0.1:18789`
- **Gateway Token**: ❌ **PLACEHOLDER** - Needs real token
- **Model**: `default`
- **Timeout**: 300000ms (5 minutes)

#### Required Setup
1. Install and configure OpenClaw gateway server
2. Start OpenClaw gateway on port 18789
3. Get gateway authentication token
4. Replace `PLACEHOLDER_REPLACE_WITH_YOUR_TOKEN` with actual token
5. Restart Qwen Code to activate

#### Capabilities (Once Activated)
- AI chat via OpenClaw gateway
- Async task processing
- Session management
- Multiple instance support
- Task prioritization
- Task cancellation

#### Environment Variables
| Variable | Value | Description |
|----------|-------|-------------|
| `OPENCLAW_URL` | `http://127.0.0.1:18789` | OpenClaw gateway URL |
| `OPENCLAW_GATEWAY_TOKEN` | `PLACEHOLDER_REPLACE_WITH_YOUR_TOKEN` | ❌ Needs real token |
| `OPENCLAW_MODEL` | `default` | Default model |
| `OPENCLAW_TIMEOUT_MS` | `300000` | Request timeout (5 min) |

#### Available Tools (After Activation)
- `mcp__openclaw__openclaw_chat` - Send message to OpenClaw
- `mcp__openclaw__openclaw_chat_async` - Async message (returns task_id)
- `mcp__openclaw__openclaw_status` - Check gateway status
- `mcp__openclaw__openclaw_task_status` - Check async task status
- `mcp__openclaw__openclaw_task_list` - List all tasks
- `mcp__openclaw__openclaw_task_cancel` - Cancel pending task
- `mcp__openclaw__openclaw_instances` - List configured instances

---

## 3. Other MCP Servers (Currently Active)

### 3.1 Filesystem MCP
- **Status**: ✅ Active
- **Capabilities**: File read/write, directory operations, search
- **Tools**: `mcp__filesystem__read_file`, `mcp__filesystem__write_file`, etc.

### 3.2 GitHub MCP
- **Status**: ✅ Active
- **Capabilities**: Repository management, issues, PRs, code search
- **Tools**: `mcp__github-official__*` (20+ tools)

### 3.3 Git MCP
- **Status**: ✅ Active
- **Capabilities**: Git operations (status, diff, commit, branch, log)
- **Tools**: `mcp__git__git_status`, `mcp__git__git_commit`, etc.

### 3.4 Firecrawl MCP
- **Status**: ✅ Active
- **Capabilities**: Web scraping, crawling, search, browser automation
- **Tools**: `mcp__firecrawl__firecrawl_scrape`, `mcp__firecrawl__firecrawl_search`, etc.

### 3.5 Playwright MCP
- **Status**: ✅ Active
- **Capabilities**: Browser automation, testing, screenshots
- **Tools**: `mcp__playwright__browser_navigate`, `mcp__playwright__browser_click`, etc.

### 3.6 Puppeteer MCP
- **Status**: ✅ Active
- **Capabilities**: Browser automation (alternative to Playwright)
- **Tools**: `mcp__puppeteer__puppeteer_navigate`, `mcp__puppeteer__puppeteer_click`, etc.

### 3.7 Memory MCP
- **Status**: ✅ Active
- **Capabilities**: Knowledge graph management
- **Tools**: `mcp__memory__create_entities`, `mcp__memory__search_nodes`, etc.

### 3.8 Context7 MCP
- **Status**: ✅ Active
- **Capabilities**: Library documentation lookup
- **Tools**: `mcp__context7__resolve-library-id`, `mcp__context7__query-docs`

### 3.9 Sequential Thinking MCP
- **Status**: ✅ Active
- **Capabilities**: Chain-of-thought problem solving
- **Tools**: `mcp__sequential-thinking__sequentialthinking`

---

## 4. Setup Instructions

### 4.1 Activate DeepSeek

1. **Get API Key**:
   - Visit: https://platform.deepseek.com/
   - Sign up and navigate to API keys
   - Create new API key (starts with `sk-`)

2. **Update Settings**:
   Open `C:\Users\Ruben\.qwen\settings.json` and replace:
   ```json
   "DEEPSEEK_API_KEY": "sk-PLACEHOLDER_REPLACE_WITH_YOUR_KEY"
   ```
   With your actual key:
   ```json
   "DEEPSEEK_API_KEY": "sk-your-actual-api-key-here"
   ```

3. **Restart Qwen Code** to load the new configuration

4. **Verify**:
   - Try listing models: `mcp__deepseek__list_models`
   - Check balance: `mcp__deepseek__get_user_balance`

---

### 4.2 Activate OpenClaw

1. **Install OpenClaw Gateway**:
   ```bash
   npm install -g openclaw
   ```

2. **Configure OpenClaw**:
   Create configuration file or use environment variables

3. **Start Gateway**:
   ```bash
   openclaw start --port 18789
   ```

4. **Get Authentication Token**:
   - Check OpenClaw documentation or config
   - Token is usually generated on first start

5. **Update Settings**:
   Open `C:\Users\Ruben\.qwen\settings.json` and replace:
   ```json
   "OPENCLAW_GATEWAY_TOKEN": "PLACEHOLDER_REPLACE_WITH_YOUR_TOKEN"
   ```
   With your actual token

6. **Restart Qwen Code** to load the new configuration

7. **Verify**:
   - Check status: `mcp__openclaw__openclaw_status`
   - List instances: `mcp__openclaw__openclaw_instances`

---

### 4.3 Verify Gemini API

1. **Test Connection**:
   - Use: `mcp__gemini-audit__search_docs` with query "text generation"
   - Should return Gemini API documentation

2. **Test AI Server**:
   - Check if `@anthropic/mcp-server-gemini` is installed
   - Verify API key is valid at: https://console.cloud.google.com/

3. **Check Model Availability**:
   - Current model: `gemini-2.0-flash`
   - Verify model is available in your region

---

## 5. Troubleshooting

### DeepSeek Not Working
- **Issue**: "DEEPSEEK_API_KEY" is placeholder
- **Solution**: Replace with actual API key from DeepSeek platform
- **Verify**: Run `mcp__deepseek__get_user_balance` after updating

### OpenClaw Not Connecting
- **Issue**: Gateway not running or token invalid
- **Solution**: 
  1. Start OpenClaw gateway on port 18789
  2. Verify token matches
  3. Check firewall isn't blocking port 18789
- **Verify**: Run `mcp__openclaw__openclaw_status`

### Gemini API Errors
- **Issue**: Invalid API key or model not found
- **Solution**:
  1. Verify key at Google Cloud Console
  2. Check model `gemini-2.0-flash` is available
  3. Ensure billing is enabled
- **Verify**: Run `mcp__gemini-audit__search_docs`

### MCP Server Not Loading
- **Issue**: Server shows as disabled or missing
- **Solution**:
  1. Check `settings.json` syntax is valid JSON
  2. Ensure `disabled` field is `false` or removed
  3. Restart Qwen Code
  4. Check internet connection for HTTP MCP servers

---

## 6. Security Best Practices

### API Keys
1. **Never commit API keys to Git**
2. **Use environment variables** when possible
3. **Rotate keys regularly** (every 90 days)
4. **Restrict key permissions** in provider dashboards
5. **Monitor usage** for unexpected activity

### Current Security Status
| Service | Key Type | Status | Risk Level |
|---------|----------|--------|------------|
| Gemini | Hardcoded | ⚠️ Exposed | Medium |
| DeepSeek | Placeholder | ✅ Safe | None |
| OpenClaw | Placeholder | ✅ Safe | None |
| Qwen OAuth | OAuth | ✅ Secure | Low |

### Recommendations
- Move Gemini API key to environment variable
- Set up API key rotation schedule
- Enable usage alerts on all paid APIs
- Review MCP server permissions regularly

---

## 7. Quick Reference

### Check MCP Server Status
```bash
# In Qwen Code, use the skill:
/qc-helper what MCP servers are configured?
```

### Test DeepSeek
```
Tool: mcp__deepseek__list_models
Expected: List of available DeepSeek models
```

### Test OpenClaw
```
Tool: mcp__openclaw__openclaw_status
Expected: Gateway status and health info
```

### Test Gemini
```
Tool: mcp__gemini-audit__search_docs
Query: "text generation"
Expected: Gemini API documentation results
```

### Configuration Files
| File | Purpose |
|------|---------|
| `C:\Users\Ruben\.qwen\settings.json` | Qwen Code + MCP configuration |
| `C:\Users\Ruben\.qwen\settings.json.orig` | Original settings backup |
| `C:\penduka\QWEN.md` | Project memories and context |

---

## 8. Summary

### Currently Active AI Tools
✅ **Gemini API** (gemini-audit) - Documentation search  
✅ **Gemini AI** (gemini) - Chat, vision, code generation  
✅ **Qwen OAuth** - Primary authentication  
✅ **Filesystem MCP** - File operations  
✅ **GitHub MCP** - Git repository management  
✅ **Git MCP** - Local Git operations  
✅ **Firecrawl MCP** - Web scraping & crawling  
✅ **Playwright MCP** - Browser automation  
✅ **Puppeteer MCP** - Alternative browser automation  
✅ **Memory MCP** - Knowledge graph  
✅ **Context7 MCP** - Library documentation  
✅ **Sequential Thinking MCP** - Chain-of-thought reasoning  

### Requires Activation
⚠️ **DeepSeek MCP** - Needs API key replacement  
⚠️ **OpenClaw MCP** - Needs gateway setup + token  

### Total MCP Servers
- **Configured**: 13 servers
- **Active**: 12 servers
- **Pending**: 2 servers (DeepSeek, OpenClaw)

---

**Last Updated**: April 12, 2026  
**Status**: Documentation Complete - 2 MCP servers need API keys  
