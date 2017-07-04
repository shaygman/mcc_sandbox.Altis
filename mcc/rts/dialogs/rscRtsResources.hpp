class MCC_ResourcesControlsGroup: MCC_RscControlsGroupNoScrollbars
{
	idc = 80;
	x = 0.226719 * safezoneW + safezoneX;
	y = 0.786 * safezoneH + safezoneY;
	w = 0.15 * safezoneW;
	h = 0.209 * safezoneH;
	class controls
	{
		class MCC_AmmoText: MCC_RscText
		{
			idc = 81;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			x = 0.025781 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.08 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class MCC_RepairText: MCC_RscText
		{
			idc = 82;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			x = 0.025781 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.08 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class MCC_FuelText: MCC_RscText
		{
			idc = 83;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			x = 0.025781 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.08 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MCC_FoodText: MCC_RscText
		{
			idc = 84;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			x = 0.025781 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.08 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MCC_MedText: MCC_RscText
		{
			idc = 85;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			x = 0.025781 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.08 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MCC_unitsText: MCC_RscText
		{
			idc = 86;

			x = 0.025781 * safezoneW;
			y = 0.176 * safezoneH;
			w = 0.08 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_Ammo: MCC_RscPicture
		{
			idc = -1;
			colorText[] = { 0.9, 0, 0, 1 };
			text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
			tooltip = "Ammo";

			x = 0.00515598 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MCC_Repair: MCC_RscPicture
		{
			idc = -1;
			colorText[] = { 0, 0.5, 0.9, 1 };
			text = __EVAL(MCCPATH +"data\IconRepair.paa");
			tooltip = "Supplies";

			x = 0.00515598 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MCC_Fuel: MCC_RscPicture
		{
			idc = -1;
			tooltip = "Fuel";
			text = __EVAL(MCCPATH +"data\IconFuel.paa");
			colorText[] = { 0, 0.9, 0.5, 1 };

			x = 0.00515598 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MCC_FoodPic: MCC_RscPicture
		{
			idc = -1;
			tooltip = "Food";
			text = __EVAL(MCCPATH +"data\IconFood.paa");
			colorText[] = { 0.9, 0.5, 0, 1 };

			x = 0.00515598 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MCC_MedPic: MCC_RscPicture
		{
			idc = -1;
			tooltip = "Meds";
			text = __EVAL(MCCPATH +"data\IconMed.paa");
			colorText[] = { 0, 0.9, 0.9, 1 };

			x = 0.00515598 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MCC_unitsPic: MCC_RscPicture
		{
			idc = -1;
			text = __EVAL(MCCPATH +"data\IconMen.paa");

			x = 0.00515598 * safezoneW;
			y = 0.176 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};