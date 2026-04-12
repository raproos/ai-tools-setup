@echo off
title AI CLI Tools Setup
color 0A

echo.
echo ============================================================
echo          AI CLI TOOLS - COMPLETE SETUP SCRIPT
echo ============================================================
echo.
echo  This script will install and configure:
echo   [1] Claude Code CLI (Anthropic)
echo   [2] OpenAI Codex CLI
echo   [3] Qwen Code CLI (this tool!)
echo   [4] Crush CLI (charmbracelet)
echo   [5] OpenCode CLI
echo   [6] Plandex CLI
echo   [7] n8n Workflow Automation
echo   [8] Context7 MCP Server
echo   [9] Filesystem MCP Server
echo   [10] Git MCP Server
echo   [11] CleverHumanizer.ai Integration
echo   [12] OpenRouter + Nemotron 3 Super (Code Generation)
echo.
echo  Prerequisites needed:
echo   - Node.js v22+  (npm)
echo   - Go 1.21+      (for Crush)
echo   - Git
echo.
echo ============================================================
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
echo  [3/12] Installing Qwen Code CLI...
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
:: 4. CRUSH CLI (charmbracelet)
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [4/12] Installing Crush CLI...
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
echo  [5/12] Installing OpenCode CLI...
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
echo  [6/12] Installing Plandex CLI...
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
echo  [7/12] Installing n8n Workflow Automation...
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
echo  [8/12] Installing Context7 MCP Server...
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
echo  [9/12] Installing Filesystem MCP Server...
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
echo  [10/12] Installing Git MCP Server...
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
:: 10. SETUP CONFIGURATION FILES
:: ============================================================
echo.
echo ------------------------------------------------------------
echo  [11/12] Setting up configuration files...
echo ------------------------------------------------------------

:: Create config directory
if not exist "%USERPROFILE%\.ai-tools" mkdir "%USERPROFILE%\.ai-tools"

:: Create MCP config
echo { > "%USERPROFILE%\.ai-tools\mcp_config.json"
echo   "mcpServers": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     "filesystem": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "command": "npx", >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "args": ["-y", "@modelcontextprotocol/server-filesystem", "%USERPROFILE%"] >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     }, >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo     "context7": { >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "command": "npx", >> "%USERPROFILE%\.ai-tools\mcp_config.json"
echo       "args": ["-y", "@upstash/context7-mcp"] >> "%USERPROFILE%\.ai-tools\mcp_config.json"
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
echo CLEVER_HUMANIZER_API_KEY=your_api_key_here > "%~dp0.env.example"
echo OPENROUTER_API_KEY=sk-or-v1-your_key_here >> "%~dp0.env.example"
echo SITE_URL=http://localhost >> "%~dp0.env.example"
echo SITE_NAME=Penduka AI Tools >> "%~dp0.env.example"
echo. >> "%~dp0.env.example"
echo # Get your API keys from: >> "%~dp0.env.example"
echo # - CleverHumanizer: https://cleverhumanizer.ai/profile >> "%~dp0env.example"
echo # - OpenRouter: https://openrouter.ai/keys >> "%~dp0.env.example"
echo # Nemotron 3 Super model: https://openrouter.ai/nvidia/nemotron-3-super-120b-a12b >> "%~dp0.env.example"
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

:: MCP Servers launcher
echo @echo off > "%~dp0start-mcp-servers.bat"
echo title MCP Servers Status >> "%~dp0start-mcp-servers.bat"
echo color 0F >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo echo ============================================================ >> "%~dp0start-mcp-servers.bat"
echo echo   MCP Servers Status >> "%~dp0start-mcp-servers.bat"
echo echo ============================================================ >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo echo Installed MCP Servers: >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo echo 1. Context7 MCP:     npx @upstash/context7-mcp >> "%~dp0start-mcp-servers.bat"
echo echo 2. Filesystem MCP:   npx @modelcontextprotocol/server-filesystem >> "%~dp0start-mcp-servers.bat"
echo echo 3. Git MCP:          npx @modelcontextprotocol/server-git >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo echo Config file: %%USERPROFILE%%\.ai-tools\mcp_config.json >> "%~dp0start-mcp-servers.bat"
echo echo. >> "%~dp0start-mcp-servers.bat"
echo pause >> "%~dp0start-mcp-servers.bat"
echo [OK] start-mcp-servers.bat created

echo.
echo ============================================================
echo  SETUP COMPLETE!
echo ============================================================
echo.
echo  Installed tools:
echo   [1] Claude Code     - claude
echo   [2] OpenAI Codex    - codex
echo   [3] Qwen Code       - qwen (THIS TOOL!)
echo   [4] Crush           - crush
echo   [5] OpenCode        - opencode (manual install needed)
echo   [6] Plandex         - plandex
echo   [7] n8n             - n8n
echo   [8] Context7 MCP    - npx @upstash/context7-mcp
echo   [9] Filesystem MCP  - npx @modelcontextprotocol/server-filesystem
echo   [10] Git MCP         - npx @modelcontextprotocol/server-git
echo   [11] CleverHumanizer - PHP wrapper created
echo   [12] OpenRouter      - PHP wrapper (Nemotron 3 Super 120B)
echo.
echo  Launcher scripts created:
echo   - start-n8n.bat         (n8n server)
echo   - start-claude.bat      (Claude Code)
echo   - start-codex.bat       (OpenAI Codex)
echo   - start-qwen.bat        (Qwen Code CLI)
if "%SKIP_CRUSH%"=="0" echo   - start-crush.bat         (Crush AI)
echo   - start-mcp-servers.bat (MCP status)
echo.
echo  Next steps:
echo   1. Set your API keys in .env (CleverHumanizer, OpenRouter)
echo   2. Run 'claude login' to authenticate Claude
echo   3. Run 'codex login' to authenticate OpenAI
echo   4. Run start-n8n.bat to start n8n server
echo   5. Run start-qwen.bat to use this tool locally
echo   6. See SETUP_GUIDE.md for full documentation
echo.
echo ============================================================
echo.
pause