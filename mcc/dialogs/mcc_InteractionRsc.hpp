class MCC_interactionPB
{
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "MCC_interactionPB";
	onLoad = "uiNamespace setVariable [""MCC_interactionPB"", _this select 0]";

	class Controls
	{
		class MCC_interactionCTG: MCC_RscControlsGroup
		{
			idc = 0;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.099 * safezoneH;

			class controls
			{
				class MCC_interactionPRBar: MCC_RscProgress
				{
					idc = 1;
					x = 0.00515602 * safezoneW;
					y = 0.066 * safezoneH;
					w = 0.154687 * safezoneW;
					h = 0.022 * safezoneH;
					colorBar[] = {0,0,0.8,0.6};
					colorFrame[] = {1,1,1,0.8};
					colorBackground[] = {0,0,0,0.3};
				};

				class MCC_interactionText: MCC_RscText
				{
					idc = 2;
					style = 0x02;
					sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
					x = 0.015469 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.134062 * safezoneW;
					h = 0.044 * safezoneH;
				};
			};
		};
	};
};