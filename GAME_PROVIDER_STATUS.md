# Penduka Casino - Game Provider Status

## Working Providers ✅

### 1. Betsoft (BS)
- **Type**: Local PHP Math (Server.php)
- **Status**: ✅ WORKING
- **Server**: PHP Built-in Server (port 8001)
- **Games**: AtTheMoviesBS, WolfMoonRisingBS, BookOfDarknessBS, etc.
- **Notes**: Fixed DEFCOIN=0 NaN error in Server.php
- **Files**: `app/Games/*BS/Server.php`, `www/games/*BS/`

### 2. CQ9 (CQ9)
- **Type**: Arcade Server (WebSocket)
- **Status**: ✅ WORKING
- **Server**: Arcade Server (port 22188)
- **Games**: FruitKingCQ9, WaterMarginFishingCQ9, etc.
- **Files**: `www/games/*CQ9/`

### 3. KA Gaming (KA)
- **Type**: Arcade Server (WebSocket)
- **Status**: ✅ WORKING (66 games assigned to category)
- **Server**: Arcade Server (port 22188)
- **Games**: AfricaRunKA, AirCombatKA, FishHunterKA, etc.
- **Files**: `www/games/*KA/`
- **Notes**: Had to assign all games to ka-gaming category

### 4. ISB (ISB)
- **Type**: Arcade Server (WebSocket)
- **Status**: ✅ WORKING
- **Server**: Arcade Server (port 22188)
- **Games**: FishingForGoldISB, AztecGoldMegawaysISB
- **Files**: `www/games/*ISB/`

### 5. Minigame (MN)
- **Type**: Static HTML5/JS (React-based)
- **Status**: ✅ WORKING
- **Server**: PHP Static Files (port 8001)
- **Games**: BananasMN
- **Notes**: Fixed asset path issues (added /games/ prefix)

### 6. Playtech PT/PTM (PT)
- **Type**: WebSocket + PHP Server.php
- **Status**: ✅ FULLY WORKING (Fixed April 12, 2026)
- **Servers**: Slots WS (port 22154) + PHP (port 8001)
- **Games**: AgeOfTheGodsGodOfStormsPTM, and 69 other PTM games
- **Working**: Game client loads, WebSocket connects, balance displays, spinning works, balance updates correctly
- **Fixes Applied**:
  1. ✅ JavaScript `el2[1].style` undefined error (all 69 templates)
  2. ✅ Socket.IO `1::` handshake deadlock in Slots.js (critical fix)
  3. ✅ WebSocket URL includes gameName param for server routing
  4. ✅ All 70 PTM blade templates updated with proper WebSocket URLs
  5. ✅ Enhanced verbose logging in Slots.js for debugging
- **Key Fix**: Slots.js now sends `1::` Socket.IO handshake IMMEDIATELY on connection, before the game sends any messages. Playtech GWT games wait for this handshake before responding.
- **Architecture**: Browser → Socket.IO WS (Slots.js:22154) → HTTP POST → PHP Server.php → MySQL

### 7. EGT
- **Type**: Static/Local
- **Status**: ⚠️ UNTESTED
- **Games**: Multiple EGT suffix games

---

## Partially Working ⚠️

### 8. Skywind (SW)
- **Type**: Arcade Server (WebSocket)
- **Status**: ⚠️ CONNECTION ISSUES
- **Server**: Arcade Server (port 22188)
- **Games**: FlyJetSW, FuFarmSW, DragonRichesSW
- **Issue**: Server init fails - `{request: 'init', isInitResponse: true}`
- **Possible Fix**: Check Arcade server SW game handlers

### 9. Wazdan (WD)
- **Type**: Static HTML5/JS
- **Status**: ⚠️ SOME WORK, SOME DON'T
- **Server**: PHP Static Files (port 8001)
- **Games**: FenixPlay27DeluxeWD, HungrySharkWD, etc.
- **Structure**: `www/games/*WD/wazdan40-*/`
- **Note**: CaptainSharkWD fails (may be mislabeled, not actually Wazdan)

### 10. Pragmatic PM/PMM
- **Type**: Local PHP Math (Server.php)
- **Status**: ⚠️ UNTESTED
- **Server**: PHP Built-in Server (port 8001)
- **Games**: AncientEgyptPM, AztecGemsPM, GreatRhinoPM, etc.
- **Should Work**: Same architecture as Betsoft

---

## Not Working ❌

### 11. Pragmatic gs2c
- **Type**: Static Files + External Server
- **Status**: ❌ NEEDS EXTERNAL SERVER
- **Issue**: References fake URL `https://ttrt/gs2c/v3/gameService`
- **Games**: WolfGold, SweetBonanza, BookofKingdoms
- **Fix Needed**: Real Pragmatic Play server or local reimplementation

### 12. NetEnt (NET)
- **Type**: Static/External
- **Status**: ⚠️ MINOR ISSUES
- **Games**: DazzleMeNET, HalloweenJackNET
- **Issues**: Missing currency files (fixed NAD), some 404s

---

## Server Infrastructure

### Currently Running:
1. **PHP Web Server** - Port 8001 (Laravel)
2. **MySQL** - Port 3306
3. **Slotopol Math Server** - Port 8080
4. **Slots WebSocket** - Port 22154 (for PT games)
5. **Arcade WebSocket** - Port 22188 (for CQ9, KA, ISB, SW)

### Startup Command:
```
C:\penduka\Start_Penduka.bat
```

---

## Fixes Applied

### Betsoft Games:
- ✅ Fixed DEFCOIN=0 NaN error (changed `$bet = 0` to `$bet = 1`)
- ✅ Added JSON request support to Server.php
- ✅ Added null safety for bet calculations

### KA Gaming:
- ✅ Assigned 66 games to ka-gaming category
- ✅ Fixed GameReel namespace for MillionTwoBS
- ✅ Created WolfMoonRisingBS_Restored game files

### Minigame (MN):
- ✅ Fixed asset paths (added `/games/` prefix)
- ✅ Fixed manifest.json path
- ✅ Fixed webpack publicPath

### CQ9 Games:
- ✅ Fixed innerHTML null error in WaterMarginFishingCQ9

### Playtech PT/PTM Games:
- ✅ Fixed JavaScript `el2[1].style` undefined error in all 69 PTM blade templates
- ✅ PTM games now load without console errors
- ✅ WebSocket server (port 22154) running and configured

### Live Chat:
- ✅ Created tickets table
- ✅ Created tickets_answers table
- ✅ Added delete functionality
- ✅ Added assign functionality

### User Management:
- ✅ Fixed role assignment for new users
- ✅ Fixed "choose_shop" error for MillionTwoBS
- ✅ Fixed Delete button position

### Categories:
- ✅ Fixed duplicate games in /categories/all
- ✅ Fixed $category1 undefined errors
- ✅ Fixed $currentSliderNum undefined errors

---

## Game Count by Provider

| Provider | Count | Status |
|----------|-------|--------|
| Betsoft (BS) | ~12 | ✅ Working |
| CQ9 | ~5 | ✅ Working |
| KA Gaming | 66 | ✅ Working |
| ISB | ~3 | ✅ Working |
| Minigame (MN) | ~2 | ✅ Working |
| Playtech PT/PTM | ~69 | ✅ Working |
| Skywind (SW) | ~8 | ⚠️ Issues |
| Wazdan (WD) | ~10 | ⚠️ Mixed |
| Pragmatic PM/PMM | ~8 | ⚠️ Untested |
| EGT | ~15 | ⚠️ Untested |
| NetEnt (NET) | ~5 | ⚠️ Minor |
| **TOTAL** | **~203** | |

---

## Known Issues

1. **Skywind Init Failure**: Games load engine but fail on server init
2. **CaptainSharkWD**: Not loading (may be mislabeled provider)
3. **Pragmatic gs2c**: Needs external server
4. **AfricaRunKA**: Missing PWA icons (non-critical)

## Resolved Issues ✅

1. **PTM Games JavaScript Error**: Fixed `el2[1].style` undefined error in all 69 PTM blade templates
2. **Duplicate Game Cards**: Fixed with `groupBy('game_id')` in category query and `keyBy('id')` after fetching
3. **PTM WebSocket DEADLOCK** (April 12, 2026): Slots.js now sends Socket.IO `1::` handshake IMMEDIATELY on connection. Playtech GWT games wait for this before sending any messages - was causing complete communication failure.
4. **PTM Game Routing** (April 12, 2026): All 70 PTM blade templates updated to pass `gameName` in WebSocket URL query params for proper server-side routing

---

## File Locations

- **Game Files**: `C:\penduka\www\games\*`
- **Game Logic**: `C:\penduka\www\casino\app\Games\*\Server.php`
- **Frontend**: `C:\penduka\www\frontend\Default\`
- **WebSocket Servers**: `C:\penduka\www\casino\PTWebSocket\`
- **Config**: `C:\penduka\www\socket_config0.json`, `C:\penduka\www\arcade_config.json`

---

## AI Tools & Development Environment

### MCP Servers Configured
The development environment includes 13 MCP (Model Context Protocol) servers:

**Active AI Tools:**
- ✅ **Gemini API** - Google Gemini documentation search (`mcp__gemini-audit__search_docs`)
- ✅ **Gemini AI** - Chat, vision, code generation (`gemini-2.0-flash` model)
- ✅ **Filesystem MCP** - File operations and directory management
- ✅ **GitHub MCP** - Repository, issue, and PR management
- ✅ **Git MCP** - Local Git operations (commit, branch, diff, log)
- ✅ **Firecrawl MCP** - Web scraping, crawling, and search
- ✅ **Playwright MCP** - Browser automation and testing
- ✅ **Puppeteer MCP** - Alternative browser automation
- ✅ **Memory MCP** - Knowledge graph for persistent context
- ✅ **Context7 MCP** - Library documentation lookup
- ✅ **Sequential Thinking MCP** - Chain-of-thought problem solving

**Pending Activation:**
- ⚠️ **DeepSeek MCP** - Requires API key replacement (see `AI_TOOLS_SETUP.md`)
- ⚠️ **OpenClaw MCP** - Requires gateway setup and token (see `AI_TOOLS_SETUP.md`)

### Configuration Files
- **Qwen Settings**: `C:\Users\Ruben\.qwen\settings.json`
- **AI Tools Documentation**: `C:\penduka\AI_TOOLS_SETUP.md` (full guide)
- **Quick Reference**: `C:\penduka\AI_TOOLS_QUICK_REF.md` (checklist)

### Security Notes
- Gemini API key is currently hardcoded in settings.json (medium risk)
- DeepSeek and OpenClaw use placeholder keys (safe, but need activation)
- See `AI_TOOLS_SETUP.md` Section 6 for security best practices

---

**Last Updated**: April 12, 2026
**Status**: Active Development - PTM Games Fully Working
**AI Tools**: 12/13 MCP servers active (see AI_TOOLS_SETUP.md)
