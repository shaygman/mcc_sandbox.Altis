class MCC_debugDialogControls:MCC_RscControlsGroup
{
	idc = 504;
	x = 0.52 * safezoneW + safezoneX;
	y = 0.18 * safezoneH + safezoneY;
	w = 0.345 * safezoneW;
	h = 0.30788 * safezoneH;

	class Controls
	{
		class MCC_debugDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			
			x = 0.373958 * safezoneW + safezoneX;
			y = 0.214111 * safezoneH + safezoneY;
			w = 0.345 * safezoneW;
			h = 0.30788 * safezoneH;
		};

		class MCC_debugTitle: MCC_RscText
		{
			idc = -1;
			text = "Debug:"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};
			
			x = 0.45 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.161477 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class MCC_Debug: MCC_RscButton
		{
			idc = -1;
			onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'RscDisplayDebugPublic';} else {player globalchat 'Access Denied'};";

			text = "Debug"; //--- ToDo: Localize;
			x = 0.379688 * safezoneW + safezoneX;
			y = 0.26909 * safezoneH + safezoneY;
			w = 0.0764887 * safezoneW;
			h = 0.0340016 * safezoneH;
			tooltip = "Open BIS Debug Console"; //--- ToDo: Localize;
		};
		class MCC_DebugExtra: MCC_RscButton
		{
			idc = -1;
			onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'RscDisplayDebug';} else {player globalchat 'Access Denied'};";

			text = "Adv. Debug"; //--- ToDo: Localize;
			x = 0.528646 * safezoneW + safezoneX;
			y = 0.26909 * safezoneH + safezoneY;
			w = 0.0764887 * safezoneW;
			h = 0.0340016 * safezoneH;
			tooltip = "Open BIS Advanced Debug Console"; //--- ToDo: Localize;
		};
		class MCC_CommandLineTittle: MCC_RscText
		{
			idc = -1;

			text = "Command line:"; //--- ToDo: Localize;
			x = 0.379688 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_CommandLineText: MCC_RscText
		{
			idc = 24;
			type = 2;

			x = 0.379688 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.223438 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_CommandLineTextFrmae: MCC_RscFrame
		{
			idc = -1;

			x = 0.379688 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.223438 * safezoneW;
			h = 0.0439828 * safezoneH;
		};
		class MCC_commandlineTextSmall: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL ("[3] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\commandLine.sqf'");

			text = "text"; //--- ToDo: Localize;
			x = 0.379688 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.033995 * safezoneW;
			h = 0.0340016 * safezoneH;
			tooltip = "Broadcast the command line fraze to all clients - small fonts"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_commandlineTextBig: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL ("[4] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\commandLine.sqf'");

			text = "TEXT"; //--- ToDo: Localize;
			x = 0.419792 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.033995 * safezoneW;
			h = 0.0340016 * safezoneH;
			tooltip = "Broadcast the command line fraze to all clients - big fonts"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_commandlineLocal: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL ("[0] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\commandLine.sqf'");

			text = "Local"; //--- ToDo: Localize;
			x = 0.528646 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.033995 * safezoneW;
			h = 0.0340016 * safezoneH;
			tooltip = "Execute the command line fraze only on the mission maker computer"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};
		class MCC_commandlineGlobal: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL ("[1] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\commandLine.sqf'");

			text = "Global"; //--- ToDo: Localize;
			x = 0.56875 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.033995 * safezoneW;
			h = 0.0340016 * safezoneH;
			tooltip = "Execute the command line fraze on all clients and sever"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};
		class MCC_commandlineCloseButton: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 504) ctrlShow false";

			text = "Close"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.467013 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0439828 * safezoneH;
		};
	};
};

