// By: Shay_gman
// Version: 1 (September 2014)

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_LOGISTICS_BASE_BUILD
{
	idd = -1;
	movingEnable = 1;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\mcc_logisticsBaseBuild.sqf'"); 

	controlsBackground[] = 
	{
	};


	//---------------------------------------------
	objects[] = 
	{ 
	};

	class controls  
	{
		class bottomData: MCC_RscText
		{
			idc = 0;
			x = -0.00416669 * safezoneW + safezoneX;
			y = 0.885 * safezoneH + safezoneY;
			w = 1.0026 * safezoneW;
			h = 0.121 * safezoneH;
		};
		class rightData: MCC_RscText
		{
			idc = 1;
			x = -0.00416669 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.891 * safezoneH;
		};
		
		class button1: MCC_RscButton
		{
			idc = 100;
			x = 0.310417 * safezoneW + safezoneX;
			y = 0.24537 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.055 * safezoneH;
		};
		
		class button2: button1 {idc = 101;};
		class button3: button1 {idc = 102;};
		class button4: button1 {idc = 103;};
		class button5: button1 {idc = 104;};
		class button6: button1 {idc = 105;};
		class button7: button1 {idc = 106;};
		class button8: button1 {idc = 107;};
		class button9: button1 {idc = 108;};
		class button10: button1 {idc = 109;};
		class button11: button1 {idc = 110;};
		class button12: button1 {idc = 111;};
		class button13: button1 {idc = 112;};
		class button14: button1 {idc = 113;};
		class button15: button1 {idc = 114;};
		class button16: button1 {idc = 115;};
	};
};
