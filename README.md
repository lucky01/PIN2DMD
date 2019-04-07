# PIN2DMD - a color LED dotmatrix controller for virtual and real pinballs

With the PIN2DMD project you get a full color LED DMD controller 
for real and virtual pinball machines.
The project was started by Lucky1 and shortly after that joined by Steve45 
as co-author. Version 1.X is free for DIY private NON COMMERCIAL use and released under 
a Creative Commons Attribution-NonCommercial- ShareAlike 4.0 International License.

http://creativecommons.org/licenses/by-nc-sa/4.0/

Due to copyright violations through commercial sales of our software the authors were forced to
change the project to allow access to the source code for contributors only with version 2.0.
Also a activation key which is bound to the hardware was introduced.
More Information how to obtain a key can be found in chapter 3 here https://pin2dmd.com/installation/ 

The latest binary can be found here 
https://github.com/lucky01/PIN2DMD/raw/master/firmware/latest/

Sorry for inconvinience, but is seems that the hunt for quick money eats the brain of the hunter.

It currently supports:

- WPC real pinball input
- Stern real pinball input
- Whitestar real pinball input
- DataEast real pinball input
- WPC95 real pinball input
- WPC PinLED
- Sega 192x64 using 64x64 1/32scan P2 Panels
- Stern Spike real pinball input
- Gottlieb real pinball input
- Capcom real pinball input
- AlvinG real pinball input
- Spooky real pinball input
- SPinball real pinball input (beta)
- DataEast 128x16 real pinball input
- Visual Pinball / PinMame USB input
- Future Pinball with DMD interceptor DLL
- Unit3d Pinball
- Ultra DMD support (Stephen)
- PinballX / XDMD support (Tom Speirs)
- Pinball fx2 support using dmdext from Freezy
- The Pinball Arcade support using dmdext from Freezy and NoEx
- Pinball Browser / SmartDMD color switching for full color Stern ROMS
- Frame colorization with PIN2DMD Editor by Steve for all pinball machines
- WCID Windows automated driver installation

The components cost approximately 120$
Here is a list of what you need:
 
#1. The Panels
The panels we use are sold for video walls and advertising signs. There are many 
sizes of panels available with different spacing between the LEDs. The ones 
that fit best into a pinball have 2.5mm spacing (also referred to as P2.5), 
which results in a 128×32 display of 320×76.8mm. This can be mounted into an 
existing DMD/speaker panel from a pinball cabinet. Currently the only place 
to buy these panels is from AliExpress. search for "RGB LED 64x64 p2.5 1/16" or 
"RGB LED 64x64 p2.5 1/16". You don´t find 128×32 panels, but you can buy two 
64×32 or one 64x64 panel which consists of two 64x32 panels which can be removed 
from the frame and connect side-by-side. Make sure that you end up with 2 x 1/16 
scan panels since these are the only one currently supported by PIN2DMD. 
The good thing is that they are seamless.

#2. The Controller

#2.1 The STM32F4 Discovery / Nucleo board with PIN2DMD Shield

The panels use a 16 pin Hub75 interface to be connected to the next panel or to a 
controller. We use standard STM32 development boards like the STM32F407 discovery or 
Nucleo144-F429ZI which are available from multiple sources for about $20. 
It is based on a ARM Cortex processor architecture which is needed 
for the rapid bit-shifting of data to control the panels. We write the program in C. 
The software is uploaded to the controller through mini USB port.
To connect the displays to the controller you need a connector shield pcb, which 
basically just connects the pins to the 16-pin ribbon cable that drives the displays. 
The board also has a 14pin connector which is used as input to get the data from a real machine. 
PCB layout examples can be found in the hardware directory. The advantage of the modular 
system is that new hardware functions can easily be implemented by changing the shield 
while keeping the controller. Members of the community have organized a group buy for 
printed circuit boards and also offer different kits. 

#3. The Power Supply
The RGB LED displays require 5vdc for power and if you want to run them
with full brightness they need a lot of current. A 10A power should be enough.
You need to connect that power supply up to both panels. The controller can 
either be supplied by USB or by an external 5V power source
 
#4. The Firmware
Installation is done using ST-Link interface

1) Download and install ST Link Utility: http://www.st.com/web/en/catalog/tools/PF258168
2) The latest binary can be found here https://github.com/lucky01/PIN2DMD/raw/master/firmware/latest/
3) Connect the STM32 board to the PC using a mini-USB cable (not the smaller microUSB cable). The board will light up and you should an STM32 STLink USB device connected in the Windows notification tray
4) Flash firmware: Target -> Program 
Choose PIN2DMD.BIN file from firmware/latest latest folder.

#5. The pin2dmd.exe tool
The tool is used to configure the controller und upload needed data for the pinball
used. It can either run in commandline mode or in GUI mode.
 

