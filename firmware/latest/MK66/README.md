# PIN2DMD

Firmware for NXP MK66 (Teensy 3.6) custom controller board.

This is a firmware version based on the latest codebase for teensy 3.6 and custom DMDMK66 hardware. 
There are some limitations due to the lack of hardware or peripherals compared to the EVO/DISCOVERY/NUCLEO version. 
Since you need to install this firmware through SWD debug port use at your own risk. Device may need to be unlocked and
original firmware deleted using openocd to install pin2dmd. See howto.txt in the openocd.zip

Although the pin2dmd.bin file contains it´s own bootloader, the pin2dmd.upd file can also be prepared for uTasker bootloader with 
the uTaskerConvert utility and the loader specific parameters.

For information how to get a activation key for your device 
please visit http://www.pin2dmd.com
