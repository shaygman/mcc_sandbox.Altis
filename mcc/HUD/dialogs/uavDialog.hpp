class MCC_uavDialog {
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "MCC_uavDialog";

	onLoad = "uiNamespace setVariable [""MCC_uavDialog"", _this select 0]";

	class Controls {
		class MCC_ConsoleACFeedTargetPic: MCC_RscPicture
		{
			idc = 100;
			x = 0.219271 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.561458 * safezoneW;
			h = 0.472816 * safezoneH;

		};

		class MCC_ConsoleACMissileCount: MCC_RscText
		{
			idc = 101;
			x = 0.682708 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0859375 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class MCC_ConsoleACMissileCount2: MCC_RscText
		{
			idc = 102;
			x = 0.682708 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.0859375 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class MCC_ConsoleACMissileCount3: MCC_RscText
		{
			idc = 103;
			x = 0.682708 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.0859375 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class MCC_ConsoleACVisionText: MCC_RscText
		{
			idc = 105;
			x = 0.230729 * safezoneW + safezoneX;
			y = 0.637963 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class MCC_ConsoleACTimeText: MCC_RscStructuredText
		{
			idc =106;
			style = MCCST_MULTI;
			x = 0.6 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.12 * safezoneW;
			h = 0.239828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class MCC_ConsoleACZoomText: MCC_RscText
		{
			idc = 107;

			x = 0.230729 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class MCC_ConsoleACDirText: MCC_RscText
		{
			idc = 108;

			x = 0.45 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class MCC_ConsoleCompassN: MCC_RscText
		{
			idc = 110;
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
			idc = 111;
			colorText[] = {1,1,1,1};
			text = "E";
		};
		class MCC_ConsoleCompassS: MCC_ConsoleCompassE
		{
			idc = 112;
			text = "S";
		};
		class MCC_ConsoleCompassW: MCC_ConsoleCompassE
		{
			idc = 113;
			text = "W";
		};

		class MCC_mapConsole : MCC_RscMapControl {
			idc = 120;
			moving = true;
			colorBackground[] = { 1, 1, 1, 1};
			colorText[] = { 1, 1, 1, 0};
			x = 0.788749 * safezoneW + safezoneX;
			y = 0.212936 * safezoneH + safezoneY;
			w = 0.01 * safezoneW;
			h = 0.01 * safezoneH;
		};
	};
};