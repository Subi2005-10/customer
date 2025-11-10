@echo off
echo ========================================
echo   ngrok Error Troubleshooting
echo ========================================
echo.

echo Checking ngrok installation...
ngrok version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ERROR: ngrok is not found!
    echo.
    echo Solutions:
    echo 1. Make sure ngrok.exe is downloaded
    echo 2. Add ngrok to PATH, OR
    echo 3. Use full path: C:\path\to\ngrok.exe http 5000
    echo.
    echo Download ngrok from: https://ngrok.com/download
    echo.
    pause
    exit /b 1
)

echo ngrok is installed
echo.

echo Checking if authtoken is configured...
ngrok config check >nul 2>&1
if errorlevel 1 (
    echo.
    echo WARNING: Authtoken might not be configured
    echo.
    echo To fix:
    echo 1. Sign up at: https://dashboard.ngrok.com/signup
    echo 2. Get your authtoken from dashboard
    echo 3. Run: ngrok config add-authtoken YOUR_TOKEN
    echo.
)

echo Checking if port 5000 is available...
netstat -ano | findstr :5000 >nul 2>&1
if errorlevel 1 (
    echo Port 5000 is available
) else (
    echo WARNING: Port 5000 is in use
    echo Make sure Flask server is running on port 5000
)

echo.
echo ========================================
echo   Common ngrok Errors and Fixes
echo ========================================
echo.
echo ERROR: "ngrok: command not found"
echo FIX: Add ngrok to PATH or use full path
echo.
echo ERROR: "authtoken not found" or "You must pass a single argument"
echo FIX: Run: ngrok config add-authtoken YOUR_TOKEN
echo.
echo ERROR: "bind: address already in use"
echo FIX: Another ngrok instance is running. Close it first.
echo.
echo ERROR: "failed to start tunnel"
echo FIX: Check if Flask server is running on port 5000
echo.
echo ERROR: "dial tcp: lookup ngrok.com"
echo FIX: Check internet connection
echo.
pause



