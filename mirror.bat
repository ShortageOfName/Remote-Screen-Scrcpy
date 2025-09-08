@echo off
echo ==============================
echo   SCRCPY Wireless Launcher
echo ==============================

:: Step 1: Check if device is connected via USB
adb devices | findstr "device$" >nul
if %errorlevel% neq 0 (
    echo [ERROR] No device detected! Please connect your phone via USB with USB debugging enabled.
    pause
    exit /b
)

:: Step 2: Get Wi-Fi IP before switching (from wlan0 only)
for /f "tokens=9" %%a in ('adb shell ip route ^| findstr "wlan0"') do set PHONE_IP=%%a

if "%PHONE_IP%"=="" (
    echo [ERROR] Could not detect Wi-Fi IP. Make sure Wi-Fi is ON and connected.
    pause
    exit /b
)

echo [OK] Detected phone Wi-Fi IP: %PHONE_IP%

:: Step 3: Enable TCP/IP mode
adb tcpip 5555
echo [OK] ADB set to TCP/IP mode (port 5555)

:: Step 4: Disconnect USB connection
adb disconnect

:: Step 5: Connect via Wi-Fi
adb connect %PHONE_IP%:5555
if %errorlevel% neq 0 (
    echo [ERROR] Could not connect over Wi-Fi. Make sure phone and PC are on same network.
    pause
    exit /b
)
echo [OK] Connected to %PHONE_IP%

:: Step 6: Launch scrcpy with screen OFF but device awake
scrcpy --turn-screen-off --stay-awake
