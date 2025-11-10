@echo off
echo ========================================
echo   Configure ngrok Authtoken
echo ========================================
echo.
echo This will help you configure your ngrok authtoken.
echo.
echo Step 1: Get your authtoken
echo   - Go to: https://dashboard.ngrok.com/signup
echo   - Sign up (free) if you haven't
echo   - Go to: https://dashboard.ngrok.com/get-started/your-authtoken
echo   - Copy your authtoken
echo.
echo Step 2: Paste your authtoken below
echo.
set /p TOKEN="Enter your ngrok authtoken: "

if "%TOKEN%"=="" (
    echo.
    echo ERROR: No token entered!
    pause
    exit /b 1
)

echo.
echo Configuring ngrok with your token...
ngrok config add-authtoken %TOKEN%

if errorlevel 1 (
    echo.
    echo ERROR: Failed to configure token!
    echo.
    echo Make sure:
    echo - You copied the entire token (no spaces)
    echo - ngrok is installed
    echo - You have internet connection
    echo.
) else (
    echo.
    echo ========================================
    echo   SUCCESS! Authtoken configured!
    echo ========================================
    echo.
    echo You can now use: ngrok http 5000
    echo.
)

pause



