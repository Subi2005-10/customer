@echo off
echo ====================================
echo Starting Customer Churn Website
echo ====================================
echo.

REM Change to the script's directory
cd /d "%~dp0"

echo Current directory: %CD%
echo.

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    echo Please make sure Python is installed and in PATH.
    pause
    exit /b 1
)

echo Python found!
echo.

REM Check if model exists
if not exist "models\knn_model.pkl" (
    echo Model not found. Training model...
    echo.
    python train_model.py
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to train model!
        echo Please check the error message above.
        pause
        exit /b 1
    )
    echo.
    echo Model trained successfully!
    echo.
) else (
    echo Model already exists. Skipping training...
    echo.
)

echo Starting Flask server...
echo.
echo ====================================
echo IMPORTANT: Wait for "Running on..." message!
echo ====================================
echo.
echo Server will be available at:
echo   http://localhost:5000
echo   http://127.0.0.1:5000
echo.
echo ====================================
echo.
echo Starting server now...
echo Look for: "* Running on http://127.0.0.1:5000"
echo.
echo KEEP THIS WINDOW OPEN while using the website!
echo Press Ctrl+C to stop the server
echo.
echo ====================================
echo.
python app.py
if errorlevel 1 (
    echo.
    echo ====================================
    echo ERROR: Server failed to start!
    echo ====================================
    echo.
    echo Check the error message above.
    echo.
    echo Common issues:
    echo - Model files missing: Run python train_model.py
    echo - Port 5000 in use: Close other programs using port 5000
    echo - Python error: Check error message above
    echo.
    pause
)

pause


