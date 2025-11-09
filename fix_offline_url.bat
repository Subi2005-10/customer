@echo off
setlocal enabledelayedexpansion

echo ========================================
echo   Diagnosing ngrok URL Offline Issue
echo ========================================
echo.

cd /d "%~dp0"

echo Checking system status...
echo.

REM Check Flask server
echo [1/3] Checking Flask server on port 5000...
netstat -ano | findstr :5000 >nul 2>&1
if errorlevel 1 (
    echo    ❌ Flask server is NOT running
    set FLASK_RUNNING=0
) else (
    echo    ✅ Flask server is running
    set FLASK_RUNNING=1
)

REM Check ngrok process
echo [2/3] Checking ngrok process...
tasklist | findstr /i ngrok >nul 2>&1
if errorlevel 1 (
    echo    ❌ ngrok is NOT running
    set NGROK_RUNNING=0
) else (
    echo    ✅ ngrok is running
    set NGROK_RUNNING=1
)

REM Check ngrok installation
echo [3/3] Checking ngrok installation...
ngrok version >nul 2>&1
if errorlevel 1 (
    echo    ❌ ngrok is NOT installed or not in PATH
    set NGROK_INSTALLED=0
) else (
    echo    ✅ ngrok is installed
    set NGROK_INSTALLED=1
)

echo.
echo ========================================
echo   Diagnosis Complete
echo ========================================
echo.

if !FLASK_RUNNING!==0 (
    echo PROBLEM: Flask server is not running
    echo.
    echo SOLUTION: Start Flask server first
    echo.
)

if !NGROK_RUNNING!==0 (
    echo PROBLEM: ngrok tunnel is not running
    echo.
    echo SOLUTION: Start ngrok tunnel after Flask server
    echo.
)

if !NGROK_INSTALLED!==0 (
    echo PROBLEM: ngrok is not installed
    echo.
    echo SOLUTION: Install ngrok from https://ngrok.com/download
    echo.
)

echo ========================================
echo   Why Your URL is Offline
echo ========================================
echo.
echo The URL https://bettina-inventional-nominally.ngrok-free.dev/
echo is showing as offline because:
echo.
echo 1. Free ngrok URLs are TEMPORARY
echo    - They only work while ngrok is running
echo    - They expire when ngrok stops
echo    - Each time you restart ngrok, you get a NEW URL
echo.
echo 2. Your Flask server or ngrok is not running
echo    - Both must be running for the URL to work
echo    - If either stops, the URL becomes offline
echo.
echo ========================================
echo   How to Fix (Quick Steps)
echo ========================================
echo.
echo OPTION 1: Use the automated script (EASIEST)
echo   1. Double-click: start_all.bat
echo   2. Wait for both windows to open
echo   3. Copy the NEW URL from ngrok window
echo.
echo OPTION 2: Manual start (TWO STEPS)
echo   STEP 1: Start Flask server
echo      - Double-click: start_website.bat
echo      - OR run: python app.py
echo      - Wait for "Running on..." message
echo.
echo   STEP 2: Start ngrok (in NEW terminal)
echo      - Double-click: URLngrok.bat
echo      - OR run: ngrok http 5000
echo      - Copy the NEW URL shown
echo.
echo ========================================
echo   Important Notes
echo ========================================
echo.
echo ✅ You will get a NEW URL each time
echo    - The old URL (bettina-inventional-nominally...) won't work anymore
echo    - Copy the NEW URL from the ngrok window
echo.
echo ✅ Keep BOTH windows open
echo    - Flask server window (keep running)
echo    - ngrok window (keep running)
echo.
echo ✅ Free ngrok URLs change every restart
echo    - This is normal behavior
echo    - Paid plans can have static URLs
echo.
echo ========================================
echo.

if !FLASK_RUNNING!==0 (
    echo Would you like to start Flask server now? (Y/N)
    set /p start_flask="> "
    if /i "!start_flask!"=="Y" (
        echo.
        echo Starting Flask server...
        start "Flask Server" cmd /k "cd /d %CD% && python app.py"
        echo.
        echo Flask server is starting in a new window.
        echo Wait 5 seconds, then start ngrok.
        timeout /t 5
    )
)

if !FLASK_RUNNING!==1 if !NGROK_RUNNING!==0 (
    echo Flask server is running! Would you like to start ngrok now? (Y/N)
    set /p start_ngrok="> "
    if /i "!start_ngrok!"=="Y" (
        echo.
        echo Starting ngrok...
        start "ngrok Tunnel" cmd /k "cd /d %CD% && ngrok http 5000"
        echo.
        echo ngrok is starting in a new window.
        echo Copy the NEW URL from that window!
    )
)

if !FLASK_RUNNING!==1 if !NGROK_RUNNING!==1 (
    echo Both services are running!
    echo.
    echo If your URL is still offline, try:
    echo 1. Restart ngrok to get a new URL
    echo 2. Check the ngrok window for the correct URL
    echo 3. Make sure you're using the URL from the ngrok window
    echo.
)

echo.
echo Press any key to exit...
pause >nul

