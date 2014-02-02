////////////////////////////////////////////////////////
// BY Shay Gman 04.2013
////////////////////////////////////////////////////////
#define MCC_SANDBOX_IDD 1000
#define MCC_SANDBOX2_IDD 2000
#define MCC_SANDBOX3_IDD 3000
#define MCC_SANDBOX4_IDD 4000
#define MCC_SANDBOX5_IDD 6000

#define MCC_MINIMAP 9000
#define MAIN 1050
#define MENU2 1051
#define MENU3 1052
#define MENU4 1053
#define MENU5 1054
#define MCCSTOPCAPTURE 1014
#define FACTIONCOMBO 1001
#define MCCZONENUMBER 1023
#define MCCDELETEBRUSH 1030
#define MCC_ZONE_LOC 1026

#define MCC_AIRDROPTYPE 1031
#define MCC_airdropClass 1032
#define MCC_airdropArray 1033

#define MCC_UM_LIST 3069
#define MCC_UM_PIC 3070

#define MCC_ZONE_BT 1034

class MCC_Sandbox4 {
	  idd = MCC_SANDBOX4_IDD;
	  movingEnable = true;
	  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_gui_init4.sqf'");
	  
	  controlsBackground[] = 
	  {
	  MCC_pic,
	  MCC_background,
	  MCC_UMListFrame,
	  MCC_mapBckg,
	  MCC_PIPUmFrame,
	  MCC_m4f1,
	  MCC_m4f2,
	  MCC_m4f3,
	  MCC_m4f4,
	  MCC_m4f5,
	  MCC_m4f6,
	  MCC_m4f7
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
		MCC_factioTittle,
		MCC_factionCombo,
		MCC_zoneTittle,
		MCC_zone,
		MCC_zoneUpdate,
		MCC_Close,
		MCC_zoneLocTittle,
		MCC_zoneLoc,
		MCC_UMTittle,
		MCC_UMList,
		MCC_UMUnits,
		MCC_UMPlayers,
		MCC_UMwest,
		MCC_UMEast,
		MCC_UMGuar,
		MCC_UMTeleport,
		MCC_UMHijak,
		MCC_UMMark,
		MCC_UMbroadcast,
		MCC_UMDelete,
		MCC_UMJoin,
		MCC_UMHALO,
		MCC_UMParachute,
		MCC_UMHCgeneral,
		MCC_UMHCaddGroup,
		MCC_UMHCclear,
		MCC_UMhint,
		MCC_PIPUm,
		MCC_PIPviewMod,
		MCC_deleteBrushTittle,
		MCC_deleteBrushCombo,
		MCC_deleteBrush,
		MCC_airdropTittle,
		MCC_airdropTypeCombo,
		MCC_airdropClassCombo,
		MCC_airdropArrayCombo,
		MCC_airdropArrayTittle,
		MCC_airdropAdd,
		MCC_airdropClear,
		MCC_airdropCall,
		MCC_airdropAddConsole		
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
		y = 0.445021 * safezoneH + safezoneY;
		w = 0.144479 * safezoneW;
		h = 0.0340016 * safezoneH;
		onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");
	};

	class MCC_stopCapture: MCC_RscButton {idc = MCCSTOPCAPTURE;	text = "Stop Capturing";
		x = 0.185546 * safezoneW + safezoneX;
		y = 0.397995 * safezoneH + safezoneY;
		w = 0.161476 * safezoneW;
		h = 0.0340016 * safezoneH;
		onButtonClick = "ctrlEnable [1014,false];MCC_capture_state=false;";
		tooltip = "Stop capturing MCC triger"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class MCC_zoneTittle: MCC_RscText {idc = -1;	text = "Zone:";
		x = 0.508499 * safezoneW + safezoneX;
		y = 0.431997 * safezoneH + safezoneY;
		w = 0.0594912 * safezoneW;
		h = 0.0170008 * safezoneH;
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_zone: MCC_RscCombo {idc = MCCZONENUMBER;	
		x = 0.56799 * safezoneW + safezoneX;
		y = 0.431997 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0170008 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		onLBSelChanged = __EVAL("[0,0,0] execVM '"+MCCPATH+"mcc\pop_menu\zones.sqf'");
	};
	class MCC_zoneLocTittle: MCC_RscText {idc = -1;	text = "Location:"; 
		x = 0.508499 * safezoneW + safezoneX;
		y = 0.465998 * safezoneH + safezoneY;
		w = 0.0509925 * safezoneW;
		h = 0.0170008 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_zoneLoc: MCC_RscCombo {idc = MCC_ZONE_LOC;	
		x = 0.56799 * safezoneW + safezoneX;
		y = 0.465998 * safezoneH + safezoneY;
		w = 0.0934862 * safezoneW;
		h = 0.0170008 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_zoneUpdate: MCC_RscButton {idc = MCC_ZONE_BT;	text = "Update Zone"; 
		x = 0.686972 * safezoneW + safezoneX;
		y = 0.448998 * safezoneH + safezoneY;
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
	//================================== Unit Managment=================================================
	class MCC_UMTittle: MCC_RscText
	{
		idc = -1;
		text = "Units Management"; //--- ToDo: Localize;
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.126146 * safezoneH + safezoneY;
		w = 0.164062 * safezoneW;
		h = 0.0280063 * safezoneH;
		colorText[] = {0,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class MCC_UMList: MCC_RscListBox
	{
		idc = MCC_UM_LIST;
		rowHeight=0.022;
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.23625 * safezoneW;
		h = 0.0980219 * safezoneH;
		onLBSelChanged = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
		onMouseButtonUp = __EVAL("[8,_this] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMUnits: MCC_RscToolbox
	{
		idc = -1;
		strings[]={"Units","Groups"};
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0280063 * safezoneH;
		rows=1;
		columns=2;
		values[] = {0, 1};
		onToolBoxSelChanged = "MCC_UMUnit = (_this select 1);";
		tooltip = "Switch dispaly between units and groups from the given side"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMPlayers: MCC_RscButton
	{
		idc = -1;
		text = "Players"; //--- ToDo: Localize;
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.324069 * safezoneH + safezoneY;
		w = 0.039375 * safezoneW;
		h = 0.0280063 * safezoneH;
		onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\side_change.sqf'");
		tooltip = "Show only player controlled units "; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMwest: MCC_RscButton
	{
		idc = -1;
		text = "West"; //--- ToDo: Localize;
		x = 0.242188 * safezoneW + safezoneX;
		y = 0.324069 * safezoneH + safezoneY;
		w = 0.039375 * safezoneW;
		h = 0.0280063 * safezoneH;
		colorText[] = {0,0,1,0.5};
		onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\side_change.sqf'");
		tooltip = "Show only west units "; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMEast: MCC_RscButton
	{
		idc = -1;
		text = "East"; //--- ToDo: Localize;
		x = 0.310937 * safezoneW + safezoneX;
		y = 0.324069 * safezoneH + safezoneY;
		w = 0.039375 * safezoneW;
		h = 0.0280063 * safezoneH;
		colorText[] = {1,0,0,0.5};
		onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\side_change.sqf'");
		tooltip = "Show only east units "; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMGuar: MCC_RscButton
	{
		idc = -1;
		text = "Ind"; //--- ToDo: Localize;
		x = 0.373958 * safezoneW + safezoneX;
		y = 0.324069 * safezoneH + safezoneY;
		w = 0.039375 * safezoneW;
		h = 0.0280063 * safezoneH;
		colorText[] = {0,1,0,0.5};
		onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\side_change.sqf'");
		tooltip = "Show only independents' units "; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMTeleport: MCC_RscButton
	{
		idc = -1;
		text = "Teleport"; //--- ToDo: Localize;
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
		tooltip = "Teleport selected units"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMHijak: MCC_RscButton
	{
		idc = -1;
		text = "Hijack"; //--- ToDo: Localize;
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.203116 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
		tooltip = "Hijack selected unit, can only work on non-player units "; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMMark: MCC_RscButton
	{
		idc = -1;
		text = "Track units"; //--- ToDo: Localize;
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.236103 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
		tooltip = "Toggle on and off tracking all units on mission maker map"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMbroadcast: MCC_RscButton
	{
		idc = -1;
		text = "Broadcast"; //--- ToDo: Localize;
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.26909 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		onButtonClick = __EVAL ("[11] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
		tooltip = "Broadcast the live feed to all players for 15 seconds"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};

	class MCC_UMDelete: MCC_RscButton
	{
		idc = -1;
		text = "Delete"; //--- ToDo: Localize;
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.302077 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		onButtonClick = __EVAL ("[12] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
		tooltip = "Delete the selected unit or group"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMJoin: MCC_RscButton
	{
		idc = -1;
		text = "Join"; //--- ToDo: Localize;
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.335064 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		onButtonClick = __EVAL ("[13] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
		tooltip = "Join group or unit with another group or unit"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMHALO: MCC_RscButton
	{
		idc = -1;
		onButtonClick = __EVAL ("[9] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

		text = "H.A.L.O"; //--- ToDo: Localize;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		tooltip = "HALO the current selected units"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};

	class MCC_UMParachute: MCC_RscButton
	{
		idc = -1;
		onButtonClick = __EVAL ("[10] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

		text = "Parachute"; //--- ToDo: Localize;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.203116 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		tooltip = "Parachute the currently selected units"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMHCgeneral: MCC_RscButton
	{
		idc = -1;
		onButtonClick = __EVAL("[5] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

		text = "HC: General"; //--- ToDo: Localize;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.236103 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		tooltip = "Create a General who can command other AI groups on the same side"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMHCaddGroup: MCC_RscButton
	{
		idc = -1;
		onButtonClick = __EVAL("[7] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

		text = "HC: Add group"; //--- ToDo: Localize;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.26909 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		tooltip = "Add the selected group to it's appropriate side general control"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMHCclear: MCC_RscButton
	{
		idc = -1;
		onButtonClick = __EVAL("[6] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

		text = "HC: Clear"; //--- ToDo: Localize;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.302077 * safezoneH + safezoneY;
		w = 0.0525 * safezoneW;
		h = 0.0280063 * safezoneH;
		tooltip = "Remove all AI groups from the control of the selected commander"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_UMListFrame: MCC_RscFrame
	{
		idc = -1;
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.23625 * safezoneW;
		h = 0.0980219 * safezoneH;
	};
	class MCC_UMhint: MCC_RscText
	{
		idc = -1;
		text = "*Hold Ctrl for multi-selection"; //--- ToDo: Localize;
		x = 0.265104 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.137812 * safezoneW;
		h = 0.0280063 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
	};
	class MCC_PIPUm: MCC_RscPicture
	{
		idc = MCC_UM_PIC;
		text = "#(argb,256,256,1)r2t(rendertarget10,1.0);";
		x = 0.563021 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.269271 * safezoneW;
		h = 0.15394 * safezoneH;
	};
	class MCC_PIPUmFrame: MCC_RscFrame
	{
		idc = -1;
		x = 0.563021 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.269271 * safezoneW;
		h = 0.15394 * safezoneH;
	};
	class MCC_PIPviewMod: MCC_RscToolbox
	{
		idc = -1;
		strings[] = {"Regular","Night Vision","Thermal"};
		rows = 1;
		columns = 3;
		values[] = {0,1,3};
		onToolBoxSelChanged = __EVAL("_this execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um_camView.sqf'");

		x = 0.563021 * safezoneW + safezoneX;
		y = 0.335064 * safezoneH + safezoneY;
		w = 0.2 * safezoneW;
		h = 0.0329871 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_m4f1: MCC_RscFrame
	{
		idc = -1;
		x = 0.167708 * safezoneW + safezoneX;
		y = 0.0931586 * safezoneH + safezoneY;
		w = 0.664583 * safezoneW;
		h = 0.296884 * safezoneH;
	};
	class MCC_m4f2: MCC_RscFrame
	{
		idc = -1;
		x = 0.351042 * safezoneW + safezoneX;
		y = 0.0931586 * safezoneH + safezoneY;
		w = 0.48125 * safezoneW;
		h = 0.07697 * safezoneH;
	};
	class MCC_m4f3: MCC_RscFrame
	{
		idc = -1;
		x = 0.494271 * safezoneW + safezoneX;
		y = 0.390043 * safezoneH + safezoneY;
		w = 0.338021 * safezoneW;
		h = 0.109957 * safezoneH;
	};
	class MCC_m4f4: MCC_RscFrame
	{
		idc = -1;

		x = 0.167709 * safezoneW + safezoneX;
		y = 0.390043 * safezoneH + safezoneY;
		w = 0.326562 * safezoneW;
		h = 0.109957 * safezoneH;
	};
	class MCC_m4f5: MCC_RscFrame
	{
		idc = -1;

		x = 0.168549 * safezoneW + safezoneX;
		y = 0.0919812 * safezoneH + safezoneY;
		w = 0.6637 * safezoneW;
		h = 0.82 * safezoneH;
	};
	class MCC_m4f6: MCC_RscFrame
	{
		idc = -1;

		x = 0.167708 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.360938 * safezoneW;
		h = 0.0549786 * safezoneH;
	};
	class MCC_m4f7: MCC_RscFrame
	{
		idc = -1;

		x = 0.167708 * safezoneW + safezoneX;
		y = 0.554979 * safezoneH + safezoneY;
		w = 0.360938 * safezoneW;
		h = 0.131949 * safezoneH;
	};	
	class MCC_deleteBrushTittle: MCC_RscText
	{
		idc = -1;

		text = "Delete Brush:"; //--- ToDo: Localize;
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.510996 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0329871 * safezoneH;
		colorText[] = {0,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class MCC_deleteBrushCombo: MCC_RscCombo
	{
		idc = MCCDELETEBRUSH;
		onLBSelChanged =  __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");

		x = 0.305208 * safezoneW + safezoneX;
		y = 0.510996 * safezoneH + safezoneY;
		w = 0.144479 * safezoneW;
		h = 0.0340016 * safezoneH;
	};
	class MCC_deleteBrush: MCC_RscButton
	{
		idc = -1;
		onButtonClick = "hint 'Mark the area you want to delete'; MCC_delete_drawing = true";

		text = "Delete"; //--- ToDo: Localize;
		x = 0.459896 * safezoneW + safezoneX;
		y = 0.510996 * safezoneH + safezoneY;
		w = 0.0515625 * safezoneW;
		h = 0.0329871 * safezoneH;
		tooltip = "Delete the certain type of objects"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	//=============Air drop===============
	class MCC_airdropTittle: MCC_RscText
	{
		idc = -1;

		text = "Air Drop:"; //--- ToDo: Localize;
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.565974 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0329871 * safezoneH;
		colorText[] = {0,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class MCC_airdropTypeCombo: MCC_RscCombo
	{
		idc = MCC_AIRDROPTYPE;
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.609957 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0219914 * safezoneH;
		onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\cas\airdropReq.sqf'");
	};
	class MCC_airdropClassCombo: MCC_RscCombo
	{
		idc = MCC_airdropClass;
		x = 0.288021 * safezoneW + safezoneX;
		y = 0.609957 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	class MCC_airdropArrayCombo: MCC_RscCombo
	{
		idc = MCC_airdropArray;
		x = 0.265104 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	class MCC_airdropArrayTittle: MCC_RscText
	{
		idc = -1;

		text = "Current Airdrop:"; //--- ToDo: Localize;
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.0744792 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_airdropAdd: MCC_RscButton
	{
		idc = -1;
		text = "Add"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.609957 * safezoneH + safezoneY;
		w = 0.0572917 * safezoneW;
		h = 0.0219914 * safezoneH;
		tooltip = "Add this item to the current airdrop list"; //--- ToDo: Localize;
		onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\general_scripts\cas\airdropReq.sqf'");
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_airdropClear: MCC_RscButton
	{
		idc = -1;
		text = "Clear"; //--- ToDo: Localize;
		x = 0.459896 * safezoneW + safezoneX;
		y = 0.609957 * safezoneH + safezoneY;
		w = 0.0572917 * safezoneW;
		h = 0.0219914 * safezoneH;
		tooltip = "Clear the current airdrop list"; //--- ToDo: Localize;
		onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\general_scripts\cas\airdropReq.sqf'");
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_airdropCall: MCC_RscButton
	{
		idc = -1;
		text = "Call"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.0572917 * safezoneW;
		h = 0.0329871 * safezoneH;
		tooltip = "Call the current airdrop"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\cas\cas_request.sqf'");
	};
	class MCC_airdropAddConsole: MCC_RscButton
	{
		idc = -1;
		
		text = "Add Console"; //--- ToDo: Localize;
		x = 0.459896 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.0572917 * safezoneW;
		h = 0.0329871 * safezoneH;
		onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\cas\cas_request.sqf'");
		tooltip = "Add the current airdrop to the player's console"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};	
};
