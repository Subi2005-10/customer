@echo off
setlocal enabledelayedexpansion
echo ========================================
echo   Starting Flask Server AND ngrok
echo ========================================
echo.
echo This will start both services for you!
echo.
echo IMPORTANT: You need TWO terminal windows:
echo   1. Flask server (this window)
echo   2. ngrok tunnel (will open automatically)
echo.
echo ========================================
echo.

REM Change to script directory
cd /d "%~dp0"

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    echo Please install Python first.
    pause
    exit /b 1
)

REM Check if ngrok is available
ngrok version >nul 2>&1
if errorlevel 1 (
    echo ERROR: ngrok not found!
    echo Please install ngrok first.
    echo Download from: https://ngrok.com/download
    pause
    exit /b 1
)

echo Checking if Flask server is already running...
netstat -ano | findstr :5000 >nul 2>&1
if not errorlevel 1 (
    echo.
    echo WARNING: Something is already running on port 5000!
    echo.
    echo Choose an option:
    echo   1. Stop the existing process and start fresh
    echo   2. Keep existing process and just start ngrok
    echo   3. Cancel
    echo.
    set /p choice="Enter choice (1/2/3): "
    
    if "!choice!"=="1" (
        echo.
        echo Stopping process on port 5000...
        for /f "tokens=5" %%a in ('netstat -ano ^| findstr :5000 ^| findstr LISTENING') do (
            taskkill /F /PID %%a >nul 2>&1
        )
        timeout /t 2 >nul
        echo Process stopped.
    ) else if "!choice!"=="2" (
        echo.
        echo Starting ngrok in new window...
        start "ngrok Tunnel" cmd /k "cd /d %CD% && ngrok http 5000"
        echo.
        echo ========================================
        echo   ngrok started in new window!
        echo ========================================
        echo.
        echo Check the ngrok window for your new URL.
        echo The URL will be different from the old one.
        echo.
        pause
        exit /b 0
    ) else (
        echo Cancelled.
        exit /b 0
    )
)

echo.
echo ========================================
echo   Step 1: Starting Flask Server
echo ========================================
echo.

REM Check if model exists
if not exist "models\knn_model.pkl" (
    echo Model not found. Training model first...
    echo.
    python train_model.py
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to train model!
        pause
        exit /b 1
    )
    echo.
    echo Model trained successfully!
    echo.
)

echo Starting Flask server...
echo.
echo ========================================
echo   IMPORTANT: Wait 5 seconds for server to start
echo ========================================
echo.

REM Start Flask server in background
start /B python app.py

REM Wait for server to start
echo Waiting for Flask server to start...
timeout /t 5 >nul

REM Check if server started
netstat -ano | findstr :5000 >nul 2>&1
if errorlevel 1 (
    echo.
    echo ERROR: Flask server failed to start!
    echo Please check for errors above.
    pause
    exit /b 1
)

echo Flask server is running on port 5000!
echo.

echo ========================================
echo   Step 2: Starting ngrok Tunnel
echo ========================================
echo.

REM Start ngrok in a new window
echo Opening ngrok in a new window...
start "ngrok Tunnel - Copy URL from here!" cmd /k "cd /d %CD% && echo ======================================== && echo   NGROK TUNNEL ACTIVE && echo ======================================== && echo. && echo Your NEW ngrok URL will appear below: && echo. && echo Look for the line starting with: && echo   Forwarding    https://xxxx-xxxx.ngrok-free.app && echo. && echo COPY THAT URL - it's different from the old one! && echo. && echo Press Ctrl+C to stop ngrok && echo ======================================== && echo. && ngrok http 5000"

echo.
echo ========================================
echo   SUCCESS! Both services are starting
echo ========================================
echo.
echo 1. Flask server is running (this window)
echo 2. ngrok tunnel is starting in a NEW window
echo.
echo CHECK THE NGROK WINDOW for your NEW URL!
echo.
echo IMPORTANT NOTES:
echo - Your NEW URL will be DIFFERENT from the old one
echo - Free ngrok URLs change every time you restart
echo - The old URL (bettina-inventional-nominally.ngrok-free.dev) is no longer valid
echo - Copy the NEW URL from the ngrok window
echo.
echo Keep BOTH windows open while using the website!
echo.
echo Press any key to see Flask server logs (or close this window to stop Flask)...
pause >nul

