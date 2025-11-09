@echo off
echo ========================================
echo   DIAGNOSING: Why URL is Not Working
echo ========================================
echo.

cd /d "%~dp0"

echo Checking system status...
echo.

REM Check Flask server
echo [1/4] Checking Flask server on port 5000...
netstat -ano | findstr :5000 >nul 2>&1
if errorlevel 1 (
    echo    ❌ Flask server is NOT running
    echo    This is the PROBLEM!
    set FLASK_RUNNING=0
) else (
    echo    ✅ Flask server is running
    set FLASK_RUNNING=1
)

REM Check Python processes
echo [2/4] Checking Python processes...
tasklist | findstr /i python >nul 2>&1
if errorlevel 1 (
    echo    ❌ No Python process found
    set PYTHON_RUNNING=0
) else (
    echo    ✅ Python process found
    tasklist | findstr /i python
    set PYTHON_RUNNING=1
)

REM Check ngrok process
echo [3/4] Checking ngrok process...
tasklist | findstr /i ngrok >nul 2>&1
if errorlevel 1 (
    echo    ❌ ngrok is NOT running
    set NGROK_RUNNING=0
) else (
    echo    ✅ ngrok is running
    tasklist | findstr /i ngrok
    set NGROK_RUNNING=1
)

REM Test localhost
echo [4/4] Testing Flask server on localhost:5000...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:5000' -TimeoutSec 3 -UseBasicParsing -ErrorAction Stop; Write-Host '    ✅ Flask server responds (Status: ' $response.StatusCode ')' } catch { Write-Host '    ❌ Flask server not responding: ' $_.Exception.Message }" 2>nul
echo.

echo ========================================
echo   DIAGNOSIS COMPLETE
echo ========================================
echo.

if %FLASK_RUNNING%==0 (
    echo ⚠️  MAIN PROBLEM: Flask server is NOT running!
    echo.
    echo This is why your ngrok URL doesn't work.
    echo ngrok is trying to forward to port 5000, but nothing is there.
    echo.
    echo SOLUTION: Start Flask server first!
    echo.
    echo Would you like to start Flask server now? (Y/N)
    set /p start_flask="> "
    if /i "%start_flask%"=="Y" (
        echo.
        echo Starting Flask server...
        echo.
        echo Checking if model exists...
        if not exist "models\knn_model.pkl" (
            echo Model not found. Training model first...
            python train_model.py
            if errorlevel 1 (
                echo ERROR: Failed to train model!
                pause
                exit /b 1
            )
        )
        echo.
        echo Starting Flask server in a new window...
        echo KEEP THAT WINDOW OPEN!
        echo.
        start "Flask Server - MUST KEEP OPEN!" cmd /k "cd /d %CD% && echo ======================================== && echo   FLASK SERVER STARTING && echo ======================================== && echo. && echo Wait for: * Running on http://127.0.0.1:5000 && echo. && echo KEEP THIS WINDOW OPEN! && echo. && echo ======================================== && echo. && python app.py"
        
        echo.
        echo Waiting 10 seconds for Flask server to start...
        timeout /t 10 >nul
        
        echo.
        echo Testing Flask server again...
        timeout /t 2 >nul
        netstat -ano | findstr :5000 >nul 2>&1
        if errorlevel 1 (
            echo.
            echo ⚠️  Flask server might not have started yet.
            echo Check the Flask server window for errors.
            echo.
        ) else (
            echo.
            echo ✅ Flask server is now running!
            echo.
            if %NGROK_RUNNING%==1 (
                echo ✅ ngrok is already running!
                echo.
                echo ========================================
                echo   EVERYTHING SHOULD WORK NOW!
                echo ========================================
                echo.
                echo 1. Flask server is running
                echo 2. ngrok is running
                echo 3. Check the ngrok window for your URL
                echo 4. Try the URL in your browser again
                echo.
                echo If it still doesn't work:
                echo - Make sure you're using the URL from ngrok window
                echo - Wait a few more seconds for Flask to fully start
                echo - Check Flask window for any error messages
                echo.
            ) else (
                echo.
                echo ⚠️  ngrok is NOT running.
                echo.
                echo Would you like to start ngrok now? (Y/N)
                set /p start_ngrok="> "
                if /i "%start_ngrok%"=="Y" (
                    echo.
                    echo Starting ngrok...
                    start "ngrok Tunnel - COPY URL FROM HERE!" cmd /k "cd /d %CD% && echo. && echo ======================================== && echo   NGROK TUNNEL && echo ======================================== && echo. && echo Your URL will appear below: && echo Look for: Forwarding https://xxxx-xxxx.ngrok-free.app && echo. && echo COPY THAT URL! && echo. && echo ======================================== && echo. && ngrok http 5000"
                    echo.
                    echo ngrok is starting in a new window.
                    echo Wait 5 seconds, then copy the URL from that window.
                    echo.
                )
            )
        )
    )
) else (
    echo ✅ Flask server is running!
    echo.
    if %NGROK_RUNNING%==0 (
        echo ⚠️  ngrok is NOT running!
        echo.
        echo Would you like to start ngrok now? (Y/N)
        set /p start_ngrok="> "
        if /i "%start_ngrok%"=="Y" (
            echo.
            echo Starting ngrok...
            start "ngrok Tunnel - COPY URL FROM HERE!" cmd /k "cd /d %CD% && echo. && echo ======================================== && echo   NGROK TUNNEL && echo ======================================== && echo. && echo Your URL will appear below: && echo Look for: Forwarding https://xxxx-xxxx.ngrok-free.app && echo. && echo COPY THAT URL! && echo. && echo ======================================== && echo. && ngrok http 5000"
            echo.
            echo ngrok is starting in a new window.
            echo Wait 5 seconds, then copy the URL from that window.
            echo.
        )
    ) else (
        echo ✅ ngrok is running!
        echo.
        echo ========================================
        echo   BOTH SERVICES ARE RUNNING
        echo ========================================
        echo.
        echo If URL still doesn't work, try:
        echo.
        echo 1. Restart ngrok to get a fresh connection
        echo    - Close ngrok window
        echo    - Run: ngrok http 5000
        echo    - Copy the NEW URL
        echo.
        echo 2. Test localhost first:
        echo    - Open: http://localhost:5000
        echo    - If this doesn't work, Flask has a problem
        echo.
        echo 3. Check for errors:
        echo    - Look at Flask server window for errors
        echo    - Look at ngrok window for errors
        echo.
        echo 4. Make sure you're using the HTTPS URL:
        echo    - Use: https://xxxx-xxxx.ngrok-free.app
        echo    - NOT: http://xxxx-xxxx.ngrok-free.app
        echo.
        echo 5. Wait a few seconds after starting:
        echo    - Flask needs time to start
        echo    - ngrok needs time to connect
        echo.
    )
)

echo.
echo ========================================
echo   TROUBLESHOOTING TIPS
echo ========================================
echo.
echo Common issues and solutions:
echo.
echo 1. "Tunnel not found" or "offline"
echo    → Flask server is not running
echo    → Start Flask server first: python app.py
echo.
echo 2. "Connection refused"
echo    → Flask server crashed or stopped
echo    → Check Flask window for errors
echo    → Restart Flask server
echo.
echo 3. "502 Bad Gateway"
echo    → Flask server is starting up
echo    → Wait 10-15 seconds and try again
echo.
echo 4. "ngrok page shows but website doesn't load"
echo    → Click "Visit Site" button on ngrok page
echo    → This is normal for free ngrok accounts
echo.
echo 5. URL works on computer but not phone
echo    → Make sure you're using the HTTPS URL
echo    → Try the ngrok URL on your computer first
echo    → Check if firewall is blocking
echo.
echo Press any key to exit...
pause >nul

