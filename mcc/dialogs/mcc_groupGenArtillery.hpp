class MCC_artilleryDialogControls:MCC_RscControlsGroup
{
	idc = 505;
	x = 0.186 * safezoneW + safezoneX;
	y = 0.14 * safezoneH + safezoneY;
	w = 0.20625 * safezoneW;
	h = 0.274893 * safezoneH;

	class Controls
	{
	
		class MCC_artilleryDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			
			w = 0.20625 * safezoneW;
			h = 0.274893 * safezoneH;
		};

		class MCC_artilleryTitle: MCC_RscText
		{
			idc = -1;
			text = "Artillery:"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};
			
			x = 0.0802088 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_artilleryTypeTitle: MCC_RscText
		{
			idc = -1;

			text = "Type:"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.0549786 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_artillerySpreadTitle: MCC_RscText
		{
			idc = -1;

			text = "Spread:"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.0879657 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_artilleryNumberTitle: MCC_RscText
		{
			idc = -1;

			text = "N. of Shells:"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			x = 0.00572967 * safezoneW;
			y = 0.120953 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_artilleryType: MCC_RscCombo
		{
			idc = 30;

			x = 0.0802088 * safezoneW;
			y = 0.0549786 * safezoneH;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_artillerySpread: MCC_RscCombo
		{
			idc = 31;

			x = 0.0802088 * safezoneW;
			y = 0.0879657 * safezoneH;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_artilleryNumber: MCC_RscCombo
		{
			idc = 32;

			x = 0.0802088 * safezoneW;
			y = 0.120953 * safezoneH;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_artilleryDelayText: MCC_RscText
		{
			idc = -1;

			text = "Delay:"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.15394 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_artilleryDelayCombo: MCC_RscCombo
		{
			idc = 33;

			x = 0.0802088 * safezoneW;
			y = 0.15394 * safezoneH;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_artilleryCall: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\artillery\artillery_request.sqf'");

			text = "Call"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.0859375 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Call Artillery on map position hold Ctrl for multi calls"; //--- ToDo: Localize;
		};
		class MCC_artilleryAdd: MCC_RscButton
		{
			idc = 27; // idc set to allow hiding button when no mcc_console available
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\artillery\artillery_request.sqf'");

			text = "Add"; //--- ToDo: Localize;
			x = 0.114584 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.0859375 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Add artillery to MCC Console "; //--- ToDo: Localize;
		};
		class MCC_artilleryDialogClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 505) ctrlShow false";

			text = "Close"; //--- ToDo: Localize;
			x = 0.0572917 * safezoneW;
			y = 0.23091 * safezoneH;
			w = 0.0859375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};
