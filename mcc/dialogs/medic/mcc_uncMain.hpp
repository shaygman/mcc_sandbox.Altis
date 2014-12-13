class mcc_uncMain
{
	idd = -1;
	movingEnable = 0;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\medic\mcc_uncMain_init.sqf'");

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class respawn: MCC_RscButtonMenu
		{
			idc = 0;
			text = "Respawn";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.775 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class secondWind: MCC_RscButtonMenu
		{
			idc = 1;
			text = "Second wind";
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.775 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class info: MCC_RscText
		{
			idc = 2;
			text = "info";
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.11 * safezoneH;
		};
	};
};
