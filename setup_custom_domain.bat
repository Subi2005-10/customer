@echo off
echo ====================================
echo Setting up Custom Domain
echo ====================================
echo.
echo This will allow you to access the website at:
echo   http://churn-prediction
echo   http://churnprediction
echo.
echo You need Administrator privileges for this.
echo.
pause

REM Check for admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: This script requires Administrator privileges!
    echo.
    echo Please right-click this file and select "Run as administrator"
    pause
    exit /b 1
)

echo Adding custom domain to hosts file...
echo.

REM Backup hosts file
copy "%SystemRoot%\System32\drivers\etc\hosts" "%SystemRoot%\System32\drivers\etc\hosts.backup" >nul 2>&1

REM Check if entry already exists
findstr /C:"churn-prediction" "%SystemRoot%\System32\drivers\etc\hosts" >nul 2>&1
if %errorlevel% equ 0 (
    echo Custom domain already exists in hosts file.
    echo.
) else (
    REM Add entries to hosts file
    echo Adding entries...
    echo 127.0.0.1    churn-prediction >> "%SystemRoot%\System32\drivers\etc\hosts"
    echo 127.0.0.1    churnprediction >> "%SystemRoot%\System32\drivers\etc\hosts"
    echo.
    echo Successfully added custom domain!
    echo.
)

echo ====================================
echo Setup Complete!
echo ====================================
echo.
echo You can now access the website at:
echo   http://churn-prediction:5000
echo   http://churnprediction:5000
echo.
echo Note: You still need to include the port number :5000
echo.
pause

