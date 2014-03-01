#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007

class MCC_csDialogControls: MCC_RscControlsGroup
{
	idc = 516;
	x = 0.695 * safezoneW + safezoneX;
	y = 0.4 * safezoneH + safezoneY;
	w = 0.166146 * safezoneW;
	h = 0.164936 * safezoneH;

	class Controls
	{			
		class MCC_CSDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			x = 0.265104 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.166146 * safezoneW;
			h = 0.164936 * safezoneH;
		};

		class MCC_CSSettings: MCC_RscText
		{
			idc = -1;

			text = "Client Side Settings:"; //--- ToDo: Localize;
			x = 0.288021 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.127481 * safezoneW;
			h = 0.0340016 * safezoneH;
			colorText[] = {0,1,1,1};
		};
		class MCC_viewDistanceTittle: MCC_RscText
		{
			idc = -1;

			text = "View:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_grassDensityTittle: MCC_RscText
		{
			idc = -1;

			text = "Grass:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_viewDistance: MCC_RscCombo
		{
			idc = MCCVIEWDISTANCE;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged =  __EVAL("[2] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");			

			x = 0.345313 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
			
		};
		class MCC_grassDensity: MCC_RscCombo
		{
			idc = MCCGRASSDENSITY;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged =  __EVAL("[1] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");

			x = 0.345313 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_CSClose: MCC_RscButtonMenu
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			onButtonClick = __EVAL("[15] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.310938 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};


