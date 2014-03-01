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
		
		class MCC_MissionMakerTittle: MCC_RscText 
		{
			idc = -1; 
			text = "Mission Maker:"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.056 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_MissionMakerName: MCC_RscText 
		{
			idc = MCCMISSIONMAKERNAME;	
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.419792 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_clientFPSTittle: MCC_RscText 
		{	
			idc = -1;	
			text = "Client FPS:"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.488542 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_ServerFPSTittle: MCC_RscText 
		{	
			idc = -1;	
			text = "Server FPS:";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.585938 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_clientFPS: MCC_RscText 
		{
			idc = MCCCLIENTFPS; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.540104 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;		
		};
		
		class MCC_ServerFPS: MCC_RscText 
		{
			idc = MCCSERVERFPS;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.6375 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;	
		};
		
		class MCC_login: MCC_RscButtonMenu 
		{
			idc = -1; 
			text = "Login/Logout"; 
			x = 0.648958 * safezoneW + safezoneX;
			y = 0.796884 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Login or logout as the mission maker"; 
			onButtonClick = __EVAL("nul=[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_login.sqf'");
		};

	};
};