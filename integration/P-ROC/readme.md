Here is an example P-ROC python script to send the display data directly to the pin2dmd through USB.
You need to install pyusb by executing "pip install pyusb" and copying the libusb-1,0.dll to the Python27 folder where the python.exe is located.
The script needs to be copied to your games ep folder.
If you have first generation RBG panels you need to change the color mapping. Just search for RBG, remove the comment # in the 6 pixel mappings and comment out the RBG mappings above.
I also added pygame.display.iconify() to hide the desktop display. You need firmware version >= v3.05 installed on the device.
For CCC Virtual Pinball implementation please checkout https://github.com/CarnyPriest/CCCforVP/tree/pin2dmd

