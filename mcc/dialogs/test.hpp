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
		class MCC_ConsoleEvacText: MCC_RscText {
			idc = -1;
			text = "Evac Management:"; //--- ToDo: Localize;
			x = 0.215581 * safezoneW + safezoneX;
			y = 0.485997 * safezoneH + safezoneY;
			w = 0.142187 * safezoneW;
			h = 0.035 * safezoneH;
			colorText[] = {0,1,1,1};
			colorBackground[] = {1,1,1,0};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_ConsoleEvacTypeText: MCC_RscText {
			idc = -1;
			text = "Evac:"; //--- ToDo: Localize;
			x = 0.217813 * safezoneW + safezoneX;
			y = 0.542009 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.0280062 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,0};
		};
		class MCC_ConsoleEvacType: MCC_RscCombo
		{
			idc = MCC_ConsoleEvacTypeText_IDD;
			onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\evac_focus.sqf'");
			x = 0.322812 * safezoneW + safezoneX;
			y = 0.542009 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.0280062 * safezoneH;
		};
		class MCC_ConsoleEvacFlyHightText: MCC_RscText {
			idc = -1;
			text = "Flight Hight:"; //--- ToDo: Localize;
			x = 0.217813 * safezoneW + safezoneX;
			y = 0.626028 * safezoneH + safezoneY;
			w = 0.0853125 * safezoneW;
			h = 0.0280062 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,0};
		};
		class MCC_ConsoleEvacFlyHightComboBox: MCC_RscCombo {
			idc = MCC_ConsoleEvacFlyHightComboBox_IDD;
			x = 0.322812 * safezoneW + safezoneX;
			y = 0.626028 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.0280062 * safezoneH;
		};
		class MCC_ConsoleEvacApproachText: MCC_RscText {
			idc = -1;
			text = "Insertion:"; //--- ToDo: Localize;
			x = 0.217813 * safezoneW + safezoneX;
			y = 0.584019 * safezoneH + safezoneY;
			w = 0.0853125 * safezoneW;
			h = 0.0280062 * safezoneH;
			colorBackground[] = {1,1,1,0};
		};
		class MCC_ConsoleEvacApproachComboBox: MCC_RscCombo {
			idc = MCC_ConsoleEvacApproachComboBox_IDD;
			x = 0.322812 * safezoneW + safezoneX;
			y = 0.584019 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.0280062 * safezoneH;
		};
		class MCC_ConsoleCallEvacButton: MCC_RscButton {
			idc = -1;text = "Call EVAC";
			x = 0.217813 * safezoneW + safezoneX;
			y = 0.668037 * safezoneH + safezoneY;
			w = 0.0853125 * safezoneW;
			h = 0.0420094 * safezoneH;
			tooltip = "Call selected EVAC - Mouse click on the mini-map to call it";
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\evacwp.sqf'");
		};
		class MCC_ConsoleCallEvac3WPButton: MCC_RscButton {
			idc = -1;
			text = "Call EVAC 3 WP";
			x = 0.322812 * safezoneW + safezoneX;
			y = 0.668037 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.0420094 * safezoneH;
			tooltip = "Call selected EVAC - Mouse click on the mini-map to call it";
			onButtonClick = __EVAL("nul=[1] execVM '"+MCCPATH+"mcc\general_scripts\console\evacwp.sqf'");
		};
	};
};
