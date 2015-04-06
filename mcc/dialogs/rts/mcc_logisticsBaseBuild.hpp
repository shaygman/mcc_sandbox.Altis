// By: Shay_gman
// Version: 1 (September 2014)

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_LOGISTICS_BASE_BUILD
{
	idd = -1;
	movingEnable = 1;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\rts\mcc_logisticsBaseBuild.sqf'");

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class bottomData: MCC_RscText
		{
			idc = -1;
			colorBackground[] = { 0.051, 0.051, 0.051,0.9};
			x = -0.0207813 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 1.02094 * safezoneW;
			h = 0.253 * safezoneH;
		};

		class mouseArea: MCC_RscListBox
		{
			idc = 2;
			colorBackground[] = {0,0,0,0};
			x = -0.000156274 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 1.00547 * safezoneW;
			h = 0.759 * safezoneH;

			onMouseMoving = "MCC_mousePos = [ _this select 1,_this select 2 ];";
			onMouseExit = "MCC_mousePos = nil;";
		};

		class infoText: MCC_RscStructuredText
		{
			idc = 9999;
			colorBackground[] = {0,0,0,0};
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.209 * safezoneH;
		};

		class map: MCC_RscMapControl
		{
			idc = 1004;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.231 * safezoneH;

			onMouseButtonDown = "";
			onMouseButtonUp = "";
			onMouseButtonDblClick = "";
			onMouseMoving = "";
		};

		#include "rscRtsResources.hpp"
		#include "rscRtsManageSelected.hpp"
	};
};
