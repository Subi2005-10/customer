@echo off
echo ========================================
echo   QUICK START: Flask + ngrok
echo ========================================
echo.
echo This script will help you start everything!
echo.
pause

REM Change to script directory
cd /d "%~dp0"

echo.
echo ========================================
echo   STEP 1: Checking Python
echo ========================================
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    echo Please install Python first.
    pause
    exit /b 1
)
echo OK: Python is installed
echo.

echo ========================================
echo   STEP 2: Checking ngrok
echo ========================================
ngrok version >nul 2>&1
if errorlevel 1 (
    echo ERROR: ngrok not found!
    echo Please install ngrok from: https://ngrok.com/download
    pause
    exit /b 1
)
echo OK: ngrok is installed
echo.

echo ========================================
echo   STEP 3: Checking Flask Server
echo ========================================
netstat -ano | findstr :5000 >nul 2>&1
if errorlevel 1 (
    echo Flask server is NOT running.
    echo Starting Flask server now...
    echo.
    
    REM Check if model exists
    if not exist "models\knn_model.pkl" (
        echo Training model first...
        python train_model.py
        if errorlevel 1 (
            echo ERROR: Failed to train model!
            pause
            exit /b 1
        )
    )
    
    echo.
    echo Starting Flask server in a new window...
    echo Keep that window open!
    echo.
    start "Flask Server - KEEP THIS OPEN!" cmd /k "cd /d %CD% && python app.py"
    
    echo Waiting 8 seconds for Flask server to start...
    timeout /t 8 >nul
    
    REM Check if server started
    netstat -ano | findstr :5000 >nul 2>&1
    if errorlevel 1 (
        echo.
        echo WARNING: Flask server might not have started yet.
        echo Check the Flask server window for errors.
        echo.
    ) else (
        echo OK: Flask server is running!
        echo.
    )
) else (
    echo OK: Flask server is already running!
    echo.
)

echo ========================================
echo   STEP 4: Starting ngrok
echo ========================================
echo.
echo Starting ngrok in a new window...
echo.
echo ========================================
echo   IMPORTANT: Copy the URL from ngrok window!
echo ========================================
echo.
echo The ngrok window will show your NEW URL.
echo It will look like: https://xxxx-xxxx.ngrok-free.app
echo.
echo COPY THAT URL - it's different from the old one!
echo.
pause

start "ngrok Tunnel - COPY URL FROM HERE!" cmd /k "cd /d %CD% && echo. && echo ======================================== && echo   NGROK TUNNEL ACTIVE && echo ======================================== && echo. && echo Your NEW ngrok URL is shown below: && echo. && echo Look for the line: Forwarding https://xxxx-xxxx.ngrok-free.app && echo. && echo COPY THAT URL! && echo. && echo The old URL (bettina-inventional-nominally.ngrok-free.dev) will NOT work. && echo. && echo Press Ctrl+C to stop ngrok && echo ======================================== && echo. && ngrok http 5000"

echo.
echo ========================================
echo   SUCCESS!
echo ========================================
echo.
echo 1. Flask server window is open (keep it open!)
echo 2. ngrok window is opening (copy the URL from there!)
echo.
echo NEXT STEPS:
echo 1. Look at the ngrok window
echo 2. Find the line with "Forwarding https://..."
echo 3. Copy that URL
echo 4. Paste it in your browser
echo.
echo Keep BOTH windows open while using the website!
echo.
echo Press any key to exit this window...
pause >nul

