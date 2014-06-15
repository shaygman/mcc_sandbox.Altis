#define MCC_LoginDIalog_IDD 2990

#define MCC_keyBindsOpenMCCButtonIDC 8415
#define MCC_keyBindsOpenConsoleButtonIDC 8416
#define MCC_keyBindsT2TButtonIDC 8417

class mcc_loginDialog
{
	idd = MCC_LoginDIalog_IDD;
	movingEnable = true;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\mcc_loginDialog_init.sqf'"); 

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
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.423958 * safezoneW;
			h = 0.241906 * safezoneH;
		};
		
		class mcc_loginDialogFrame: MCC_RscText
		{
			idc = -1;
			
			colorBackground[] = { 0.150, 0.150, 0.150,1};
			x = 0.299479 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.219914 * safezoneH;
		};
		class MCC_LoginTittle: MCC_RscText
		{
			idc = -1;

			text = "MCC Login"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			
			x = 0.459896 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.0439828 * safezoneH;
			colorText[] = {0,1,1,1};
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
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
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
			x = 0.402604 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_ServerFPSTittle: MCC_RscText
		{
			idc = -1;

			text = "Server FPS:"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_clientFPS: MCC_RscText
		{
			idc = 1021;

			x = 0.454167 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_ServerFPS: MCC_RscText
		{
			idc = 1022;

			x = 0.551563 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		
		class MCC_keyBindsOpenMCCtext: MCC_RscText
		{
			idc = -1;

			text = "Open MCC:"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.302077 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_keyBindsOpenConsoletext: MCC_RscText
		{
			idc = -1;

			text = "Open MCC Console:"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_keyBindsOpenT2Ttext: MCC_RscText
		{
			idc = -1;

			text = "Teleport to team:"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_keyBindsOpenMCCButton: MCC_RscButton
		{
			idc = MCC_keyBindsOpenMCCButtonIDC;
			tooltip = "Click to change";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			action =  __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\keyBinds.sqf'");

			x = 0.603125 * safezoneW + safezoneX;
			y = 0.302077 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_keyBindsOpenConsoleButton: MCC_RscButton
		{
			idc = MCC_keyBindsOpenConsoleButtonIDC;
			tooltip = "Click to change";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			action =  __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\keyBinds.sqf'");

			x = 0.603125 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0219914 * safezoneH;
		};

		class MCC_keyBindsT2TButton: MCC_RscButton
		{
			idc = MCC_keyBindsT2TButtonIDC;
			tooltip = "Click to change";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			action =  __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\keyBinds.sqf'");

			x = 0.603125 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
	
		class MCC_login: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = __EVAL("nul=[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_login.sqf'");

			text = "Login"; //--- ToDo: Localize;
			x = 0.6375 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorBackground[] = {0.219,0.147,0.112,1};
			tooltip = "Login as the mission maker"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
	};
};