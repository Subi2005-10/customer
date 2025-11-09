@echo off
echo ====================================
echo Installing Dependencies
echo ====================================
echo.

REM Try to upgrade pip first
echo Step 1: Upgrading pip...
python -m pip install --upgrade pip
echo.

REM Install packages one by one to identify any issues
echo Step 2: Installing packages one by one...
echo.

echo Installing Flask...
python -m pip install Flask==3.0.0
if errorlevel 1 (
    echo WARNING: Flask installation had issues, trying without version...
    python -m pip install Flask
)
echo.

echo Installing pandas...
python -m pip install pandas==2.1.3
if errorlevel 1 (
    echo WARNING: pandas installation had issues, trying without version...
    python -m pip install pandas
)
echo.

echo Installing scikit-learn...
python -m pip install scikit-learn==1.3.2
if errorlevel 1 (
    echo WARNING: scikit-learn installation had issues, trying without version...
    python -m pip install scikit-learn
)
echo.

echo Installing numpy...
python -m pip install numpy==1.24.3
if errorlevel 1 (
    echo WARNING: numpy installation had issues, trying without version...
    python -m pip install numpy
)
echo.

echo Installing Werkzeug...
python -m pip install Werkzeug==3.0.1
if errorlevel 1 (
    echo WARNING: Werkzeug installation had issues, trying without version...
    python -m pip install Werkzeug
)
echo.

echo Installing joblib...
python -m pip install joblib==1.3.2
if errorlevel 1 (
    echo WARNING: joblib installation had issues, trying without version...
    python -m pip install joblib
)
echo.

echo ====================================
echo Installation complete!
echo ====================================
echo.
echo Verifying installations...
python -c "import flask; print('Flask: OK')"
python -c "import pandas; print('pandas: OK')"
python -c "import sklearn; print('scikit-learn: OK')"
python -c "import numpy; print('numpy: OK')"
python -c "import werkzeug; print('Werkzeug: OK')"
python -c "import joblib; print('joblib: OK')"
echo.
pause



