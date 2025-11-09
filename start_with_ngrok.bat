@echo off
echo ========================================
echo   Starting Website with ngrok
echo ========================================
echo.

REM Check if ngrok is installed
ngrok version >nul 2>&1
if errorlevel 1 (
    echo ERROR: ngrok is not installed or not in PATH!
    echo.
    echo Solutions:
    echo 1. Download ngrok from: https://ngrok.com/download
    echo 2. Extract ngrok.exe
    echo 3. Add to PATH OR place in project folder OR use full path
    echo.
    echo Quick fix - place ngrok.exe in this folder and run again
    echo Or install via: choco install ngrok
    echo.
    echo Running diagnostic...
    call fix_ngrok_error.bat
    pause
    exit /b 1
)

echo ngrok found!
echo.

REM Check if Flask server is running
netstat -ano | findstr :5000 >nul 2>&1
if errorlevel 1 (
    echo Flask server is NOT running!
    echo.
    echo Please start Flask server first:
    echo   1. Open another terminal
    echo   2. Run: python app.py
    echo   3. Wait for "Running on..." message
    echo   4. Then come back and run this script
    echo.
    pause
    exit /b 1
)

echo Flask server is running on port 5000
echo.

echo ========================================
echo   Starting ngrok tunnel...
echo ========================================
echo.

REM Check authtoken
ngrok config check >nul 2>&1
if errorlevel 1 (
    echo WARNING: Authtoken might not be configured!
    echo.
    echo To fix:
    echo 1. Sign up at: https://dashboard.ngrok.com/signup
    echo 2. Get authtoken from: https://dashboard.ngrok.com/get-started/your-authtoken
    echo 3. Run: ngrok config add-authtoken YOUR_TOKEN
    echo.
    echo Press any key to continue anyway, or Ctrl+C to cancel...
    pause >nul
)

echo Your website will be available at a URL like:
echo   https://xxxx-xxxx.ngrok-free.app
echo.
echo This URL will be shown below.
echo.
echo Press Ctrl+C to stop ngrok
echo (Flask server will keep running)
echo ========================================
echo.

ngrok http 5000
if errorlevel 1 (
    echo.
    echo ========================================
    echo ERROR: ngrok failed to start!
    echo ========================================
    echo.
    echo Common issues:
    echo - Authtoken not configured
    echo - Port 5000 not available
    echo - Network/firewall issue
    echo.
    echo Run fix_ngrok_error.bat for detailed diagnosis
    echo.
    pause
)

pause

