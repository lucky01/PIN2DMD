# PIN2DMD

Firmware for a STM32F429ZI Nucleo-144 board board to drive a HUB75 RGB panel.

Standard firmware is for two 64x32 1/16 scan panels in a row for 128x32 resolution.

XL firmware is for three 64x64 1/32 scan panels in a row for 192x64 resolution.(SEGA)

Copy the .upd file to you micro SD card to upload the firmware to your device with
firmware >= 2.50 preinstalled. (for XL >= 2.08) 

Use the .bin file with the ST-Link Utility to upload the firmware to your device
using the ST-Link interface
http://www.st.com/web/en/catalog/tools/PF258168

Use the .dfu file with the DfuSEDemo Utility to upload the firmware to your device
using the user USB port in dfu mode.
http://www.st.com/en/development-tools/stsw-stm32080.html

For information how to get a activation key for your device 
please visit http://www.pin2dmd.com
