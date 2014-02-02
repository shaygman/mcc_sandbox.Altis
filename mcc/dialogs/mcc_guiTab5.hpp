////////////////////////////////////////////////////////
// BY Shay Gman 11.2013
////////////////////////////////////////////////////////
#define MCC_SANDBOX_IDD 1000
#define MCC_SANDBOX2_IDD 2000
#define MCC_SANDBOX3_IDD 3000
#define MCC_SANDBOX4_IDD 4000
#define MCC_SANDBOX5_IDD 6000

#define MAIN 1050
#define MENU2 1051
#define MENU3 1052
#define MENU4 1053
#define MENU5 1054
#define MCCSTOPCAPTURE 1014
#define FACTIONCOMBO 1001
#define MCCZONENUMBER 1023

#define MCC_MWPlayersIDC 6001
#define MCC_MWATMinesIDC 6002
#define MCC_MWAPMinesIDC 6003
#define MCC_MWStealthIDC 6004
#define MCC_MWReinforcementIDC 6005
#define MCC_MWDifficultyIDC 6006
#define MCC_MWObjective1IDC 6007
#define MCC_MWObjective2IDC 6008
#define MCC_MWObjective3IDC 6009
#define MCC_MWVehiclesIDC 6010
#define MCC_MWArmorIDC 6011
#define MCC_MWIEDIDC 6012
#define MCC_MWSBIDC 6013
#define MCC_MWArmedCiviliansIDC 6014
#define MCC_MWCQBIDC 6015
#define MCC_MWRoadBlocksIDC 6016
#define MCC_MWWeatherComboIDC 6017
#define MCC_MCC_MWAreaComboIDC 6018
#define MCC_MWDebugComboIDC 6019
#define MCC_MWPreciseMarkersComboIDC 6020
#define MCC_MWArtilleryIDC 6021

class MCC_Sandbox5 {
	  idd = MCC_SANDBOX5_IDD;
	  movingEnable = true;
	  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_gui_init5.sqf'");
	  
	  controlsBackground[] = 
	  {
	  MCC_pic,
	  MCC_background,
	  MCC_mapBckg
	  };
	  

	  //---------------------------------------------
	  objects[] = 
	  { 
	  };
	  
	  controls[] = 
	  {
		MCC_map,
		MCC_Menu1,
		MCC_Menu2,
		MCC_Menu3,
		MCC_Menu4,
		MCC_Menu5,
		MCC_stopCapture,
		//MCC_factioTittle,
		MCC_factionCombo,
		MCC_zoneTittle,
		MCC_zone,
		MCC_zoneUpdate,
		MCC_Close,
		//=== Mission Wizard===
		MCC_MWTittle,
		MCC_MWPlayersTittle,
		MCC_MWRoadBlockTittle,
		MCC_MWStealthTittle,
		MCC_MWPlayersCombo,
		MCC_MWRivalFactionTittle,
		MCC_MWRoadBlockCombo,
		MCC_MWStealthCombo,
		MCC_MWPreciseMarkersText,
		MCC_MWPreciseMarkersCombo,
		MCC_MWObjective1Tittle,
		MCC_MWObjective2Tittle,
		MCC_MWObjective3Tittle,
		MCC_MWVehiclesTittle,
		MCC_MWDebugText,
		MCC_MWDebugCombo,
		MCC_MWDifficultyTittle,
		MCC_MWDifficultyCombo,
		MCC_MWObjective1Combo,
		MCC_MWObjective2Combo,
		MCC_MWObjective3Combo,
		MCC_MWVehiclesCombo,
		MCC_MWArmorTittle,
		MCC_MWArmorCombo,
		MCC_MWReinforcementTittle,
		MCC_MWReinforcementCombo,
		MCC_MWArtilleryTittle,
		MCC_MWArtilleryCombo,
		MCC_MWIEDTittle,
		//MCC_MWATMinesTittle,
		//MCC_MWAPMinesTittle,
		MCC_MWSBTittle,
		MCC_MWArmedCiviliansTittle,
		MCC_MWCQBTittle,
		MCC_MWIEDCombo,
		//MCC_MWATMinesCombo,
		//MCC_MWAPMinesCombo,
		MCC_MWSBCombo,
		MCC_MWArmedCiviliansCombo,
		MCC_MWCQBCombo,
		MCC_MWWeatherText,
		MCC_MWWeatherCombo,
		MCC_MWAreaText,
		MCC_MWAreaCombo,
		MCC_MWGenerate
	 };
	   
	class MCC_map: MCC_RscMapControl {idc = MCC_MINIMAP; moving = true; 	text = "";	
		x = 0.525552 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.303646 * safezoneW;
		h = 0.406841 * safezoneH;
		onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseDown.sqf'");
		onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseUp.sqf'");
		onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseMoving.sqf'");
	};
	class MCC_mapBckg: MCC_RscText {idc = -1; moving = true; 	text = "";	
		x = 0.525552 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.303646 * safezoneW;
		h = 0.406841 * safezoneH;
		colorBackground[] = {1,1,1,1};
	};
	class MCC_Menu1: MCC_RscButtonMenu	{idc = MAIN;text = "Main";	x = 0.355521 * safezoneW + safezoneX;
		y = 0.108982 * safezoneH + safezoneY;
		w = 0.0849875 * safezoneW;
		h = 0.0510023 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,1};
		onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
	};
	class MCC_Menu2: MCC_RscButtonMenu	{idc = MENU2;text = "Menu 2";x = 0.449008 * safezoneW + safezoneX;
		y = 0.108982 * safezoneH + safezoneY;
		w = 0.0849875 * safezoneW;
		h = 0.0510023 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,1};
		onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
	};
	class MCC_Menu3: MCC_RscButtonMenu	{idc = MENU3;text = "Menu 3"; x = 0.542494 * safezoneW + safezoneX;
		y = 0.108982 * safezoneH + safezoneY;
		w = 0.0849875 * safezoneW;
		h = 0.0510023 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,1};
		onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
	};
	class MCC_Menu4: MCC_RscButtonMenu	{idc = MENU4;text = "Menu 4"; x = 0.63598 * safezoneW + safezoneX;
		y = 0.108982 * safezoneH + safezoneY;
		w = 0.0849875 * safezoneW;
		h = 0.0510023 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,1};
		onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
	};
	class MCC_Menu5: MCC_RscButtonMenu	{idc = MENU5;text = "Menu 5";x = 0.729466 * safezoneW + safezoneX;
		y = 0.108982 * safezoneH + safezoneY;
		w = 0.0849875 * safezoneW;
		h = 0.0510023 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,1};
		onButtonClick = __EVAL ("[6] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
	}
	class MCC_factioTittle: MCC_RscText	{idc = -1;text = "Faction:";
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.445021 * safezoneH + safezoneY;
		w = 0.06799 * safezoneW;
		h = 0.0340016 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class MCC_factionCombo: MCC_RscCombo {idc = FACTIONCOMBO;
		x = 0.259375 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");
	};

	class MCC_stopCapture: MCC_RscButton {idc = MCCSTOPCAPTURE;	text = "Stop Capturing";
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.456017 * safezoneH + safezoneY;
		w = 0.161477 * safezoneW;
		h = 0.0340016 * safezoneH;
		onButtonClick = "ctrlEnable [1014,false];MCC_capture_state=false;";
		tooltip = "Stop capturing MCC triger"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class MCC_zoneTittle: MCC_RscText {idc = -1;	text = "Zone:";
		x = 0.528646 * safezoneW + safezoneX;
		y = 0.456017 * safezoneH + safezoneY;
		w = 0.0630208 * safezoneW;
		h = 0.0329871 * safezoneH;
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_zone: MCC_RscCombo {idc = MCCZONENUMBER;	
		x = 0.597396 * safezoneW + safezoneX;
		y = 0.456017 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.0329871 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		onLBSelChanged = __EVAL("[0,0,0] execVM '"+MCCPATH+"mcc\pop_menu\zones.sqf'");
	};
	class MCC_zoneUpdate: MCC_RscButton {idc = -1;	text = "Update Zone"; 
		x = 0.711979 * safezoneW + safezoneX;
		y = 0.456017 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0340016 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		tooltip = "Click and drag on the minimap to make a zone"; 
		onButtonClick = "if (mcc_missionmaker == (name player)) then {MCC_zone_drawing= true;} else {player globalchat 'Access Denied'};";
	};
	class MCC_Close: MCC_RscButtonMenu {idc = -1; text = "Close"; 
		x = 0.440509 * safezoneW + safezoneX;
		y = 0.857016 * safezoneH + safezoneY;
		w = 0.0764887 * safezoneW;
		h = 0.0510023 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		onButtonClick = "closeDialog 0";
	};
	class MCC_background: MCC_RscText {idc = -1; text = "";x = 0.168549 * safezoneW + safezoneX;
		y = 0.0919812 * safezoneH + safezoneY;
		w = 0.662902 * safezoneW;
		h = 0.816037 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
	};
	class MCC_pic: MCC_RscPicture {idc = -1; text = __EVAL(MCCPATH +"mcc\dialogs\mcc_background.paa");x = 0.1 * safezoneW + safezoneX;
		y = 0.005 * safezoneH + safezoneY;
		w = 0.8 * safezoneW;
		h = 1.01 * safezoneH;
	};
	
	//===========================       Mission Wizard   ============================================================
	class MCC_MWTittle: MCC_RscText
	{
		idc = -1;

		text = "Missions Wizard"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.0329871 * safezoneH;
		colorText[] = {0,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class MCC_MWPlayersTittle: MCC_RscText
	{
		idc = -1;

		text = "# Players:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWRoadBlockTittle: MCC_RscText
	{
		idc = -1;

		text = "Roadblocks:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWStealthTittle: MCC_RscText
	{
		idc = -1;

		text = "Stealth:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWPlayersCombo: MCC_RscCombo
	{
		idc = MCC_MWPlayersIDC;

		x = 0.259375 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWRivalFactionTittle: MCC_RscText
	{
		idc = -1;

		text = "Rival Faction:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWRoadBlockCombo: MCC_RscCombo
	{
		idc = MCC_MWRoadBlocksIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWStealthCombo: MCC_RscCombo
	{
		idc = MCC_MWStealthIDC;
		x = 0.259375 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWObjective1Tittle: MCC_RscText
	{
		idc = -1;

		text = "Objective 1:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective2Tittle: MCC_RscText
	{
		idc = -1;

		text = "Objective 2:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective3Tittle: MCC_RscText
	{
		idc = -1;

		text = "Objective 3:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWVehiclesTittle: MCC_RscText
	{
		idc = -1;

		text = "Vehicles:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWDifficultyTittle: MCC_RscText
	{
		idc = -1;

		text = "Difficulty:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWDifficultyCombo: MCC_RscCombo
	{
		idc = MCC_MWDifficultyIDC;
		x = 0.259375 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective1Combo: MCC_RscCombo
	{
		idc = MCC_MWObjective1IDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective2Combo: MCC_RscCombo
	{
		idc = MCC_MWObjective2IDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective3Combo: MCC_RscCombo
	{
		idc = MCC_MWObjective3IDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWVehiclesCombo: MCC_RscCombo
	{
		idc = MCC_MWVehiclesIDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWArmorTittle: MCC_RscText
	{
		idc = -1;

		text = "Armor:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWArmorCombo: MCC_RscCombo
	{
		idc = MCC_MWArmorIDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWReinforcementTittle: MCC_RscText
	{
		idc = -1;

		text = "Reinforcement:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWReinforcementCombo: MCC_RscCombo
	{
		idc = MCC_MWReinforcementIDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWArtilleryTittle: MCC_RscText
	{
		idc = -1;

		text = "Artillery:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWArtilleryCombo: MCC_RscCombo
	{
		idc = MCC_MWArtilleryIDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWPreciseMarkersText: MCC_RscText
	{
		idc = -1;

		text = "Precise Locations:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
	};
	
	class MCC_MWPreciseMarkersCombo: MCC_RscCombo
	{
		idc = MCC_MWPreciseMarkersComboIDC;

		x = 0.259375 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY; //0.412034
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWDebugText: MCC_RscText
	{
		idc = -1;

		text = "Show Markers:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWDebugCombo: MCC_RscCombo
	{
		idc = MCC_MWDebugComboIDC;

		x = 0.259375 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWIEDTittle: MCC_RscText
	{
		idc = -1;

		text = "IEDs:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWATMinesTittle: MCC_RscText
	{
		idc = -1;

		text = "AT Mines:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWAPMinesTittle: MCC_RscText
	{
		idc = -1;

		text = "AP Mines:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWSBTittle: MCC_RscText
	{
		idc = -1;

		text = "Suicide Bombers:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
	};
	class MCC_MWArmedCiviliansTittle: MCC_RscText
	{
		idc = -1;

		text = "Armed Civilians:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
	};
	class MCC_MWCQBTittle: MCC_RscText
	{
		idc = -1;

		text = "CQB:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWIEDCombo: MCC_RscCombo
	{
		idc = MCC_MWIEDIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWATMinesCombo: MCC_RscCombo
	{
		idc = MCC_MWATMinesIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWAPMinesCombo: MCC_RscCombo
	{
		idc = MCC_MWAPMinesIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWSBCombo: MCC_RscCombo
	{
		idc = MCC_MWSBIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWArmedCiviliansCombo: MCC_RscCombo
	{
		idc = MCC_MWArmedCiviliansIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWCQBCombo: MCC_RscCombo
	{
		idc = MCC_MWCQBIDC;
		x = 0.259375 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWWeatherText: MCC_RscText
	{
		idc = -1;

		text = "Time/Weather:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWWeatherCombo: MCC_RscCombo
	{
		idc = MCC_MWWeatherComboIDC;

		x = 0.626042 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWAreaText: MCC_RscText
	{
		idc = -1;

		text = "Area:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWAreaCombo: MCC_RscCombo
	{
		idc = MCC_MCC_MWAreaComboIDC;

		x = 0.626042 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};

	class MCC_MWGenerate: MCC_RscButton
	{
		idc = -1;
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\missionWizard\missionWizardInit.sqf'");

		text = "Generate Mission"; //--- ToDo: Localize;
		x = 0.717708 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0340016 * safezoneH;
		tooltip = "Generate a mission "; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
	};
};
