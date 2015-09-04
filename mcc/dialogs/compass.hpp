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
		/*
		class Compass: MCC_RscControlsGroupNoScrollbars
		{
			x = "0.5 - 8 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
			idc = 16810;
			y = "1.5 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY)";
			w = "16 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "0.7 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls
			{
				class CompassBackground: MCC_RscText
				{
					idc = 15518;
					x = "0 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "16 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.7 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0.1,0.1,0.1,0.5};
				};
				class CompassFrame: MCC_RscFrame
				{
					idc = 16312;
					x = "0 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "16 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.7 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
				};
				class CompassCaret: MCC_RscFrame
				{
					idc = 16314;
					x = "8 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "0 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.7 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
				};
			};
		};
		*/
		class MCC_ConsoleCompassN: MCC_RscText
		{
			idc = 0;
			text = "N";

			x = 0.5 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.05 * safezoneH;
			colorText[] = {1,0,0,0.7};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class MCC_ConsoleCompassE: MCC_ConsoleCompassN
		{
			idc = 1;
			colorText[] = {1,1,1,1};
			text = "E";
		};
		class MCC_ConsoleCompassS: MCC_ConsoleCompassE
		{
			idc = 2;
			text = "S";
		};
		class MCC_ConsoleCompassW: MCC_ConsoleCompassE
		{
			idc = 3;
			text = "W";
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