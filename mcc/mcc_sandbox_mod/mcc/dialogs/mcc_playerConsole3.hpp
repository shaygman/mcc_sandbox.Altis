// By: Shay_gman
// Version: 1.1 (April 2013)

#define mcc_playerConsole3_IDD 5010

#define MCC_CONSOLE_AC_BCKG 5011
#define MCC_CONSOLE_AC_MISSILE_COUNT 5012
#define MCC_CONSOLE_AC_MISSILE_COUNT2 5019
#define MCC_CONSOLE_AC_MISSILE_COUNT3 5020
#define MCC_CONSOLE_AC_VISION_TEXT 5013
#define MCC_CONSOLE_AC_TIME_TEXT 5014
#define MCC_CONSOLE_AC_ZOOM_TEXT 5015
#define MCC_CONSOLE_AC_TARGET 5016
#define MCC_CONSOLE_AC_WEAPON 5017
#define MCC_CONSOLE_ACPIP 5018
#define MCC_CONSOLE_AC_DIR_TEXT 5021
#define MCC_CONSOLE_COMPASS_N 9116
#define MCC_CONSOLE_COMPASS_E 9117
#define MCC_CONSOLE_COMPASS_S 9118
#define MCC_CONSOLE_COMPASS_W 9119
#define MCC_CONSOLE_AC_MAP 5022

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_playerConsole3 {
  idd = mcc_playerConsole3_IDD;
  movingEnable = 1;
  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_playerConsole3_init.sqf'"); 
  
  controlsBackground[] = 
  {
  mcc_ConsolePic,
  mcc_ConsoleBackground,
  MCC_ConsoleACFeedFrame,
  MCC_ConsoleACFeed,
  MCC_ConsoleACFeedBckg
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
  MCC_ConsoleACFeedTargetPic,
  MCC_ConsoleACFeedFake,
  MCC_ConsoleACCamera,
  MCC_ConsoleACMissileCount,
  MCC_ConsoleACMissileCount2,
  MCC_ConsoleACMissileCount3,
  MCC_ConsoleACVisionText,
  MCC_ConsoleACTimeText,
  MCC_ConsoleACZoomText,
  MCC_ConsoleACWeapon,
  MCC_ConsoleACDirText,
  MCC_ConsoleCompassN,
  MCC_ConsoleCompassE,
  MCC_ConsoleCompassS,
  MCC_ConsoleCompassW,
  MCC_mapConsole,
  MCC_ConsoleACMap

  };
  
 //========================================= Background========================================
	class mcc_ConsolePic: MCC_RscPicture	{idc = -1;text = __EVAL(MCCPATH +"data\console.paa");
		x = -0.0446875 * safezoneW + safezoneX;
		y = 0.0939094 * safezoneH + safezoneY;
		w = 1.00406 * safezoneW;
		h = 0.840187 * safezoneH;
	};
	class mcc_ConsoleBackground: MCC_RscText	{idc = -1;text = "";colorBackground[] = { 0, 0, 0, 1};x = 0.204688 * safezoneW + safezoneX;y = 0.2025 * safezoneH + safezoneY;w = 0.590625 * safezoneW;h = 0.595 * safezoneH;};
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
class MCC_ConsoleExitButton: MCC_RscButton 
{
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
		onButtonClick = "closedialog 0; MCC_ConsoleOperator =''; publicVariable 'MCC_ConsoleOperator'";
};
	//=============================UAV========================================================
	class MCC_ConsoleACFeed: MCC_RscPicture
	{
		idc = MCC_CONSOLE_ACPIP;
		text = "#(argb,512,512,1)r2t(rendertarget8,1.0);";
		x = 0.219271 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.561458 * safezoneW;
		h = 0.472816 * safezoneH;
	};
	class MCC_ConsoleACFeedBckg: MCC_RscText
	{
		idc = MCC_CONSOLE_AC_BCKG;
		text = "";
		style = MCCST_CENTER;
		x = 0.219271 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.561458 * safezoneW;
		h = 0.472816 * safezoneH;
		
	};
	class MCC_ConsoleACFeedTargetPic: MCC_RscPicture
	{
		idc = MCC_CONSOLE_AC_TARGET;
		x = 0.219271 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.561458 * safezoneW;
		h = 0.472816 * safezoneH;
		
	};
	class MCC_ConsoleACFeedFrame: MCC_RscFrame
	{
		idc = -1;
		x = 0.219271 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.561458 * safezoneW;
		h = 0.472816 * safezoneH;
	};
	class MCC_ConsoleACFeedFake: MCC_RscListBox {
		idc = -1;
		x = 0.219271 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.561458 * safezoneW;
		h = 0.472816 * safezoneH;
		onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\ACmouseDown.sqf'");
		onMouseButtonUp = "MCC_consoleACmousebuttonUp = true;";
		onMouseZChanged = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\ACmousez.sqf'");
		onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\ACmouseMoving.sqf'");
	};
	class MCC_ConsoleACCamera: MCC_RscToolbox
	{
		idc = -1;
		onToolBoxSelChanged = __EVAL("_this execVM '"+MCCPATH+"mcc\general_scripts\console\ac_camView.sqf'");
		strings[] = {"Regular","N/V","Thermal"};
		rows = 1;
		columns = 3;
		values[] = {0,1,3};
		x = 0.219271 * safezoneW + safezoneX;
		y = 0.708919 * safezoneH + safezoneY;
		w = 0.131771 * safezoneW;
		h = 0.0329871 * safezoneH;
		tooltip = "Change UAV camera mod"; 
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_ConsoleACWeapon: MCC_RscToolbox
	{
		idc = MCC_CONSOLE_AC_WEAPON;
		onToolBoxSelChanged = __EVAL("_this execVM '"+MCCPATH+"mcc\general_scripts\console\ac_weaponChange.sqf'");
		strings[] = {"25mm","40mm","105mm"};
		rows = 1;
		columns = 3;
		values[] = {0,1,2};
		x = 0.4 * safezoneW + safezoneX;
		y = 0.708919 * safezoneH + safezoneY;
		w = 0.131771 * safezoneW;
		h = 0.0329871 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};	
	
	class MCC_ConsoleACMissileCount: MCC_RscText
	{
		idc = MCC_CONSOLE_AC_MISSILE_COUNT;
		x = 0.682708 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.05 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	
	class MCC_ConsoleACMissileCount2: MCC_RscText
	{
		idc = MCC_CONSOLE_AC_MISSILE_COUNT2;
		x = 0.682708 * safezoneW + safezoneX;
		y = 0.56 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.05 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	
	class MCC_ConsoleACMissileCount3: MCC_RscText
	{
		idc = MCC_CONSOLE_AC_MISSILE_COUNT3;
		x = 0.682708 * safezoneW + safezoneX;
		y = 0.62 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.05 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	
	class MCC_ConsoleACVisionText: MCC_RscText
	{
		idc = MCC_CONSOLE_AC_VISION_TEXT;
		x = 0.230729 * safezoneW + safezoneX;
		y = 0.637963 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class MCC_ConsoleACTimeText: MCC_RscStructuredText
	{
		idc =MCC_CONSOLE_AC_TIME_TEXT;
		style = MCCST_MULTI;
		x = 0.6 * safezoneW + safezoneX;
		y = 0.236103 * safezoneH + safezoneY;
		w = 0.12 * safezoneW;
		h = 0.239828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class MCC_ConsoleACZoomText: MCC_RscText
	{
		idc = MCC_CONSOLE_AC_ZOOM_TEXT;

		x = 0.230729 * safezoneW + safezoneX;
		y = 0.236103 * safezoneH + safezoneY;
		w = 0.0916667 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class MCC_ConsoleACDirText: MCC_RscText
	{
		idc = MCC_CONSOLE_AC_DIR_TEXT;

		x = 0.45 * safezoneW + safezoneX;
		y = 0.236103 * safezoneH + safezoneY;
		w = 0.0916667 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
		class MCC_ConsoleCompassN: MCC_RscText
	{
		idc = MCC_CONSOLE_COMPASS_N;
		text = "N";

		x = 0.5 * safezoneW + safezoneX;
		y = 0.25 * safezoneH + safezoneY;
		w = 0.05 * safezoneW;
		h = 0.05 * safezoneH;
		colorText[] = {1,0,0,0.7};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class MCC_ConsoleCompassE: MCC_ConsoleCompassN
	{
		idc = MCC_CONSOLE_COMPASS_E;
		colorText[] = {1,1,1,1};
		text = "E";
	};
	class MCC_ConsoleCompassS: MCC_ConsoleCompassE
	{
		idc = MCC_CONSOLE_COMPASS_S;
		text = "S";
	};
	class MCC_ConsoleCompassW: MCC_ConsoleCompassE
	{
		idc = MCC_CONSOLE_COMPASS_W;
		text = "W";
	};
		class MCC_mapConsole : MCC_RscMapControl {
		idc = MCC_MINIMAP;
		moving = true;
		colorBackground[] = { 1, 1, 1, 1};
		colorText[] = { 1, 1, 1, 0};
		x = 0.788749 * safezoneW + safezoneX;
		y = 0.212936 * safezoneH + safezoneY;
		w = 0.01 * safezoneW;
		h = 0.01 * safezoneH;
	};
	class MCC_ConsoleACMap: MCC_RscButton
	{
		idc = MCC_CONSOLE_AC_MAP;
		x = 0.6 * safezoneW + safezoneX;
		y = 0.708919 * safezoneH + safezoneY;
		w = 0.07 * safezoneW;
		h = 0.0329871 * safezoneH;
		text = "Open Map";
		onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleMap.sqf'");
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
};
