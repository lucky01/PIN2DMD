// pin2dmd.cpp : main project file.

String^ argument; //this will not pass from main.cpp to Form1.h

#include "stdafx.h"
#include "Form1.h"
#include <iostream>
#include <stdio.h>
#include <fstream>




using namespace pin2dmd;
using namespace std;
using namespace System;
using namespace System::Runtime::InteropServices;

[STAThreadAttribute]


int main(array<System::String ^> ^args)
{	
	
	if (args.Length==0) {
		// Enabling Windows XP visual effects before any controls are created
		Application::EnableVisualStyles();
		Application::SetCompatibleTextRenderingDefault(false); 

		// Create the main window and run it
		sendLogo();
		Application::Run(gcnew Form1());
		return 0;
	} else {
	if (args[0] == "/b") {
		char* fileName = (char*)Marshal::StringToHGlobalAnsi(args[1]).ToPointer();
		sendPalBinary(_T(fileName));
		Marshal::FreeHGlobal((IntPtr)fileName);
	}else{
	if (args[0] == "/t") {
		char* fileName = (char*)Marshal::StringToHGlobalAnsi(args[1]).ToPointer();
		sendPalText(_T(fileName));
		Marshal::FreeHGlobal((IntPtr)fileName);
	}else{
	if (args[0] == "/a") {
		char* fileName = (char*)Marshal::StringToHGlobalAnsi(args[1]).ToPointer();
		sendPalAlt(_T(fileName));
		Marshal::FreeHGlobal((IntPtr)fileName);
	}else{
	if (args[0] == "/s") {
		char* fileName = (char*)Marshal::StringToHGlobalAnsi(args[1]).ToPointer();
		sendSmartDMD(_T(fileName));
		Marshal::FreeHGlobal((IntPtr)fileName);
	}else{
	if (args[0] == "/i") {
		char* fileName = (char*)Marshal::StringToHGlobalAnsi(args[1]).ToPointer();
		sendPPM(_T(fileName));
		Marshal::FreeHGlobal((IntPtr)fileName);
	}else{
	if (args[0] == "/v") {
		char* fileName = (char*)Marshal::StringToHGlobalAnsi(args[1]).ToPointer();
		sendFSQ(_T(fileName));
		Marshal::FreeHGlobal((IntPtr)fileName);
		return 0;
	}else{
	if (args[0] == "/p") {
		int i=System::Convert::ToInt32(args[1]);
		sendConfig(3, i);
	}else{
	if (args[0] == "/r") {
		sendReset();
		return 0;
	}else{
	if (args[0] == "/c") {
		sendClearSettings();
		return 0;
	}else{
	if (args[0] == "/u") {
		char* fileName = (char*)Marshal::StringToHGlobalAnsi(args[1]).ToPointer();
		uploadFile(_T(fileName));
		Marshal::FreeHGlobal((IntPtr)fileName);
		return 0;
	}else{
		System::Windows::Forms::MessageBox::Show("No valid parameter");
		return 1;
	}
	}
	}
	}
	}
	}
	}  
	}
	}
	}
	}
}

