////////////////////////////////////////////////////////
// BY Shay Gman 03.2013
////////////////////////////////////////////////////////

#define MCC_SANDBOX_IDD 1000
#define MCC_SANDBOX2_IDD 2000
#define MCC_SANDBOX3_IDD 3000
#define MCC_SANDBOX4_IDD 4000
#define MCC_SANDBOX5_IDD 6000

#define MAIN 1050
#define MENU2 1051
#define MENU3 1052
#define MENU4 1053
#define MENU5 1054

#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007
#define TSMONTH 1010
#define TSDAY 1011
#define TSHOUR 1012
#define TSMINUTE 1013
#define MCCSTOPCAPTURE 1014
#define MCCSTARTWEST 1015
#define MCCSTARTEAST 1016
#define MCCSTARTGUAR 1017
#define MCCSTARTCIV 1018

#define MCCENABLECP 1027

class MCC_Sandbox {
	  idd = MCC_SANDBOX_IDD;
	  movingEnable = true;
	  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_gui_init1.sqf'");
	  
	  controlsBackground[] = 
	  {
	  MCC_pic,
	  MCC_background,
	  MCC_Title,
	  MCC_logo,
	  MCC_mapBckg
	  };
	  

	  //---------------------------------------------
	  objects[] = 
	  { 
	  };
	  
	  controls[] = 
	  {
	  MCC_map,
	  MCC_Menu1,
	  MCC_Menu2,
	  MCC_Menu3,
	  MCC_Menu4,
	  MCC_Menu5,
	  MCC_viewDistanceTittle,
	  MCC_viewDistance,
	  MCC_grassDensityTittle,
	  MCC_grassDensity,
	  MCC_stopCapture,
	  MCC_groupGenerator,
	  MCC_StartWest,
	  MCC_StartEast,
	  MCC_StartGuar,
	  MCC_StartCiv,
	  MCC_StartEnableCP,
	  MCC_FOBWest,
	  MCC_FOBEast,
	  MCC_FOBGuar,
	  MCC_StartLocationsTittle,
	  MCC_CSSettings,
	  MCC_saveLoad,
	  MCC_login,
	  MCC_Close	  
	   };

class MCC_logo: MCC_RscPicture	{idc = -1;text = __EVAL(MCCPATH +"mcc\pop_menu\mcc1.paa");x = 0.185546 * safezoneW + safezoneX;
	y = 0.159984 * safezoneH + safezoneY;
	w = 0.171476 * safezoneW;
	h = 0.22101 * safezoneH;
};
class MCC_Title: MCC_RscText	{idc = -1;text = __EVAL ("MCC Sandbox V"+MCCVersion+" By shay_gman, Spirit & Ollem");x = 0.185546 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.161476 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.52)";
};

class MCC_map: MCC_RscMapControl {idc = -1; moving = true; 	text = "";	
	x = 0.525552 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.303646 * safezoneW;
	h = 0.406841 * safezoneH;
	onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseDown.sqf'");
	onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseUp.sqf'");
	onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseMoving.sqf'");
};
class MCC_mapBckg: MCC_RscText {idc = -1; moving = true; 	text = "";	
	x = 0.525552 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.303646 * safezoneW;
	h = 0.406841 * safezoneH;
	colorBackground[] = {1,1,1,1};
};
class MCC_Menu1: MCC_RscButtonMenu	{idc = MAIN;text = "Main";	x = 0.355521 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
};
class MCC_Menu2: MCC_RscButtonMenu	{idc = MENU2;text = "Menu 2";x = 0.449008 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
};
class MCC_Menu3: MCC_RscButtonMenu	{idc = MENU3;text = "Menu 3"; x = 0.542494 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
};
class MCC_Menu4: MCC_RscButtonMenu	{idc = MENU4;text = "Menu 4"; x = 0.63598 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
};
class MCC_Menu5: MCC_RscButtonMenu	{idc = MENU5;text = "Menu 5";x = 0.729466 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	onButtonClick = __EVAL ("[6] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
}
class MCC_viewDistanceTittle: MCC_RscText {idc = -1; text = "View:"; 
	x = 0.185583 * safezoneW + safezoneX;
	y = 0.483067 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_grassDensityTittle: MCC_RscText {idc = -1; text = "Grass:"; 
	x = 0.185583 * safezoneW + safezoneX;
	y = 0.516933 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_viewDistance: MCC_RscCombo {idc = MCCVIEWDISTANCE; 
	x = 0.245052 * safezoneW + safezoneX;
	y = 0.494942 * safezoneH + safezoneY;
	w = 0.0802083 * safezoneW;
	h = 0.0219914 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onLBSelChanged =  __EVAL("[2] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
};
class MCC_grassDensity: MCC_RscCombo {idc = MCCGRASSDENSITY;
	x = 0.245052 * safezoneW + safezoneX;
	y = 0.529029 * safezoneH + safezoneY;
	w = 0.0802083 * safezoneW;
	h = 0.0219914 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onLBSelChanged =  __EVAL("[1] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
};

class MCC_stopCapture: MCC_RscButton {idc = MCCSTOPCAPTURE;	text = "Stop Capturing"; 
	x = 0.185583 * safezoneW + safezoneX;
	y = 0.39796 * safezoneH + safezoneY;
	w = 0.161477 * safezoneW;
	h = 0.0340016 * safezoneH;
	onButtonClick = "ctrlEnable [1014,false];MCC_capture_state=false;";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};

class MCC_groupGenerator: MCC_RscButton {idc = -1;	text = "Group Generator"; 
	x = 0.474448 * safezoneW + safezoneX;
	y = 0.39796 * safezoneH + safezoneY;
	w = 0.101985 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Open Group Generator"; 
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'mcc_groupGen';} else {player globalchat 'Access Denied'};";
};
class MCC_StartWest: MCC_RscButton {idc = MCCSTARTWEST;	text = "West"; 	
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.489004 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,0,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set west start location"; 
	action = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartEast: MCC_RscButton {idc = MCCSTARTEAST;	text = "East"; 
	x = 0.442708 * safezoneW + safezoneX;
	y = 0.489004 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {1,0,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set east start location"; 
	action = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartGUAR: MCC_RscButton {idc = MCCSTARTGUAR; text = "Independent"; 
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.532987 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,1,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set GUAR start location"; 
	action = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartCiv: MCC_RscButton {idc = MCCSTARTCIV; text = "Civ";
	x = 0.442708 * safezoneW + safezoneX;
	y = 0.532987 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set civilians start location"; 
	action = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartEnableCP: MCC_RscButton
{
	idc = MCCENABLECP;
	action = __EVAL("[6] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
	text = "Role Selection"; //--- ToDo: Localize;
	x = 0.43125 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0329871 * safezoneH;
	tooltip = "If pressed before a start position to the given side has been set it will open a role selection menu to all players"; 
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_StartLocationsTittle: MCC_RscText {idc = -1; text = "Start Locations:"; 
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.101985 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_CSSettings: MCC_RscText {idc = -1; text = "Client Side Settings:"; 
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.127481 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};

class MCC_saveLoad: MCC_RscButtonMenu {idc = -1; text = "Save/Load"; x = 0.185546 * safezoneW + safezoneX;
	y = 0.857016 * safezoneH + safezoneY;
	w = 0.110484 * safezoneW;
	h = 0.0510023 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'MCC_SaveLoadScreen';} else {player globalchat 'Access Denied'};";
};
class MCC_login: MCC_RscButtonMenu {idc = -1; text = "Login/Logout"; x = 0.304529 * safezoneW + safezoneX;
	y = 0.857016 * safezoneH + safezoneY;
	w = 0.127481 * safezoneW;
	h = 0.0510023 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Login or logout as the mission maker"; 
	onButtonClick = __EVAL("nul=[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_login.sqf'");
};
class MCC_Close: MCC_RscButtonMenu {idc = -1; text = "Close"; x = 0.440509 * safezoneW + safezoneX;
	y = 0.857016 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0510023 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onButtonClick = "closeDialog 0";
};
class MCC_background: MCC_RscText {idc = -1; text = "";
	x = 0.168549 * safezoneW + safezoneX;
	y = 0.0919812 * safezoneH + safezoneY;
	w = 0.662902 * safezoneW;
	h = 0.816037 * safezoneH;
	colorBackground[] = {0,0,0,0.8};
};
class MCC_pic: MCC_RscPicture {idc = -1; text = __EVAL(MCCPATH +"mcc\dialogs\mcc_background.paa");x = 0.1 * safezoneW + safezoneX;
	y = 0.005 * safezoneH + safezoneY;
	w = 0.8 * safezoneW;
	h = 1.01 * safezoneH;
};
//---------------------FOB------------------------------------------------
class MCC_FOBWest: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[7] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");

	text = "FOB"; //--- ToDo: Localize;
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.620953 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,0,1,1};
	tooltip = "Set west FOB (will work only if Role Selection is on)"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_FOBEast: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[8] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");

	text = "FOB"; //--- ToDo: Localize;
	x = 0.404762 * safezoneW + safezoneX;
	y = 0.620953 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {1,0,0,1};
	tooltip = "Set east FOB (will work only if Role Selection is on)"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_FOBGuar: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[9] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");

	text = "FOB"; //--- ToDo: Localize;
	x = 0.459896 * safezoneW + safezoneX;
	y = 0.620953 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,1,0,1};
	tooltip = "Set resistance FOB (will work only if Role Selection is on)"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
};