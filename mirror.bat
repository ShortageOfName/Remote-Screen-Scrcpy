@echo off
title SCRCPY Wireless Launcher
color 0A
echo ==========================================
echo          SCRCPY Wireless Launcher
echo ==========================================
echo.

:: Step 1: Check if adb exists
where adb >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] ADB not found! Please install platform-tools and add to PATH.
    pause
    exit /b
)

:: Step 2: Check if scrcpy exists
where scrcpy >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] scrcpy not found! Please install scrcpy and add to PATH.
    pause
    exit /b
)

:: Step 3: Check USB device connection
echo [INFO] Checking for USB device...
adb devices | findstr "device$" >nul
if %errorlevel% neq 0 (
    echo [ERROR] No device detected! Please connect via USB with USB debugging enabled.
    pause
    exit /b
)
echo [OK] USB device detected.

:: Step 4: Get phone Wi-Fi IP
for /f "tokens=9" %%a in ('adb shell ip route ^| findstr "wlan0"') do set PHONE_IP=%%a

if "%PHONE_IP%"=="" (
    echo [ERROR] Could not detect Wi-Fi IP. Make sure Wi-Fi is ON and connected.
    pause
    exit /b
)

echo [OK] Phone Wi-Fi IP detected: %PHONE_IP%

:: Step 5: Enable TCP/IP mode
echo [INFO] Enabling TCP/IP mode on port 5555...
adb tcpip 5555 >nul
if %errorlevel% neq 0 (
    echo [ERROR] Failed to set TCP/IP mode.
    pause
    exit /b
)
echo [OK] ADB set to TCP/IP mode (port 5555)

:: Step 6: Disconnect USB
echo [INFO] Disconnecting USB ADB...
adb disconnect >nul

:: Step 7: Connect over Wi-Fi
echo [INFO] Connecting to %PHONE_IP%:5555 ...
adb connect %PHONE_IP%:5555
if %errorlevel% neq 0 (
    echo [ERROR] Could not connect over Wi-Fi. Ensure phone & PC are on same network.
    pause
    exit /b
)
echo [OK] Successfully connected to %PHONE_IP%

:: Step 8: Launch scrcpy with options
echo [INFO] Launching scrcpy...
scrcpy --turn-screen-off --stay-awake --max-size 1080 --bit-rate 8M
echo.
echo ==========================================
echo      SCRCPY Wireless session started!
echo Close this window to exit scrcpy session.
echo ==========================================
pause >nul
