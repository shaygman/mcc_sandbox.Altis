class mcc_test
{
	idd = 9999999;
	movingEnable = true;
	onLoad ="";

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{ 	//(0.671875 * safezoneW + safezoneX) / safezoneW -X
	};	//(0.478009 * safezoneH + safezoneY) / safezoneH - Y

	class controls
	{
		class upperBckg1: MCC_RscText
		{
			idc = -1;
			x = 0 * safezoneW;
			y = 0 * safezoneH;
			w = 0.840469 * safezoneW;
			h = 0.11 * safezoneH;
			colorBackground[] = {0.192,0.192,0.192,0.9};
		};
		class MCC_missionName: MCC_RscText
		{
			idc = 1021;

			x = 0.00515597 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.180469 * safezoneW;
			h = 0.088 * safezoneH;
		};
		class MCC_exitButton: MCC_RscButtonMenu
		{
			action = "endMission 'END1' ";

			idc = 1006;
			text = "Exit Game";
			x = 0.737343 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.0928125 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class MCC_flag: MCC_RscPicture
		{
			idc = 20;

			x = 0.567187 * safezoneW;
			y = 0.066 * safezoneH;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_side1: MCC_RscText
		{
			idc = 21;

			x = 0.53625 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_side1Score: MCC_RscText
		{
			idc = 22;
			style = 2;

			x = 0.53625 * safezoneW;
			y = 0.033 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_side2: MCC_RscText
		{
			idc = 23;

			x = 0.5775 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_side2Score: MCC_RscText
		{
			idc = 24;
			style = 2;

			x = 0.5775 * safezoneW;
			y = 0.033 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_side3: MCC_RscText
		{
			idc = 25;

			x = 0.61875 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_side3Score: MCC_RscText
		{
			idc = 26;
			style = 2;

			x = 0.61875 * safezoneW;
			y = 0.033 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
	};
};
