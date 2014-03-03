class mcc_loginDialog
{
	idd = 2990;
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
			
			x = 0.368229 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.240625 * safezoneW;
			h = 0.296884 * safezoneH;
		};
		
		class mcc_loginDialogFrame: MCC_RscText
		{
			idc = -1;
			
			colorBackground[] = { 0.150, 0.150, 0.150,1};
			x = 0.373958 * safezoneW + safezoneX;
			y = 0.258094 * safezoneH + safezoneY;
			w = 0.229167 * safezoneW;
			h = 0.274893 * safezoneH;
		};
		class MCC_LoginTittle: MCC_RscText
		{
			idc = -1;

			text = "MCC Login"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			
			x = 0.454167 * safezoneW + safezoneX;
			y = 0.26909 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.0439828 * safezoneH;
			colorText[] = {0,1,1,1};
		};
		class MCC_viewDistanceTittle: MCC_RscText
		{
			idc = -1;

			text = "View:"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_grassDensityTittle: MCC_RscText
		{
			idc = -1;

			text = "Grass:"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.445021 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_viewDistance: MCC_RscCombo
		{
			idc = 1006;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged =  __EVAL("[2] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");	

			x = 0.459896 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class MCC_grassDensity: MCC_RscCombo
		{
			idc = 1007;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged =  __EVAL("[1] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
			colorText[] = {1,1,1,1};

			x = 0.459896 * safezoneW + safezoneX;
			y = 0.445021 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_CSClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "closeDialog 0";

			text = "Close"; //--- ToDo: Localize;
			x = 0.379688 * safezoneW + safezoneX;
			y = 0.489004 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorBackground[] = {0.219,0.147,0.112,1};
		};
		class MCC_MissionMakerTittle: MCC_RscText
		{
			idc = -1;

			text = "Mission Maker:"; //--- ToDo: Localize;
			x = 0.425521 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_MissionMakerName: MCC_RscText
		{
			idc = 1020;

			x = 0.488542 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_clientFPSTittle: MCC_RscText
		{
			idc = -1;

			text = "Client FPS:"; //--- ToDo: Localize;
			x = 0.379688 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_ServerFPSTittle: MCC_RscText
		{
			idc = -1;

			text = "Server FPS:"; //--- ToDo: Localize;
			x = 0.511458 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_clientFPS: MCC_RscText
		{
			idc = 1021;

			x = 0.43125 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_ServerFPS: MCC_RscText
		{
			idc = 1022;

			x = 0.563021 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class MCC_login: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = __EVAL("nul=[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_login.sqf'");

			text = "Login"; //--- ToDo: Localize;
			x = 0.528646 * safezoneW + safezoneX;
			y = 0.489004 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorBackground[] = {0.219,0.147,0.112,1};
			tooltip = "Login as the mission maker"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
	};
};