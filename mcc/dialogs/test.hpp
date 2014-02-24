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
	{ 
	};

	class controls 
	{
		class MCC_CSSettings: MCC_RscText {idc = -1; text = "Client Side Settings:"; 
			x = 0.184896 * safezoneW + safezoneX;
			y = 0.445021 * safezoneH + safezoneY;
			w = 0.127481 * safezoneW;
			h = 0.0340016 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		
		class MCC_viewDistanceTittle: MCC_RscText {idc = -1; text = "View:"; 
		x = 0.185583 * safezoneW + safezoneX;
		y = 0.483067 * safezoneH + safezoneY;
		w = 0.0594912 * safezoneW;
		h = 0.0340016 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};
		class MCC_grassDensityTittle: MCC_RscText {idc = -1; text = "Grass:"; 
			x = 0.185583 * safezoneW + safezoneX;
			y = 0.516933 * safezoneH + safezoneY;
			w = 0.0594912 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};
		class MCC_viewDistance: MCC_RscCombo {idc = MCCVIEWDISTANCE; 
			x = 0.245052 * safezoneW + safezoneX;
			y = 0.494942 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged =  __EVAL("[2] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
		};
		class MCC_grassDensity: MCC_RscCombo {idc = MCCGRASSDENSITY;
			x = 0.245052 * safezoneW + safezoneX;
			y = 0.529029 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged =  __EVAL("[1] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
		};

	};
};