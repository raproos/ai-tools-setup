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

### 2.3 DeepSeek API MCP Server (FREE TIER)

#### Configuration
```json
"deepseek": {
  "command": "npx",
  "args": ["-y", "deepseek-mcp-server"],
  "env": {
    "DEEPSEEK_API_KEY": "sk-9b30ee1cab9e4680b654abff1c73fdcd"
  }
}
```

#### Details
- **Type**: NPX MCP Server
- **Package**: `deepseek-mcp-server`
- **Status**: ✅ **CONFIGURED & READY**
- **API Key**: ✅ Configured (starts with `sk-9b30ee1c...`)
- **Cost**: **FREE** — 5 million free tokens on sign-up, no credit card required

#### Free Tier Details
- **Free Allowance**: 5,000,000 tokens (input + output combined)
- **Rate Limits**: None enforced (serves every request it can)
- **Models Available**: All DeepSeek models (V3, R1, Coder, etc.)
- **Credit Card**: Not required
- **After Free Tier**: ~$0.28/M input tokens (cache miss), ~$0.42/M output tokens

#### Required Setup (Free — 5 minutes)
1. **Sign Up**:
   - Visit: https://platform.deepseek.com/
   - Register with email or GitHub account
   - No credit card needed

2. **Get API Key**:
   - After login, navigate to **API Keys** section in dashboard
   - Click **Create API Key**
   - Copy the key (starts with `sk-`)
   - ⚠️ Save it immediately — it won't be shown again

3. **Update Settings**:
   Open `C:\Users\Ruben\.qwen\settings.json` and replace:
   ```json
   "DEEPSEEK_API_KEY": "sk-PLACEHOLDER_REPLACE_WITH_YOUR_KEY"
   ```
   With your actual key:
   ```json
   "DEEPSEEK_API_KEY": "sk-your-actual-api-key-here"
   ```

4. **Restart Qwen Code** to load the new configuration

5. **Verify**:
   - Try listing models: `mcp__deepseek__list_models`
   - Check balance: `mcp__deepseek__get_user_balance`
   - Test chat: `mcp__deepseek__chat_completion` with a simple message

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
| `DEEPSEEK_API_KEY` | `sk-9b30ee1c...` | ✅ Configured |

#### Available Tools
- `mcp__deepseek__chat_completion` - Chat with DeepSeek
- `mcp__deepseek__completion` - Text/FIM completion
- `mcp__deepseek__list_models` - List available models
- `mcp__deepseek__get_user_balance` - Check API balance
- `mcp__deepseek__reset_conversation` - Reset conversation history
- `mcp__deepseek__list_conversations` - List stored conversations

---

### 2.4 OpenClaw MCP Server (FREE — Self-Hosted)

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
- **Gateway Token**: ❌ **PLACEHOLDER** - Auto-generated during onboarding
- **Model**: `default`
- **Timeout**: 300000ms (5 minutes)
- **Cost**: **FREE** — Fully self-hosted, zero cost with local LLM (Ollama) or free cloud tiers

---

#### Complete Windows Setup Guide (Free — 30 minutes)

**⚠️ IMPORTANT: OpenClaw does NOT support native Windows.**
You **must** use **WSL2** (Windows Subsystem for Linux). This is a hard requirement — the official OpenClaw docs confirm native Windows is not supported.

**Prerequisites:**
- **WSL2** (required on Windows)
- **Node.js v22+** (inside WSL2)
- **PowerShell** (Admin, for WSL2 install)
- An AI model provider (Ollama for local/free, or cloud API)

---

**Step 1: Install WSL2 (Windows Only — Skip on macOS/Linux)**

Open PowerShell as **Administrator**:
```powershell
# Enable WSL2 and install Ubuntu
wsl --install

# Restart your computer when prompted
```

After restart, Ubuntu will launch. Create a username and password.

**Verify WSL2 is running:**
```powershell
wsl --status
wsl -l -v    # Should show "Running" for Ubuntu
```

---

**Step 2: Install Node.js Inside WSL2**

Open your WSL2 Ubuntu terminal:
```bash
# Install Node.js 22
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

# Verify
node --version    # Should show v22.x.x
npm --version
```

---

**Step 3: Install OpenClaw (Inside WSL2)**

```bash
# Install OpenClaw globally
npm install -g openclaw@latest

# Verify installation
openclaw --version
```

If `openclaw` command not found:
```bash
export PATH="$(npm config get prefix)/bin:$PATH"
# Add this to ~/.bashrc to make permanent
```

---

**Step 4: Run Onboarding Wizard (Inside WSL2)**

```bash
openclaw onboard --install-daemon
```

This interactive wizard will ask you:

| Prompt | What to Choose | Notes |
|--------|---------------|-------|
| **LLM Provider** | `ollama` (free/local) or `anthropic`/`openai`/`openrouter` | For zero cost, choose **Ollama** |
| **API Key** | Leave blank for Ollama, or paste cloud API key | Cloud keys from provider dashboards |
| **Model** | `llama3.2` or `qwen2.5` (Ollama) or provider default | Good coding model: `qwen2.5` |
| **Gateway Port** | Accept default `18789` | This is what Qwen Code expects |
| **Channels** | Skip for now (Telegram, Discord optional) | Not needed for MCP |
| **Install as Service** | Yes (recommended) | Auto-starts on boot |

The wizard generates config at: `~/.openclaw/openclaw.json` (inside WSL2)

---

**Step 5: Install Local LLM (Ollama) — Free Option**

If you chose Ollama as your LLM provider:

```bash
# 1. Install Ollama (inside WSL2)
curl -fsSL https://ollama.com/install.sh | sh

# 2. Pull a model
ollama pull qwen2.5       # Good for coding (~3.5GB)
# OR
ollama pull llama3.2      # General purpose (~2GB)

# 3. Verify model is loaded
ollama list
```

Ollama runs on `http://localhost:11434` inside WSL2.

---

**Step 6: Start the Gateway (Inside WSL2)**

```bash
# Start gateway on port 18789
openclaw gateway run --port 18789

# Or if installed as service:
openclaw gateway start
openclaw gateway enable    # Auto-start on boot
```

The gateway will be available at: `http://127.0.0.1:18789`

WSL2 automatically forwards port 18789 to Windows, so you can access it from your Windows browser.

**Gateway Management Commands:**
```bash
openclaw gateway start      # Start gateway
openclaw gateway stop       # Stop gateway
openclaw gateway restart    # Restart gateway
openclaw gateway status     # Check if running
openclaw gateway enable     # Enable auto-start
openclaw gateway disable    # Disable auto-start
openclaw doctor             # Run diagnostics
```

---

**Step 7: Find the Gateway Token (Inside WSL2)**

The token is auto-generated during onboarding. Find it here:

1. **Open the config file (inside WSL2):**
   ```bash
   cat ~/.openclaw/openclaw.json
   # Or edit it:
   nano ~/.openclaw/openclaw.json
   ```

2. **Look for the gateway token section:**
   ```json
   {
     "gateway": {
       "auth": {
         "token": "your-auto-generated-token-here"
       }
     }
   }
   ```

3. **Copy the token value** — this is your `OPENCLAW_GATEWAY_TOKEN`

Alternatively, generate a fresh token:
```bash
openclaw doctor --generate-gateway-token
```

---

**Step 8: Verify Gateway is Running**

From Windows browser (WSL2 port forwarding works automatically):
```
http://127.0.0.1:18789/?token=YOUR_TOKEN_HERE
```

Or from WSL2 terminal:
```bash
openclaw dashboard
```

You should see the OpenClaw web dashboard with chat interface.

---

**Step 9: Connect to Qwen Code**

Open `C:\Users\Ruben\.qwen\settings.json` (on Windows) and replace:
```json
"OPENCLAW_GATEWAY_TOKEN": "PLACEHOLDER_REPLACE_WITH_YOUR_TOKEN"
```
With your actual token from Step 7.

Then **restart Qwen Code** to load the new configuration.

---

**Step 10: Verify Connection**

After restarting Qwen Code, test the connection:
```
Tool: mcp__openclaw__openclaw_status
Expected: Gateway status and health info

Tool: mcp__openclaw__openclaw_chat
Message: "hello"
Expected: AI response from OpenClaw
```

---

#### Free Setup Options

**Option A: Zero Cost with Local LLM (Ollama)**
- Runs entirely on your machine
- No API keys needed
- Uses CPU/GPU resources
- Recommended models: `qwen2.5` (coding), `llama3.2` (general)

**Option B: Free Cloud Tiers**
| Provider | Free Tier | URL |
|----------|-----------|-----|
| Google AI Studio | Free Gemini | https://aistudio.google.com/ |
| Groq | Free Llama/Mixtral | https://console.groq.com/ |
| DeepSeek | 5M free tokens | https://platform.deepseek.com/ |

Configure these during `openclaw onboard` by selecting the provider and pasting the API key.

---

#### Required Setup Summary (Windows — Requires WSL2)

| # | Step | Command / Action | Where |
|---|------|-----------------|-------|
| 1 | Enable WSL2 | `wsl --install` (PowerShell Admin) | Windows |
| 2 | Install Node.js v22 | `curl ... nodesource ...` | Inside WSL2 |
| 3 | Install OpenClaw | `npm install -g openclaw@latest` | Inside WSL2 |
| 4 | Install Ollama (optional) | `curl ... ollama.com/install.sh \| sh` | Inside WSL2 |
| 5 | Run onboarding | `openclaw onboard --install-daemon` | Inside WSL2 |
| 6 | Start gateway | `openclaw gateway run --port 18789` | Inside WSL2 |
| 7 | Get token | `cat ~/.openclaw/openclaw.json` → `gateway.auth.token` | Inside WSL2 |
| 8 | Update settings | Replace token in `C:\Users\Ruben\.qwen\settings.json` | Windows |
| 9 | Restart Qwen Code | Close and reopen | Windows |
| 10 | Test connection | `mcp__openclaw__openclaw_status` | Qwen Code |

---

#### Troubleshooting

| Issue | Solution |
|-------|----------|
| **Gateway won't start** | Run `openclaw doctor` to diagnose |
| **Port 18789 in use** | Change port: `openclaw gateway run --port 18790`, update `OPENCLAW_URL` in settings.json |
| **Token mismatch error** | Copy fresh token from `%USERPROFILE%\.openclaw\openclaw.json` |
| **Windows Defender blocking** | Add exclusions for `C:\Users\YourUsername\AppData\Roaming\npm` and `C:\Users\YourUsername\.openclaw` |
| **sharp module error** | `npm cache clean --force` then `npm install -g openclaw@latest --force` |
| **Permission errors** | Run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| **Ollama not responding** | Check service: `ollama list`, restart Ollama from system tray |

---

#### Environment Variables
| Variable | Value | Description |
|----------|-------|-------------|
| `OPENCLAW_URL` | `http://127.0.0.1:18789` | OpenClaw gateway URL (default port) |
| `OPENCLAW_GATEWAY_TOKEN` | Auto-generated in `~/.openclaw/openclaw.json` | Gateway auth token |
| `OPENCLAW_MODEL` | `default` | Model name (uses Ollama default if local) |
| `OPENCLAW_TIMEOUT_MS` | `300000` | Request timeout (5 min) |

#### Available Tools (After Activation)
- `mcp__openclaw__openclaw_chat` - Send message to OpenClaw
- `mcp__openclaw__openclaw_chat_async` - Async message (returns task_id)
- `mcp__openclaw__openclaw_status` - Check gateway status
- `mcp__openclaw__openclaw_task_status` - Check async task status
- `mcp__openclaw__openclaw_task_list` - List all tasks
- `mcp__openclaw__openclaw_task_cancel` - Cancel pending task
- `mcp__openclaw__openclaw_instances` - List configured instances

#### Useful Commands
```bash
# Install
npm install -g openclaw@latest

# Verify installation
openclaw --version

# Run onboarding wizard
openclaw onboard --install-daemon

# Start gateway on port 18789
openclaw gateway --port 18789

# Run diagnostics
openclaw doctor

# Check gateway status
openclaw gateway status

# View config file location
echo %USERPROFILE%\.openclaw\openclaw.json
```

---

### 2.5 GitHub Copilot MCP Server (Official)

#### Configuration
```json
"github-copilot": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "github_pat_11AFL3QEI0...t8zvnO"
  }
}
```

#### Details
- **Type**: NPX MCP Server
- **Package**: `@modelcontextprotocol/server-github`
- **Status**: ✅ **CONFIGURED & READY**
- **User**: `raproos` (authenticated)
- **Source**: Official GitHub open-source MCP server
- **Cost**: **FREE** — requires GitHub Personal Access Token
- **Compatibility**: Works with GitHub Copilot, Claude Desktop, Qwen Code, and any MCP client

#### Capabilities
| Tool | Description |
|------|-------------|
| `create_or_update_file` | Create or update a file in a repository |
| `search_repositories` | Search for GitHub repositories |
| `create_repository` | Create a new repository |
| `get_file_contents` | Get file/directory contents |
| `push_files` | Push multiple files in one commit |
| `create_issue` | Create a new issue |
| `create_pull_request` | Create a pull request |
| `list_issues` | List and filter issues |
| `list_commits` | Get commit history |
| `list_pull_requests` | List and filter PRs |
| `get_pull_request` | Get PR details |
| `merge_pull_request` | Merge a PR |
| `search_code` | Search code across GitHub |
| `search_issues` | Search issues and PRs |
| `search_users` | Search GitHub users |
| `fork_repository` | Fork a repository |
| `create_branch` | Create a new branch |
| `get_pull_request_files` | Get files changed in a PR |
| `get_pull_request_status` | Get PR status checks |
| `get_pull_request_reviews` | Get PR reviews |

#### Setup (Free — 5 minutes)

**Step 1: Create GitHub Personal Access Token**
1. Go to: https://github.com/settings/tokens
2. Click **Generate new token (classic)**
3. Give it a name (e.g., "MCP Server")
4. Select scopes:
   - ✅ `repo` (full control of private repositories)
   - ✅ `read:user` (user profile)
   - ✅ `workflow` (update GitHub Actions workflows)
5. Click **Generate token** and copy it (starts with `ghp_`)

**Step 2: Add to Qwen Code Settings**
Open `C:\Users\Ruben\.qwen\settings.json` and add to `mcpServers`:
```json
"github-copilot": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your-token-here"
  }
}
```

**Step 3: Restart Qwen Code**

**Step 4: Verify**
Test the connection — you should see new `mcp__github-copilot__*` tools available.

#### VS Code / Copilot Integration
If you use GitHub Copilot in VS Code, you can also add it to VS Code settings:
```json
// .vscode/settings.json or VS Code settings
{
  "github.copilot.chat.mcp.servers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your-token"
      }
    }
  }
}
```

This lets Copilot chat interact with your GitHub repos directly.

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

### 4.1 Activate DeepSeek (FREE — 5 Million Tokens)

1. **Sign Up** (No Credit Card Needed):
   - Visit: https://platform.deepseek.com/
   - Register with email or GitHub account
   - You automatically get 5,000,000 free tokens

2. **Get API Key**:
   - After login, go to **API Keys** in dashboard
   - Click **Create API Key**
   - Copy the key (starts with `sk-`)
   - ⚠️ Save it — won't be shown again

3. **Update Settings**:
   Open `C:\Users\Ruben\.qwen\settings.json` and replace:
   ```json
   "DEEPSEEK_API_KEY": "sk-PLACEHOLDER_REPLACE_WITH_YOUR_KEY"
   ```
   With your actual key:
   ```json
   "DEEPSEEK_API_KEY": "sk-your-actual-api-key-here"
   ```

4. **Restart Qwen Code** to load the new configuration

5. **Verify**:
   - Try listing models: `mcp__deepseek__list_models`
   - Check balance: `mcp__deepseek__get_user_balance`
   - Test chat: `mcp__deepseek__chat_completion` with a simple message

#### Free Tier Details
| Feature | Value |
|---------|-------|
| Free Tokens | 5,000,000 |
| Rate Limits | None enforced |
| Models | All (V3, R1, Coder) |
| Credit Card | Not required |
| After Free | ~$0.28/M input, ~$0.42/M output |

---

### 4.2 Activate OpenClaw (FREE — Self-Hosted with Ollama)

**Option A: Fully Free with Local LLM (Recommended)**

This setup costs nothing — runs entirely on your machine:

1. **Install Ollama** (Local LLM Runtime):
   - Download: https://ollama.com/
   - Install and start the service
   - Pull a model: `ollama pull qwen2.5` (good for coding) or `ollama pull llama3.2`

2. **Install OpenClaw Gateway**:
   ```bash
   npm install -g openclaw@latest
   ```
   - Requires: Node.js v22 or higher

3. **Run Onboarding Wizard**:
   ```bash
   openclaw onboard --install-daemon
   ```
   - Select **Ollama** as LLM provider when prompted
   - This avoids all paid API keys
   - Token is auto-generated

4. **Find Gateway Token**:
   - Open: `%USERPROFILE%\.openclaw\openclaw.json`
   - Find: `gateway.auth.token`
   - Copy this value

5. **Start Gateway**:
   ```bash
   openclaw gateway --port 18789
   ```

6. **Update Settings**:
   Open `C:\Users\Ruben\.qwen\settings.json` and replace:
   ```json
   "OPENCLAW_GATEWAY_TOKEN": "PLACEHOLDER_REPLACE_WITH_YOUR_TOKEN"
   ```
   With your actual token from step 4

7. **Restart Qwen Code** to load the new configuration

8. **Verify**:
   - Check status: `mcp__openclaw__openclaw_status`
   - List instances: `mcp__openclaw__openclaw_instances`
   - Send test: `mcp__openclaw__openclaw_chat` with "hello"

**Option B: Free Cloud Tiers**

If you prefer cloud models:
- **Google AI Studio**: Free Gemini (https://aistudio.google.com/)
- **Groq**: Free Llama/Mixtral (https://console.groq.com/)
- Configure during `openclaw onboard`

#### Quick Reference Commands
```bash
npm install -g openclaw@latest        # Install
openclaw --version                     # Verify
openclaw onboard --install-daemon      # Setup wizard
openclaw gateway --port 18789          # Start gateway
openclaw doctor                        # Diagnostics
openclaw gateway status                # Check status
```

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
- **Issue**: "DEEPSEEK_API_KEY" is still placeholder
- **Solution**: Sign up at https://platform.deepseek.com/ (free, 5M tokens), replace with actual key
- **Verify**: Run `mcp__deepseek__get_user_balance` after updating
- **Common Error**: `invalid_api_key` — make sure you copied the full key starting with `sk-`

### OpenClaw Not Connecting
- **Issue**: Gateway not running
- **Solution**:
  1. Install: `npm install -g openclaw@latest`
  2. Run onboarding: `openclaw onboard --install-daemon`
  3. Start gateway: `openclaw gateway --port 18789`
- **Verify**: Run `openclaw doctor` for diagnostics

- **Issue**: Invalid token
- **Solution**:
  1. Open `%USERPROFILE%\.openclaw\openclaw.json`
  2. Copy value from `gateway.auth.token`
  3. Update `settings.json` with this token

- **Issue**: Port 18789 already in use
- **Solution**: Change port in `settings.json` `OPENCLAW_URL` to another port (e.g., 18790)
  - Also update gateway start command: `openclaw gateway --port 18790`

- **Issue**: Firewall blocking connection
- **Solution**: Allow port 18789 through Windows Firewall

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
| DeepSeek | Hardcoded | ⚠️ Exposed | Medium |
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
✅ **DeepSeek MCP** - Chat, completion, code generation
✅ **GitHub Copilot MCP** - Official GitHub integration (20+ tools)
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
⚠️ **OpenClaw MCP** - Needs gateway setup + token (FREE with Ollama)

### Total MCP Servers
- **Configured in settings.json**: 14 servers
- **Active**: 13 servers
- **Pending**: 1 server (OpenClaw)

---

**Last Updated**: April 12, 2026
**Status**: DeepSeek + GitHub Copilot MCP Configured — 1 MCP server pending (OpenClaw)
