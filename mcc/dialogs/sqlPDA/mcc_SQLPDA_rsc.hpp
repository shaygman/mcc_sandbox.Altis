// By: Shay_gman
// Version: 1.1 (May 2012)
#define MCC_SQLPDA_IDD 2996
#define MCC_MINIMAP 9120

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_SQLPDA_rsc
{
	idd = MCC_SQLPDA_IDD;
	movingEnable = 1;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "MCC_SQLPDA_rsc";

	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\sqlPDA\mcc_sqlpda_rsc_init.sqf'");


	class controls
	{
		class MCC_sqlpdaMapBackground : MCC_RscPicture
		{
			idc = 22;
			moving = true;
			x = 0.139062 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.27 * safezoneW;
			h = 0.341 * safezoneH;
		};
		class MCC_sqlpdaMap : MCC_RscMapControl {
			idc = MCC_MINIMAP;
			moving = true;
			colorBackground[] = { 1, 1, 1, 1};
			colorText[] = { 1, 1, 1, 0};
			x = 0.139062 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.27 * safezoneW;
			h = 0.341 * safezoneH;
			onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\pda\mouseDown.sqf'");
			onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\pda\mouseUp.sqf'");
			onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\pda\mouseDblClick.sqf'");
			onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\pda\mouseMoving.sqf'");
		};
	};
};
