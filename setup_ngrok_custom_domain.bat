@echo off
echo ========================================
echo   Setup ngrok Custom Domain (Paid)
echo ========================================
echo.
echo This requires ngrok paid plan ($8/month)
echo.
echo If you haven't upgraded yet:
echo 1. Go to: https://dashboard.ngrok.com/billing
echo 2. Upgrade to paid plan
echo 3. Reserve a domain in dashboard
echo.
pause

REM Check if ngrok is installed
ngrok version >nul 2>&1
if errorlevel 1 (
    echo ERROR: ngrok is not installed!
    pause
    exit /b 1
)

echo.
echo Enter your reserved domain name:
echo (e.g., churn-prediction.ngrok-free.app)
echo.
set /p DOMAIN="Domain name: "

if "%DOMAIN%"=="" (
    echo ERROR: No domain entered!
    pause
    exit /b 1
)

echo.
echo Creating ngrok config file...
echo.

REM Create config directory if it doesn't exist
if not exist "%USERPROFILE%\AppData\Local\ngrok" (
    mkdir "%USERPROFILE%\AppData\Local\ngrok"
)

REM Create or update config file
(
echo version: "2"
echo authtoken: YOUR_TOKEN_HERE
echo tunnels:
echo   web:
echo     addr: 5000
echo     proto: http
echo     domain: %DOMAIN%
) > "%USERPROFILE%\AppData\Local\ngrok\ngrok.yml"

echo.
echo ========================================
echo   Config Created!
echo ========================================
echo.
echo Config file: %USERPROFILE%\AppData\Local\ngrok\ngrok.yml
echo.
echo IMPORTANT: Edit the config file and:
echo 1. Replace YOUR_TOKEN_HERE with your actual authtoken
echo 2. Make sure domain name is correct: %DOMAIN%
echo.
echo Then start with: ngrok start web
echo.
pause


