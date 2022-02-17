# DFU Loader for XMOS based JDS Labs DACs
This script was originally distributed as a component of the [XMOS USB Audio 2.0 Reference Software](http://www.xmos.com/products/development-kits/usbaudio2) Version 6.15.2, and has been modified to facilitate firmware updates via DFU mode for the following XMOS based JDS Labs, Inc. devices:

- Atom DAC(+)
- EL DAC II(+)
- Element II
- Element III

## License
  A copy of the original AS-IS [License](https://github.com/jdslabs/xmos_dfu/blob/main/LICENSE.txt) is included within this repository.

## General Knowledge
- This script only supports the USB devices listed above. Only connect one (1) JDS Labs DAC at a time!
- A _direct_ USB connection is required. USB hubs are known to prevent DFU communication.
- M1 based Macs: See [#2](https://github.com/jdslabs/xmos_dfu/issues/2)

## WARNING
This command line tool only checks for a valid JDS Labs USB Vendor and Product ID before loading firmware to your DAC. It does *not* check the .bin file you supply, nor can it check that the DAC matches the .bin file you provide. Thus, triple check that you are loading the right firmware for the right model!

In the event that you accidentally load firmware for the wrong JDS Labs DAC, you can normally recover by flashing the intended firmware. If not, please reach out to jdslabs.com/support

# Usage in macOS
This process has been tested under Big Sur on Intel based Macs.
## Prerequisites
- Install XCode Command Line Tools, from a command line: `xcode-select --install`
- Install [Homebrew](https://brew.sh/)
- Install libusb: `brew install libusb`

## Loading Firmware in macOS 
1. Open a terminal in the `/xmos_dfu/xmos_dfu` folder and compile Makefile.OSX. Warnings may be ignored:
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

4. To flash new firmware, download the [desired .bin file](https://blog.jdslabs.com/2020/08/custom-firmware-builds-for-element-ii-el-dac-ii-and-atom-dac/), then run the command below. *Only 1 DAC may be plugged in at a time!*
You will need to edit the path to reflect the full path of your downloaded firmware file (tip: select the downloaded file in Finder, then right click on its path in the bottom of the window and choose Copy <filename> as Pathname):
```
sudo ./xmosdfu --download /edit/this/path/Atom_DAC_Plus-v184-LockedVolume.bin
```

# Usage in Ubuntu 20.0.4
## Prerequisites
- Install libusb: `sudo apt-get install libusb-1.0-0-dev`

## Loading Firmware in Ubuntu

1. Open a terminal in the `/xmos_dfu/xmos_dfu` folder and compile Makefile.Linux. Warnings may be ignored:
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
4. To flash new firmware, download the [desired .bin file](https://blog.jdslabs.com/2020/08/custom-firmware-builds-for-element-ii-el-dac-ii-and-atom-dac/), then run the command below as `sudo`. *Only 1 DAC may be plugged in at a time!*
You will need to edit the path to reflect the full path of your downloaded firmware file:  
```
sudo ./xmosdfu --download /edit/this/path/Atom_DAC_Plus-v184-LockedVolume.bin
```
