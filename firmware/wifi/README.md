There are currently two possiblities to flash the firmware to the esp wifi chip.

You need to prepare your controller for the wifi upgrade with a special firmware load. Depending on the
upgrade method you have to do the following:

1. Programm through the onboard USB port of your controller
	- Flash stm_esp_loader.bin on your pin2dmd controller board using ST-Link Utility or stm_esp_loader.dfu using DfuSe Demo and run it
	- you should see the blue status LED on
	- install the STM virtual COM port drivers
	from http://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-utilities/stsw-stm32102.html

2. Program with a USB dongle connected to the RX and TX port of the wifi chip
	- Flash esp_serial_loader.bin on your pin2dmd controller board using ST-Link Utility or esp_serial_loader.dfu using DfuSe Demo and run it
	- you should see the blue status LED on
	- connect the USB dongle to the RX/TX/GND pins of your board

The upgrade process itself is common to both methods
  
- Start ESP8266Flasher.exe 
- Set the Speed of the comport to 115200 under Advanced tab
- Set the Files and Memory area as follows in the Config tab and check the checkboxes for each file
	flash boot_v1.5bin from to 0x00000
	flash blank.bin to 0x3FE000
	flash user1.bin to 0x01000
- Start Flash on Operations tab
- press the blue / option button
- blue LED should turn off and green LED on
- make a wifi search from you PC
- connect to the wifi accesspoint named esp_ or AI_thinker_
- open the webfrontend at http://192.168.4.1

Finally you have to flash the pin2dmd firmware to the controller.


