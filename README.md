# JDS Customized XMOS DFU Uploader
This CLI utility is derived from the XMOS DFU utility provided with reference XMOS Reference Audio Kit, per the attached License:
https://www.xmos.com/developer/software/usbaudio

# Usage

1. Install a g++ compiler: http://www.edparrish.net/common/macgpp.php
2. Open a terminal in the same folder as the extracted files in step 1, then run the following command to compile. You may ignore the 6 warnings.
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
