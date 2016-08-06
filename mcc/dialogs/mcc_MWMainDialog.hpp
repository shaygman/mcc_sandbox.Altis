#define MCC_MINIMAP 9000
#define MCCMWDialog_IDD 2989

class MCCMWDialog
{
	idd = MCCMWDialog_IDD;
	movingEnable = true;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\mcc_mw_init.sqf'");

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class MCCMWDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = { 0.051, 0.051, 0.051,1};

			x = 0.225 * safezoneW + safezoneX;
			y = 0.11515 * safezoneH + safezoneY;
			w = 0.55 * safezoneW;
			h = 0.76 * safezoneH;
		};

		class MCCMWDialoglogo: MCC_RscPicture
		{
			idc = -1;
			text = __EVAL(MCCPATH +"data\mcc_loadingScreen.paa");

			x = 0.230729 * safezoneW + safezoneX;
			y = 0.126146 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.318876 * safezoneH;
		};
		class MCCMWDialoghelptext: MCC_RscStructuredText
		{
			idc = 0;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";

			x = 0.230729 * safezoneW + safezoneX;
			y = 0.445021 * safezoneH + safezoneY;
			w = 0.303646 * safezoneW;
			h = 0.0549786 * safezoneH;
		};

		class MCCMWDialogClose: MCC_RscButtonMenu
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			action = "MCC_mcc_screen = 2;closeDialog 0;";

			x = 0.694792 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
		};


		//Generate
		class MCC_MWGenerate: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\missionWizard\scripts\missionWizardInit.sqf'");
			text = "Generate Mission"; //--- ToDo: Localize;

			x = 0.45 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.085 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Generate a mission "; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};

		class MCC_mapBackground : MCC_RscText
		{
			idc = -1;

			x = 0.53 * safezoneW + safezoneX;
			y = 0.126146 * safezoneH + safezoneY;
			w = 0.240625 * safezoneW;
			h = 0.318876 * safezoneH;

			colorBackground[] = { 1, 1, 1, 1};
			colorText[] = { 1, 1, 1, 0};
			text = "";
		};

		class MCC_map : MCC_RscMapControl
		{
			idc = MCC_MINIMAP;

			x = 0.53 * safezoneW + safezoneX;
			y = 0.126146 * safezoneH + safezoneY;
			w = 0.240625 * safezoneW;
			h = 0.318876 * safezoneH;

			text = "";
			onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDown.sqf'");
			onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseUp.sqf'");
			onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDblClick.sqf'");
			onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseMoving.sqf'");
		};

		class MCCMWZoneTittle: MCC_RscText
		{
			idc = -1;
			text = "Zone:";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			x = 0.540104 * safezoneW + safezoneX;
			y = 0.456017 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
		};

		class MCCMWZoneCombo: MCC_RscCombo
		{
			idc = 1023;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged = __EVAL("[0,0,0] execVM '"+MCCPATH+"mcc\pop_menu\zones.sqf'");

			x = 0.591667 * safezoneW + safezoneX;
			y = 0.456017 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.0219914 * safezoneH;
		};

		class MCCMWZoneUpdateButton: MCC_RscButton
		{
			idc = -1;
			text = "Update Zone";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			tooltip = "Click and drag on the minimap to make a zone";
			onButtonClick = "if (mcc_missionmaker == (name player)) then {MCC_zone_drawing= true;} else {player globalchat 'Access Denied'};";

			x = 0.700521 * safezoneW + safezoneX;
			y = 0.456017 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		#include "mcc_MWcontrols.hpp"
	};
};
