// By: Shay_gman
// Version: 1.1 (May 2012)
#define MCC_SANDBOX_IDD 1000
#define MCC_SANDBOX2_IDD 2000
#define MCC_SANDBOX3_IDD 3000
#define MCC_SANDBOX4_IDD 4000
#define MCC_MINIMAP 9000

#define mcc_playerConsole_IDD 2993

#define MCC_ConsoleCASAvailableTextBox_IDD 9100
#define MCC_ConsoleEvacFlyHightComboBox_IDD 9101
#define MCC_ConsoleEvacApproachComboBox_IDD 9102
#define MCC_ConsoleEvacTypeText_IDD 9103
#define MCC_ConsoleAirdropAvailableTextBox_IDD 9104

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_playerConsole {
  idd = mcc_playerConsole_IDD;
  movingEnable = 1;
  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_playerConsole_init.sqf'"); 
  
  controlsBackground[] = 
  {
  mcc_ConsolePic,
  mcc_ConsoleBackground,
  MCC_mapBackground,
  MCC_ConsoleCASFrame,
  MCC_ConsoleEvacFrame
  };
  

  //---------------------------------------------
  objects[] = 
  { 
  };
  
  controls[] = 
  {
  mcc_consoleF1,
  mcc_consoleF2,
  mcc_consoleF3,
  mcc_consoleF4,
  mcc_consoleF5,
  mcc_consoleF6,
  MCC_ConsoleExitButton,
  MCC_mapConsole,
  MCC_ConsoleCASAvailableText,
  MCC_ConsoleCASAvailableTextBox,
  MCC_ConsoleCallCASButton,
  MCC_ConsoleAirdropAvailableText,
  MCC_ConsoleAirdropAvailableTextBox,
  MCC_ConsoleAirdropCallButton,
  MCC_ConsoleEvacText,
  MCC_ConsoleEvacTypeText,
  MCC_ConsoleEvacType,
  MCC_ConsoleEvacFlyHightText,
  MCC_ConsoleEvacFlyHightComboBox,
  MCC_ConsoleEvacApproachText,
  MCC_ConsoleEvacApproachComboBox,
  MCC_ConsoleCallEvacButton,
  MCC_ConsoleCallEvac3WPButton
  };
  
 //========================================= Background========================================
	class mcc_ConsolePic: MCC_RscPicture	{idc = -1;text = __EVAL(MCCPATH +"data\console.paa");
		x = -0.0446875 * safezoneW + safezoneX;
		y = 0.0939094 * safezoneH + safezoneY;
		w = 1.00406 * safezoneW;
		h = 0.840187 * safezoneH;
	};
	class mcc_ConsoleBackground: MCC_RscText	{idc = -1;text = "";colorBackground[] = { 0, 0, 0, 1};x = 0.204688 * safezoneW + safezoneX;y = 0.2025 * safezoneH + safezoneY;w = 0.590625 * safezoneW;h = 0.595 * safezoneH;};
	class MCC_ConsoleCASFrame: MCC_RscFrame {idc = -1;
		x = 0.217419 * safezoneW + safezoneX;
		y = 0.254945 * safezoneH + safezoneY;
		w = 0.229687 * safezoneW;
		h = 0.0840187 * safezoneH;
	};
	class MCC_ConsoleEvacFrame: MCC_RscFrame {
		idc = -1;
		x = 0.217813 * safezoneW + safezoneX;
		y = 0.401978 * safezoneH + safezoneY;
		w = 0.229687 * safezoneW;
		h = 0.0700156 * safezoneH;
	};
//============================================Buttons==========================================
class mcc_consoleF1: MCC_RscButton
{
	idc = -1;
	x = 0.310937 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorBackground[] = {0,0,0,0};
	colorFocused[] = {1,1,1,0.2};
	colorShadow[] = { 0, 0, 0, 0};
	colorBorder[] = { 0, 0, 0, 0 };
	colorBackgroundActive[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleSwitchMenu.sqf'");
	tooltip = "Main Menu";
};
class mcc_consoleF2: MCC_RscButton
{
	idc = -1;
	x = 0.339583 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorBackground[] = {0,0,0,0};
	colorFocused[] = {1,1,1,0.2};
	colorShadow[] = { 0, 0, 0, 0};
	colorBorder[] = { 0, 0, 0, 0 };
	colorBackgroundActive[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleSwitchMenu.sqf'");
	tooltip = "UAV Control"; 
};
class mcc_consoleF3: MCC_RscButton
{
	idc = -1;
	x = 0.368229 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorBackground[] = {0,0,0,0};
	colorFocused[] = {1,1,1,0.2};
	colorShadow[] = { 0, 0, 0, 0};
	colorBorder[] = { 0, 0, 0, 0 };
	colorBackgroundActive[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleSwitchMenu.sqf'");
	tooltip = "AC-130 Control"; 
};
class mcc_consoleF4: MCC_RscButton
{
	idc = -1;
	x = 0.396875 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorBackground[] = {0,0,0,0};
	colorFocused[] = {1,1,1,0.2};
	colorShadow[] = { 0, 0, 0, 0};
	colorBorder[] = { 0, 0, 0, 0 };
	colorBackgroundActive[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	tooltip = "Forward observer artillery's interface"; 
	onButtonClick = __EVAL("[0,0,0,[1]] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleOpenMenu.sqf'");
};
class mcc_consoleF5: MCC_RscButton
{
	idc = -1;
	x = 0.425521 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorBackground[] = {0,0,0,0};
	colorFocused[] = {1,1,1,0.2};
	colorShadow[] = { 0, 0, 0, 0};
	colorBorder[] = { 0, 0, 0, 0 };
	colorBackgroundActive[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
};
class mcc_consoleF6: MCC_RscButton
{
	idc = -1;
	x = 0.454167 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorBackground[] = {0,0,0,0};
	colorFocused[] = {1,1,1,0.2};
	colorShadow[] = { 0, 0, 0, 0};
	colorBorder[] = { 0, 0, 0, 0 };
	colorBackgroundActive[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
};
 //===========================================Map==============================================
	class MCC_mapBackground : MCC_RscText {
		idc = -1;
		moving = true;
		colorBackground[] = { 1, 1, 1, 1};
		colorText[] = { 1, 1, 1, 0};
		x = 0.493437 * safezoneW + safezoneX;
		y = 0.212936 * safezoneH + safezoneY;
		w = 0.295312 * safezoneW;
		h = 0.266059 * safezoneH;
		text = "";
	};
	class MCC_mapConsole : MCC_RscMapControl {
		idc = MCC_MINIMAP;
		moving = true;
		colorBackground[] = { 1, 1, 1, 1};
		colorText[] = { 1, 1, 1, 0};
		x = 0.493437 * safezoneW + safezoneX;
		y = 0.212936 * safezoneH + safezoneY;
		w = 0.295312 * safezoneW;
		h = 0.266059 * safezoneH;
		onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseDown.sqf'");
		onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseUp.sqf'");
		onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseMoving.sqf'");
	};
 //========================================= Controls========================================
	//CAS
	class MCC_ConsoleCASAvailableText: MCC_RscText {
		idc = -1;
		text = "CAS Available:";
		x = 0.215581 * safezoneW + safezoneX;
		y = 0.202574 * safezoneH + safezoneY;
		w = 0.11849 * safezoneW;
		h = 0.035 * safezoneH;
		colorText[] = {0,1,1,1};
		colorBackground[] = {1,1,1,0};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class MCC_ConsoleCASAvailableTextBox: MCC_RscListBox {
		idc = MCC_ConsoleCASAvailableTextBox_IDD;
		x = 0.217419 * safezoneW + safezoneX;
		y = 0.254945 * safezoneH + safezoneY;
		w = 0.229687 * safezoneW;
		h = 0.0840187 * safezoneH;
	};
	class MCC_ConsoleCallCASButton: MCC_RscButton {
		idc = -1;
		text = "Call CAS";
		x = 0.36875 * safezoneW + safezoneX;
		y = 0.205934 * safezoneH + safezoneY;
		w = 0.07875 * safezoneW;
		h = 0.0280062 * safezoneH;
		tooltip = "Call selected CAS - Click and drag on the mini-map to define CAS's approach"; 
		onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\console\console_request.sqf'");
	};
	//Airdrop
	class MCC_ConsoleAirdropAvailableText: MCC_RscText {
		idc = -1;
		text = "Airdrop Available:";
		x = 0.215581 * safezoneW + safezoneX;
		y = 0.359969 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
		colorText[] = {0,1,1,1};
		colorBackground[] = {1,1,1,0};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class MCC_ConsoleAirdropAvailableTextBox: MCC_RscListBox {
		idc = MCC_ConsoleAirdropAvailableTextBox_IDD;
		x = 0.217813 * safezoneW + safezoneX;
		y = 0.401978 * safezoneH + safezoneY;
		w = 0.229687 * safezoneW;
		h = 0.0700156 * safezoneH;
	};
	class MCC_ConsoleAirdropCallButton: MCC_RscButton {
		idc = -1;text = "Call Airdrop";
		x = 0.362187 * safezoneW + safezoneX;
		y = 0.359969 * safezoneH + safezoneY;
		w = 0.07875 * safezoneW;
		h = 0.0280062 * safezoneH;
		tooltip = "Call selected airdrop - Click and drag on the mini-map to define airdrop's approach"; 
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\console_request.sqf'");
	};
	//==============================EVAC===========================================
	class MCC_ConsoleEvacText: MCC_RscText {
		idc = -1;
		text = "Evac Management:"; //--- ToDo: Localize;
		x = 0.215581 * safezoneW + safezoneX;
		y = 0.485997 * safezoneH + safezoneY;
		w = 0.142187 * safezoneW;
		h = 0.035 * safezoneH;
		colorText[] = {0,1,1,1};
		colorBackground[] = {1,1,1,0};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class MCC_ConsoleEvacTypeText: MCC_RscText {
		idc = -1;
		text = "Evac:"; //--- ToDo: Localize;
		x = 0.217813 * safezoneW + safezoneX;
		y = 0.542009 * safezoneH + safezoneY;
		w = 0.07875 * safezoneW;
		h = 0.0280062 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {1,1,1,0};
	};
	class MCC_ConsoleEvacType: MCC_RscCombo
	{
		idc = MCC_ConsoleEvacTypeText_IDD;
		onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\evac_focus.sqf'");
		x = 0.322812 * safezoneW + safezoneX;
		y = 0.542009 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_ConsoleEvacFlyHightText: MCC_RscText {
		idc = -1;
		text = "Flight Hight:"; //--- ToDo: Localize;
		x = 0.217813 * safezoneW + safezoneX;
		y = 0.626028 * safezoneH + safezoneY;
		w = 0.0853125 * safezoneW;
		h = 0.0280062 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {1,1,1,0};
	};
	class MCC_ConsoleEvacFlyHightComboBox: MCC_RscCombo {
		idc = MCC_ConsoleEvacFlyHightComboBox_IDD;
		x = 0.322812 * safezoneW + safezoneX;
		y = 0.626028 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_ConsoleEvacApproachText: MCC_RscText {
		idc = -1;
		text = "Insertion:"; //--- ToDo: Localize;
		x = 0.217813 * safezoneW + safezoneX;
		y = 0.584019 * safezoneH + safezoneY;
		w = 0.0853125 * safezoneW;
		h = 0.0280062 * safezoneH;
		colorBackground[] = {1,1,1,0};		
	};
	class MCC_ConsoleEvacApproachComboBox: MCC_RscCombo {
		idc = MCC_ConsoleEvacApproachComboBox_IDD;
		x = 0.322812 * safezoneW + safezoneX;
		y = 0.584019 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_ConsoleCallEvacButton: MCC_RscButton {
		idc = -1;text = "Call EVAC";
		x = 0.217813 * safezoneW + safezoneX;
		y = 0.668037 * safezoneH + safezoneY;
		w = 0.0853125 * safezoneW;
		h = 0.0420094 * safezoneH;
		tooltip = "Call selected EVAC - Mouse click on the mini-map to call it"; 
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\evacwp.sqf'");
	};
	class MCC_ConsoleCallEvac3WPButton: MCC_RscButton {
		idc = -1;
		text = "Call EVAC 3 WP";
		x = 0.322812 * safezoneW + safezoneX;
		y = 0.668037 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0420094 * safezoneH;
		tooltip = "Call selected EVAC - Mouse click on the mini-map to call it"; 
		onButtonClick = __EVAL("nul=[1] execVM '"+MCCPATH+"mcc\general_scripts\console\evacwp.sqf'");
	};
	//=================================Buttons=============================================
	class MCC_ConsoleExitButton: MCC_RscButton {
		idc = -1;
		text = "";
		x = 0.480312 * safezoneW + safezoneX;
		y = 0.822072 * safezoneH + safezoneY;
		w = 0.0328125 * safezoneW;
		h = 0.0420094 * safezoneH;
		colorBackground[] = {0,0,0,0};
		colorFocused[] = {1,1,1,0.2};
		colorShadow[] = { 0, 0, 0, 0};
		colorBorder[] = { 0, 0, 0, 0 };
		colorBackgroundActive[] = {0,0,0,0};
		colorDisabled[] = {0,0,0,0};
		colorBackgroundDisabled[] = {0,0,0,0};
		tooltip = "Close the conosle"; 
		onButtonClick = "closedialog 0;";
	};
};
