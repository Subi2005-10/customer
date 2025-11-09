@echo off
echo ========================================
echo   Testing Flask + ngrok Connection
echo ========================================
echo.

cd /d "%~dp0"

echo Step 1: Checking if Flask server is running...
netstat -ano | findstr :5000 >nul 2>&1
if errorlevel 1 (
    echo ❌ Flask server is NOT running on port 5000
    echo.
    echo SOLUTION: Start Flask server first!
    echo Run: python app.py
    echo OR double-click: start_website.bat
    echo.
    pause
    exit /b 1
) else (
    echo ✅ Flask server is running on port 5000
)

echo.
echo Step 2: Testing Flask server locally...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:5000' -TimeoutSec 5 -UseBasicParsing -ErrorAction Stop; Write-Host '✅ Flask server responds! Status:' $response.StatusCode } catch { Write-Host '❌ Flask server not responding:' $_.Exception.Message }"

echo.
echo Step 3: Checking if ngrok is running...
tasklist | findstr /i ngrok >nul 2>&1
if errorlevel 1 (
    echo ❌ ngrok is NOT running
    echo.
    echo SOLUTION: Start ngrok!
    echo Run: ngrok http 5000
    echo OR double-click: URLngrok.bat
    echo.
) else (
    echo ✅ ngrok is running
)

echo.
echo ========================================
echo   Test Complete
echo ========================================
echo.
echo If Flask is running but URL doesn't work:
echo 1. Make sure you're using the URL from ngrok window
echo 2. Make sure you're using HTTPS URL (not HTTP)
echo 3. Wait 10 seconds after starting ngrok
echo 4. Try restarting ngrok
echo.
pause

