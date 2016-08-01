
- Flash stm_esp_loader.bin on your pin2dmd controller board using ST-Link Utility
  or stm_esp_loader.dfu using DfuSe Demo
- Start ESP8266Flasher.exe with pin2dmd usb port connected
- Set the Speed of the comport to 115200 under Advanced tab
- Set the Files and Memory area as follows in the Config tab
- Start Flash on Operations tab

flash boot_v1.5bin from to 0x00000
flash blank.bin to 0x3FE000
flash user1.bin to 0x01000

- Flash pin2dmd firmware on the controller.

