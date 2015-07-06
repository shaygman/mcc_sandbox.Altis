// By: Shay_gman
// Version: 1 (September 2014)

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_LOGISTICS_LOAD_TRUCK
{
	idd = -1;
	movingEnable = 1;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\mcc_logisticsLoadTruck_init.sqf'");

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class MCC_loadTruckbckgs: MCC_RscText
		{
			idc = -1;
			colorBackground[] = { 0.051, 0.051, 0.051,0.9};
			x = 0.276562 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.506 * safezoneH;
		};

		class MCC_loadTruckbckgs2: MCC_RscText
		{
			idc = -1;

			x = 0.362499 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0.31,0.31,0.31,0.9};
		};

		class MCC_loadTruckC1Minus: MCC_RscButton
		{
			idc = 1000;
			text = "-";
			borderSize = 0;
			colorShadow[] = {0,0,0,0};
		};

		class MCC_loadTruckC1Plus: MCC_loadTruckC1Minus
		{
			idc = 1001;
			text = "+";
		};

		class MCC_loadTruckC1: MCC_RscListNbox
		{
			idc = 0;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.171875 * safezoneW;
			h = 0.176 * safezoneH;

			drawSideArrows = 1;
			idcLeft = 1000;
			idcRight = 1001;
		};

		class MCC_loadTruckTittle: MCC_RscText
		{
			idc = -1;
			text = "Logistics"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2)";

			x = 0.425 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.131771 * safezoneW;
			h = 0.066 * safezoneH;

		};
		class MCC_loadTruckRepairText: MCC_RscText
		{
			idc = 1;

			x = 0.482813 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckSuppliesText: MCC_RscText
		{
			idc = 2;

			x = 0.396875 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckFuelText: MCC_RscText
		{
			idc = 3;

			x = 0.56875 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckSupplies: MCC_RscPicture
		{
			idc = -1;
			text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
			x = 0.368229 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.03 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckRepair: MCC_RscPicture
		{
			idc = -1;
			text =  __EVAL(MCCPATH +"data\IconRepair.paa");
			x = 0.454167 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.03 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckFuel: MCC_RscPicture
		{
			idc = -1;
			text =  __EVAL(MCCPATH +"data\IconFuel.paa");
			x = 0.540104 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.03 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class MCC_loadTruckCancelButton: MCC_RscButton
		{
			idc = -1;
			action = "closeDialog 0;";

			text = "Close"; //--- ToDo: Localize;
			x = 0.442708 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckOutpot: MCC_RscButton
		{
			idc = 4;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			colorBackground[] = { 0.21, 0.21, 0.21,0.9};
			text = ""; //--- ToDo: Localize;
			x = 0.34 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class MCC_loadTruckOutpot2: MCC_RscButton
		{
			idc = 5;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			colorBackground[] = { 0.21, 0.21, 0.21,0.9};
			x = 0.45 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class MCC_loadTruckOutpot3: MCC_RscButton
		{
			idc = 6;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			colorBackground[] = { 0.21, 0.21, 0.21,0.9};
			x = 0.56 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.077 * safezoneH;
		};
	};
};
