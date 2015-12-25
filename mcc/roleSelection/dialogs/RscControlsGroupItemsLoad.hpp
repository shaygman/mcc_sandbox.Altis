
class CP_ItemsLoad: MCC_RscControlsGroupNoScrollbars
{
	idc = 200;
	x = 0.615191 * safezoneW + safezoneX;
	y = 0.7 * safezoneH + safezoneY;
	w = 0.195937 * safezoneW;
	h = 0.11 * safezoneH;
	class controls
	{
		class InfoArmorText: MCC_RscText
		{
			idc = -1;
			text = "Armor";
			x = 0.00515625 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class InfoLoadText: MCC_RscText
		{
			idc = -1;
			text = "Max.Load";
			x = 0.00515625 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};

		class InfoWeightText: MCC_RscText
		{
			idc = -1;
			text = "Weight";
			x = 0.00515625 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};

		class InfoArmorBar: MCC_RscProgress
		{
			idc = 201;
			x = 0.04125 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.149531 * safezoneW;
			h = 0.022 * safezoneH;
			colorFrame[] = {1,1,1,0.8};
			colorBar[] = {1,1,1,0.6};
		};
		class InfoLoadBar: MCC_RscProgress
		{
			idc = 202;
			x = 0.04125 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.149531 * safezoneW;
			h = 0.022 * safezoneH;
			colorFrame[] = {1,1,1,0.8};
			colorBar[] = {1,1,1,0.6};
		};
		class InfoWeightBar: MCC_RscProgress
		{
			idc = 203;
			x = 0.04125 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.149531 * safezoneW;
			h = 0.022 * safezoneH;
			colorFrame[] = {1,1,1,0.8};
			colorBar[] = {1,1,1,0.6};
		};
	};
};

