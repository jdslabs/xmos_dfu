# JDS Customized XMOS DFU Uploader
This CLI utility is derived from the XMOS DFU utility provided with reference XMOS Reference Audio Kit, per the attached License:
https://www.xmos.com/developer/software/usbaudio

# Usage in macOS

## Prerequisites
- Install XCode Command Line Tools, from a command line: `xcode-select --install`
- Install Homebrew: https://brew.sh/
- Install libusb: `brew install libusb`

1. Open a terminal in the `xmos_dfu` folder, then run the following command to compile. This returns 6 warnings in Big Sur, which may be ignored:
```
make -f Makefile.OSX all
```

2. Run the command:
```
source setup.sh 
```

3. Make sure your DAC is connected by USB, then run the following command to verify the connection and check the current firmware version. Your DAC will appear as “VID = 0x20b1” or "VID = 0x152A. *Only 1 DAC may be plugged in at a time!*:
```
./xmosdfu --listdevices
```
4. To flash new firmware, download the desired file, then run the command below. You will need to edit the path to reflect the full path of your downloaded firmware file ( select the downloaded file in Finder, then right click on its path in the bottom of the window and choose Copy <filename> as Pathname):
```
sudo ./xmosdfu --download /edit/this/path/Atom_DAC_Plus-v184-LockedVolume.bin
```

# Usage in Ubuntu 20.0.4
## Prerequisites
- Install libusb: `sudo apt-get install libusb-1.0-0-dev`

1. Open `xmosdfu.cpp` and comment out the macOS libusb file `#include "libusb.h"`, then uncomment the Linux/Ubuntu libusb, `#include <libusb-1.0/libusb.h>`. Save.
2. Open a terminal in the `xmos_dfu` folder, then run the following command to compile. This returns 5 warnings which may be ignored:
```
make -f Makefile.Linux all
```
3. In terminal, run the command:
```
source setup.sh 
```

4. Make sure your DAC is connected by USB, then run the following command to verify the connection and check the current firmware version. Your DAC will appear as “VID = 0x20b1” or "VID = 0x152A. *Only 1 DAC may be plugged in at a time!*:
```
sudo ./xmosdfu --listdevices
```
4. To flash new firmware, download the desired file, then run the command below as `sudo`. You will need to edit the path to reflect the full path of your downloaded firmware file (select the downloaded file in Finder, then right click on its path in the bottom of the window and choose Copy <filename> as Pathname):  
```
sudo ./xmosdfu --download /edit/this/path/Atom_DAC_Plus-v184-LockedVolume.bin
```