# JDS Customized XMOS DFU Uploader
This CLI utility is derived from the XMOS DFU utility provided with reference XMOS Reference Audio Kit, per the attached License:
https://www.xmos.com/developer/software/usbaudio

# Usage in macOS

1. Install a g++ compiler: http://www.edparrish.net/common/macgpp.php
2. Open a terminal in the `xmos_dfu_osx` folder, then run the following command to compile. This returns 6 warnings in Big Sur, which may be ignored:
```
make -f Makefile.OSX all
```
3. Make sure your DAC is connected by USB, then run the following command to verify the connection and check the current firmware version. Your DAC will appear as “VID = 0x20b1”. *Only 1 DAC may be plugged in at a time!*:
```
source setup.sh 
./xmosdfu --listdevices
```
3. To flash new firmware, download the desired file, then run the command below. You will need to edit the command to reflect the full path of your downloaded firmware file: select the downloaded file in Finder, then right click on its path in the bottom of the window and choose Copy <filename> as Pathname:
```
source setup.sh 
./xmosdfu --download /Users/jseaber/Downloads/Atom_DAC_Plus-v184-LockedVolume.bin
```

# Usage in Ubuntu 20.0.4

1. Install usblib:
```
sudo apt-get install libusb-1.0-0-dev
```
2. Open a terminal in the `xmos_dfu_linux` folder, then run the following command to compile. This returns 5 warnings:
```
make -f Makefile all
```
3. Make sure your DAC is connected by USB, then run the following command to verify the connection and check the current firmware version. Your DAC will appear as “VID = 0x20b1”. *Only 1 DAC may be plugged in at a time!*:
```
source setup.sh 
./xmosdfu --listdevices
```
3. Flashing firmware???? The libusb library is broken, but supposedly worked in Ubuntu 17.0.4 per: https://www.xcore.com/viewtopic.php?t=4025
