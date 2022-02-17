# DFU Loader for XMOS based JDS Labs DACs
  This script was originally distributed as a component of the [XMOS USB Audio 2.0 Reference Software](http://www.xmos.com/products/development-kits/usbaudio2) Version 6.15.2, and has been modified to
  facilitate firmware updates via DFU mode for the following XMOS based JDS Labs, Inc. devices:
    - Atom DAC(+)
    - EL DAC II(+)
    - Element II
    - Element III

  A copy of the original AS-IS [License](https://github.com/jdslabs/xmos_dfu/blob/main/LICENSE.txt) is included within this repository.

# Usage in macOS

## Prerequisites
- Install XCode Command Line Tools, from a command line: `xcode-select --install`
- Install [Homebrew](https://brew.sh/)
- Install libusb: `brew install libusb`

1. Open a terminal in the `xmos_dfu` folder, then run the following command to compile. Warnings may be ignored:
```
make -f Makefile.OSX all
```

2. Next, run:
```
source setup.sh 
```

3. Make sure your DAC is connected by USB, then run the following command to verify the connection and current firmware version. Your DAC will appear as “VID = 0x20b1” or "VID = 0x152A:
```
./xmosdfu --listdevices
```

4. To flash new firmware, download the [desired .bin file](https://jdslabs.com/support/drivers/), then run the command below. *Only 1 DAC may be plugged in at a time!*
You will need to edit the path to reflect the full path of your downloaded firmware file (tip: select the downloaded file in Finder, then right click on its path in the bottom of the window and choose Copy <filename> as Pathname):
```
sudo ./xmosdfu --download /edit/this/path/Atom_DAC_Plus-v184-LockedVolume.bin
```

# Usage in Ubuntu 20.0.4
## Prerequisites
- Install libusb: `sudo apt-get install libusb-1.0-0-dev`

1. Open a terminal in the `xmos_dfu` folder, then run the following command to compile. Warnings may be ignored:
```
make -f Makefile.Linux all
```
2. Next, run:
```
source setup.sh 
```

3. Make sure your DAC is connected by USB, then run the following command to verify the connection and current firmware version. Your DAC will appear as “VID = 0x20b1” or "VID = 0x152A:
```
sudo ./xmosdfu --listdevices
```
4. To flash new firmware, download the desired file, then run the command below as `sudo`. *Only 1 DAC may be plugged in at a time!*
You will need to edit the path to reflect the full path of your downloaded firmware file:  
```
sudo ./xmosdfu --download /edit/this/path/Atom_DAC_Plus-v184-LockedVolume.bin
```