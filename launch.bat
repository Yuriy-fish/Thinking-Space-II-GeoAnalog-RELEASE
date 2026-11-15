@echo off
setlocal enabledelayedexpansion
title GeoAnalog Matchmaker - NASA Space Apps Challenge 2026
cd /d "%~dp0"

echo ========================================================================
echo.
echo     GEOANALOG MATCHMAKER // NASA SPACE APPS CHALLENGE 2026
echo     Planetary Analog Intelligence ^& Decision Analysis Platform
echo.
echo ========================================================================
echo.

:: =========================================================
:: TIER 1 — Try Node.js (best experience: live dev server)
:: =========================================================
set "NODE_FOUND=0"

where node >nul 2>nul
if %errorlevel% equ 0 (
    set "NODE_FOUND=1"
    goto :run_node
)

:: Try common fallback locations
for %%P in (
    "%USERPROFILE%\.local\nodejs"
    "C:\Program Files\nodejs"
    "C:\Program Files (x86)\nodejs"
    "%LOCALAPPDATA%\Programs\nodejs"
    "%APPDATA%\nvm\current"
) do (
    if exist "%%~P\node.exe" (
        set "PATH=%%~P;%PATH%"
        set "NODE_FOUND=1"
        goto :run_node
    )
)

:: =========================================================
:: TIER 2 — Try Python (serves pre-built dist\ folder)
:: =========================================================
set "PYTHON_FOUND=0"
set "PYTHON_CMD="

where python >nul 2>nul
if %errorlevel% equ 0 (
    set "PYTHON_CMD=python"
    set "PYTHON_FOUND=1"
    goto :run_python
)

where python3 >nul 2>nul
if %errorlevel% equ 0 (
    set "PYTHON_CMD=python3"
    set "PYTHON_FOUND=1"
    goto :run_python
)

for %%P in (
    "%LOCALAPPDATA%\Programs\Python\Python312"
    "%LOCALAPPDATA%\Programs\Python\Python311"
    "%LOCALAPPDATA%\Programs\Python\Python310"
    "%LOCALAPPDATA%\Programs\Python\Python39"
    "C:\Python312"
    "C:\Python311"
    "C:\Python310"
) do (
    if exist "%%~P\python.exe" (
        set "PYTHON_CMD=%%~P\python.exe"
        set "PYTHON_FOUND=1"
        goto :run_python
    )
)

:: =========================================================
:: TIER 3 — No runtime at all: just open dist\index.html
:: =========================================================
echo [NOTICE] Node.js and Python were not found on this machine.
echo.
echo Falling back: opening the pre-built application directly in your browser.
echo NOTE: Some features that fetch external data may be limited without a server.
echo.
if exist "dist\index.html" (
    echo Opening dist\index.html in your default browser...
    start "" "dist\index.html"
    echo.
    echo The application should open in your browser now.
    echo If nothing opens, manually open this file:
    echo   %~dp0dist\index.html
) else (
    echo [ERROR] No pre-built dist\ folder found either.
    echo.
    echo To run this application you need ONE of:
    echo   A) Node.js ^(recommended^) — https://nodejs.org/   then re-run launch.bat
    echo   B) Python 3                 — https://python.org/  then re-run launch.bat
    echo.
)
echo.
pause
exit /b 0


:: =========================================================
:run_node
:: =========================================================
for /f "tokens=*" %%v in ('node -v 2^>nul') do set "NODE_VERSION=%%v"
for /f "tokens=*" %%v in ('npm -v 2^>nul')  do set "NPM_VERSION=%%v"

echo [1/4] Node.js detected: %NODE_VERSION% / npm v%NPM_VERSION%
echo.

if not exist "node_modules\" (
    echo [2/4] First run — installing dependencies (this takes ~30 seconds)...
    call npm install
    if !errorlevel! neq 0 (
        echo.
        echo [ERROR] npm install failed. Check your internet connection and try again.
        pause
        exit /b 1
    )
    echo       Done!
) else (
    echo [2/4] Dependencies already installed.
)
echo.

echo [3/4] Starting development server on http://localhost:5173/ ...
echo [4/4] Opening your default browser...
echo.
echo ========================================================================
echo   Server is RUNNING. Press Ctrl+C in this window to stop.
echo   URL: http://localhost:5173/
echo ========================================================================
echo.

:: Launch browser immediately (server takes ~2s to start; browser will retry)
start "" "http://localhost:5173/"

:: Start Vite (--open launches browser again once ready, so user gets it for sure)
call npm run dev

if !errorlevel! neq 0 (
    echo.
    echo Server stopped.
    pause
)
exit /b 0


:: =========================================================
:run_python
:: =========================================================
echo [INFO] Node.js not found. Using Python to serve the pre-built app.
echo.

if not exist "dist\index.html" (
    echo [ERROR] No pre-built dist\ folder found.
    echo         Please install Node.js from https://nodejs.org/ and re-run launch.bat.
    echo         Node.js is needed to build the application the first time.
    pause
    exit /b 1
)

echo [1/2] Python detected. Serving pre-built dist\ folder on http://localhost:8080/ ...
echo [2/2] Opening your default browser...
echo.
echo ========================================================================
echo   Server is RUNNING. Press Ctrl+C in this window to stop.
echo   URL: http://localhost:8080/
echo ========================================================================
echo.

:: Small delay then open browser
start /b cmd /c "timeout /t 2 /nobreak >nul & start """" ""http://localhost:8080/"""

:: Serve the dist folder
cd dist
%PYTHON_CMD% -m http.server 8080

cd ..
pause
exit /b 0
