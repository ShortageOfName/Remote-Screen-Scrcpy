# Remote-Screen-Scrcpy

A simple **wireless screen mirroring tool** for Android devices using **scrcpy** and **ADB**.  
Mirror your Android device to a PC over Wi-Fi without keeping the USB cable connected.

---

## Features

- Mirror Android device to PC over Wi-Fi.
- Launch scrcpy with the device screen off while keeping it awake.
- Automatic detection of device IP for Wi-Fi connection.
- Simple one-click batch script for setup.
- Works with Windows (tested on Windows 10/11).

---

## How to Use

1. Connect your Android device via **USB**.
2. Enable **USB debugging** in Developer Options.
3. Run `main mirror.bat`.
4. The script will:
   - Detect your device over USB.
   - Get the Wi-Fi IP of your phone.
   - Enable **ADB TCP/IP mode**.
   - Disconnect USB.
   - Connect over Wi-Fi and launch scrcpy.
5. Enjoy wireless screen mirroring with your device screen turned off but device awake.

---

## Optional scrcpy Flags

- `--turn-screen-off` – Turns off device screen while mirroring.
- `--stay-awake` – Prevents device from sleeping.
- `--max-size 1080` – Limits resolution to 1080p for smoother streaming.
- `--bit-rate 8M` – Sets video bitrate (higher = better quality, more network usage).

---

## Notes

- Make sure both your PC and phone are on the **same Wi-Fi network**.
- If the script fails to detect the phone, reconnect via USB and ensure **ADB drivers** are installed.
- Tested on Windows 10/11 (home/pro).

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE.txt) file for details.
