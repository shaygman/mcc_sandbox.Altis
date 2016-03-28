class MCC_compass
{
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "MCC_compass";

	onLoad = "uiNamespace setVariable [""MCC_compass"", _this select 0]";

	class Controls
	{
		class MCC_ConsoleCompassN: MCC_RscText
		{
			idc = 10;
			text = "N";

			x = 0.5 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.05 * safezoneH;
			colorText[] = {1,0,0,0.7};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			offSet[] = {0,1,0};
		};

		class MCC_ConsoleCompassNa: MCC_ConsoleCompassN
		{
			idc = 11;
			text = ".";
			colorText[] = {1,1,1,1};
			offSet[] = {0,0.7,0};
		};

		class MCC_ConsoleCompassNaa: MCC_ConsoleCompassNa
		{
			idc = 12;
			text = ".";
			offSet[] = {0,0.4,0};
		};

		class MCC_ConsoleCompassE: MCC_ConsoleCompassNa
		{
			idc = 13;
			colorText[] = {1,1,1,1};
			text = "E";
			offSet[] = {1,0,0};
		};

		class MCC_ConsoleCompassEa: MCC_ConsoleCompassNa
		{
			idc = 14;
			text = ".";
			offSet[] = {0.7,0,0};
		};

		class MCC_ConsoleCompassEaa: MCC_ConsoleCompassNa
		{
			idc = 15;
			text = ".";
			offSet[] = {0.4,0,0};
		};

		class MCC_ConsoleCompassS: MCC_ConsoleCompassE
		{
			idc = 16;
			text = "S";
			offSet[] = {0,-1,0};
		};

		class MCC_ConsoleCompassSa: MCC_ConsoleCompassNa
		{
			idc = 17;
			text = ".";
			offSet[] = {0,-0.7,0};
		};

		class MCC_ConsoleCompassSaa: MCC_ConsoleCompassNa
		{
			idc = 18;
			text = ".";
			offSet[] = {0,-0.4,0};
		};

		class MCC_ConsoleCompassW: MCC_ConsoleCompassE
		{
			idc = 19;
			text = "W";
			offSet[] = {-1,0,0};
		};

		class MCC_ConsoleCompassWa: MCC_ConsoleCompassNa
		{
			idc = 20;
			text = ".";
			offSet[] = {-0.7,0,0};
		};

		class MCC_ConsoleCompassWaa: MCC_ConsoleCompassNa
		{
			idc = 21;
			text = ".";
			offSet[] = {-0.4,0,0};
		};

		class MCC_ConsoleCompassNVMode: MCC_RscText
		{
			idc = 4;

			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			x = 0.459896 * safezoneW + safezoneX;
			y = 0.00519296 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0659743 * safezoneH;
		};

		class MCC_ConsoleCompassMap: MCC_RscMapControl
		{
			idc = 5;
			x = 0.78073 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.223438 * safezoneW;
			h = 0.285889 * safezoneH;
		};

		class MCC_ConsoleCompassMapBackground : MCC_RscText
		{
			idc = 6;

			x = 0.78073 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.223438 * safezoneW;
			h = 0.285889 * safezoneH;

			colorBackground[] = { 1, 1, 1, 1};
			colorText[] = { 1, 1, 1, 0};
			text = "";
		};
	};
};