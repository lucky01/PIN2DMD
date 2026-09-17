# PIN2DMD

Firmware for NXP MK66 (Teensy 3.6) custom controller board.

This is a firmware version based on the latest codebase for teensy 3.6 and custom DMDMK66 hardware. 
There are some limitations due to the lack of hardware or peripherals compared to the EVO/DISCOVERY/NUCLEO version. 
To convert your DMDMK66 to a PIN2DMD you need to change the uTasker bootloader to pin2dmd bootloader by copying the dmdmk66.bin and the pin2dmd.upd file to your SD card. 
Thanks to @gerwout for making this possible by hacking the uTasker bootloader used on DMDMK66. The whole story how he did this is here https://github.com/gerwout/dmdmk66-update-tool/

For information how to get a activation key for your device 
please visit http://www.pin2dmd.com
