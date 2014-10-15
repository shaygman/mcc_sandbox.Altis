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

	class Controls
	{
	class MCC_RepairText: MCC_RscText
			{
				idc = 81;

				x = 0.310937 * safezoneW + safezoneX;
				y = 0.28 * safezoneH + safezoneY;
				w = 0.0458333 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_SuppliesText: MCC_RscText
			{
				idc = 82;

				x = 0.310937 * safezoneW + safezoneX;
				y = 0.236 * safezoneH + safezoneY;
				w = 0.0458333 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_FuelText: MCC_RscText
			{
				idc = 83;

				x = 0.310937 * safezoneW + safezoneX;
				y = 0.324 * safezoneH + safezoneY;
				w = 0.0458333 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_Supplies: MCC_RscPicture
			{
				idc = -1;

				text =  __EVAL(MCCPATH +"data\IconAmmo.paa"); //--- ToDo: Localize;
				x = 0.276563 * safezoneW + safezoneX;
				y = 0.236 * safezoneH + safezoneY;
				w = 0.03 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_Repair: MCC_RscPicture
			{
				idc = -1;

				text = __EVAL(MCCPATH +"data\IconRepair.paa"); //--- ToDo: Localize;
				x = 0.276563 * safezoneW + safezoneX;
				y = 0.28 * safezoneH + safezoneY;
				w = 0.03 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_Fuel: MCC_RscPicture
			{
				idc = -1;

				text = __EVAL(MCCPATH +"data\IconFuel.paa"); //--- ToDo: Localize;
				x = 0.276563 * safezoneW + safezoneX;
				y = 0.324 * safezoneH + safezoneY;
				w = 0.03 * safezoneW;
				h = 0.033 * safezoneH;
			};
	};
};