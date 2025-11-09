@echo off
echo ====================================
echo Customer Churn Prediction Website
echo ====================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH!
    echo.
    echo Please install Python from https://www.python.org/downloads/
    echo Make sure to check "Add Python to PATH" during installation.
    echo.
    echo Alternatively, try using:
    echo   py -m pip install -r requirements.txt
    echo   py train_model.py
    echo   py app.py
    echo.
    pause
    exit /b 1
)

echo Python found! Continuing...
echo.

echo Step 1: Installing dependencies...
echo.
echo Trying to install with specific versions first...
python -m pip install -r requirements.txt
if errorlevel 1 (
    echo.
    echo Specific versions failed. Trying with latest compatible versions...
    python -m pip install -r requirements_simple.txt
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to install dependencies!
        echo.
        echo Trying alternative method - installing packages one by one...
        echo Please run install_dependencies.bat for detailed installation
        echo.
        pause
        exit /b 1
    )
)
echo.

echo Step 2: Checking if model exists...
if not exist "models\knn_model.pkl" (
    echo Model not found. Training the model...
    python train_model.py
    if errorlevel 1 (
        echo ERROR: Failed to train model!
        pause
        exit /b 1
    )
) else (
    echo Model already exists. Skipping training...
)
echo.

echo Step 3: Starting Flask server...
echo.
echo ====================================
echo Server will be available at:
echo   http://localhost:5000
echo   http://127.0.0.1:5000
echo ====================================
echo.
echo Press Ctrl+C to stop the server
echo.
python app.py
pause

