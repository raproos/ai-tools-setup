# AI CLI Tools - Setup Guide

Complete setup guide for all free open-source AI coding tools, MCP servers, and integrations.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Quick Start](#quick-start)
3. [Installed Tools](#installed-tools)
4. [MCP Servers](#mcp-servers)
5. [CleverHumanizer Integration](#cleverhumanizer-integration)
6. [Tool Usage](#tool-usage)
7. [Configuration](#configuration)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before running `setup.bat`, ensure you have:

| Tool | Version | Download |
|------|---------|----------|
| **Node.js** | v22+ | https://nodejs.org |
| **npm** | v10+ | Bundled with Node.js |
| **Go** | 1.21+ | https://go.dev/dl/ |
| **Git** | Any | https://git-scm.com/download/win |

Check versions:
```cmd
node --version
npm --version
go version
git --version
```

---

## Quick Start

### 1. Run the Setup Script

```cmd
cd C:\penduka\ai-tools-setup
setup.bat
```

This will:
- Install all CLI tools globally via npm/Go
- Create MCP configuration files
- Generate launcher scripts
- Create CleverHumanizer PHP wrapper

### 2. Authenticate Services

```cmd
claude login       # Anthropic Claude
codex login        # OpenAI Codex
```

### 3. Start n8n Server

```cmd
start-n8n.bat
```

Access at: http://localhost:5678

---

## Installed Tools

### 1. Claude Code CLI
- **Command:** `claude`
- **Publisher:** Anthropic
- **Install:** `npm install -g @anthropic-ai/claude-code`
- **Login:** `claude login`
- **Usage:** Navigate to project, run `claude`

```cmd
cd C:\penduka\www\casino
claude
> "Fix the PTM balance integration issue"
```

### 2. OpenAI Codex CLI
- **Command:** `codex`
- **Publisher:** OpenAI
- **Install:** `npm install -g @openai/codex`
- **Login:** `codex login`
- **Usage:** Navigate to project, run `codex`

```cmd
cd C:\penduka\www\casino
codex
> "Add a new game provider integration"
```

### 3. Qwen Code CLI
- **Command:** `qwen`
- **Publisher:** Alibaba (Qwen)
- **Install:** `npm install -g @qwen-code/qwen-code@latest`
- **Usage:** Navigate to project, run `qwen`
- **MCP Support:** Built-in MCP management

```cmd
cd C:\penduka\www\casino
qwen
> "Fix the PTM balance integration issue"

# MCP management
qwen mcp list       # List configured MCP servers
qwen mcp add filesystem ...  # Add MCP server
```

### 4. Crush CLI (charmbracelet)
- **Command:** `crush`
- **Publisher:** Charm
- **Install:** `go install github.com/charmbracelet/crush@latest`
- **Requires:** Go 1.21+
- **Usage:** Navigate to project, run `crush`

```cmd
cd C:\penduka\www\casino
crush
> "Refactor the GamesController PTM method"
```

### 5. OpenCode CLI
- **Command:** `opencode`
- **Publisher:** Anomaly
- **Install:** Manual (Windows needs binary download)
  - Download from: https://github.com/anomalyco/opencode/releases
  - Place binary in `%GOPATH%\bin` or add to PATH
- **WSL Alternative:**
  ```bash
  curl -fsSL https://opencode.ai/install | bash
  ```

### 6. Plandex CLI
- **Command:** `plandex`
- **Publisher:** Plandex AI
- **Install:** `go install github.com/plandex-ai/plandex@latest`
- **Usage:** Plan-driven AI coding with multi-file changes

```cmd
cd C:\penduka\www\casino
plandex init
plandex "Create a new WebSocket handler for KA gaming"
```

### 7. n8n Workflow Automation
- **Command:** `n8n`
- **Install:** `npm install -g n8n`
- **Start:** `n8n start` or `start-n8n.bat`
- **Access:** http://localhost:5678
- **Features:** 500+ integrations, AI chains, visual workflows

```cmd
# Start server
start-n8n.bat

# Or directly
n8n start
```

---

## MCP Servers

### Configuration File

All MCP servers are configured in:
```
%USERPROFILE%\.ai-tools\mcp_config.json
```

### 1. Context7 MCP Server
- **Package:** `@upstash/context7-mcp`
- **Purpose:** Pulls latest, version-specific documentation into AI prompts
- **Run:** `npx -y @upstash/context7-mcp`

**Example use in Claude Code:**
```
> @context7 Show me the latest Laravel routing documentation
```

### 2. Filesystem MCP Server
- **Package:** `@modelcontextprotocol/server-filesystem`
- **Purpose:** Secure file read/write/search for AI agents
- **Run:** `npx -y @modelcontextprotocol/server-filesystem <allowed-paths>`

**Example use:**
```
> @filesystem Read the file C:\penduka\www\casino\app\Http\Controllers\Web\Frontend\GamesController.php
```

### 3. Git MCP Server
- **Package:** `@modelcontextprotocol/server-git`
- **Purpose:** Git operations through AI (status, diff, commit, branch)
- **Run:** `npx -y @modelcontextprotocol/server-git`

**Example use:**
```
> @git Show me the diff of uncommitted changes
> @git Create a new branch called "ptm-fix"
```

### Running MCP Servers

Use the status checker:
```cmd
start-mcp-servers.bat
```

Or run individually:
```cmd
npx -y @upstash/context7-mcp
npx -y @modelcontextprotocol/server-filesystem C:\penduka
npx -y @modelcontextprotocol/server-git
```

---

## CleverHumanizer Integration

### What is CleverHumanizer?

CleverHumanizer.ai is an AI text humanization service that:
- Rewrites AI-generated text to sound natural
- Detects AI-generated content
- Checks for plagiarism
- Offers multiple writing styles

### Setup

1. **Get API Key:**
   - Go to https://cleverhumanizer.ai/profile
   - Sign up / Sign in
   - Copy your API key from the dashboard

2. **Configure:**
   ```cmd
   copy .env.example .env
   ```
   Edit `.env` and add your API key:
   ```
   CLEVER_HUMANIZER_API_KEY=your_key_here
   ```

3. **Use in PHP:**
   ```php
   require_once 'cleverhumanizer.php';
   
   $humanizer = new CleverHumanizer();
   
   // Humanize AI text
   $result = $humanizer->humanize("Your AI-generated text here", 'casual');
   
   // Detect AI content
   $detection = $humanizer->detect("Text to analyze");
   
   // Check plagiarism
   $plagiarism = $humanizer->checkPlagiarism("Text to check");
   
   // Get usage stats
   $usage = $humanizer->getUsage();
   ```

### API Methods

| Method | Description | Parameters |
|--------|------------|------------|
| `humanize($text, $style)` | Rewrite AI text | text, style (casual/professional/academic) |
| `detect($text)` | AI detection | text |
| `checkPlagiarism($text)` | Plagiarism check | text |
| `getUsage()` | Account usage | - |

---

## OpenRouter + Nemotron 3 Super

### What is OpenRouter?

OpenRouter is a unified API platform providing access to 100+ LLM models through a single OpenAI-compatible interface.

### NVIDIA Nemotron 3 Super 120B

- **Model ID:** `nvidia/nemotron-3-super-120b-a12b`
- **Architecture:** 120B parameter MoE (Mixture of Experts), 12B active params
- **Best for:** Code generation, technical writing, complex reasoning
- **Endpoint:** `https://openrouter.ai/api/v1/chat/completions`
- **Pricing:** Free tier available

### Setup

1. **Get API Key:**
   - Go to https://openrouter.ai
   - Sign up and navigate to https://openrouter.ai/keys
   - Copy your API key

2. **Configure:**
   ```cmd
   copy .env.example .env
   ```
   Edit `.env`:
   ```
   OPENROUTER_API_KEY=sk-or-v1-your_key_here
   SITE_URL=http://localhost
   SITE_NAME=Penduka AI Tools
   ```

3. **Use in PHP:**
   ```php
   require_once 'openrouter.php';

   $client = new OpenRouterClient();

   // Generate code
   $result = $client->generateCode(
       "Create a Laravel REST API endpoint for user registration with validation",
       "php"
   );
   echo $result['choices'][0]['message']['content'];

   // Review existing code
   $review = $client->reviewCode(file_get_contents('app/Http/Controllers/UserController.php'));

   // Refactor code
   $refactored = $client->refactorCode(
       file_get_contents('old_code.php'),
       "make it use dependency injection and add type hints",
       "php"
   );

   // Use a different model
   $response = $client->chat(
       [['role' => 'user', 'content' => 'Explain MVC architecture']],
       'anthropic/claude-3.5-sonnet'
   );

   // Check credits
   $credits = $client->getCredits();
   ```

### API Methods

| Method | Description | Parameters |
|--------|------------|------------|
| `generateCode($prompt, $lang)` | Generate code from description | prompt, language (php/js/python/etc) |
| `reviewCode($code, $lang)` | Security/performance review | code, language |
| `refactorCode($code, $goal, $lang)` | Refactor with specific goal | code, goal, language |
| `chat($messages, $model)` | General chat with any model | messages array, model ID |
| `listModels()` | List all available models | - |
| `getCredits()` | Check account balance | - |

---

## Tool Usage

### Daily Workflow Example

```cmd
# 1. Start n8n for workflow automation
start-n8n.bat

# 2. Open new terminal, use Qwen Code for code review (this tool!)
cd C:\penduka\www\casino
qwen
> "Review the recent changes to Slots.js"

# 3. Use Claude for another perspective
claude
> "Optimize the PTM balance fetch logic"

# 4. Use Codex for a specific coding task
codex
> "Create a new blade template for the KA gaming provider"

# 5. Use Crush for quick refactoring
crush
> "Clean up duplicate code in GamesController"

# 6. Use OpenRouter/Nemotron for code generation
php -r "
require 'openrouter.php';
$c = new OpenRouterClient();
print_r($c->generateCode('Create a WebSocket handler for real-time game events', 'php'));
"

# 7. Use Context7 for latest docs
qwen
> "@context7 What's the latest on Laravel 11 service containers?"

# 8. Use Git MCP to check status
qwen mcp list

# 9. Humanize documentation with CleverHumanizer
php -r "
require 'cleverhumanizer.php';
\$h = new CleverHumanizer();
print_r(\$h->humanize('This function handles authentication', 'casual'));
"
```

---

## Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

```env
# CleverHumanizer API
CLEVER_HUMANIZER_API_KEY=your_key_here

# OpenAI (for Codex)
OPENAI_API_KEY=sk-...

# Anthropic (for Claude)
ANTHROPIC_API_KEY=sk-ant-...
```

### MCP Config Location

```
%USERPROFILE%\.ai-tools\mcp_config.json
```

### n8n Data Directory

n8n stores workflows in:
```
%USERPROFILE%\.n8n
```

---

## Troubleshooting

### Node.js/npm Issues

```cmd
# Check versions
node --version
npm --version

# Clear npm cache
npm cache clean --force

# Reinstall global packages
npm install -g @anthropic-ai/claude-code @openai/codex n8n
```

### Go/Crush Issues

```cmd
# Check Go
go version

# Check GOPATH
go env GOPATH

# Reinstall Crush
go install github.com/charmbracelet/crush@latest

# Verify binary in GOPATH/bin
dir %GOPATH%\bin\crush.exe
```

### MCP Server Issues

```cmd
# Test Context7
npx -y @upstash/context7-mcp --help

# Test Filesystem
npx -y @modelcontextprotocol/server-filesystem C:\penduka --help

# Clear npx cache
npx clear-npx-cache
```

### n8n Issues

```cmd
# Check if port 5678 is in use
netstat -ano | findstr 5678

# Kill process on port
taskkill /PID <pid> /F

# Restart n8n
n8n start
```

### CleverHumanizer Issues

```php
// Test API connection
require 'cleverhumanizer.php';
try {
    $h = new CleverHumanizer();
    print_r($h->getUsage());
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
```

### Permission Issues on Windows

Run commands in **Administrator PowerShell** if you get access denied:
```powershell
# Set execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## File Structure

```
C:\penduka\ai-tools-setup\
├── setup.bat                  # Main installer script
├── SETUP_GUIDE.md             # Full documentation
├── .env.example               # Environment template (created on run)
├── cleverhumanizer.php        # CleverHumanizer PHP wrapper (created on run)
├── openrouter.php             # OpenRouter/Nemotron PHP wrapper (created on run)
├── start-n8n.bat              # n8n launcher (created on run)
├── start-claude.bat           # Claude launcher (created on run)
├── start-codex.bat            # Codex launcher (created on run)
├── start-qwen.bat             # Qwen Code launcher (created on run)
├── start-crush.bat            # Crush launcher (created on run)
├── start-mcp-servers.bat      # MCP status checker (created on run)
└── logs\                      # Installation logs (created on run)
    └── setup_YYYYMMDD.log
```

---

## Links

| Tool | URL |
|------|-----|
| Qwen Code | https://github.com/QwenLM/qwen-code |
| Claude Code | https://claude.ai/code |
| OpenAI Codex | https://platform.openai.com/docs |
| Crush | https://github.com/charmbracelet/crush |
| OpenCode | https://opencode.ai |
| Plandex | https://github.com/plandex-ai/plandex |
| n8n | https://n8n.io |
| Context7 MCP | https://github.com/upstash/context7 |
| MCP Servers | https://github.com/modelcontextprotocol/servers |
| CleverHumanizer | https://cleverhumanizer.ai/profile |
| OpenRouter | https://openrouter.ai |
| Nemotron 3 Super | https://openrouter.ai/nvidia/nemotron-3-super-120b-a12b |
| Awesome MCP | https://github.com/wong2/awesome-mcp-servers |

---

*Last updated: April 12, 2026*
