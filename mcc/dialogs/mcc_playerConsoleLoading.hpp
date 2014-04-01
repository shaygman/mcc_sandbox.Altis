// By: Shay_gman
// Version: 1.1 (May 2012)
#define mcc_playerConsole_IDD 2993
#define MCC_SaveLoadScreen_IDD 2992
#define MCC_playerConsoleLoading_IDD 2991

#define MCC_ConsoleLoadingText 9105

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_playerConsoleLoading {
  idd = MCC_playerConsoleLoading_IDD;
  movingEnable = true;
  
  controlsBackground[] = 
  {
  mcc_ConsolePic,
  mcc_ConsoleBackground
  };
  

  //---------------------------------------------
  objects[] = 
  { 
  };
  
  controls[] = 
  {
  MCC_ConsoleLoadingText,
  MCC_ConsoleExitButton
  };
  
 //========================================= Background========================================
	class mcc_ConsolePic: MCC_RscPicture	{idc = -1;text = __EVAL(MCCPATH +"data\console.paa");
		x = -0.0446875 * safezoneW + safezoneX;
		y = 0.0939094 * safezoneH + safezoneY;
		w = 1.00406 * safezoneW;
		h = 0.840187 * safezoneH;
	};
	class mcc_ConsoleBackground: MCC_RscText	{idc = -1;text = "";colorBackground[] = { 0, 0, 0, 1};x = 0.204688 * safezoneW + safezoneX;y = 0.2025 * safezoneH + safezoneY;w = 0.590625 * safezoneW;h = 0.595 * safezoneH;};
	class MCC_ConsoleLoadingText: MCC_RscText {idc = MCC_ConsoleLoadingText;text = ""; x = 0.47 * safezoneW + safezoneX;y = 0.45 * safezoneH + safezoneY;w = 0.2 * safezoneW;h = 0.05 * safezoneH;colorText[] = {1,1,1,1};colorBackground[] = {1,1,1,0};};
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
		onButtonClick = "closedialog 0;";
	};
};
