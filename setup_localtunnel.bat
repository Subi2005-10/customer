@echo off
echo ========================================
echo   Setup LocalTunnel (Free Custom URL)
echo ========================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js is not installed!
    echo.
    echo Please install Node.js first:
    echo 1. Download from: https://nodejs.org/
    echo 2. Install it
    echo 3. Restart terminal
    echo 4. Run this script again
    echo.
    pause
    exit /b 1
)

echo Node.js found!
node --version
echo.

REM Check if localtunnel is installed
lt --version >nul 2>&1
if errorlevel 1 (
    echo LocalTunnel is not installed. Installing...
    echo.
    npm install -g localtunnel
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to install LocalTunnel!
        echo Make sure you have internet connection.
        pause
        exit /b 1
    )
    echo.
    echo LocalTunnel installed successfully!
) else (
    echo LocalTunnel is already installed!
)
echo.

REM Check if Flask is running
netstat -ano | findstr :5000 >nul 2>&1
if errorlevel 1 (
    echo WARNING: Flask server is NOT running!
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
echo   Starting LocalTunnel...
echo ========================================
echo.
echo Enter your desired subdomain name:
echo (e.g., churn-prediction, my-churn, etc.)
echo.
set /p SUBDOMAIN="Subdomain name: "

if "%SUBDOMAIN%"=="" (
    echo Using random subdomain...
    lt --port 5000
) else (
    echo.
    echo Starting tunnel with subdomain: %SUBDOMAIN%
    echo Your URL will be: https://%SUBDOMAIN%.loca.lt
    echo.
    echo If subdomain is taken, try a different name.
    echo.
    lt --port 5000 --subdomain %SUBDOMAIN%
)

pause


