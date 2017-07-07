// By: Shay_gman
// Version: 1 (September 2014)

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_LOGISTICS_BASE_BUILD
{
	idd = -1;
	movingEnable = 1;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\rts\scripts\mcc_logisticsBaseBuild.sqf'");

	class controlsBackground
	{
		class mouseArea: MCC_RscListBox
		{
			idc = 2;
			colorBackground[] = {0,0,0,0};
			shadow = false;
			x = -0.000156274 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 1.00547 * safezoneW;
			h = 0.759 * safezoneH;

			onMouseMoving = "MCC_mousePos = [ _this select 1,_this select 2 ];";
			onMouseExit = "MCC_mousePos = nil;";
		};

		class bottomData: MCC_RscText
		{
			idc = -1;
			colorBackground[] = { 0.051, 0.051, 0.051,0.9};
			x = -0.0207813 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 1.02094 * safezoneW;
			h = 0.253 * safezoneH;
		};

		class mapSkirt: MCC_RscText
		{
			idc = -1;
			colorBackground[] = { 0.051, 0.051, 0.051,0.9};
			x = -0.000156274 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.225 * safezoneW;
			h = 0.088 * safezoneH;
		};

		class frameMiddle: MCC_RscFrame
		{
			idc = -1;

			x = 0.226719 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.417656 * safezoneW;
			h = 0.242 * safezoneH;
			colorBackground[] = {0.224,0.224,0.224,1};
		};
		class frameLeft: MCC_RscFrame
		{
			idc = -1;

			x = 0.649531 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.345469 * safezoneW;
			h = 0.253 * safezoneH;
			colorBackground[] = {0.224,0.224,0.224,1};
		};
		class frameRight: MCC_RscFrame
		{
			idc = -1;

			x = -0.000156274 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.225 * safezoneW;
			h = 0.352 * safezoneH;
			colorBackground[] = {0.224,0.224,0.224,1};
		};
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class side1Score: MCC_RscText
		{
			idc = 20;

			style = 0x02;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class side2Score: MCC_RscText
		{
			idc = 21;

			style = 0x02;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class side3Score: MCC_RscText
		{
			idc = 22;

			style = 0x02;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
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

		class feedBackText: MCC_RscText
		{
			idc = 9989;
			style = 2;
			//colorText[] = {1,0,0,0.8};
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.066 * safezoneH;
		};

		class mouseFeedBackText: MCC_RscText
		{
			idc = 9191;
			style = 2;
			//colorText[] = {1,0,0,0.8};
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 0 * safezoneW;
			h = 0 * safezoneH;
		};

		class selectBox: MCC_RscFrame
		{
			idc = 9929;
			x = 0;
			y = 0;
			w = 0;
			h = 0;
		};
		#include "rscRtsResources.hpp"
		#include "rscRtsManageSelected.hpp"

		class map: MCC_RscMapControl
		{
			idc = 9120;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.319 * safezoneH;

			onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseDown.sqf'");
			onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseUp.sqf'");
			onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseDblClick.sqf'");
			onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseMoving.sqf'");
		};
	};
};
