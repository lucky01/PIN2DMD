#pragma once
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------BEGIN CUT AND PASTE BLOCK-----------------------------------------------------------------------------------
//Includes
#include <windows.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <tchar.h>
#include "cmd.h"


//-------------------------------------------------------END CUT AND PASTE BLOCK-------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------

namespace pin2dmd {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Summary for Form1
	///
	/// WARNING: If you change the name of this class, you will need to change the
	///          'Resource File Name' property for the managed resource compiler tool
	///          associated with all .resx files this class depends on.  Otherwise,
	///          the designers will not be able to interact properly with localized
	///          resources associated with this form.
	/// </summary>
	public ref class Form1 : public System::Windows::Forms::Form
	{
	public:
		Form1(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~Form1()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::Button^  reset_btn;
	private: System::Windows::Forms::Button^  save_btn;
	protected: 


	protected: 



	private: System::Windows::Forms::Label^  StateLabel;
	private: System::Windows::Forms::Label^  successLabel;


	private: System::Windows::Forms::Button^  vga_btn;
	private: System::Windows::Forms::Button^  red_btn;
	private: System::Windows::Forms::Button^  white_btn;
	private: System::Windows::Forms::Button^  cyan_btn;
	private: System::Windows::Forms::Button^  yellow_btn;
	private: System::Windows::Forms::Button^  pink_btn;
	private: System::Windows::Forms::Button^  blue_btn;
	private: System::Windows::Forms::Button^  green_btn;
	private: System::Windows::Forms::RadioButton^  RGB_btn;

	private: System::Windows::Forms::RadioButton^  MONO_btn;

	private: System::Windows::Forms::RadioButton^  WMS_btn;
	private: System::Windows::Forms::RadioButton^  STERN_btn;
	private: System::Windows::Forms::RadioButton^  GOTTLIEB_btn;
	private: System::Windows::Forms::RadioButton^  DATAEAST_btn;
	private: System::Windows::Forms::RadioButton^  WHITESTAR_btn;
	private: System::Windows::Forms::TrackBar^  DispTime0;
	private: System::Windows::Forms::TrackBar^  DispTime1;
	private: System::Windows::Forms::TrackBar^  DispTime2;
	private: System::Windows::Forms::TrackBar^  DispTime3;
	private: System::Windows::Forms::TrackBar^  DispTime4;





	private: System::Windows::Forms::ToolTip^  toolTip1;
	private: System::Windows::Forms::Label^  label1;
	private: System::Windows::Forms::Label^  label2;
	private: System::Windows::Forms::Label^  label3;
	private: System::Windows::Forms::Label^  label4;
	private: System::Windows::Forms::Label^  label5;
	private: System::Windows::Forms::CheckBox^  checkBox1;
	private: System::Windows::Forms::TrackBar^  Brightness;
	private: System::Windows::Forms::Label^  label6;
	private: System::Windows::Forms::RadioButton^  WPC95_btn;
	private: System::ComponentModel::IContainer^  components;

























	protected:

	protected:




	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>


#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->components = (gcnew System::ComponentModel::Container());
			this->reset_btn = (gcnew System::Windows::Forms::Button());
			this->save_btn = (gcnew System::Windows::Forms::Button());
			this->StateLabel = (gcnew System::Windows::Forms::Label());
			this->successLabel = (gcnew System::Windows::Forms::Label());
			this->vga_btn = (gcnew System::Windows::Forms::Button());
			this->red_btn = (gcnew System::Windows::Forms::Button());
			this->white_btn = (gcnew System::Windows::Forms::Button());
			this->cyan_btn = (gcnew System::Windows::Forms::Button());
			this->yellow_btn = (gcnew System::Windows::Forms::Button());
			this->pink_btn = (gcnew System::Windows::Forms::Button());
			this->blue_btn = (gcnew System::Windows::Forms::Button());
			this->green_btn = (gcnew System::Windows::Forms::Button());
			this->RGB_btn = (gcnew System::Windows::Forms::RadioButton());
			this->MONO_btn = (gcnew System::Windows::Forms::RadioButton());
			this->WMS_btn = (gcnew System::Windows::Forms::RadioButton());
			this->STERN_btn = (gcnew System::Windows::Forms::RadioButton());
			this->GOTTLIEB_btn = (gcnew System::Windows::Forms::RadioButton());
			this->DATAEAST_btn = (gcnew System::Windows::Forms::RadioButton());
			this->WHITESTAR_btn = (gcnew System::Windows::Forms::RadioButton());
			this->DispTime0 = (gcnew System::Windows::Forms::TrackBar());
			this->DispTime1 = (gcnew System::Windows::Forms::TrackBar());
			this->DispTime2 = (gcnew System::Windows::Forms::TrackBar());
			this->DispTime3 = (gcnew System::Windows::Forms::TrackBar());
			this->DispTime4 = (gcnew System::Windows::Forms::TrackBar());
			this->toolTip1 = (gcnew System::Windows::Forms::ToolTip(this->components));
			this->label1 = (gcnew System::Windows::Forms::Label());
			this->label2 = (gcnew System::Windows::Forms::Label());
			this->label3 = (gcnew System::Windows::Forms::Label());
			this->label4 = (gcnew System::Windows::Forms::Label());
			this->label5 = (gcnew System::Windows::Forms::Label());
			this->checkBox1 = (gcnew System::Windows::Forms::CheckBox());
			this->Brightness = (gcnew System::Windows::Forms::TrackBar());
			this->label6 = (gcnew System::Windows::Forms::Label());
			this->WPC95_btn = (gcnew System::Windows::Forms::RadioButton());
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime0))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime1))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime2))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime3))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime4))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->Brightness))->BeginInit();
			this->SuspendLayout();
			// 
			// reset_btn
			// 
			this->reset_btn->Location = System::Drawing::Point(12, 425);
			this->reset_btn->Name = L"reset_btn";
			this->reset_btn->Size = System::Drawing::Size(93, 27);
			this->reset_btn->TabIndex = 16;
			this->reset_btn->Text = L"Reset";
			this->reset_btn->UseVisualStyleBackColor = true;
			this->reset_btn->Click += gcnew System::EventHandler(this, &Form1::reset_btn_Click);
			// 
			// save_btn
			// 
			this->save_btn->Location = System::Drawing::Point(182, 425);
			this->save_btn->Name = L"save_btn";
			this->save_btn->Size = System::Drawing::Size(93, 26);
			this->save_btn->TabIndex = 17;
			this->save_btn->Text = L"Save";
			this->save_btn->UseVisualStyleBackColor = true;
			this->save_btn->Click += gcnew System::EventHandler(this, &Form1::save_btn_Click);
			// 
			// StateLabel
			// 
			this->StateLabel->AutoSize = true;
			this->StateLabel->Location = System::Drawing::Point(9, 9);
			this->StateLabel->Name = L"StateLabel";
			this->StateLabel->Size = System::Drawing::Size(153, 13);
			this->StateLabel->TabIndex = 3;
			this->StateLabel->Text = L"PinMAME mode with output to:";
			// 
			// successLabel
			// 
			this->successLabel->AutoSize = true;
			this->successLabel->Location = System::Drawing::Point(10, 89);
			this->successLabel->Name = L"successLabel";
			this->successLabel->Size = System::Drawing::Size(141, 13);
			this->successLabel->TabIndex = 4;
			this->successLabel->Text = L"Pinball mode with input from:";
			// 
			// vga_btn
			// 
			this->vga_btn->Location = System::Drawing::Point(209, 9);
			this->vga_btn->Name = L"vga_btn";
			this->vga_btn->Size = System::Drawing::Size(66, 27);
			this->vga_btn->TabIndex = 7;
			this->vga_btn->Text = L"0 - VGA";
			this->vga_btn->UseVisualStyleBackColor = true;
			this->vga_btn->Click += gcnew System::EventHandler(this, &Form1::vga_btn_Click);
			// 
			// red_btn
			// 
			this->red_btn->BackColor = System::Drawing::Color::Red;
			this->red_btn->Location = System::Drawing::Point(209, 42);
			this->red_btn->Name = L"red_btn";
			this->red_btn->Size = System::Drawing::Size(27, 27);
			this->red_btn->TabIndex = 8;
			this->red_btn->Text = L"1";
			this->red_btn->UseVisualStyleBackColor = false;
			this->red_btn->Click += gcnew System::EventHandler(this, &Form1::red_btn_Click);
			// 
			// white_btn
			// 
			this->white_btn->BackColor = System::Drawing::Color::White;
			this->white_btn->Location = System::Drawing::Point(209, 141);
			this->white_btn->Name = L"white_btn";
			this->white_btn->Size = System::Drawing::Size(27, 27);
			this->white_btn->TabIndex = 15;
			this->white_btn->Text = L"7";
			this->white_btn->UseVisualStyleBackColor = false;
			this->white_btn->Click += gcnew System::EventHandler(this, &Form1::white_btn_Click);
			// 
			// cyan_btn
			// 
			this->cyan_btn->BackColor = System::Drawing::Color::Cyan;
			this->cyan_btn->Location = System::Drawing::Point(209, 108);
			this->cyan_btn->Name = L"cyan_btn";
			this->cyan_btn->Size = System::Drawing::Size(27, 27);
			this->cyan_btn->TabIndex = 14;
			this->cyan_btn->Text = L"5";
			this->cyan_btn->UseVisualStyleBackColor = false;
			this->cyan_btn->Click += gcnew System::EventHandler(this, &Form1::cyan_btn_Click);
			// 
			// yellow_btn
			// 
			this->yellow_btn->BackColor = System::Drawing::Color::Yellow;
			this->yellow_btn->Location = System::Drawing::Point(248, 108);
			this->yellow_btn->Name = L"yellow_btn";
			this->yellow_btn->Size = System::Drawing::Size(27, 27);
			this->yellow_btn->TabIndex = 13;
			this->yellow_btn->Text = L"6";
			this->yellow_btn->UseVisualStyleBackColor = false;
			this->yellow_btn->Click += gcnew System::EventHandler(this, &Form1::yellow_btn_Click);
			// 
			// pink_btn
			// 
			this->pink_btn->BackColor = System::Drawing::Color::Fuchsia;
			this->pink_btn->Location = System::Drawing::Point(248, 75);
			this->pink_btn->Name = L"pink_btn";
			this->pink_btn->Size = System::Drawing::Size(27, 27);
			this->pink_btn->TabIndex = 11;
			this->pink_btn->Text = L"4";
			this->pink_btn->UseVisualStyleBackColor = false;
			this->pink_btn->Click += gcnew System::EventHandler(this, &Form1::pink_btn_Click);
			// 
			// blue_btn
			// 
			this->blue_btn->BackColor = System::Drawing::Color::Blue;
			this->blue_btn->Location = System::Drawing::Point(209, 75);
			this->blue_btn->Name = L"blue_btn";
			this->blue_btn->Size = System::Drawing::Size(27, 27);
			this->blue_btn->TabIndex = 10;
			this->blue_btn->Text = L"3";
			this->blue_btn->UseVisualStyleBackColor = false;
			this->blue_btn->Click += gcnew System::EventHandler(this, &Form1::blue_btn_Click);
			// 
			// green_btn
			// 
			this->green_btn->BackColor = System::Drawing::Color::Lime;
			this->green_btn->Location = System::Drawing::Point(248, 42);
			this->green_btn->Name = L"green_btn";
			this->green_btn->Size = System::Drawing::Size(27, 27);
			this->green_btn->TabIndex = 9;
			this->green_btn->Text = L"2";
			this->green_btn->UseVisualStyleBackColor = false;
			this->green_btn->Click += gcnew System::EventHandler(this, &Form1::green_btn_Click);
			// 
			// RGB_btn
			// 
			this->RGB_btn->AutoSize = true;
			this->RGB_btn->Location = System::Drawing::Point(12, 33);
			this->RGB_btn->Name = L"RGB_btn";
			this->RGB_btn->Size = System::Drawing::Size(168, 17);
			this->RGB_btn->TabIndex = 1;
			this->RGB_btn->TabStop = true;
			this->RGB_btn->Text = L"Color Hub75 or Hub08 Display";
			this->RGB_btn->UseVisualStyleBackColor = true;
			this->RGB_btn->CheckedChanged += gcnew System::EventHandler(this, &Form1::RGB_btn_CheckedChanged);
			// 
			// MONO_btn
			// 
			this->MONO_btn->AutoSize = true;
			this->MONO_btn->Location = System::Drawing::Point(12, 61);
			this->MONO_btn->Name = L"MONO_btn";
			this->MONO_btn->Size = System::Drawing::Size(158, 17);
			this->MONO_btn->TabIndex = 2;
			this->MONO_btn->TabStop = true;
			this->MONO_btn->Text = L"Monochrome Pinball Display";
			this->MONO_btn->UseVisualStyleBackColor = true;
			this->MONO_btn->CheckedChanged += gcnew System::EventHandler(this, &Form1::MONO_btn_CheckedChanged);
			// 
			// WMS_btn
			// 
			this->WMS_btn->AutoSize = true;
			this->WMS_btn->Location = System::Drawing::Point(12, 118);
			this->WMS_btn->Name = L"WMS_btn";
			this->WMS_btn->Size = System::Drawing::Size(166, 17);
			this->WMS_btn->TabIndex = 3;
			this->WMS_btn->TabStop = true;
			this->WMS_btn->Text = L"Bally/Williams pinball machine";
			this->WMS_btn->UseVisualStyleBackColor = true;
			this->WMS_btn->CheckedChanged += gcnew System::EventHandler(this, &Form1::WMS_btn_CheckedChanged);
			// 
			// STERN_btn
			// 
			this->STERN_btn->AutoSize = true;
			this->STERN_btn->Location = System::Drawing::Point(12, 146);
			this->STERN_btn->Name = L"STERN_btn";
			this->STERN_btn->Size = System::Drawing::Size(126, 17);
			this->STERN_btn->TabIndex = 4;
			this->STERN_btn->TabStop = true;
			this->STERN_btn->Text = L"Stern pinball machine";
			this->STERN_btn->UseVisualStyleBackColor = true;
			this->STERN_btn->CheckedChanged += gcnew System::EventHandler(this, &Form1::STERN_btn_CheckedChanged);
			// 
			// GOTTLIEB_btn
			// 
			this->GOTTLIEB_btn->AutoSize = true;
			this->GOTTLIEB_btn->Location = System::Drawing::Point(12, 174);
			this->GOTTLIEB_btn->Name = L"GOTTLIEB_btn";
			this->GOTTLIEB_btn->Size = System::Drawing::Size(137, 17);
			this->GOTTLIEB_btn->TabIndex = 5;
			this->GOTTLIEB_btn->TabStop = true;
			this->GOTTLIEB_btn->Text = L"Gottlieb pinball machine";
			this->GOTTLIEB_btn->UseVisualStyleBackColor = true;
			this->GOTTLIEB_btn->CheckedChanged += gcnew System::EventHandler(this, &Form1::GOTTLIEB_btn_CheckedChanged);
			// 
			// DATAEAST_btn
			// 
			this->DATAEAST_btn->AutoSize = true;
			this->DATAEAST_btn->Location = System::Drawing::Point(12, 202);
			this->DATAEAST_btn->Name = L"DATAEAST_btn";
			this->DATAEAST_btn->Size = System::Drawing::Size(145, 17);
			this->DATAEAST_btn->TabIndex = 6;
			this->DATAEAST_btn->TabStop = true;
			this->DATAEAST_btn->Text = L"DataEast pinball machine";
			this->DATAEAST_btn->UseVisualStyleBackColor = true;
			this->DATAEAST_btn->CheckedChanged += gcnew System::EventHandler(this, &Form1::DATAEAST_btn_CheckedChanged);
			// 
			// WHITESTAR_btn
			// 
			this->WHITESTAR_btn->AutoSize = true;
			this->WHITESTAR_btn->Location = System::Drawing::Point(12, 230);
			this->WHITESTAR_btn->Name = L"WHITESTAR_btn";
			this->WHITESTAR_btn->Size = System::Drawing::Size(146, 17);
			this->WHITESTAR_btn->TabIndex = 7;
			this->WHITESTAR_btn->TabStop = true;
			this->WHITESTAR_btn->Text = L"Whitestar pinball machine";
			this->WHITESTAR_btn->UseVisualStyleBackColor = true;
			this->WHITESTAR_btn->CheckedChanged += gcnew System::EventHandler(this, &Form1::WHITESTAR_btn_CheckedChanged);
			// 
			// DispTime0
			// 
			this->DispTime0->Enabled = false;
			this->DispTime0->LargeChange = 50;
			this->DispTime0->Location = System::Drawing::Point(35, 286);
			this->DispTime0->Maximum = 13823;
			this->DispTime0->Minimum = 2048;
			this->DispTime0->Name = L"DispTime0";
			this->DispTime0->Size = System::Drawing::Size(250, 45);
			this->DispTime0->SmallChange = 10;
			this->DispTime0->TabIndex = 19;
			this->DispTime0->TickStyle = System::Windows::Forms::TickStyle::None;
			this->DispTime0->Value = 12239;
			this->DispTime0->Scroll += gcnew System::EventHandler(this, &Form1::DispTime0_Scroll);
			// 
			// DispTime1
			// 
			this->DispTime1->Enabled = false;
			this->DispTime1->LargeChange = 50;
			this->DispTime1->Location = System::Drawing::Point(35, 311);
			this->DispTime1->Maximum = 11263;
			this->DispTime1->Minimum = 160;
			this->DispTime1->Name = L"DispTime1";
			this->DispTime1->Size = System::Drawing::Size(250, 45);
			this->DispTime1->SmallChange = 10;
			this->DispTime1->TabIndex = 20;
			this->DispTime1->TickStyle = System::Windows::Forms::TickStyle::None;
			this->DispTime1->Value = 160;
			this->DispTime1->Scroll += gcnew System::EventHandler(this, &Form1::DispTime1_Scroll);
			// 
			// DispTime2
			// 
			this->DispTime2->Enabled = false;
			this->DispTime2->LargeChange = 50;
			this->DispTime2->Location = System::Drawing::Point(35, 337);
			this->DispTime2->Maximum = 11263;
			this->DispTime2->Minimum = 160;
			this->DispTime2->Name = L"DispTime2";
			this->DispTime2->Size = System::Drawing::Size(250, 45);
			this->DispTime2->SmallChange = 10;
			this->DispTime2->TabIndex = 21;
			this->DispTime2->TickStyle = System::Windows::Forms::TickStyle::None;
			this->DispTime2->Value = 320;
			this->DispTime2->Scroll += gcnew System::EventHandler(this, &Form1::DispTime2_Scroll);
			// 
			// DispTime3
			// 
			this->DispTime3->Enabled = false;
			this->DispTime3->LargeChange = 50;
			this->DispTime3->Location = System::Drawing::Point(35, 362);
			this->DispTime3->Maximum = 11263;
			this->DispTime3->Minimum = 160;
			this->DispTime3->Name = L"DispTime3";
			this->DispTime3->Size = System::Drawing::Size(250, 45);
			this->DispTime3->SmallChange = 10;
			this->DispTime3->TabIndex = 23;
			this->DispTime3->TickStyle = System::Windows::Forms::TickStyle::None;
			this->DispTime3->Value = 640;
			this->DispTime3->Scroll += gcnew System::EventHandler(this, &Form1::DispTime3_Scroll);
			// 
			// DispTime4
			// 
			this->DispTime4->Enabled = false;
			this->DispTime4->LargeChange = 50;
			this->DispTime4->Location = System::Drawing::Point(35, 388);
			this->DispTime4->Maximum = 11263;
			this->DispTime4->Minimum = 160;
			this->DispTime4->Name = L"DispTime4";
			this->DispTime4->Size = System::Drawing::Size(250, 45);
			this->DispTime4->SmallChange = 10;
			this->DispTime4->TabIndex = 22;
			this->DispTime4->TickStyle = System::Windows::Forms::TickStyle::None;
			this->DispTime4->Value = 1280;
			this->DispTime4->Scroll += gcnew System::EventHandler(this, &Form1::DispTime4_Scroll);
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Location = System::Drawing::Point(9, 289);
			this->label1->Name = L"label1";
			this->label1->Size = System::Drawing::Size(20, 13);
			this->label1->TabIndex = 24;
			this->label1->Text = L"T0";
			// 
			// label2
			// 
			this->label2->AutoSize = true;
			this->label2->Location = System::Drawing::Point(10, 314);
			this->label2->Name = L"label2";
			this->label2->Size = System::Drawing::Size(20, 13);
			this->label2->TabIndex = 25;
			this->label2->Text = L"T1";
			this->label2->Click += gcnew System::EventHandler(this, &Form1::label2_Click);
			// 
			// label3
			// 
			this->label3->AutoSize = true;
			this->label3->Location = System::Drawing::Point(9, 340);
			this->label3->Name = L"label3";
			this->label3->Size = System::Drawing::Size(20, 13);
			this->label3->TabIndex = 26;
			this->label3->Text = L"T2";
			// 
			// label4
			// 
			this->label4->AutoSize = true;
			this->label4->Location = System::Drawing::Point(9, 365);
			this->label4->Name = L"label4";
			this->label4->Size = System::Drawing::Size(20, 13);
			this->label4->TabIndex = 27;
			this->label4->Text = L"T3";
			// 
			// label5
			// 
			this->label5->AutoSize = true;
			this->label5->Location = System::Drawing::Point(9, 391);
			this->label5->Name = L"label5";
			this->label5->Size = System::Drawing::Size(20, 13);
			this->label5->TabIndex = 28;
			this->label5->Text = L"T4";
			// 
			// checkBox1
			// 
			this->checkBox1->AutoSize = true;
			this->checkBox1->Checked = true;
			this->checkBox1->CheckState = System::Windows::Forms::CheckState::Checked;
			this->checkBox1->Location = System::Drawing::Point(191, 261);
			this->checkBox1->Name = L"checkBox1";
			this->checkBox1->Size = System::Drawing::Size(89, 17);
			this->checkBox1->TabIndex = 29;
			this->checkBox1->Text = L"Lock Timings";
			this->checkBox1->UseVisualStyleBackColor = true;
			this->checkBox1->CheckedChanged += gcnew System::EventHandler(this, &Form1::checkBox1_CheckedChanged);
			// 
			// Brightness
			// 
			this->Brightness->Location = System::Drawing::Point(176, 215);
			this->Brightness->Name = L"Brightness";
			this->Brightness->Size = System::Drawing::Size(104, 45);
			this->Brightness->TabIndex = 30;
			this->Brightness->Scroll += gcnew System::EventHandler(this, &Form1::Brightness_Scroll);
			// 
			// label6
			// 
			this->label6->AutoSize = true;
			this->label6->Location = System::Drawing::Point(197, 199);
			this->label6->Name = L"label6";
			this->label6->Size = System::Drawing::Size(56, 13);
			this->label6->TabIndex = 31;
			this->label6->Text = L"Brightness";
			// 
			// WPC95_btn
			// 
			this->WPC95_btn->AutoSize = true;
			this->WPC95_btn->Location = System::Drawing::Point(12, 259);
			this->WPC95_btn->Name = L"WPC95_btn";
			this->WPC95_btn->Size = System::Drawing::Size(141, 17);
			this->WPC95_btn->TabIndex = 32;
			this->WPC95_btn->TabStop = true;
			this->WPC95_btn->Text = L"WPC-95 pinball machine";
			this->WPC95_btn->UseVisualStyleBackColor = true;
			this->WPC95_btn->CheckedChanged += gcnew System::EventHandler(this, &Form1::WPC95_btn_CheckedChanged);
			// 
			// Form1
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(292, 462);
			this->Controls->Add(this->WPC95_btn);
			this->Controls->Add(this->label6);
			this->Controls->Add(this->checkBox1);
			this->Controls->Add(this->label5);
			this->Controls->Add(this->label4);
			this->Controls->Add(this->label3);
			this->Controls->Add(this->label2);
			this->Controls->Add(this->label1);
			this->Controls->Add(this->reset_btn);
			this->Controls->Add(this->save_btn);
			this->Controls->Add(this->WHITESTAR_btn);
			this->Controls->Add(this->DATAEAST_btn);
			this->Controls->Add(this->GOTTLIEB_btn);
			this->Controls->Add(this->STERN_btn);
			this->Controls->Add(this->WMS_btn);
			this->Controls->Add(this->MONO_btn);
			this->Controls->Add(this->RGB_btn);
			this->Controls->Add(this->green_btn);
			this->Controls->Add(this->blue_btn);
			this->Controls->Add(this->pink_btn);
			this->Controls->Add(this->yellow_btn);
			this->Controls->Add(this->cyan_btn);
			this->Controls->Add(this->white_btn);
			this->Controls->Add(this->red_btn);
			this->Controls->Add(this->vga_btn);
			this->Controls->Add(this->successLabel);
			this->Controls->Add(this->StateLabel);
			this->Controls->Add(this->DispTime4);
			this->Controls->Add(this->DispTime3);
			this->Controls->Add(this->DispTime2);
			this->Controls->Add(this->DispTime1);
			this->Controls->Add(this->DispTime0);
			this->Controls->Add(this->Brightness);
			this->Name = L"Form1";
			this->Text = L"PIN2DMD ";
			this->FormClosed += gcnew System::Windows::Forms::FormClosedEventHandler(this, &Form1::Form1_FormClosed);
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime0))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime1))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime2))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime3))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->DispTime4))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->Brightness))->EndInit();
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion

private: System::Void save_btn_Click(System::Object^  sender, System::EventArgs^  e)
		 {	
			 sendConfig(1,0);
			 Sleep(500);
			 sendReset();
		}


private: System::Void reset_btn_Click(System::Object^  sender, System::EventArgs^  e)
		 {
			 DispTime0->Enabled=false;
			 DispTime1->Enabled=false;
			 DispTime2->Enabled=false;
			 DispTime3->Enabled=false;
			 DispTime4->Enabled=false;
			 DispTime0->Value = 12239;
			 Brightness->Minimum = 160;
			 Brightness->Maximum = DispTime0->Value/8;
			 Brightness->Value = 160;
			 checkBox1->Checked = true;
			 DispTime1->Maximum = DispTime0->Value-1024;
			 DispTime2->Maximum = DispTime0->Value-1024;
			 DispTime3->Maximum = DispTime0->Value-1024;
			 DispTime4->Maximum = DispTime0->Value-1024;
			 DispTime1->Value = Brightness->Value;
			 DispTime2->Value = Brightness->Value*2;
			 DispTime3->Value = Brightness->Value*4;
			 DispTime4->Value = Brightness->Value*8;
			 sendReset();
		 }


private: System::Void Form1_FormClosed(System::Object^  sender, System::Windows::Forms::FormClosedEventArgs^  e) {

		 }


private: System::Void vga_btn_Click(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(3,0);
		 }
private: System::Void red_btn_Click(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(3,1);
		 }
private: System::Void green_btn_Click(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(3,2);
		 }
private: System::Void blue_btn_Click(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(3,3);
		 }
private: System::Void pink_btn_Click(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(3,4);
		 }
private: System::Void yellow_btn_Click(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(3,6);
		 }
private: System::Void cyan_btn_Click(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(3,5);
		 }
private: System::Void white_btn_Click(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(3,7);
		 }
private: System::Void RGB_btn_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(2,0);
		 }
private: System::Void MONO_btn_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(2,1);
		 }
private: System::Void WMS_btn_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(2,2);
		 }
private: System::Void STERN_btn_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(2,3);
		 }
private: System::Void GOTTLIEB_btn_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(2,4);
		 }
private: System::Void DATAEAST_btn_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(2,5);
		 }
private: System::Void WHITESTAR_btn_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(2,6);
		 }
private: System::Void WPC95_btn_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 sendConfig(2,7);
		 }

private: System::Void DispTime0_Scroll(System::Object^  sender, System::EventArgs^  e) {
			 toolTip1->SetToolTip(DispTime0, String::Concat( "", DispTime0->Value));
			 DispTime1->Maximum = DispTime0->Value-1024;
			 DispTime2->Maximum = DispTime0->Value-1024;
			 DispTime3->Maximum = DispTime0->Value-1024;
			 DispTime4->Maximum = DispTime0->Value-1024;
			 sendDisplayTimings(DispTime0->Value,DispTime1->Value,DispTime2->Value,DispTime3->Value,DispTime4->Value);
		 }
private: System::Void DispTime1_Scroll(System::Object^  sender, System::EventArgs^  e) {
			toolTip1->SetToolTip(DispTime1, String::Concat( "", DispTime1->Value));
			sendDisplayTimings(DispTime0->Value,DispTime1->Value,DispTime2->Value,DispTime3->Value,DispTime4->Value);
		 }
private: System::Void DispTime2_Scroll(System::Object^  sender, System::EventArgs^  e) {
			 toolTip1->SetToolTip(DispTime2, String::Concat( "", DispTime2->Value));
			 sendDisplayTimings(DispTime0->Value,DispTime1->Value,DispTime2->Value,DispTime3->Value,DispTime4->Value);
		 }

private: System::Void DispTime3_Scroll(System::Object^  sender, System::EventArgs^  e) {
			 toolTip1->SetToolTip(DispTime3, String::Concat( "", DispTime3->Value));
			 sendDisplayTimings(DispTime0->Value,DispTime1->Value,DispTime2->Value,DispTime3->Value,DispTime4->Value);
		 }
private: System::Void DispTime4_Scroll(System::Object^  sender, System::EventArgs^  e) {
			 toolTip1->SetToolTip(DispTime4, String::Concat( "", DispTime4->Value));
			 sendDisplayTimings(DispTime0->Value,DispTime1->Value,DispTime2->Value,DispTime3->Value,DispTime4->Value);
		 }
private: System::Void label2_Click(System::Object^  sender, System::EventArgs^  e) {
		 }
private: System::Void checkBox1_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
				if (checkBox1->Checked){
					DispTime0->Enabled=false;
					DispTime1->Enabled=false;
					DispTime2->Enabled=false;
					DispTime3->Enabled=false;
					DispTime4->Enabled=false;
					Brightness->Maximum = (DispTime0->Value-1024)/8;
					Brightness->Minimum = 160;
					DispTime1->Value = Brightness->Value;
					DispTime2->Value = Brightness->Value*2;
					DispTime3->Value = Brightness->Value*4;
					DispTime4->Value = Brightness->Value*8;
					sendDisplayTimings(DispTime0->Value,DispTime1->Value,DispTime2->Value,DispTime3->Value,DispTime4->Value);
				} else {
					DispTime0->Enabled=true;
					DispTime1->Enabled=true;
					DispTime2->Enabled=true;
					DispTime3->Enabled=true;
					DispTime4->Enabled=true;
				}

		 }
private: System::Void Brightness_Scroll(System::Object^  sender, System::EventArgs^  e) {
			 Brightness->Maximum = (DispTime0->Value-1024)/8;
			 Brightness->Minimum = 160;
			 toolTip1->SetToolTip(Brightness, String::Concat( "", Brightness->Value));
			 DispTime1->Value = Brightness->Value;
			 DispTime2->Value = Brightness->Value*2;
			 DispTime3->Value = Brightness->Value*4;
			 DispTime4->Value = Brightness->Value*8;
			 sendDisplayTimings(DispTime0->Value,DispTime1->Value,DispTime2->Value,DispTime3->Value,DispTime4->Value);
		 }

};
}



