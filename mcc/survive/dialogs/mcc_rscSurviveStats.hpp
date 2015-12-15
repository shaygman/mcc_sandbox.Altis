class mcc_rscSurviveStats
{
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "mcc_rscSurviveStats";
	onLoad = "uiNamespace setVariable [""mcc_rscSurviveStats"", _this select 0]";

	class Controls
	{
		class mcc_rscSurviveStatsCTG: MCC_RscControlsGroup
		{
			idc = 0;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.3 * safezoneH;

			class controls
			{
				class MCC_surviveStatsFoodBCKG: MCC_RscText
				{
					idc = -1;
					x = 0.04 * safezoneW;
					y = 0.076 * safezoneH;
					w = 0.254687 * safezoneW;
					h = 0.022 * safezoneH;
					colorBackground[] = {0,0,0,0.5};
				};

				class MCC_surviveStatsFoodText: MCC_RscText
				{
					idc = -1;
					text = "Food";
					sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";

					x = 0.0 * safezoneW;
					y = 0.066 * safezoneH;
					w = 0.08 * safezoneW;
					h = 0.044 * safezoneH;
				};

				class MCC_surviveStatsFood: MCC_RscProgress
				{
					idc = 1;
					x = 0.04 * safezoneW;
					y = 0.076 * safezoneH;
					w = 0.254687 * safezoneW;
					h = 0.022 * safezoneH;
					colorBar[] = {0,0.8,0,1};
					colorFrame[] = {1,1,1,0.8};
				};

				class MCC_surviveStatsWaterBCKG: MCC_RscText
				{
					idc = -1;
					x = 0.04 * safezoneW;
					y = 0.11 * safezoneH;
					w = 0.254687 * safezoneW;
					h = 0.022 * safezoneH;
					colorBackground[] = {0,0,0,0.5};
				};

				class MCC_surviveStatsWaterText: MCC_RscText
				{
					idc = -1;
					text = "Water";
					sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";

					x = 0.0 * safezoneW;
					y = 0.1 * safezoneH;
					w = 0.08 * safezoneW;
					h = 0.044 * safezoneH;
				};

				class MCC_surviveStatsWater: MCC_RscProgress
				{
					idc = 2;
					x = 0.04 * safezoneW;
					y = 0.11 * safezoneH;
					w = 0.254687 * safezoneW;
					h = 0.022 * safezoneH;
					colorBar[] = {0,0,0.8,1};
					colorFrame[] = {1,1,1,0.8};
				};

				class MCC_surviveStatsStatus: MCC_RscText
				{
					idc = 3;
					style = 0x02;
					sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
					x = 0.06 * safezoneW;
					y = 0.02 * safezoneH;
					w = 0.134062 * safezoneW;
					h = 0.044 * safezoneH;
				};
			};
		};
	};
};