mac:
	g++ -g -o xmosdfu xmosdfu.cpp -I. -IOSX /usr/local/lib/libusb-1.0.0.dylib
mac-m1:
	g++ -g -o xmosdfu xmosdfu.cpp -I. -IOSX /opt/homebrew/Cellar/libusb/1.0.25/lib/libusb-1.0.0.dylib
linux:
	g++ -g -o xmosdfu xmosdfu.cpp `pkg-config --libs --cflags libusb-1.0`