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
		class MCC_AmmoText: MCC_RscText
		{
			idc = 81;

			x = 0.0257812 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class MCC_RepairText: MCC_RscText
		{
			idc = 82;

			x = 0.0257812 * safezoneW;
			y = 0.055 * safezoneH;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class MCC_FuelText: MCC_RscText
		{
			idc = 83;

			x = 0.0257812 * safezoneW;
			y = 0.099 * safezoneH;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_FoodText: MCC_RscText
		{
			idc = 84;

			x = 0.0257812 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_MedText: MCC_RscText
		{
			idc = 85;

			x = 0.0257812 * safezoneW;
			y = 0.187 * safezoneH;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_Ammo: MCC_RscPicture
		{
			idc = -1;

			text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
			x = 0.00515625 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_Repair: MCC_RscPicture
		{
			idc = -1;

			text = __EVAL(MCCPATH +"data\IconRepair.paa");
			x = 0.00515625 * safezoneW;
			y = 0.055 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_Fuel: MCC_RscPicture
		{
			idc = -1;

			text = __EVAL(MCCPATH +"data\IconFuel.paa");
			x = 0.00515625 * safezoneW;
			y = 0.099 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_FoodPic: MCC_RscPicture
		{
			idc = -1;

			text = __EVAL(MCCPATH +"data\IconFood.paa");
			x = 0.00515625 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_MedPic: MCC_RscPicture
		{
			idc = -1;

			text = __EVAL(MCCPATH +"data\IconMed.paa");
			x = 0.00515625 * safezoneW;
			y = 0.187 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};
