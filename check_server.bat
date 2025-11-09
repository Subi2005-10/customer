@echo off
echo ====================================
echo Checking Server Status
echo ====================================
echo.

echo Checking if Python is available...
python --version
if errorlevel 1 (
    echo ERROR: Python not found!
    pause
    exit /b 1
)
echo.

echo Checking if port 5000 is in use...
netstat -ano | findstr :5000
if errorlevel 1 (
    echo Port 5000 is available (server not running)
) else (
    echo Port 5000 is in use (server might be running)
)
echo.

echo Checking if model exists...
if exist "models\knn_model.pkl" (
    echo Model found: OK
) else (
    echo Model NOT found - need to train first!
)
echo.

echo ====================================
echo Troubleshooting Steps:
echo ====================================
echo.
echo 1. Make sure you started the server with: python app.py
echo 2. Look for this message: "Running on http://127.0.0.1:5000"
echo 3. Try these URLs in your browser:
echo    - http://localhost:5000
echo    - http://127.0.0.1:5000
echo.
echo 4. If server is not running, double-click start_website.bat
echo.
pause

