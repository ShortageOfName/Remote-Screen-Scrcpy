@echo off
echo ==============================
echo   SCRCPY Wireless Launcher (Ultra Low-Lag + Auto Drag & Drop)
echo ==============================

:: -----------------------------
:: Step 1: Check USB connection
adb devices | findstr "device$" >nul
if %errorlevel% neq 0 (
    echo [ERROR] No device detected! Connect USB with debugging enabled.
    pause
    exit /b
)

:: -----------------------------
:: Step 2: Get phone Wi-Fi IP (wlan0 only)
for /f "tokens=9" %%a in ('adb shell ip route ^| findstr "wlan0"') do set PHONE_IP=%%a
if "%PHONE_IP%"=="" (
    echo [ERROR] Could not detect Wi-Fi IP.
    pause
    exit /b
)

echo [OK] Phone Wi-Fi IP: %PHONE_IP%

:: -----------------------------
:: Step 3: Enable TCP/IP mode
adb tcpip 5555
echo [OK] TCP/IP mode enabled
timeout /t 2 >nul

:: -----------------------------
:: Step 4: Disconnect USB
adb disconnect

:: -----------------------------
:: Step 5: Connect via Wi-Fi
adb connect %PHONE_IP%:5555
if %errorlevel% neq 0 (
    echo [ERROR] Could not connect over Wi-Fi.
    pause
    exit /b
)
echo [OK] Connected via Wi-Fi

:: -----------------------------
:: Step 6: Ensure target folder exists on phone
adb shell "mkdir -p /sdcard/Ashare"
echo [OK] Target folder /sdcard/Ashare ready

:: -----------------------------
:: Step 7: Launch scrcpy with ultra-low-lag settings and push-target
scrcpy -s %PHONE_IP%:5555 ^
 --turn-screen-off ^
 --stay-awake ^
 --max-size 800 ^
 --video-bit-rate 1500000 ^
 --max-fps 90 ^
 --push-target /sdcard/Ashare

