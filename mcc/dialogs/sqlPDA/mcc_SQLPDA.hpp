// By: Shay_gman
// Version: 1.1 (May 2012)
#define MCC_SQLPDA_IDD 2996
#define MCC_MINIMAP 9120
#define MCC_CONSOLEINFOTEXT 9150
#define MCC_CONSOLEINFOLIVEFEED 9151

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_SQLPDA
{
	idd = MCC_SQLPDA_IDD;
	movingEnable = 1;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\sqlPDA\mcc_sqlpda_init.sqf'");

	controlsBackground[] =
	{
		mcc_sqlpdaPic,
		MCC_sqlpdaMapBackground,
		MCC_sqlpdaMap,
		MCC_ConsoleInfoText
	};


	//---------------------------------------------
	objects[] =
	{
	};

	controls[] =
	{
		MCC_sqlpdaMenu0,
		MCC_sqlpdaMenu1,
		MCC_sqlpdaMenu2,
		MCC_ConsoleInfoLiveFeed,
		MCC_sqlpdaScaleButton,
		MCC_sqlpdaCloseLiveFeedButton,
		MCC_sqlpdaMove2BcgButton,
		MCC_sqlpdaExitButton
	};

	//========================================= Background========================================
	class mcc_sqlpdaPic: MCC_RscPicture
	{
		idc = 21;
		moving = true;
		text = __EVAL(MCCPATH +"mcc\dialogs\sqlPDA\data\mccpdasmall.paa");
		x = 0.116146 * safezoneW + safezoneX;
		y = 0.434 * safezoneH + safezoneY;
		w = 0.35 * safezoneW;
		h = 0.53 * safezoneH;
	};

	//===========================================Map==============================================
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

	class MCC_ConsoleInfoLiveFeed: MCC_RscButton
	{
		idc = 3;
		text = "Live Feed";
		x = 0.217813 * safezoneW + safezoneX;
		y = 0.668037 * safezoneH + safezoneY;
		w = 0.06 * safezoneW;
		h = 0.03 * safezoneH;
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\pda\liveFeed.sqf'");
	};

	class MCC_ConsoleInfoText: MCC_RscStructuredText
		{
			idc = 4;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
			colorBackground[] = {0,0,0,0.8};
		};


	class MCC_sqlpdaMenu0: MCC_RscListbox
	{
		idc = 0;
		moving = true;
		colorBackground[] = {0,0,0,0.7};
		x = 0 * safezoneW + safezoneX;
		y = 0 * safezoneH + safezoneY;
		w = 0 * safezoneW;
		h = 0.4 * safezoneH;
	};

	class MCC_sqlpdaMenu1 : MCC_RscListbox
	{
		idc = 1;
		moving = true;
		colorBackground[] = {0,0,0,0.7};
		x = 0 * safezoneW + safezoneX;
		y = 0 * safezoneH + safezoneY;
		w = 0 * safezoneW;
		h = 0.4 * safezoneH;
	};

	class MCC_sqlpdaMenu2 : MCC_RscListbox
	{
		idc = 2;
		moving = true;
		colorBackground[] = {0,0,0,0.7};
		x = 0 * safezoneW + safezoneX;
		y = 0 * safezoneH + safezoneY;
		w = 0 * safezoneW;
		h = 0.4 * safezoneH;
	};

	//=================================Buttons=============================================
	class MCC_sqlpdaExitButton: MCC_RscActivePicture
	{
		idc = 23;
		moving = true;
		text = __EVAL(MCCPATH +"mcc\dialogs\sqlPDA\data\power.paa");
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.885 * safezoneH + safezoneY;
		w = 0.0328125 * safezoneW;
		h = 0.0420094 * safezoneH;
		action = "closedialog 0;";
	};

	class MCC_sqlpdaScaleButton: MCC_RscActivePicture
	{
		idc = 24;
		moving = true;
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.885 * safezoneH + safezoneY;
		w = 0.0328125 * safezoneW;
		h = 0.0420094 * safezoneH;
	};

	class MCC_sqlpdaCloseLiveFeedButton: MCC_RscActivePicture
	{
		idc = 25;
		moving = true;
		text = __EVAL(MCCPATH +"mcc\dialogs\sqlPDA\data\back.paa");
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.885 * safezoneH + safezoneY;
		w = 0.0328125 * safezoneW;
		h = 0.0420094 * safezoneH;
		action = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\pda\liveFeed.sqf'");
	};

	class MCC_sqlpdaMove2BcgButton: MCC_RscActivePicture
	{
		idc = 26;
		moving = true;
		text = __EVAL(MCCPATH +"mcc\dialogs\sqlPDA\data\pin.paa");
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.885 * safezoneH + safezoneY;
		w = 0.0328125 * safezoneW;
		h = 0.0420094 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		action = "0 spawn {(['MCC_SQLPDA_rsc'] call BIS_fnc_rscLayer) cutRsc ['MCC_SQLPDA_rsc', 'PLAIN']};";
	};
};
