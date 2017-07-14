#define MCC_LoginDIalog_IDD 2990

class mcc_loginDialog
{
	idd = MCC_LoginDIalog_IDD;
	movingEnable = true;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\login\scripts\mcc_loginDialog_init.sqf'");

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class MCC_loginFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = { 0.051, 0.051, 0.051,1};

			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.423958 * safezoneW;
			h = 0.394 * safezoneH;
		};

		class mcc_loginDialogFrame: MCC_RscText
		{
			idc = -1;

			colorBackground[] = { 0.150, 0.150, 0.150,1};
			x = 0.299479 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.372 * safezoneH;
		};
		class MCC_LoginTittle: MCC_RscText
		{
			idc = -1;

			text = "MCC Login";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";

			x = 0.459896 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.0439828 * safezoneH;
			colorText[] = {0,1,1,1};
		};

		class MCC_version: MCC_LoginTittle
		{
			idc = -1;

			text = MCCVersion;
			x = (0.459896 * safezoneW + safezoneX) + (0.06 * safezoneW);
		};

		class MCC_viewDistanceTittle: MCC_RscText
		{
			idc = -1;

			text = "View:"; //--- ToDo: Localize;
			x = 0.305208 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_grassDensityTittle: MCC_RscText
		{
			idc = -1;

			text = "Grass:"; //--- ToDo: Localize;
			x = 0.305208 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_viewDistance: MCC_RscCombo
		{
			idc = 1006;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged =  __EVAL("[2] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");

			x = 0.4 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class MCC_grassDensity: MCC_RscCombo
		{
			idc = 1007;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged =  __EVAL("[1] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
			colorText[] = {1,1,1,1};

			x = 0.4 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_CSClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "closeDialog 0";

			text = "Close"; //--- ToDo: Localize;
			x = 0.305208 * safezoneW + safezoneX;
			y = 0.564 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.032987 * safezoneH;
			colorBackground[] = {0.219,0.147,0.112,1};
		};
		class MCC_MissionMakerTittle: MCC_RscText
		{
			idc = -1;

			text = "Mission Maker:"; //--- ToDo: Localize;
			x = 0.305208 * safezoneW + safezoneX;
			y = 0.302077 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_MissionMakerName: MCC_RscText
		{
			idc = 1020;

			x = 0.4 * safezoneW + safezoneX;
			y = 0.302077 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
		};
		class MCC_clientFPSTittle: MCC_RscText
		{
			idc = -1;

			text = "Client FPS:"; //--- ToDo: Localize;
			x = 0.305208 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.032987 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_ServerFPSTittle: MCC_RscText
		{
			idc = -1;

			text = "Server FPS:"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.032987 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_clientFPS: MCC_RscText
		{
			idc = 1021;

			x = 0.356771 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.032987 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_ServerFPS: MCC_RscText
		{
			idc = 1022;

			x = 0.448438 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.032987 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};

		class MCC_keyBindsLogin: MCC_keyBindsGroup
		{
			x = 0.5 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
		};

		class MCC_login: MCC_RscButtonMenu
		{
			idc = -1;
			action = "_null = [] spawn MCC_fnc_loginDialog";

			text = "Login"; //--- ToDo: Localize;
			x = 0.6375 * safezoneW + safezoneX;
			y = 0.564 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.032987 * safezoneH;
			colorBackground[] = {0.219,0.147,0.112,1};
			tooltip = "Login as the mission maker"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};

		class MCC_Help: MCC_RscStructuredText
		{
			idc = 1000;
			text = "(?)";
			colorBackground[] = { 1, 1, 1, 0.7};
			tooltip = "Click to open a link on your default browser";
			//onMouseEnter = "[_this, true,[5,1],'mcclogin'] spawn MCC_fnc_help";

				x = 0.309219 * safezoneW + safezoneX;
				y = 0.467 * safezoneH + safezoneY;
				w = 0.170156 * safezoneW;
				h = 0.088 * safezoneH;
		};
	};
};