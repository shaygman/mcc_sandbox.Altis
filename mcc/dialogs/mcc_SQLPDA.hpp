// By: Shay_gman
// Version: 1.1 (May 2012)
#define MCC_SQLPDA_IDD 2996
#define MCC_MINIMAP 9120

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_SQLPDA 
{
	idd = MCC_SQLPDA_IDD;
	movingEnable = 1;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\mcc_sqlpda_init.sqf'"); 

	controlsBackground[] = 
	{
		mcc_sqlpdaPic,
		MCC_sqlpdaMapBackground,
		MCC_sqlpdaMap
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
		MCC_sqlpdaExitButton
	};

	//========================================= Background========================================
	class mcc_sqlpdaPic: MCC_RscPicture	
	{
		idc = -1;
		moving = true;
		text = __EVAL(MCCPATH +"data\mccpdasmall.paa");
		x = 0.116146 * safezoneW + safezoneX;
		y = 0.434 * safezoneH + safezoneY;
		w = 0.189063 * safezoneW;
		h = 0.528 * safezoneH;
	};

	//===========================================Map==============================================
	class MCC_sqlpdaMapBackground : MCC_RscPicture 
	{
		idc = -1;
		moving = true;
		x = 0.139062 * safezoneW + safezoneX;
		y = 0.533 * safezoneH + safezoneY;
		w = 0.143229 * safezoneW;
		h = 0.341 * safezoneH;
	};
	class MCC_sqlpdaMap : MCC_RscMapControl {
		idc = MCC_MINIMAP;
		moving = true;
		colorBackground[] = { 1, 1, 1, 1};
		colorText[] = { 1, 1, 1, 0};
		x = 0.139062 * safezoneW + safezoneX;
		y = 0.533 * safezoneH + safezoneY;
		w = 0.143229 * safezoneW;
		h = 0.341 * safezoneH;
		onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\pda\mouseDown.sqf'");
		onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\pda\mouseUp.sqf'");
		onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\pda\mouseDblClick.sqf'");
		onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\pda\mouseMoving.sqf'");
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
	class MCC_sqlpdaExitButton: MCC_RscButton 
	{
		idc = -1;
		moving = true;
		text = "Close";
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.885 * safezoneH + safezoneY;
		w = 0.0328125 * safezoneW;
		h = 0.0420094 * safezoneH;
		tooltip = "Close the conosle"; 
		onButtonClick = "closedialog 0;";
	};
};
