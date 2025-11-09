@echo off
cls
echo ========================================
echo   CHURN PREDICTION WEBSITE - STARTUP
echo ========================================
echo.

REM Change to script directory
cd /d "%~dp0"
echo Working in: %CD%
echo.

REM Step 1: Check Python
echo [1/4] Checking Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo    ERROR: Python not found!
    echo    Please install Python first.
    pause
    exit /b 1
)
python --version
echo    OK
echo.

REM Step 2: Check Flask
echo [2/4] Checking Flask...
python -c "import flask" >nul 2>&1
if errorlevel 1 (
    echo    ERROR: Flask not installed!
    echo    Installing Flask...
    python -m pip install Flask
    if errorlevel 1 (
        echo    ERROR: Failed to install Flask!
        pause
        exit /b 1
    )
)
echo    OK
echo.

REM Step 3: Check Model
echo [3/4] Checking model files...
if not exist "models\knn_model.pkl" (
    echo    Model not found. Training model...
    python train_model.py
    if errorlevel 1 (
        echo    ERROR: Failed to train model!
        pause
        exit /b 1
    )
    echo    Model trained successfully!
) else (
    echo    Model found - OK
)
echo.

REM Step 4: Start Server
echo [4/4] Starting server...
echo.
echo ========================================
echo   SERVER STARTING...
echo ========================================
echo.
echo   IMPORTANT: Wait for this message:
echo   "* Running on http://127.0.0.1:5000"
echo.
echo   Local access (this computer):
echo   http://localhost:5000
echo.
echo   Network access (phone/other devices):
echo   - Check the IP address shown when server starts
echo   - Use: http://YOUR_IP:5000
echo   - Make sure phone is on same WiFi!
echo.
echo   KEEP THIS WINDOW OPEN!
echo   Press Ctrl+C to stop the server
echo ========================================
echo.
echo Starting now...
echo.

python app.py

echo.
echo ========================================
echo   Server stopped.
echo ========================================
pause

