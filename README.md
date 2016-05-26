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
More Information how to obtain a key is here http://vpuniverse.com/forums/forum/132-pin2dmd/

The latest binary can be found here 
https://github.com/lucky01/PIN2DMD/raw/master/firmware/latest/PIN2DMD.bin

Sorry for inconvinience, but is seems that the hunt for quick money eats the brain of the hunter.

It currently supports:

 -   Visual Pinball / PinMame
 -   Future Pinball with DMD interceptor DLL
 -   Unit3d Pinball
 -   Ultra DMD
 -   XDMD
 -   PinballX
 -   WPC real pinball input
 -   Stern real pinball input
 -   Whitestar real pinball input
 -   DataEast real pinball input
 -   WPC95 real pinball input
 -   Gottlieb real pinball input (beta)
 -   SmartDMD inframe color switching
 -   Frame colorization with PIN2DMD Editor by Steve (beta)
 -   WCID automated driver installation

The components cost approximately 100$
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
 
#2. The STM32F4 Discovery board
The panels use a 16 pin Hub75 interface to be connected to the next
panel or to a controller. We use a STM32F4 discovery board which is available 
from multiple sources for about $20. It is based on 168Mhz Cortex M4 processor 
architecture which is needed for the rapid bit-shifting of data to control the 
panels. We use CooCox IDE to write the program in C. 
The software is open source and is uploaded to the controller through mini USB port.
 
#3. The PIN2DMD Shield
To connect the displays to the controller you need a connector shield pcb, which 
basically just connects the pins to the 16-pin ribbon cable that drives the displays. 
The board also has a 14pin connector which can be either used as output to a real 
monochrome pinball dmd or as input to get the data from a real machine 
(currently WPC and STERN under development). The PCB layout can be found in the pcb 
directory. There are group-buys organized for the US from UncleSash and for the 
EU from Rappelbox which can be joined here: 
http://vpuniverse.com/forums/forum/132-pin2dmd/

#4. The Power Supply
The RGB LED displays require 5vdc for power and if you want to run them
with full brightness they need a lot of current. A 10A power should be enough.
You need to connect that power supply up to both panels. The controller can 
either be supplied by USB or by an external 5V power source
 
#5. The Firmware
As mentioned under point 3 we use CooCox IDE to build the STM32 firmware which 
can be found under www.coocox.org. You also need the ARM gcc toolchain which 
can be found here https://launchpad.ne...c-arm-embedded/ There is a video tutorial 
on youtube how to get it working. You need to download the source for the firmware 
from github https://github.com/lucky01/PIN2DMD either as zip or git clone. 
Open the project in CoIDE press F7 to compile and then upload the firmware to the device.
 
UncleSash has written some really good manuals and instructions how to get the 
whole thing running which can be found here:
http://vpuniverse.com/forums/topic/2269-pin2dmd-instructions-and-howtos/

#6. The pin2dmd.exe tool
The tool is used to configure the controller und upload needed data for the pinball
used. It can either run in commandline mode or in GUI mode.
 

