// This is the main DLL file.

#include "stdafx.h"
#include "pin2dmd.h"
#include <libusb.h>
#include <stdlib.h>


struct libusb_device **devs;    
struct libusb_device_handle *MyLibusbDeviceHandle = NULL; 
struct libusb_device_descriptor desc;		

	void pin2dmdRenderRGB24 (rgb24 *currbuffer)
	{
		
		memset(OutputPacketBuffer, 0, 7684);

		OutputPacketBuffer[0] = 0x81;
		OutputPacketBuffer[1] = 0xc3;
		OutputPacketBuffer[2] = 0xe8;
		OutputPacketBuffer[3] = 15; //number of planes
		int byteIdx = 4;
		int r3, r4, r5, r6, r7, g3, g4, g5, g6, g7, b3, b4, b5, b6, b7;
		int pixelr, pixelg, pixelb;
		int i, j, v;

		for (j = 0; j <height; j++) {
						for (i = 0; i < width; i += 8) {
				r3 = 0;
				r4 = 0;
				r5 = 0;
				r6 = 0;
				r7 = 0;

				g3 = 0;
				g4 = 0;
				g5 = 0;
				g6 = 0;
				g7 = 0;

				b3 = 0;
				b4 = 0;
				b5 = 0;
				b6 = 0;
				b7 = 0;

				for (v = 7; v >= 0; v--) {
					pixelr = currbuffer[((j * width)) + ((i + v))].red; 
					pixelg = currbuffer[((j * width)) + ((i + v))].green;
					pixelb = currbuffer[((j * width)) + ((i + v))].blue;

					r3 <<= 1;
					r4 <<= 1;
					r5 <<= 1;
					r6 <<= 1;
					r7 <<= 1;
					g3 <<= 1;
					g4 <<= 1;
					g5 <<= 1;
					g6 <<= 1;
					g7 <<= 1;
					b3 <<= 1;
					b4 <<= 1;
					b5 <<= 1;
					b6 <<= 1;
					b7 <<= 1;

					if (pixelr & 8)
						r3 |= 1;
					if (pixelr & 16)
						r4 |= 1;
					if (pixelr & 32)
						r5 |= 1;
					if (pixelr & 64)
						r6 |= 1;
					if (pixelr & 128)
						r7 |= 1;

					if (pixelg & 8)
						g3 |= 1;
					if (pixelg & 16)
						g4 |= 1;
					if (pixelg & 32)
						g5 |= 1;
					if (pixelg & 64)
						g6 |= 1;
					if (pixelg & 128)
						g7 |= 1;

					if (pixelb & 8)
						b3 |= 1;
					if (pixelb & 16)
						b4 |= 1;
					if (pixelb & 32)
						b5 |= 1;
					if (pixelb & 64)
						b6 |= 1;
					if (pixelb & 128)
						b7 |= 1;
				}
				OutputPacketBuffer[byteIdx + 5120] = r3;
				OutputPacketBuffer[byteIdx + 5632] = r4;
				OutputPacketBuffer[byteIdx + 6144] = r5;
				OutputPacketBuffer[byteIdx + 6656] = r6;
				OutputPacketBuffer[byteIdx + 7168] = r7;

				OutputPacketBuffer[byteIdx + 2560] = g3;
				OutputPacketBuffer[byteIdx + 3072] = g4;
				OutputPacketBuffer[byteIdx + 3584] = g5;
				OutputPacketBuffer[byteIdx + 4096] = g6;
				OutputPacketBuffer[byteIdx + 4608] = g7;

				OutputPacketBuffer[byteIdx + 0] = b3;
				OutputPacketBuffer[byteIdx + 512] = b4;
				OutputPacketBuffer[byteIdx + 1024] = b5;
				OutputPacketBuffer[byteIdx + 1536] = b6;
				OutputPacketBuffer[byteIdx + 2048] = b7;
				byteIdx++;
			}
		}

		//Writes data to a bulk endpoint. 
		libusb_bulk_transfer(MyLibusbDeviceHandle, EP_OUT, OutputPacketBuffer , 7684,NULL, 1000);

	}

	void pin2dmdRender8bit(UINT8 *currbuffer)
	{

	int byteIdx=4;
	int bd0,bd1,bd2,bd3;
	int pixel;
	int i,j,v;
	int ret = 0;
	unsigned char frame_buf[2052];

	memset(OutputPacketBuffer,0,2052);
	OutputPacketBuffer[0] = 0x81;	// frame sync bytes
	OutputPacketBuffer[1] = 0xC3;
	OutputPacketBuffer[2] = 0xE7;
	OutputPacketBuffer[3] = 0x0;		// command byte (not used)

	for(j = 0; j < height; j++) {
		for(i = 0; i < width; i+=8) {
			bd0 = 0;
			bd1 = 0;
			bd2 = 0;
			bd3 = 0;
			for (v = 7; v >= 0; v--) {

				pixel = currbuffer[(j*width) + (i+v)];

				bd0 <<= 1;
				bd1 <<= 1;
				bd2 <<= 1;
				bd3 <<= 1;

				if ((pixel & 16) != 0) {
					bd0 |= 1;
				}
				if ((pixel & 32) != 0) {
					bd1 |= 1;
				}
				if ((pixel & 64) != 0) {
					bd2 |= 1;
				}
				if ((pixel & 128) != 0) {
					bd3 |= 1;
				}
			}
			OutputPacketBuffer[byteIdx]      = bd0;
			OutputPacketBuffer[byteIdx+512]  = bd1;
			OutputPacketBuffer[byteIdx+1024] = bd2;
			OutputPacketBuffer[byteIdx+1536] = bd3;
			byteIdx++;
		}
	}

	libusb_bulk_transfer(MyLibusbDeviceHandle, EP_OUT, OutputPacketBuffer , 2052,NULL, 1000);

}
  


void pin2dmdSet16Color(rgb24 *color)

{
	memset(OutputPacketBuffer, 0, 2052);

	const UINT8 tmp[7 + 16 * 3] = {
		0x81, 0xC3, 0xE7, 0xFF, 0x04, 0x00, 0x01, //header
		color[0].red, color[0].green, color[0].blue, // color 0 0%
		color[1].red, color[1].green, color[1].blue, // color 1
		color[2].red, color[2].green, color[2].blue, // color 2
		color[3].red, color[3].green, color[3].blue, // color 3
		color[4].red, color[4].green, color[4].blue, // color 4
		color[5].red, color[5].green, color[5].blue, // color 5
		color[6].red, color[6].green, color[6].blue, // color 6
		color[7].red, color[7].green, color[7].blue, // color 7
		color[8].red, color[8].green, color[8].blue, // color 8
		color[9].red, color[9].green, color[9].blue, // color 9
		color[10].red, color[10].green, color[10].blue, // color 10
		color[11].red, color[11].green, color[11].blue, // color 11
		color[12].red, color[12].green, color[12].blue, // color 12
		color[13].red, color[13].green, color[13].blue, // color 13
		color[14].red, color[14].green, color[14].blue, // color 14
		color[15].red, color[15].green, color[15].blue }; // color 15 100% 

	memcpy(OutputPacketBuffer, tmp, sizeof(tmp));

	libusb_bulk_transfer(MyLibusbDeviceHandle, EP_OUT, OutputPacketBuffer , 2052,NULL, 1000);
	Sleep(50);
}


	
	int pin2dmdInit()
	{
		int ret = 0;

		libusb_init(NULL); /* initialize the library */

		int device_count = libusb_get_device_list(NULL, &devs);
	
		//Now look through the list that we just populated.  We are trying to see if any of them match our device.	
		for (int i = 0; i < device_count; i++) {
			libusb_get_device_descriptor(devs[i], &desc);
			if(MY_VID == desc.idVendor && MY_PID == desc.idProduct) {
				libusb_open(devs[i], &MyLibusbDeviceHandle);
				break;
			}
		}


		if(MyLibusbDeviceHandle == NULL)
		{
		return 0;
		}

	
		unsigned char *manufacturer;
		manufacturer = (unsigned char *)malloc(256);
		ret= libusb_get_string_descriptor_ascii(MyLibusbDeviceHandle, desc.iManufacturer, manufacturer, 256);
		const char *string=NULL;
		string = (const char*) manufacturer;
		if (ret > 0) {
			if (strcmp(string, "PIN2DMD") == 0) {
				ret = 1; //PIN2DMD
				OutputPacketBuffer = (unsigned char *)malloc(7684);
			} else {
				ret = 2; //PINDMD2
				OutputPacketBuffer = (unsigned char *)malloc(2052);
			}
		}
		free(manufacturer);
	
		libusb_free_device_list(devs, 1);

		if(libusb_claim_interface(MyLibusbDeviceHandle, 0) < 0)  //claims the interface with the Operating System
		{
		//Closes a device opened since the claim interface is failed.
		libusb_close(MyLibusbDeviceHandle);
		return 0;
		}

		
		
		return ret;
	}

	bool pin2dmdDeInit()
	{
	
	//clean up.
    libusb_release_interface(MyLibusbDeviceHandle, 0);
	//closes a device opened
	libusb_close(MyLibusbDeviceHandle);

	free(OutputPacketBuffer);
	
	return true;
	}





   




	


