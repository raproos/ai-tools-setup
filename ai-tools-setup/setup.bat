@echo off
title AI CLI Tools - Complete Setup
color 0A

echo.
echo ============================================================
echo       AI CLI TOOLS + MCP SERVERS - COMPLETE SETUP
echo ============================================================
echo.
echo  AI CODING CLI TOOLS:
echo   [1]  Claude Code CLI      (Anthropic)
echo   [2]  OpenAI Codex CLI
echo   [3]  Qwen Code CLI        (this tool!)
echo   [4]  Gemini CLI           (Google)
echo   [5]  Crush CLI            (charmbracelet)
echo   [6]  OpenCode CLI
echo   [7]  Plandex CLI
echo.
echo  PLATFORMS ^+ AUTOMATION:
echo   [8]  n8n Workflow Automation
echo   [9]  Dify AI Platform
echo.
echo  MCP SERVERS:
echo   [10] Context7              (documentation)
echo   [11] Filesystem            (file read/write)
echo   [12] Git                   (git operations)
echo   [13] Puppeteer             (browser automation)
echo   [14] Playwright            (browser automation)
echo   [15] Brave Search          (web search)
echo   [16] Fetch                 (HTTP requests)
echo   [17] Firecrawl             (web scraping)
echo   [18] GitHub                (repo management)
echo   [19] SQLite                (database queries)
echo   [20] Gemini                (Google Gemini API)
echo.
echo  AI SERVICES:
echo   [21] CleverHumanizer.ai    (text humanizer)
echo   [22] OpenRouter+Nemotron   (code generation)
echo   [23] Ollama                (local LLMs)
echo.

:: Check prerequisites
echo [CHECK] Checking prerequisites...

where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed. Please install Node.js v22+ from https://nodejs.org
    pause
    exit /b 1
)

where npm >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] npm is not available. Please reinstall Node.js.
    pause
    exit /b 1
)

where go >nul 2>nul
if %errorlevel% neq 0 (
    echo [WARN] Go is not installed. Crush CLI will be skipped. Install from https://go.dev/dl/
    set SKIP_CRUSH=1
) else (
    echo [OK] Go found: 
    go version
    set SKIP_CRUSH=0
)

where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [WARN] Git is not installed. Git MCP server will be skipped. Install from https://git-scm.com/download/win
    set SKIP_GIT_MCP=1
) else (
    echo [OK] Git found
    set SKIP_GIT_MCP=0
)

echo.
echo [OK] All checks done.
echo.
pause

:: Create setup log directory
if not exist "%~dp0logs" mkdir "%~dp0logs"
set LOGFILE=%~dp0logs\setup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log

echo ============================================================
echo  Starting installation... Log: %LOGFILE%
echo ============================================================
echo.

:: ============================================================
:: 1. CLAUDE CODE CLI
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [1/10] Installing Claude Code CLI...
echo ------------------------------------------------------------
call npm install -g @anthropic-ai/claude-code > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Claude Code installed successfully
    claude --version >> "%LOGFILE%" 2>&1
) else (
    echo [FAIL] Claude Code installation failed. Check log.
)

:: ============================================================
:: 2. OPENAI CODEX CLI
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [2/12] Installing OpenAI Codex CLI...
echo ------------------------------------------------------------
call npm install -g @openai/codex > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] OpenAI Codex installed successfully
) else (
    echo [FAIL] OpenAI Codex installation failed. Check log.
)

:: ============================================================
:: 3. QWEN CODE CLI
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [3/23] Installing Qwen Code CLI...
echo ------------------------------------------------------------
call npm install -g @qwen-code/qwen-code@latest > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Qwen Code CLI installed successfully
    echo [INFO] Run with: qwen
    echo [INFO] MCP support: qwen mcp add^|remove^|list
) else (
    echo [FAIL] Qwen Code installation failed. Check log.
)

:: ============================================================
:: 4. GEMINI CLI (Google)
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [4/23] Installing Google Gemini CLI...
echo ------------------------------------------------------------
call npm install -g @google/gemini-cli > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Gemini CLI installed successfully
    echo [INFO] Run with: gemini
    echo [INFO] Set GOOGLE_API_KEY env var first
) else (
    echo [FAIL] Gemini CLI installation failed. Check log.
)

:: ============================================================
:: 5. CRUSH CLI (charmbracelet)
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [5/23] Installing Crush CLI...
echo ------------------------------------------------------------
if "%SKIP_CRUSH%"=="1" (
    echo [SKIP] Go not installed. Skipping Crush.
) else (
    call go install github.com/charmbracelet/crush@latest >> "%LOGFILE%" 2>&1
    if %errorlevel% equ 0 (
        echo [OK] Crush CLI installed successfully
    ) else (
        echo [FAIL] Crush installation failed. Check log.
    )
)

:: ============================================================
:: 4. OPENCODE CLI
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [6/23] Installing OpenCode CLI...
echo ------------------------------------------------------------
echo  OpenCode requires WSL or manual binary download on Windows.
echo  See documentation for manual install steps.
echo [INFO] Skipping automatic install (requires bash/curl)
echo [INFO] Manual: Download from https://opencode.ai or use WSL:
echo         curl -fsSL https://opencode.ai/install ^| bash

:: ============================================================
:: 5. PLANDEX CLI
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [7/23] Installing Plandex CLI...
echo ------------------------------------------------------------
call go install github.com/plandex-ai/plandex@latest >> "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Plandex CLI installed successfully
) else (
    echo [FAIL] Plandex installation failed. May require manual setup.
    echo [INFO] Try: go install github.com/plandex-ai/plandex@latest
)

:: ============================================================
:: 6. N8N WORKFLOW AUTOMATION
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [8/23] Installing n8n Workflow Automation...
echo ------------------------------------------------------------
call npm install -g n8n > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] n8n installed successfully
    echo [INFO] Start with: n8n start
    echo [INFO] Access at: http://localhost:5678
) else (
    echo [FAIL] n8n installation failed. Check log.
)

:: ============================================================
:: 7. CONTEXT7 MCP SERVER
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [10/23] Installing Context7 MCP Server...
echo ------------------------------------------------------------
call npm install -g @upstash/context7-mcp > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Context7 MCP Server installed successfully
    echo [INFO] Run with: npx @upstash/context7-mcp
) else (
    echo [FAIL] Context7 installation failed. Check log.
)

:: ============================================================
:: 8. FILESYSTEM MCP SERVER
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [11/23] Installing Filesystem MCP Server...
echo ------------------------------------------------------------
call npm install -g @modelcontextprotocol/server-filesystem > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Filesystem MCP Server installed successfully
    echo [INFO] Run with: npx @modelcontextprotocol/server-filesystem
) else (
    echo [FAIL] Filesystem MCP installation failed. Check log.
)

:: ============================================================
:: 9. GIT MCP SERVER
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [12/23] Installing Git MCP Server...
echo ------------------------------------------------------------
if "%SKIP_GIT_MCP%"=="1" (
    echo [SKIP] Git not installed. Skipping Git MCP.
) else (
    call npm install -g @modelcontextprotocol/server-git > "%LOGFILE%" 2>&1
    if %errorlevel% equ 0 (
        echo [OK] Git MCP Server installed successfully
        echo [INFO] Run with: npx @modelcontextprotocol/server-git
    ) else (
        echo [FAIL] Git MCP installation failed. Check log.
    )
)

:: ============================================================
:: 10. PUPPETEER MCP SERVER (Browser Automation)
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [13/23] Installing Puppeteer MCP Server...
echo ------------------------------------------------------------
call npm install -g @modelcontextprotocol/server-puppeteer > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Puppeteer MCP Server installed successfully
    echo [INFO] Run with: npx @modelcontextprotocol/server-puppeteer
) else (
    echo [FAIL] Puppeteer MCP installation failed. Check log.
)

:: ============================================================
:: 11. PLAYWRIGHT MCP SERVER (Browser Automation)
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [14/23] Installing Playwright MCP Server...
echo ------------------------------------------------------------
call npm install -g @playwright/mcp > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Playwright MCP Server installed successfully
    echo [INFO] Run with: npx @playwright/mcp
) else (
    echo [FAIL] Playwright MCP installation failed. Check log.
)

:: ============================================================
:: 12. BRAVE SEARCH MCP SERVER
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [15/23] Installing Brave Search MCP Server...
echo ------------------------------------------------------------
call npm install -g @modelcontextprotocol/server-brave-search > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Brave Search MCP Server installed successfully
    echo [INFO] Requires BRAVE_API_KEY env var
) else (
    echo [FAIL] Brave Search MCP installation failed. Check log.
)

:: ============================================================
:: 13. FETCH MCP SERVER (HTTP Requests)
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [16/23] Installing Fetch MCP Server...
echo ------------------------------------------------------------
call npm install -g @modelcontextprotocol/server-fetch > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Fetch MCP Server installed successfully
    echo [INFO] Run with: npx @modelcontextprotocol/server-fetch
) else (
    echo [FAIL] Fetch MCP installation failed. Check log.
)

:: ============================================================
:: 14. FIRECRAWL MCP SERVER (Web Scraping)
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [17/23] Installing Firecrawl MCP Server...
echo ------------------------------------------------------------
call npm install -g firecrawl-mcp > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Firecrawl MCP Server installed successfully
    echo [INFO] Requires FIRECRAWL_API_KEY env var (or self-hosted)
) else (
    echo [FAIL] Firecrawl MCP installation failed. Check log.
)

:: ============================================================
:: 15. GITHUB MCP SERVER
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [18/23] Installing GitHub MCP Server...
echo ------------------------------------------------------------
call npm install -g @modelcontextprotocol/server-github > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] GitHub MCP Server installed successfully
    echo [INFO] Requires GITHUB_TOKEN env var
) else (
    echo [FAIL] GitHub MCP installation failed. Check log.
)

:: ============================================================
:: 17. SQLITE MCP SERVER (Database Queries)
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [19/23] Installing SQLite MCP Server...
echo ------------------------------------------------------------
call npm install -g @modelcontextprotocol/server-sqlite > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] SQLite MCP Server installed successfully
    echo [INFO] Run with: npx @modelcontextprotocol/server-sqlite
) else (
    echo [FAIL] SQLite MCP installation failed. Check log.
)

:: ============================================================
:: 18. GEMINI MCP SERVER
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [20/23] Installing Gemini MCP Server...
echo ------------------------------------------------------------
call npm install -g gemini-mcp-tool > "%LOGFILE%" 2>&1
if %errorlevel% equ 0 (
    echo [OK] Gemini MCP Server installed successfully
    echo [INFO] Requires GOOGLE_API_KEY env var
) else (
    echo [FAIL] Gemini MCP installation failed. Check log.
)

:: ============================================================
:: 19. SETUP CONFIGURATION FILES
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [21/23] Setting up configuration files...
echo ------------------------------------------------------------

:: Create config directory
if not exist "%USERPROFILE%\.ai-tools" mkdir "%USERPROFILE%\.ai-tools"

:: Create MCP config
echo { > "%USERPROFILE%\.ai-tools\mcp_config.json"
echo   "mcpServers": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     "context7": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "command": "npx", >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "args": ["-y", "@upstash/context7-mcp"] >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     }, >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     "filesystem": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "command": "npx", >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "args": ["-y", "@modelcontextprotocol/server-filesystem", "%USERPROFILE%"] >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     }, >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     "git": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "command": "npx", >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "args": ["-y", "@modelcontextprotocol/server-git"] >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     }, >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     "puppeteer": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "command": "npx", >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "args": ["-y", "@modelcontextprotocol/server-puppeteer"] >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     }, >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     "brave-search": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "command": "npx", >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "args": ["-y", "@modelcontextprotocol/server-brave-search"], >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "env": { "BRAVE_API_KEY": "your_key_here" } >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     }, >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     "fetch": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "command": "npx", >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "args": ["-y", "@modelcontextprotocol/server-fetch"] >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     }, >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     "github": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "command": "npx", >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "args": ["-y", "@modelcontextprotocol/server-github"], >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "env": { "GITHUB_TOKEN": "your_token_here" } >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     } >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo   } >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo } >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo [OK] MCP config created at %USERPROFILE%\.ai-tools\mcp_config.json

:: Create CleverHumanizer API wrapper
echo.
echo Creating CleverHumanizer API integration...
echo ^<?php > "%~dp0cleverhumanizer.php"
echo /** >> "%~dp0cleverhumanizer.php"
echo  * CleverHumanizer.ai API Integration >> "%~dp0cleverhumanizer.php"
echo  * Sign up at: https://cleverhumanizer.ai/profile >> "%~dp0cleverhumanizer.php"
echo  * Get your API key from your profile dashboard >> "%~dp0cleverhumanizer.php"
echo  */ >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo class CleverHumanizer { >> "%~dp0cleverhumanizer.php"
echo     private string $apiKey; >> "%~dp0cleverhumanizer.php"
echo     private string $baseUrl = 'https://cleverhumanizer.ai/api/v1'; >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo     public function __construct(?string $apiKey = null) { >> "%~dp0cleverhumanizer.php"
echo         $this->apiKey = $apiKey ^|^| getenv('CLEVER_HUMANIZER_API_KEY'); >> "%~dp0cleverhumanizer.php"
echo         if (empty($this->apiKey)) { >> "%~dp0cleverhumanizer.php"
echo             throw new \Exception('CleverHumanizer API key not set. Get one at https://cleverhumanizer.ai/profile'); >> "%~dp0cleverhumanizer.php"
echo         } >> "%~dp0cleverhumanizer.php"
echo     } >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo     /** >> "%~dp0cleverhumanizer.php"
echo      * Humanize AI-generated text >> "%~dp0cleverhumanizer.php"
echo      */ >> "%~dp0cleverhumanizer.php"
echo     public function humanize(string $text, string $style = 'default'): array { >> "%~dp0cleverhumanizer.php"
echo         return $this->request('POST', '/humanize', [ >> "%~dp0cleverhumanizer.php"
echo             'text' =^> $text, >> "%~dp0cleverhumanizer.php"
echo             'style' =^> $style, >> "%~dp0cleverhumanizer.php"
echo         ]); >> "%~dp0cleverhumanizer.php"
echo     } >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo     /** >> "%~dp0cleverhumanizer.php"
echo      * Detect if text is AI-generated >> "%~dp0cleverhumanizer.php"
echo      */ >> "%~dp0cleverhumanizer.php"
echo     public function detect(string $text): array { >> "%~dp0cleverhumanizer.php"
echo         return $this->request('POST', '/detect', [ >> "%~dp0cleverhumanizer.php"
echo             'text' =^> $text, >> "%~dp0cleverhumanizer.php"
echo         ]); >> "%~dp0cleverhumanizer.php"
echo     } >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo     /** >> "%~dp0cleverhumanizer.php"
echo      * Check plagiarism >> "%~dp0cleverhumanizer.php"
echo      */ >> "%~dp0cleverhumanizer.php"
echo     public function checkPlagiarism(string $text): array { >> "%~dp0cleverhumanizer.php"
echo         return $this->request('POST', '/plagiarism', [ >> "%~dp0cleverhumanizer.php"
echo             'text' =^> $text, >> "%~dp0cleverhumanizer.php"
echo         ]); >> "%~dp0cleverhumanizer.php"
echo     } >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo     /** >> "%~dp0cleverhumanizer.php"
echo      * Get account usage/balance >> "%~dp0cleverhumanizer.php"
echo      */ >> "%~dp0cleverhumanizer.php"
echo     public function getUsage(): array { >> "%~dp0cleverhumanizer.php"
echo         return $this->request('GET', '/usage'); >> "%~dp0cleverhumanizer.php"
echo     } >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo     private function request(string $method, string $endpoint, array $data = []): array { >> "%~dp0cleverhumanizer.php"
echo         $ch = curl_init($this->baseUrl . $endpoint); >> "%~dp0cleverhumanizer.php"
echo         $headers = [ >> "%~dp0cleverhumanizer.php"
echo             'Authorization: Bearer ' . $this->apiKey, >> "%~dp0cleverhumanizer.php"
echo             'Content-Type: application/json', >> "%~dp0cleverhumanizer.php"
echo         ]; >> "%~dp0cleverhumanizer.php"
echo         curl_setopt($ch, CURLOPT_HTTPHEADER, $headers); >> "%~dp0cleverhumanizer.php"
echo         curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo         if ($method === 'POST') { >> "%~dp0cleverhumanizer.php"
echo             curl_setopt($ch, CURLOPT_POST, true); >> "%~dp0cleverhumanizer.php"
echo             curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data)); >> "%~dp0cleverhumanizer.php"
echo         } >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo         $response = curl_exec($ch); >> "%~dp0cleverhumanizer.php"
echo         $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE); >> "%~dp0cleverhumanizer.php"
echo         curl_close($ch); >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo         if ($httpCode ^>= 400) { >> "%~dp0cleverhumanizer.php"
echo             throw new \Exception('API Error: ' . $response); >> "%~dp0cleverhumanizer.php"
echo         } >> "%~dp0cleverhumanizer.php"
echo. >> "%~dp0cleverhumanizer.php"
echo         return json_decode($response, true) ^|^| []; >> "%~dp0cleverhumanizer.php"
echo     } >> "%~dp0cleverhumanizer.php"
echo } >> "%~dp0cleverhumanizer.php"
echo [OK] CleverHumanizer PHP wrapper created

:: Create .env template
echo.
echo CLEVER_HUMANIZER_API_KEY=your_api_key_here > "%~dp0.env.example"
echo. >> "%~dp0.env.example"
echo # Get your API key from: https://cleverhumanizer.ai/profile >> "%~dp0.env.example"
echo [OK] .env.example template created

:: Create OpenRouter + Nemotron code generation wrapper
echo.
echo Creating OpenRouter + Nemotron 3 Super integration...
echo ^<?php > "%~dp0openrouter.php"
echo /** >> "%~dp0openrouter.php"
echo  * OpenRouter API Integration - NVIDIA Nemotron 3 Super 120B >> "%~dp0openrouter.php"
echo  * Model: nvidia/nemotron-3-super-120b-a12b >> "%~dp0openrouter.php"
echo  * Sign up at: https://openrouter.ai >> "%~dp0openrouter.php"
echo  * Get API key from: https://openrouter.ai/keys >> "%~dp0openrouter.php"
echo  * Model page: https://openrouter.ai/nvidia/nemotron-3-super-120b-a12b >> "%~dp0openrouter.php"
echo  */ >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo class OpenRouterClient { >> "%~dp0openrouter.php"
echo     private string $apiKey; >> "%~dp0openrouter.php"
echo     private string $apiUrl = 'https://openrouter.ai/api/v1/chat/completions'; >> "%~dp0openrouter.php"
echo     private string $siteUrl = ''; >> "%~dp0openrouter.php"
echo     private string $siteName = ''; >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo     public function __construct(?string $apiKey = null, ?string $siteUrl = null, ?string $siteName = null) { >> "%~dp0openrouter.php"
echo         $this->apiKey = $apiKey ^|^| getenv('OPENROUTER_API_KEY'); >> "%~dp0openrouter.php"
echo         $this->siteUrl = $siteUrl ^|^| getenv('SITE_URL') ^|^| 'http://localhost'; >> "%~dp0openrouter.php"
echo         $this->siteName = $siteName ^|^| getenv('SITE_NAME') ^|^| 'AI Tools'; >> "%~dp0openrouter.php"
echo         if (empty($this->apiKey)) { >> "%~dp0openrouter.php"
echo             throw new \Exception('OpenRouter API key not set. Get one at https://openrouter.ai/keys'); >> "%~dp0openrouter.php"
echo         } >> "%~dp0openrouter.php"
echo     } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo     /** >> "%~dp0openrouter.php"
echo      * Generate code using Nemotron 3 Super 120B >> "%~dp0openrouter.php"
echo      * 120B parameter MoE model, 12B active params - great for code generation >> "%~dp0openrouter.php"
echo      */ >> "%~dp0openrouter.php"
echo     public function generateCode(string $prompt, string $language = 'php', bool $reasoning = false): array { >> "%~dp0openrouter.php"
echo         $systemPrompt = "You are an expert code assistant. Generate clean, well-documented $language code. "; >> "%~dp0openrouter.php"
echo         $systemPrompt .= "Follow best practices, include error handling, and add comments explaining key logic."; >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo         return $this->chat([ >> "%~dp0openrouter.php"
echo             ['role' =^> 'system', 'content' =^> $systemPrompt], >> "%~dp0openrouter.php"
echo             ['role' =^> 'user', 'content' =^> $prompt], >> "%~dp0openrouter.php"
echo         ], 'nvidia/nemotron-3-super-120b-a12b', $reasoning); >> "%~dp0openrouter.php"
echo     } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo     /** >> "%~dp0openrouter.php"
echo      * Review and improve code >> "%~dp0openrouter.php"
echo      */ >> "%~dp0openrouter.php"
echo     public function reviewCode(string $code, string $language = 'php'): array { >> "%~dp0openrouter.php"
echo         $prompt = "Review this $language code for:\n"; >> "%~dp0openrouter.php"
echo         $prompt .= "1. Security vulnerabilities\n"; >> "%~dp0openrouter.php"
echo         $prompt .= "2. Performance issues\n"; >> "%~dp0openrouter.php"
echo         $prompt .= "3. Code quality and best practices\n"; >> "%~dp0openrouter.php"
echo         $prompt .= "4. Potential bugs\n\n"; >> "%~dp0openrouter.php"
echo         $prompt .= "Code:\n````$language\n$code\n```"; >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo         return $this->generateCode($prompt, $language); >> "%~dp0openrouter.php"
echo     } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo     /** >> "%~dp0openrouter.php"
echo      * Refactor code >> "%~dp0openrouter.php"
echo      */ >> "%~dp0openrouter.php"
echo     public function refactorCode(string $code, string $goal, string $language = 'php'): array { >> "%~dp0openrouter.php"
echo         $prompt = "Refactor this $language code to: $goal\n\n"; >> "%~dp0openrouter.php"
echo         $prompt .= "Original code:\n````$language\n$code\n```"; >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo         return $this->generateCode($prompt, $language); >> "%~dp0openrouter.php"
echo     } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo     /** >> "%~dp0openrouter.php"
echo      * General chat with any model >> "%~dp0openrouter.php"
echo      */ >> "%~dp0openrouter.php"
echo     public function chat(array $messages, string $model = 'nvidia/nemotron-3-super-120b-a12b', bool $reasoning = false): array { >> "%~dp0openrouter.php"
echo         $body = [ >> "%~dp0openrouter.php"
echo             'model' =^> $model, >> "%~dp0openrouter.php"
echo             'messages' =^> $messages, >> "%~dp0openrouter.php"
echo         ]; >> "%~dp0openrouter.php"
echo         if ($reasoning) { >> "%~dp0openrouter.php"
echo             $body['reasoning'] = true; >> "%~dp0openrouter.php"
echo         } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo         return $this->request('POST', '', $body); >> "%~dp0openrouter.php"
echo     } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo     /** >> "%~dp0openrouter.php"
echo      * List available models >> "%~dp0openrouter.php"
echo      */ >> "%~dp0openrouter.php"
echo     public function listModels(): array { >> "%~dp0openrouter.php"
echo         return $this->request('GET', 'https://openrouter.ai/api/v1/models'); >> "%~dp0openrouter.php"
echo     } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo     /** >> "%~dp0openrouter.php"
echo      * Get credits/balance >> "%~dp0openrouter.php"
echo      */ >> "%~dp0openrouter.php"
echo     public function getCredits(): array { >> "%~dp0openrouter.php"
echo         return $this->request('GET', 'https://openrouter.ai/api/v1/credits'); >> "%~dp0openrouter.php"
echo     } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo     private function request(string $method, string $url, array $data = []): array { >> "%~dp0openrouter.php"
echo         $endpoint = $url ^?^? : $this->apiUrl . $url; >> "%~dp0openrouter.php"
echo         $ch = curl_init($endpoint); >> "%~dp0openrouter.php"
echo         $headers = [ >> "%~dp0openrouter.php"
echo             'Authorization: Bearer ' . $this->apiKey, >> "%~dp0openrouter.php"
echo             'Content-Type: application/json', >> "%~dp0openrouter.php"
echo             'HTTP-Referer: ' . $this->siteUrl, >> "%~dp0openrouter.php"
echo             'X-OpenRouter-Title: ' . $this->siteName, >> "%~dp0openrouter.php"
echo         ]; >> "%~dp0openrouter.php"
echo         curl_setopt($ch, CURLOPT_HTTPHEADER, $headers); >> "%~dp0openrouter.php"
echo         curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); >> "%~dp0openrouter.php"
echo         curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true); >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo         if ($method === 'POST') { >> "%~dp0openrouter.php"
echo             curl_setopt($ch, CURLOPT_POST, true); >> "%~dp0openrouter.php"
echo             curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data)); >> "%~dp0openrouter.php"
echo         } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo         $response = curl_exec($ch); >> "%~dp0openrouter.php"
echo         $error = curl_error($ch); >> "%~dp0openrouter.php"
echo         $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE); >> "%~dp0openrouter.php"
echo         curl_close($ch); >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo         if ($error) { >> "%~dp0openrouter.php"
echo             throw new \Exception('cURL Error: ' . $error); >> "%~dp0openrouter.php"
echo         } >> "%~dp0openrouter.php"
echo         if ($httpCode ^>= 400) { >> "%~dp0openrouter.php"
echo             throw new \Exception('API Error (HTTP ' . $httpCode . '): ' . $response); >> "%~dp0openrouter.php"
echo         } >> "%~dp0openrouter.php"
echo. >> "%~dp0openrouter.php"
echo         return json_decode($response, true) ^|^| []; >> "%~dp0openrouter.php"
echo     } >> "%~dp0openrouter.php"
echo } >> "%~dp0openrouter.php"
echo [OK] OpenRouter PHP wrapper created (Nemotron 3 Super 120B)

:: Create .env template
echo.
echo # ============================================ > "%~dp0.env.example"
echo # AI CLI TOOLS - Environment Configuration >> "%~dp0.env.example"
echo # ============================================ >> "%~dp0.env.example"
echo. >> "%~dp0.env.example"
echo # CleverHumanizer.ai - Text Humanization >> "%~dp0.env.example"
echo CLEVER_HUMANIZER_API_KEY=your_api_key_here >> "%~dp0.env.example"
echo. >> "%~dp0.env.example"
echo # OpenRouter - Code Generation (Nemotron 3 Super 120B) >> "%~dp0.env.example"
echo OPENROUTER_API_KEY=sk-or-v1-your_key_here >> "%~dp0.env.example"
echo SITE_URL=http://localhost >> "%~dp0.env.example"
echo SITE_NAME=Penduka AI Tools >> "%~dp0.env.example"
echo. >> "%~dp0.env.example"
echo # Google Gemini - Gemini CLI + MCP >> "%~dp0.env.example"
echo GOOGLE_API_KEY=AIza-your_key_here >> "%~dp0.env.example"
echo. >> "%~dp0.env.example"
echo # Brave Search MCP >> "%~dp0.env.example"
echo BRAVE_API_KEY=your_key_here >> "%~dp0.env.example"
echo. >> "%~dp0.env.example"
echo # Firecrawl MCP - Web Scraping >> "%~dp0.env.example"
echo FIRECRAWL_API_KEY=fc-your_key_here >> "%~dp0.env.example"
echo. >> "%~dp0.env.example"
echo # GitHub MCP Server >> "%~dp0.env.example"
echo GITHUB_TOKEN=ghp_your_token_here >> "%~dp0.env.example"
echo. >> "%~dp0.env.example"
echo # Get your API keys from: >> "%~dp0.env.example"
echo # - CleverHumanizer:  https://cleverhumanizer.ai/profile >> "%~dp0.env.example"
echo # - OpenRouter:       https://openrouter.ai/keys >> "%~dp0.env.example"
echo # - Google Gemini:    https://aistudio.google.com/apikey >> "%~dp0.env.example"
echo # - Brave Search:     https://brave.com/search/api >> "%~dp0.env.example"
echo # - Firecrawl:        https://www.firecrawl.dev >> "%~dp0.env.example"
echo # - GitHub:           https://github.com/settings/tokens >> "%~dp0.env.example"
echo [OK] .env.example template created

:: Create launcher scripts
echo.
echo Creating launcher scripts...

:: n8n launcher
echo @echo off > "%~dp0start-n8n.bat"
echo title n8n Workflow Automation >> "%~dp0start-n8n.bat"
echo color 0B >> "%~dp0start-n8n.bat"
echo echo. >> "%~dp0start-n8n.bat"
echo echo ============================================================ >> "%~dp0start-n8n.bat"
echo echo   Starting n8n Workflow Automation Server... >> "%~dp0start-n8n.bat"
echo echo ============================================================ >> "%~dp0start-n8n.bat"
echo echo. >> "%~dp0start-n8n.bat"
echo echo Access at: http://localhost:5678 >> "%~dp0start-n8n.bat"
echo echo. >> "%~dp0start-n8n.bat"
echo n8n start >> "%~dp0start-n8n.bat"
echo [OK] start-n8n.bat created

:: Crush launcher
if "%SKIP_CRUSH%"=="0" (
    echo @echo off > "%~dp0start-crush.bat"
    echo title Crush AI Coding Assistant >> "%~dp0start-crush.bat"
    echo color 0C >> "%~dp0start-crush.bat"
    echo cd /d "%%~dp0" >> "%~dp0start-crush.bat"
    echo echo. >> "%~dp0start-crush.bat"
    echo echo ============================================================ >> "%~dp0start-crush.bat"
    echo echo   Starting Crush AI Coding Assistant... >> "%~dp0start-crush.bat"
    echo echo ============================================================ >> "%~dp0start-crush.bat"
    echo echo. >> "%~dp0start-crush.bat"
    echo echo Navigate to your project folder and run: crush >> "%~dp0start-crush.bat"
    echo echo. >> "%~dp0start-crush.bat"
    echo crush %%* >> "%~dp0start-crush.bat"
    echo [OK] start-crush.bat created
)

:: Claude launcher
echo @echo off > "%~dp0start-claude.bat"
echo title Claude Code CLI >> "%~dp0start-claude.bat"
echo color 0D >> "%~dp0start-claude.bat"
echo cd /d "%%~dp0" >> "%~dp0start-claude.bat"
echo echo. >> "%~dp0start-claude.bat"
echo echo ============================================================ >> "%~dp0start-claude.bat"
echo echo   Starting Claude Code CLI... >> "%~dp0start-claude.bat"
echo echo ============================================================ >> "%~dp0start-claude.bat"
echo echo. >> "%~dp0start-claude.bat"
echo echo Navigate to your project folder and run: claude >> "%~dp0start-claude.bat"
echo echo. >> "%~dp0start-claude.bat"
echo claude %%* >> "%~dp0start-claude.bat"
echo [OK] start-claude.bat created

:: Codex launcher
echo @echo off > "%~dp0start-codex.bat"
echo title OpenAI Codex CLI >> "%~dp0start-codex.bat"
echo color 0E >> "%~dp0start-codex.bat"
echo cd /d "%%~dp0" >> "%~dp0start-codex.bat"
echo echo. >> "%~dp0start-codex.bat"
echo echo ============================================================ >> "%~dp0start-codex.bat"
echo echo   Starting OpenAI Codex CLI... >> "%~dp0start-codex.bat"
echo echo ============================================================ >> "%~dp0start-codex.bat"
echo echo. >> "%~dp0start-codex.bat"
echo echo Navigate to your project folder and run: codex >> "%~dp0start-codex.bat"
echo echo. >> "%~dp0start-codex.bat"
echo codex %%* >> "%~dp0start-codex.bat"
echo [OK] start-codex.bat created

:: Qwen Code launcher
echo @echo off > "%~dp0start-qwen.bat"
echo title Qwen Code CLI >> "%~dp0start-qwen.bat"
echo color 0A >> "%~dp0start-qwen.bat"
echo cd /d "%%~dp0" >> "%~dp0start-qwen.bat"
echo echo. >> "%~dp0start-qwen.bat"
echo echo ============================================================ >> "%~dp0start-qwen.bat"
echo echo   Starting Qwen Code CLI... >> "%~dp0start-qwen.bat"
echo echo ============================================================ >> "%~dp0start-qwen.bat"
echo echo. >> "%~dp0start-qwen.bat"
echo echo Navigate to your project folder and run: qwen >> "%~dp0start-qwen.bat"
echo echo   MCP commands: qwen mcp add^|remove^|list >> "%~dp0start-qwen.bat"
echo echo. >> "%~dp0start-qwen.bat"
echo qwen %%* >> "%~dp0start-qwen.bat"
echo [OK] start-qwen.bat created

:: Gemini launcher
echo @echo off > "%~dp0start-gemini.bat"
echo title Google Gemini CLI >> "%~dp0start-gemini.bat"
echo color 0B >> "%~dp0start-gemini.bat"
echo cd /d "%%~dp0" >> "%~dp0start-gemini.bat"
echo echo. >> "%~dp0start-gemini.bat"
echo echo ============================================================ >> "%~dp0start-gemini.bat"
echo echo   Starting Google Gemini CLI... >> "%~dp0start-gemini.bat"
echo echo ============================================================ >> "%~dp0start-gemini.bat"
echo echo. >> "%~dp0start-gemini.bat"
echo echo Set GOOGLE_API_KEY first, then run: gemini >> "%~dp0start-gemini.bat"
echo echo. >> "%~dp0start-gemini.bat"
echo gemini %%* >> "%~dp0start-gemini.bat"
echo [OK] start-gemini.bat created

:: MCP Servers launcher
echo @echo off > "%~dp0start-mcp-servers.bat"
echo title MCP Servers Status >> "%~dp0start-mcp-servers.bat"
echo color 0F >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo echo ============================================================ >> "%~dp0start-mcp-servers.bat"
echo echo   MCP Servers - Status Quick Reference >> "%~dp0start-mcp-servers.bat"
echo echo ============================================================ >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo echo INSTALLED MCP SERVERS: >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo echo  1. Context7        npx @upstash/context7-mcp >> "%~dp0start-mcp-servers.bat"
echo echo  2. Filesystem      npx @modelcontextprotocol/server-filesystem >> "%~dp0start-mcp-servers.bat"
echo echo  3. Git             npx @modelcontextprotocol/server-git >> "%~dp0start-mcp-servers.bat"
echo echo  4. Puppeteer       npx @modelcontextprotocol/server-puppeteer >> "%~dp0start-mcp-servers.bat"
echo echo  5. Playwright      npx @playwright/mcp >> "%~dp0start-mcp-servers.bat"
echo echo  6. Brave Search    npx @modelcontextprotocol/server-brave-search >> "%~dp0start-mcp-servers.bat"
echo echo  7. Fetch           npx @modelcontextprotocol/server-fetch >> "%~dp0start-mcp-servers.bat"
echo echo  8. Firecrawl       npx firecrawl-mcp >> "%~dp0start-mcp-servers.bat"
echo echo  9. GitHub          npx @modelcontextprotocol/server-github >> "%~dp0start-mcp-servers.bat"
echo echo  10. SQLite         npx @modelcontextprotocol/server-sqlite >> "%~dp0start-mcp-servers.bat"
echo echo  11. Gemini MCP     npx gemini-mcp-tool >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo echo REQUIRED API KEYS: >> "%~dp0start-mcp-servers.bat"
echo echo   BRAVE_API_KEY, FIRECRAWL_API_KEY, GITHUB_TOKEN, GOOGLE_API_KEY >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo echo Config: %%USERPROFILE%%\.ai-tools\mcp_config.json >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo pause >> "%~dp0start-mcp-servers.bat"
echo [OK] start-mcp-servers.bat created

echo.
echo ============================================================
echo  SETUP COMPLETE!
echo ============================================================
echo.
echo  INSTALLED TOOLS:
echo.
echo   AI CODING CLI:
echo   [1]  Claude Code     - claude
echo   [2]  OpenAI Codex    - codex
echo   [3]  Qwen Code       - qwen (THIS TOOL!)
echo   [4]  Gemini CLI      - gemini
echo   [5]  Crush           - crush
echo   [6]  OpenCode        - opencode (manual install)
echo   [7]  Plandex         - plandex
echo.
echo   PLATFORMS:
echo   [8]  n8n             - n8n (http://localhost:5678)
echo.
echo   MCP SERVERS (11):
echo   [9]  Context7         [10] Filesystem     [11] Git
echo   [12] Puppeteer        [13] Playwright      [14] Brave Search
echo   [15] Fetch            [16] Firecrawl       [17] GitHub
echo   [18] SQLite           [19] Gemini MCP
echo.
echo   AI SERVICES:
echo   [20] CleverHumanizer  - PHP wrapper
echo   [21] OpenRouter       - PHP wrapper (Nemotron 3 Super 120B)
echo.
echo  LAUNCHER SCRIPTS:
echo   - start-n8n.bat         - start-qwen.bat
echo   - start-claude.bat      - start-gemini.bat
echo   - start-codex.bat       - start-crush.bat (if Go)
echo   - start-mcp-servers.bat (all MCP reference)
echo.
echo  NEXT STEPS:
echo   1. Copy .env.example to .env and add your API keys
echo   2. Run: claude login / codex login / gemini auth login
echo   3. Run start-n8n.bat for workflow automation
echo   4. Run start-mcp-servers.bat for MCP reference
echo   5. See SETUP_GUIDE.md for full documentation
echo.
echo ============================================================
echo.
pause