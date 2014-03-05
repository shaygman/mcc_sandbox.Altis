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
			h = 0.736713 * safezoneH;
		};

		class MCCMWDialoglogo: MCC_RscPicture
		{
			idc = -1;
			text = __EVAL(MCCPATH +"data\mcc_loadingScreen.paa");
			
			x = 0.230729 * safezoneW + safezoneX;
			y = 0.126146 * safezoneH + safezoneY;
			w = 0.538542 * safezoneW;
			h = 0.318876 * safezoneH;
		};
		class MCCMWDialoghelptext: MCC_RscStructuredText
		{
			idc = 0;
			x = 0.230729 * safezoneW + safezoneX;
			y = 0.445021 * safezoneH + safezoneY;
			w = 0.538542 * safezoneW;
			h = 0.0549786 * safezoneH;
		};
		
		class MCCMWDialogClose: MCC_RscButtonMenu
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			action = "MCC_mcc_screen = 2;closeDialog 0;";
			
			x = 0.694792 * safezoneW + safezoneX;
			y = 0.80788 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		#include "mcc_MWcontrols.hpp"
	};
};
