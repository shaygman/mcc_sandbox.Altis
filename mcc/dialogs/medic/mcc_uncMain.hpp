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
			text = "Blood Pressure:";
			x = 0.25 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.065 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class progressBar: MCC_RscProgress
		{
			idc = 3;
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.345469 * safezoneW;
			h = 0.033 * safezoneH;
			colorBar[] = {0.8,0,0,0.6};
			colorFrame[] = {1,1,1,0.8};
			colorBackground[] = {0,0,0,0.3};
		};
	};
};
