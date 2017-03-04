class mcc_uncMain
{
	idd = -1;
	movingEnable = 0;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\medic\mcc_uncMain_init.sqf'");
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		/*
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
		*/
		class info: MCC_RscText
		{
			idc = 2;
			text = "Blood Pressure:";
			x = 0.48 * safezoneW + safezoneX;
			y = 0.11 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class progressBar: MCC_RscProgress
		{
			idc = 3;
			x = 0.35 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.35 * safezoneW;
			h = 0.033 * safezoneH;
			colorBar[] = {0.8,0,0,0.6};
			colorFrame[] = {1,1,1,0.8};
			colorBackground[] = {0,0,0,0.3};
		};
		class RespawnText: MCC_RscText
		{
			idc = -1;
			text = "Hold Space To Respawn";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.76* safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RespawnProgressBar: MCC_RscProgress
		{
			idc = 4;
			x = 0.35 * safezoneW + safezoneX;
			y = 0.775 * safezoneH + safezoneY;
			w = 0.35 * safezoneW;
			h = 0.033 * safezoneH;
			colorBar[] = {0,0,0.8,0.6};
			colorFrame[] = {1,1,1,0.8};
			colorBackground[] = {0,0,0,0.3};
		};
	};
};
