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
		MCC_loadTruckbckgs
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
			colorBackground[] = { 0.051, 0.051, 0.051,1};
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.55 * safezoneH;
		};

		class MCC_loadTruckC1: MCC_RscListbox
		{
			idc = 0;
			x = 0.316667 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0859375 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class MCC_loadTruckC2: MCC_RscListbox
		{
			idc = 1;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0859375 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class MCC_loadTruckC3: MCC_RscListbox
		{
			idc = 2;
			x = 0.574479 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0859375 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class MCC_loadTruckTittle: MCC_RscText
		{
			idc = -1;
			text = "Load Truck"; //--- ToDo: Localize;
			x = 0.43125 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.131771 * safezoneW;
			h = 0.066 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2)";
		};
		class MCC_loadTruckSupplies: MCC_RscText
		{
			idc = 3;
			text = "Supplies:"; //--- ToDo: Localize;
			x = 0.436979 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckRepair: MCC_RscText
		{
			idc = 4;
			text = "Repair:"; //--- ToDo: Localize;
			x = 0.574479 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckFuel: MCC_RscText
		{
			idc = 5;
			text = "Fuel:"; //--- ToDo: Localize;
			x = 0.299479 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckLoadButton: MCC_RscButton
		{
			idc = 6;
			text = "Load"; //--- ToDo: Localize;
			x = 0.414063 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.166146 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class MCC_loadTruckOutpot: MCC_RscText
		{
			idc = 7;
			text = ""; //--- ToDo: Localize;
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.263542 * safezoneW;
			h = 0.066 * safezoneH;
		};
	};
};
