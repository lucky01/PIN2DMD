# PIN2DMD

Firmware for NXP MK66 (Teensy 3.6) custom controller board.

This is a proof of concept firmware version based on the latest codebase. However it is based on the latest version
there are some limitations due to the lack of hardware or peripherals compared to the EVO/DISCOVERY/NUCLEO version. 
Since you need to install this firmware through SWD debug port use at your own risk. Original firmware 
needs to be deleted by initiating a mass_erase. In OPENOCD this is done through "kinetis mdm mass_erase"
command. A hardware reset may be necessary to complete the command (connect Reset pin to GND).
After successfully unlocking the device install the uTasker bootloader with "flash write_image uTaskerLoader.bin" command
Copy the update.bin to your SD card and the firmware should automatically install after reboot.

The firmware is compiled with 0x8000 as base address and then prepared for uTaskerLoader with 
the command "uTaskerConvert.exe pin2dmd_0x8000.bin update.bin -0x4B36"

For information how to get a activation key for your device 
please visit http://www.pin2dmd.com
