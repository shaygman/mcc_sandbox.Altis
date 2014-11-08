// By: Shay_gman
// Version: 1.1 (September 2011)
#define missionSettings_IDD 2997

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class missionSettings 
{
	idd = missionSettings_IDD;
	movingEnable = true;
	onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_missionSettings_init.sqf'"); 

	controlsBackground[] = 
	{
	};

	objects[] = 
	{ 
	};

	class controls 
	{
		class RscPicture_1200: MCC_RscText 
		{
			idc = -1;
			moving = true;
			x = 0.12875 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.670312 * safezoneW;
			h = 0.583 * safezoneH;
			text = "";
			colorBackground[] = { 0, 0, 0, 0.8 };
		};

		class confirmButton: MCC_RscButton
		{
			idc = -1;
			action = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\mission_settings_change.sqf'");

			text = "Confirm"; //--- ToDo: Localize;
			x = 0.670156 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0439828 * safezoneH;
		};

		class CancelButton: MCC_RscButton
		{
			idc = -1;
			action = "closeDialog 0";

			text = "Cancel"; //--- ToDo: Localize;
			x = 0.133906 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0439828 * safezoneH;
		};	
		
		#include "settings\rscMCCSettings.hpp"
		#include "settings\rscGAIASettings.hpp"
		#include "settings\rscMechanicsSettings.hpp"
	};
};
