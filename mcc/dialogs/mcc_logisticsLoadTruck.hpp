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
			colorBackground[] = { 0.051, 0.051, 0.051,0.8};
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.55 * safezoneH;
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
			x = 0.419792 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.131771 * safezoneW;
			h = 0.176 * safezoneH;

			drawSideArrows = 1; 
			idcLeft = 1000;
			idcRight = 1001; 
		};

		class MCC_loadTruckTittle: MCC_RscText
		{
			idc = -1;
			text = "Load Truck"; //--- ToDo: Localize;
			x = 0.419792 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.131771 * safezoneW;
			h = 0.066 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2)";
		};
		class MCC_loadTruckRepairText: MCC_RscText
		{
			idc = 1;

			x = 0.488542 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckSuppliesText: MCC_RscText
		{
			idc = 2;

			x = 0.356771 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckFuelText: MCC_RscText
		{
			idc = 3;

			x = 0.614583 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckSupplies: MCC_RscPicture
		{
			idc = -1;
			text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
			x = 0.322396 * safezoneW + safezoneX;
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
			x = 0.580208 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.03 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MCC_loadTruckLoadButton: MCC_RscButton
		{
			idc = 4;
			text = "Load"; //--- ToDo: Localize;
			x = 0.419792 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.131771 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class MCC_loadTruckOutpot: MCC_RscText
		{
			idc = 5;
			text = ""; //--- ToDo: Localize;
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};
