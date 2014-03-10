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

			w = 0.166146 * safezoneW;
			h = 0.164936 * safezoneH;
		};

		class MCC_CSSettings: MCC_RscText
		{
			idc = -1;

			text = "Client Side Settings:"; //--- ToDo: Localize;
			x = 0.0171876 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.127481 * safezoneW;
			h = 0.0340016 * safezoneH;
			colorText[] = {0,1,1,1};
		};
		class MCC_viewDistanceTittle: MCC_RscText
		{
			idc = -1;

			text = "View:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_grassDensityTittle: MCC_RscText
		{
			idc = -1;

			text = "Grass:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0879658 * safezoneH;
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

			x = 0.0744797 * safezoneW;
			y = 0.0549788 * safezoneH;
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

			x = 0.0744797 * safezoneW;
			y = 0.0879658 * safezoneH;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_CSClose: MCC_RscButtonMenu
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 516) ctrlShow false";
			
			x = 0.0401046 * safezoneW;
			y = 0.120953 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};


