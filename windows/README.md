# Element IV Firmware Flasher for Windows

A command line alternative to the firmware upgrade tool at [core.jdslabs.com](https://core.jdslabs.com), bypassing WebUSB.

## Contents

- `flash-element4.bat` — Interactive firmware flashing script
- `xmosdfu.exe` — Precompiled XMOS DFU utility

## How It Works

The script fetches the full firmware catalog from the JDS Labs API at startup, including both stable and beta releases. Firmware binaries are downloaded on demand — no local firmware files are needed.

## Usage

1. Connect your Element IV via USB.
2. Double-click **`flash-element4.bat`** to open it.
3. Follow the on-screen prompts:

```
=============================================
   XMOS FIRMWARE FLASHER - Element IV
=============================================

1 - Flash Element IV - Latest v2.0.2
2 - Flash Element IV v1.5.1 (required for devices below v1.4.0)
3 - View Other Firmwares to Flash [20 available]
4 - View Current Firmware
5 - Revert to Factory Image
6 - EXIT
```

4. Type a number and press **Enter** to select an option.
5. Confirm with `y` when prompted. The process takes about a minute.
6. Option **3** lists all available firmware versions (stable and beta), allowing you to flash any version:

```
=============================================
   SELECT ANOTHER FIRMWARE VERSION
=============================================

 1 - v2.0.2 (latest stable)
 2 - v2.0.1 [BETA]
 3 - v1.7.6 [BETA]
 4 - v1.7.4
 ...
 B - Back to Main Menu
```

## Important: Firmware Below v1.4.0

If your Element IV is running firmware older than v1.4.0, you **must** flash **v1.5.1 first** (option 2), then flash the latest version. Attempting to jump directly to firmware above v1.5.3 from older versions will fail.

## Why use this tool?

Firmware updates for Element IV are normally performed through [core.jdslabs.com](https://core.jdslabs.com), which updates your device directly from the browser. This works reliably on macOS, Linux, and the vast majority of Windows PCs.

However, a small number of devices have been found to fail to upgrade beyond `v1.5.x`. This is believed to be a WinUSB driver limitation: some flash chips operate more slowly than others, leading to stalls and/or corruption in the upgrade slot. Firmware is designed to be failsafe: Your Element will boot to its write-protected factory version when corruption occurs in the upgrade slot. There are three possible solutions:

- Upgrade firmware through core.jdslabs.com using a macOS or Linux system.
- Reach out to jdslabs.com/support and we will replace the flash IC for you. We'll cover shipping both ways.
- Use this tool, which uses `libusb` instead of `WinUSB. This may or may not help.

## Dependencies

A pre-compiled `libusb-1.0.dll` (release 1.0.22) for Windows x64 is included from libusb and is licensed under LGPL v2.1. Source code is available at that repository.

https://github.com/libusb/libusb/releases/
