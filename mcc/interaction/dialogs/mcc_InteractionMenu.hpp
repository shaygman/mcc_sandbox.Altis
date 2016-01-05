// By: Shay_gman
// Version: 0.1 (October 2014)

class MCC_INTERACTION_MENU
{
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""MCC_INTERACTION_MENU"", _this select 0]";

	controlsBackground[] =
	{
	};

	objects[] =
	{
	};

	class controls
	{
		class MCC_interactionMenu0: MCC_RscListbox
		{
			idc = 0;
			moving = true;
			colorBackground[] = {0,0,0,0.7};
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 0 * safezoneW;
			h = 0.8 * safezoneH;
		};

		class MCC_interactionMenu1: MCC_RscListbox
		{
			idc = 1;
			moving = true;
			colorBackground[] = {0,0,0,0.7};
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 0 * safezoneW;
			h = 0.8 * safezoneH;
		};

		class MCC_interactionMenu2: MCC_RscListbox
		{
			idc = 2;
			moving = true;
			colorBackground[] = {0,0,0,0.7};
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 0 * safezoneW;
			h = 0.8 * safezoneH;
		};
	};
};
