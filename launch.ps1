<#
.SYNOPSIS
    GeoAnalog Matchmaker — One-Click Launcher (PowerShell)
.DESCRIPTION
    Three-tier launcher:
      1. Node.js found  → Vite dev server (full experience)
      2. Python found   → Python HTTP server serving pre-built dist/
      3. Neither found  → Open dist/index.html directly in browser
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Continue'
Set-Location $PSScriptRoot

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "     GEOANALOG MATCHMAKER // NASA SPACE APPS CHALLENGE 2026"           -ForegroundColor Cyan
Write-Host "     Planetary Analog Intelligence & Decision Analysis Platform"        -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host ""

# ─── Helper: find executable ─────────────────────────────────────────────────
function Find-Exe {
    param([string[]]$Names, [string[]]$ExtraFolders = @())
    foreach ($name in $Names) {
        $found = Get-Command $name -ErrorAction SilentlyContinue
        if ($found) { return $found.Source }
    }
    foreach ($folder in $ExtraFolders) {
        $candidate = Join-Path $folder ($Names[0] + ".exe")
        if (Test-Path $candidate) { return $candidate }
    }
    return $null
}

# ─── TIER 1: Node.js ─────────────────────────────────────────────────────────
$nodeExtras = @(
    "$env:USERPROFILE\.local\nodejs",
    "$env:ProgramFiles\nodejs",
    "${env:ProgramFiles(x86)}\nodejs",
    "$env:LOCALAPPDATA\Programs\nodejs",
    "$env:APPDATA\nvm\current"
)
$nodePath = Find-Exe -Names @("node") -ExtraFolders $nodeExtras

if ($nodePath) {
    # Add parent dir to PATH if needed
    $nodeDir = Split-Path $nodePath
    if ($env:Path -notlike "*$nodeDir*") { $env:Path = "$nodeDir;$env:Path" }

    $nodeVer = & node -v 2>$null
    $npmVer  = & npm -v  2>$null
    Write-Host "[1/4] Node.js detected: $nodeVer / npm v$npmVer" -ForegroundColor Green
    Write-Host ""

    if (-not (Test-Path "node_modules")) {
        Write-Host "[2/4] First run — installing dependencies (~30 seconds)..." -ForegroundColor Yellow
        & npm install
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[ERROR] npm install failed." -ForegroundColor Red
            Read-Host "Press Enter to exit"; exit 1
        }
        Write-Host "      Done!" -ForegroundColor Green
    } else {
        Write-Host "[2/4] Dependencies already installed." -ForegroundColor Green
    }
    Write-Host ""
    Write-Host "[3/4] Starting Vite dev server on http://localhost:5173/ ..." -ForegroundColor Green
    Write-Host "[4/4] Opening your default browser..."                         -ForegroundColor Green
    Write-Host ""
    Write-Host "========================================================================" -ForegroundColor Cyan
    Write-Host "  Server is RUNNING. Close this window or press Ctrl+C to stop."       -ForegroundColor White
    Write-Host "  URL: http://localhost:5173/"                                          -ForegroundColor Cyan
    Write-Host "========================================================================" -ForegroundColor Cyan
    Write-Host ""

    Start-Process "http://localhost:5173/"
    & npm run dev
    exit 0
}

# ─── TIER 2: Python ──────────────────────────────────────────────────────────
$pyExtras = @(
    "$env:LOCALAPPDATA\Programs\Python\Python312",
    "$env:LOCALAPPDATA\Programs\Python\Python311",
    "$env:LOCALAPPDATA\Programs\Python\Python310",
    "$env:LOCALAPPDATA\Programs\Python\Python39",
    "C:\Python312", "C:\Python311", "C:\Python310"
)
$pythonPath = Find-Exe -Names @("python","python3") -ExtraFolders $pyExtras

if ($pythonPath) {
    Write-Host "[INFO] Node.js not found. Using Python to serve the pre-built app." -ForegroundColor Yellow
    Write-Host ""

    if (-not (Test-Path "dist\index.html")) {
        Write-Host "[ERROR] dist\ folder not found. Install Node.js and re-run to build." -ForegroundColor Red
        Read-Host "Press Enter to exit"; exit 1
    }

    Write-Host "[1/2] Serving dist\ on http://localhost:8080/ ..." -ForegroundColor Green
    Write-Host "[2/2] Opening your default browser..."              -ForegroundColor Green
    Write-Host ""
    Write-Host "========================================================================" -ForegroundColor Cyan
    Write-Host "  Server is RUNNING. Close this window or press Ctrl+C to stop."       -ForegroundColor White
    Write-Host "  URL: http://localhost:8080/"                                          -ForegroundColor Cyan
    Write-Host "========================================================================" -ForegroundColor Cyan
    Write-Host ""

    Start-Job -ScriptBlock { Start-Sleep 2; Start-Process "http://localhost:8080/" } | Out-Null
    Push-Location "dist"
    & $pythonPath -m http.server 8080
    Pop-Location
    exit 0
}

# ─── TIER 3: Fallback — open file directly ───────────────────────────────────
Write-Host "[NOTICE] Node.js and Python were not found on this machine." -ForegroundColor Yellow
Write-Host ""
if (Test-Path "dist\index.html") {
    Write-Host "Falling back: opening dist\index.html directly in your browser."  -ForegroundColor Yellow
    Write-Host "NOTE: Some external data features may be limited without a server." -ForegroundColor Gray
    Write-Host ""
    Start-Process (Resolve-Path "dist\index.html").Path
    Write-Host "Done! If nothing opens, manually open:" -ForegroundColor Green
    Write-Host "  $PSScriptRoot\dist\index.html"
} else {
    Write-Host "[ERROR] No dist\ folder found. Cannot run without Node.js or Python." -ForegroundColor Red
    Write-Host ""
    Write-Host "To fix this, install ONE of:" -ForegroundColor White
    Write-Host "  A) Node.js  (recommended)  https://nodejs.org/"  -ForegroundColor Cyan
    Write-Host "  B) Python 3                 https://python.org/"  -ForegroundColor Cyan
    Write-Host "Then re-run this launcher."
}
Write-Host ""
Read-Host "Press Enter to close"
