class MCC_captureProgressRsc
{
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "MCC_captureProgressRsc";
	onLoad = "uiNamespace setVariable [""MCC_captureProgressRsc"", _this select 0]";

	class Controls
	{
		class MCC_captureProgressCTG: MCC_RscControlsGroup
		{
			idc = 0;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.85 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.099 * safezoneH;

			class controls
			{
				class MCC_captureProgressPRBarBG: MCC_RscText
				{
					idc = -1;
					x = 0.00515602 * safezoneW;
					y = 0.076 * safezoneH;
					w = 0.254687 * safezoneW;
					h = 0.022 * safezoneH;
					colorBackground[] = {0.8,0,0,0.5};
				};

				class MCC_captureProgressPRBar: MCC_RscProgress
				{
					idc = 1;
					x = 0.00515602 * safezoneW;
					y = 0.076 * safezoneH;
					w = 0.254687 * safezoneW;
					h = 0.022 * safezoneH;
					colorBar[] = {0,0,0.8,1};
					colorFrame[] = {1,1,1,0.8};
					colorBackground[] = {0.8,0,0,0.6};
				};

				class MCC_captureProgressText: MCC_RscText
				{
					idc = 2;
					style = 0x02;
					sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
					colorText[] = {0,0,0,1};
					x = 0.06 * safezoneW;
					y = 0.023 * safezoneH;
					w = 0.134062 * safezoneW;
					h = 0.044 * safezoneH;
				};
			};
		};
	};
};