#!/bin/bash
# A menu driven shell script sample template 
## ----------------------------------
# Step #1: Define variables
# ----------------------------------

RED='\033[0;41;30m'
STD='\033[0;0;39m'
 
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

listfirmwares(){
	clear
	cd /Users/jseaber/Documents/GitHub/xmos_dfu/xmos_dfu_osx/
	source setup.sh
	./xmosdfu --listdevices
	echo
    pause
}

ElementIIMenu(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " Flash an Element II "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1) Load v1.3.9 / Default"
	echo "2) Load v1.3.A / PS5"
	echo "3) Back to Main Menu"
	read_elementii
}

read_elementii(){
	local choice
	read -p "Please choose an option [1 - 3]: " choice
	case $choice in
		1) flash_139;;
		2) flash_13A;;
		3) show_menus;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
 
ELDACIIMenu(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " Flash an EL DAC II "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1) Load v1.6.6 / Default"
	echo "2) Load v1.6.7 / PS5 UAC2 with UAC1 Fallback"
	echo "3) Back to Main Menu"
	read_edacii
}

read_edacii(){
	local choice
	read -p "Please choose an option [1 - 3]: " choice
	case $choice in
		1) flash_166;;
		2) flash_167;;
		3) show_menus;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

AtomDACMenu(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " Flash an Atom DAC+ "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1) Load v1.8.9 / Default"
	echo "2) Load v1.8.A / Nintendo Switch"
	echo "3) Load v1.8.B / Nintendo Switch & PS5"
	echo "4) Load v1.8.4 / PS5"
	echo "5) Back to Main Menu"
	read_atom
}

read_atom(){
	local choice
	read -p "Please choose an option [1 - 5]: " choice
	case $choice in
		1) flash_189;;
		2) flash_18A;;
		3) flash_18B;;
		4) flash_184;;
		5) show_menus;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

flash_166(){
	clear
	cd /Users/jseaber/Documents/GitHub/xmos_dfu/xmos_dfu_osx/
	source setup.sh
	./xmosdfu --download /Users/jseaber/Desktop/firmwares/bins/el-dac-ii/EL_DAC_II_v166.bin
	echo
    pause
}

flash_167(){
	clear
	cd /Users/jseaber/Documents/GitHub/xmos_dfu/xmos_dfu_osx/
	source setup.sh
	./xmosdfu --download /Users/jseaber/Desktop/firmwares/bins/el-dac-ii/EL-DAC-II-167-Vol-Lock.bin
	echo
    pause
}

flash_139(){
	clear
	cd /Users/jseaber/Documents/GitHub/xmos_dfu/xmos_dfu_osx/
	source setup.sh
	./xmosdfu --download /Users/jseaber/Desktop/firmwares/bins/element-ii/Element_II_v139.bin
	echo
    pause
}

flash_13A(){
	clear
	cd /Users/jseaber/Documents/GitHub/xmos_dfu/xmos_dfu_osx/
	source setup.sh
	./xmosdfu --download /Users/jseaber/Desktop/firmwares/bins/element-ii/Element-II-v13A.bin
	echo
    pause
}

flash_189(){
	clear
	cd /Users/jseaber/Documents/GitHub/xmos_dfu/xmos_dfu_osx/
	source setup.sh
	./xmosdfu --download /Users/jseaber/Desktop/firmwares/bins/atom-dac-plus/Atom-DAC-Plus-v189.bin
	echo
    pause
}

flash_18A(){
	clear
	cd /Users/jseaber/Documents/GitHub/xmos_dfu/xmos_dfu_osx/
	source setup.sh
	./xmosdfu --download /Users/jseaber/Desktop/firmwares/bins/atom-dac-plus/atom-dac-plus-v18A.bin
	echo
    pause
}

flash_18B(){
	clear
	cd /Users/jseaber/Documents/GitHub/xmos_dfu/xmos_dfu_osx/
	source setup.sh
	./xmosdfu --download /Users/jseaber/Desktop/firmwares/bins/atom-dac-plus/atom-dac-plus-v18B.bin
	echo
    pause
}

flash_184(){
	clear
	cd /Users/jseaber/Documents/GitHub/xmos_dfu/xmos_dfu_osx/
	source setup.sh
	./xmosdfu --download /Users/jseaber/Desktop/firmwares/bins/atom-dac-plus/Atom_DAC_Plus-v184-LockedVolume.bin
	echo
    pause
}
 
# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " JDS Labs XMOS Flasher "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. View Current Firmware"
	echo "2. Flash an Atom DAC+"
	echo "3. Flash an Element II"
	echo "4. Flash an EL DAC II"
	echo "5. Exit"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
	local choice
	read -p "Please choose an option [1 - 5]: " choice
	case $choice in
		1) listfirmwares;;
		2) AtomDACMenu;;
		3) ElementIIMenu;;
		4) ELDACIIMenu;;
		5) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
#trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
 
	show_menus
	read_options
done