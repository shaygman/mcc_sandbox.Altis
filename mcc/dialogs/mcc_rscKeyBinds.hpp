class mcc_rscKeyBinds
{
	idd = -1;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\mcc_rscKeyBinds_init.sqf'");

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class frame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = { 0, 0, 0,0.9};

			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.438 * safezoneH;
		};

		class keyBindstittle: MCC_RscText
		{
			idc = -1;
			text = "Key Binds:"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};

			x = 0.345312 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class MCC_keyBindsLogin: MCC_keyBindsGroup
		{
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
		};

		class close: MCC_RscButtonMenu
		{
			idc = -1;
			text = "close"; //--- ToDo: Localize;
			action = "closeDialog 0";

			x = 0.438125 * safezoneW + safezoneX;
			y = 0.608 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};


