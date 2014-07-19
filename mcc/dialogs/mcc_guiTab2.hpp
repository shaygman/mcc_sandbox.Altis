////////////////////////////////////////////////////////
// BY Shay Gman 03.2013
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
#define MCC_ZONE_LOC 1026

#define MCC_CLTEXT 2001
#define MCC_CASPLANETYPE 2002
#define MCC_CASTYPE 2003
#define MCC_ARTYTYPE 2004
#define MCC_ARTYSPREAD 2005
#define MCC_ARTYNUMBER 2006
#define MCC_artilleryDelayIDC 2037


#define MCC_TRAPS_TYPE 2007
#define MCC_TRAPS_OBJECT 2008
#define MCC_TRAPS_EXPLOSIN_SIZE 2009
#define MCC_TRAPS_EXPLOSIN_TYPE 2010
#define MCC_TRAPS_TARGET_FACTION 2011
#define MCC_TRAPS_JAMMABLE 2012
#define MCC_TRAPS_DISARM 2013
#define MCC_TRAPS_TRIGGER 2014
#define MCC_TRAPS_PROXIMITY 2015
#define MCC_TRAPS_AMBUSH 2016

#define MCC_EVAC_TYPE 2020
#define MCC_EVAC_CLASS 2021
#define MCC_EVAC_SELECTED 2022
#define MCC_EVAC_INSERTION 2023
#define MCC_EVAC_FLIGHTHIGHT 2024

#define MCC_CONVOY_CAR1 2030
#define MCC_CONVOY_CAR2 2031
#define MCC_CONVOY_CAR3 2032
#define MCC_CONVOY_CAR4 2033
#define MCC_CONVOY_CAR5 2034
#define MCC_CONVOY_HVT 2035
#define MCC_CONVOY_HVTCAR 2036

class MCC_Sandbox2 {
	  idd = MCC_SANDBOX2_IDD;
	  movingEnable = true;
	  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_gui_init2.sqf'");
	  
	  controlsBackground[] = 
	  {
	  MCC_pic,
	  MCC_background,
	  MCC_CommandLineTextFrmae,
	  MCC_mapBckg,
	  MCC_m2f1,
	  MCC_m2f2,
	  MCC_m2f3,
	  MCC_m2f4,
	  MCC_m2f5,
	  MCC_m2f6,
	  MCC_m2f7,
	  MCC_m2f8,
	  MCC_m2f9
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
	  MCC_missionControlTitle,
	  MCC_Debug,
	  MCC_DebugExtra,
	  MCC_MissionWIn,
	  MCC_MissionLost,
	  MCC_CommandLineTittle,
	  MCC_CommandLineText,
	  MCC_commandlineTextSmall,
	  MCC_commandlineTextBig,
	  MCC_commandlineLocal,
	  MCC_commandlineGlobal,
	  MCC_CASTitle,
	  MCC_CASPlaneTitle,
	  MCC_CASTypeTitle,
	  MCC_CASPlaneType,
	  MCC_CASType,
	  MCC_CASCall,
	  MCC_CASAdd,
	  MCC_artilleryTitle,
	  MCC_artilleryTypeTitle,
	  MCC_artillerySpreadTitle,
	  MCC_artilleryNumberTitle,
	  MCC_artilleryType,
	  MCC_artillerySpread,
	  MCC_artilleryNumber,
	  MCC_artilleryDelayText,
	  MCC_artilleryDelayCombo,
	  MCC_artilleryCall,
	  MCC_artilleryAdd,
	  MCC_trapsTittle,
	  MCC_trapsTypeTittle,
	  MCC_trapsObjectTittle,
	  MCC_trapsExplosionSizeTittle,
	  MCC_trapsExplosionTypeTittle,
	  MCC_trapsDisarmDurationTittle,
	  MCC_trapsJammableTittle,
	  MCC_trapsTargetFactionTittle,
	  MCC_trapsTriggerTittle,
	  MCC_trapsProximityTittle,
	  MCC_trapsAmbushGroupTittle,
	  MCC_trapsType,
	  MCC_trapsObject,
	  MCC_trapsExplosionSize,
	  MCC_trapsExplosionType,
	  MCC_trapsTargetFaction,
	  MCC_trapsJammable,
	  MCC_trapsDisarm,
	  MCC_trapsTrigger,
	  MCC_trapsProximity,
	  MCC_trapsAmbushGroup,
	  MCC_trapsCreateIED,
	  MCC_trapsCreateAmbush,
	  MCC_trapsExplainTittle,
	  MCC_trapsExplainTittle2,
	  MCC_evacTittle,
	  MCC_evacTypeTitle,
	  MCC_evacClassTitle,
	  MCC_evacType,
	  MCC_evacClass,
	  MCC_evacSpawn,
	  MCC_evacSelected,
	  MCC_evacSelectedTitle,
	  MCC_evacWp,
	  MCC_evac3Wp,
	  MCC_evacInsertionTitle,
	  MCC_evacInsertion,
	  MCC_evacDelHeli,
	  MCC_evacFlightHightTitle,
	  MCC_evacFlightHight,
	  MCC_evacDelPilot,
	  MCC_evacResHeli,
	  MCC_ConvoyTittle,
	  MCC_ConvoyCar1Tittle,
	  MCC_ConvoyCar2Tittle,
	  MCC_ConvoyCar3Tittle,
	  MCC_ConvoyCar4Tittle,
	  MCC_ConvoyCar5Tittle,
	  MCC_ConvoyCar1,
	  MCC_ConvoyCar2,
	  MCC_ConvoyCar3,
	  MCC_ConvoyCar4,
	  MCC_ConvoyCar5,
	  MCC_ConvoyHVTTittle,
	  MCC_ConvoyHVTCarTittle,
	  MCC_ConvoyHVT,
	  MCC_ConvoyHVTcar,
	  MCC_convoySpawn,
	  MCC_convoyReset,
	  MCC_convoyStart
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
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_factionCombo: MCC_RscCombo {idc = FACTIONCOMBO;
	x = 0.43125 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
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
	x = 0.54 * safezoneW + safezoneX;
	y = 0.434026 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_zone: MCC_RscCombo {idc = MCCZONENUMBER;	
	x = 0.603125 * safezoneW + safezoneX;
	y = 0.434026 * safezoneH + safezoneY;
	w = 0.0916667 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	onLBSelChanged = __EVAL("[0,0,0] execVM '"+MCCPATH+"mcc\pop_menu\zones.sqf'");
};
class MCC_zoneLocTittle: MCC_RscText {idc = -1;	text = "Location:"; 
	x = 0.54 * safezoneW + safezoneX;
	y = 0.467013 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_zoneLoc: MCC_RscCombo {idc = MCC_ZONE_LOC;	
	x = 0.603125 * safezoneW + safezoneX;
	y = 0.467013 * safezoneH + safezoneY;
	w = 0.0916667 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_zoneUpdate: MCC_RscButton {idc = -1;	text = "Update Zone"; 
	x = 0.70625 * safezoneW + safezoneX;
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
class MCC_background: MCC_RscText {idc = -1; text = "";
	x = 0.168549 * safezoneW + safezoneX;
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
class MCC_missionControlTitle: MCC_RscText
{
	idc = -1;
	text = "Mission Management"; //--- ToDo: Localize;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.161476 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_Debug: MCC_RscButton
{
	idc = -1;
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'RscDisplayDebugPublic';} else {player globalchat 'Access Denied'};";
	text = "Debug"; //--- ToDo: Localize;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.159984 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Open BIS Debug Console"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_DebugExtra: MCC_RscButton
{
	idc = -1;
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'RscDisplayDebug';} else {player globalchat 'Access Denied'};";
	text = "Adv. Debug"; //--- ToDo: Localize;
	x = 0.270534 * safezoneW + safezoneX;
	y = 0.159984 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Open BIS Advanced Debug Console"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_MissionWIn: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[5] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

	text = "Mission Won"; //--- ToDo: Localize;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.210987 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {0,1,0,0.8};
	tooltip = "End mission with - Mission Accomplished"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_MissionLost: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[6] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

	text = "Mission Failed"; //--- ToDo: Localize;
	x = 0.270534 * safezoneW + safezoneX;
	y = 0.210987 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {1,0,0,0.8};
	tooltip = "End mission with - Mission Failed"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
//----------------------Command Line------------------------------------------------
class MCC_CommandLineTittle: MCC_RscText
{
	idc = -1;
	text = "Command line:"; //--- ToDo: Localize;
	x = 0.185583 * safezoneW + safezoneX;
	y = 0.262053 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
};
class MCC_CommandLineText: MCC_RscText
{
	idc = MCC_CLTEXT;
	type = MCCCT_EDIT;
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.337044 * safezoneH + safezoneY;
	w = 0.160417 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_CommandLineTextFrmae: MCC_RscFrame
{
	idc = -1;
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.337044 * safezoneH + safezoneY;
	w = 0.160417 * safezoneW;
	h = 0.0439828 * safezoneH;
};

class MCC_commandlineTextSmall: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\commandLine.sqf'");

	text = "text"; //--- ToDo: Localize;
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.033995 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Broadcast the command line fraze to all clients - small fonts"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};


class MCC_commandlineTextBig: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\commandLine.sqf'");

	text = "TEXT"; //--- ToDo: Localize;
	x = 0.225 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.033995 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Broadcast the command line fraze to all clients - big fonts"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};


class MCC_commandlineLocal: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\commandLine.sqf'");

	text = "Local"; //--- ToDo: Localize;
	x = 0.270833 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.033995 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Execute the command line fraze only on the mission maker computer"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};

class MCC_commandlineGlobal: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\commandLine.sqf'");

	text = "Global"; //--- ToDo: Localize;
	x = 0.310937 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.033995 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Execute the command line fraze on all clients and sever"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
//-----------CAS-----------------------------------------------
class MCC_CASTitle: MCC_RscText
{
	idc = -1;
	text = "Close Air Support:"; //--- ToDo: Localize;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.448998 * safezoneH + safezoneY;
	w = 0.161476 * safezoneW;
	h = 0.0170008 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_CASPlaneTitle: MCC_RscText
{
	idc = -1;
	text = "Plane:"; //--- ToDo: Localize;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.482999 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_CASPlaneType: MCC_RscCombo
{
	idc = MCC_CASPLANETYPE;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.517001 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_CASTypeTitle: MCC_RscText
{
	idc = -1;
	text = "Type:"; //--- ToDo: Localize;
	x = 0.262035 * safezoneW + safezoneX;
	y = 0.482999 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_CASType: MCC_RscCombo
{
	idc = MCC_CASTYPE;
	x = 0.262035 * safezoneW + safezoneX;
	y = 0.517001 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_CASCall: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\cas\cas_request.sqf'");

	text = "Call"; //--- ToDo: Localize;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.551002 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	tooltip = "Call CAS - drag and draw a line on the minimap to call CAS"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_CASAdd: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\cas\cas_request.sqf'");

	text = "Add"; //--- ToDo: Localize;
	x = 0.270534 * safezoneW + safezoneX;
	y = 0.551002 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0170008 * safezoneH;
	tooltip = "Add CAS to MCC Console"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
//---------------------Artillery---------------------------------------------------------------------
class MCC_artilleryTitle: MCC_RscText
{
	idc = -1;
	text = "Artillery:"; //--- ToDo: Localize;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.585004 * safezoneH + safezoneY;
	w = 0.161476 * safezoneW;
	h = 0.0170008 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_artilleryTypeTitle: MCC_RscText
{
	idc = -1;
	text = "Type:"; //--- ToDo: Localize;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.619005 * safezoneH + safezoneY;
	w = 0.0509925 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_artillerySpreadTitle: MCC_RscText
{
	idc = -1;
	text = "Spread:"; //--- ToDo: Localize;
	x = 0.245038 * safezoneW + safezoneX;
	y = 0.619005 * safezoneH + safezoneY;
	w = 0.0509925 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_artilleryNumberTitle: MCC_RscText
{
	idc = -1;
	text = "#:"; //--- ToDo: Localize;
	x = 0.304529 * safezoneW + safezoneX;
	y = 0.619005 * safezoneH + safezoneY;
	w = 0.0424937 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_artilleryType: MCC_RscCombo
{
	idc = MCC_ARTYTYPE;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.653007 * safezoneH + safezoneY;
	w = 0.0509925 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_artillerySpread: MCC_RscCombo
{
	idc = MCC_ARTYSPREAD;
	x = 0.245038 * safezoneW + safezoneX;
	y = 0.653007 * safezoneH + safezoneY;
	w = 0.0509925 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_artilleryNumber: MCC_RscCombo
{
	idc = MCC_ARTYNUMBER;
	x = 0.304529 * safezoneW + safezoneX;
	y = 0.653007 * safezoneH + safezoneY;
	w = 0.0424937 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};

class MCC_artilleryDelayText: MCC_RscText
{
	idc = -1;

	text = "Delay:"; //--- ToDo: Localize;
	x = 0.245625 * safezoneW + safezoneX;
	y = 0.588845 * safezoneH + safezoneY;
	w = 0.0509925 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_artilleryDelayCombo: MCC_RscCombo
{
	idc = MCC_artilleryDelayIDC;

	x = 0.305781 * safezoneW + safezoneX;
	y = 0.589945 * safezoneH + safezoneY;
	w = 0.0406994 * safezoneW;
	h = 0.0162794 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};

class MCC_artilleryCall: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\artillery\artillery_request.sqf'");

	text = "Call"; //--- ToDo: Localize;
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.687009 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0170008 * safezoneH;
	tooltip = "Call Artillery on map position"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_artilleryAdd: MCC_RscButton
{
	idc = -1;
	onButtonClick =  __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\artillery\artillery_request.sqf'");

	text = "Add"; //--- ToDo: Localize;
	x = 0.270534 * safezoneW + safezoneX;
	y = 0.687009 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0170008 * safezoneH;
	tooltip = "Add artillery to MCC Console "; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
//-------------------------------------------------------TRAPS--------------------------
class MCC_trapsTittle: MCC_RscText					
{
	idc = -1;
	text = "IED & Ambush:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.214111 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_trapsTypeTittle: MCC_RscText
{
	idc = -1;
	text = "Type:"; //--- ToDo: Localize;
	x = 0.355521 * safezoneW + safezoneX;
	y = 0.27899 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsObjectTittle: MCC_RscText
{
	idc = -1;
	text = "Object:"; //--- ToDo: Localize;
	x = 0.355521 * safezoneW + safezoneX;
	y = 0.312991 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsExplosionSizeTittle: MCC_RscText
{
	idc = -1;
	text = "Explosion Size:"; //--- ToDo: Localize;
	x = 0.355521 * safezoneW + safezoneX;
	y = 0.346993 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsExplosionTypeTittle: MCC_RscText
{
	idc = -1;
	text = "Explosion Type:"; //--- ToDo: Localize;
	x = 0.355521 * safezoneW + safezoneX;
	y = 0.380995 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsDisarmDurationTittle: MCC_RscText
{
	idc = -1;
	text = "Disarm Duration:"; //--- ToDo: Localize;
	x = 0.508499 * safezoneW + safezoneX;
	y = 0.346993 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsJammableTittle: MCC_RscText
{
	idc = -1;
	text = "Jammable:"; //--- ToDo: Localize;
	x = 0.508499 * safezoneW + safezoneX;
	y = 0.312991 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsTargetFactionTittle: MCC_RscText
{
	idc = -1;
	text = "Target Faction:"; //--- ToDo: Localize;
	x = 0.508499 * safezoneW + safezoneX;
	y = 0.27899 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsTriggerTittle: MCC_RscText
{
	idc = -1;
	text = "Trigger Type:"; //--- ToDo: Localize;
	x = 0.508499 * safezoneW + safezoneX;
	y = 0.380995 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsProximityTittle: MCC_RscText
{
	idc = -1;
	text = "Proximity:"; //--- ToDo: Localize;
	x = 0.661476 * safezoneW + safezoneX;
	y = 0.27899 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsAmbushGroupTittle: MCC_RscText
{
	idc = -1;
	text = "Ambush Group:"; //--- ToDo: Localize;
	x = 0.661476 * safezoneW + safezoneX;
	y = 0.312991 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsType: MCC_RscCombo
{
	idc = MCC_TRAPS_TYPE;
	onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\traps\trap_change.sqf'");
	x = 0.440509 * safezoneW + safezoneX;
	y = 0.27899 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsObject: MCC_RscCombo
{
	idc = MCC_TRAPS_OBJECT;
	x = 0.440509 * safezoneW + safezoneX;
	y = 0.312991 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsExplosionSize: MCC_RscCombo
{
	idc = MCC_TRAPS_EXPLOSIN_SIZE;
	x = 0.440509 * safezoneW + safezoneX;
	y = 0.346993 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsExplosionType: MCC_RscCombo
{
	idc = MCC_TRAPS_EXPLOSIN_TYPE;
	x = 0.440509 * safezoneW + safezoneX;
	y = 0.380995 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsTargetFaction: MCC_RscCombo
{
	idc = MCC_TRAPS_TARGET_FACTION;
	x = 0.593487 * safezoneW + safezoneX;
	y = 0.27899 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsJammable: MCC_RscCombo
{
	idc = MCC_TRAPS_JAMMABLE;
	x = 0.593487 * safezoneW + safezoneX;
	y = 0.312991 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsDisarm: MCC_RscCombo
{
	idc = MCC_TRAPS_DISARM;
	x = 0.593487 * safezoneW + safezoneX;
	y = 0.346993 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsTrigger: MCC_RscCombo
{
	idc = MCC_TRAPS_TRIGGER;
	x = 0.593487 * safezoneW + safezoneX;
	y = 0.380995 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsProximity: MCC_RscCombo
{
	idc = MCC_TRAPS_PROXIMITY;
	x = 0.737965 * safezoneW + safezoneX;
	y = 0.27899 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsAmbushGroup: MCC_RscCombo
{
	idc = MCC_TRAPS_AMBUSH;
	x = 0.737965 * safezoneW + safezoneX;
	y = 0.312991 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_trapsCreateIED: MCC_RscButton
{
	idc = -1;
	onButtonClick =  __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\traps\trap_request.sqf'");

	text = "Create IED"; //--- ToDo: Localize;
	x = 0.661476 * safezoneW + safezoneX;
	y = 0.346993 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Create an IED on the given position"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_trapsCreateAmbush: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\traps\trap_request.sqf'");

	text = "Create Ambush"; //--- ToDo: Localize;
	x = 0.737965 * safezoneW + safezoneX;
	y = 0.346993 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Place an ambush group on the map (Hold Shift and drag a line between a group or IED to sync it with each other) "; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_trapsExplainTittle: MCC_RscText
{
	idc = -1;
	text = "*Press Ctrl + left mouse button to trigger an IED or ambushing party";
	x = 0.448437 * safezoneW + safezoneX;
	y = 0.214111 * safezoneH + safezoneY;
	w = 0.356948 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.55)";
};
class MCC_trapsExplainTittle2: MCC_RscText
{
	idc = -1;
	text = "*Hold Shift + left click and draw a line to link IEDs and/or ambush parties";
	x = 0.449008 * safezoneW + safezoneX;
	y = 0.239987 * safezoneH + safezoneY;
	w = 0.356948 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.55)";
};
//==============================EVAC===========================================================
class MCC_evacTittle: MCC_RscText
{
	idc = -1;
	text = "Evac:"; //--- ToDo: Localize;
	x = 0.185521 * safezoneW + safezoneX;
	y = 0.720938 * safezoneH + safezoneY;
	w = 0.161476 * safezoneW;
	h = 0.0170008 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_evacTypeTitle: MCC_RscText
{
	idc = -1;
	text = "Type:"; //--- ToDo: Localize;
	x = 0.184961 * safezoneW + safezoneX;
	y = 0.752021 * safezoneH + safezoneY;
	w = 0.0509924 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacClassTitle: MCC_RscText
{
	idc = -1;
	text = "Class:"; //--- ToDo: Localize;
	x = 0.184961 * safezoneW + safezoneX;
	y = 0.780023 * safezoneH + safezoneY;
	w = 0.0509924 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacType: MCC_RscCombo
{
	idc = MCC_EVAC_TYPE;
	onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\evac\evac_change.sqf'");
	x = 0.240968 * safezoneW + safezoneX;
	y = 0.752021 * safezoneH + safezoneY;
	w = 0.0560069 * safezoneW;
	h = 0.0140012 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacClass: MCC_RscCombo
{
	idc = MCC_EVAC_CLASS;

	x = 0.240968 * safezoneW + safezoneX;
	y = 0.783104 * safezoneH + safezoneY;
	w = 0.105013 * safezoneW;
	h = 0.0140012 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacSpawn: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\evac\request_heli.sqf'");

	text = "Spawn"; //--- ToDo: Localize;
	x = 0.303976 * safezoneW + safezoneX;
	y = 0.752021 * safezoneH + safezoneY;
	w = 0.0420052 * safezoneW;
	h = 0.0140012 * safezoneH;
	tooltip = "Spawn Evac Vehicle on map click"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_evacSelected: MCC_RscCombo
{
	idc = MCC_EVAC_SELECTED;
	onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\evac\evac_focus.sqf'");
	x = 0.240968 * safezoneW + safezoneX;
	y = 0.836028 * safezoneH + safezoneY;
	w = 0.105013 * safezoneW;
	h = 0.0140012 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_evacSelectedTitle: MCC_RscText
{
	idc = -1;
	text = "Evac:"; //--- ToDo: Localize;
	x = 0.184961 * safezoneW + safezoneX;
	y = 0.836028 * safezoneH + safezoneY;
	w = 0.0509924 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacWp: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[] execVM '"+MCCPATH+"mcc\general_scripts\evac\add_wp_heli.sqf'");

	text = "1 WP"; //--- ToDo: Localize;
	x = 0.303976 * safezoneW + safezoneX;
	y = 0.892033 * safezoneH + safezoneY;
	w = 0.0420052 * safezoneW;
	h = 0.0140012 * safezoneH;
	tooltip = "Add Evac WP"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_evac3Wp: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[] execVM '"+MCCPATH+"mcc\general_scripts\evac\move_heli.sqf'");

	text = "3 WP"; //--- ToDo: Localize;
	x = 0.303976 * safezoneW + safezoneX;
	y = 0.86403 * safezoneH + safezoneY;
	w = 0.0420052 * safezoneW;
	h = 0.0140012 * safezoneH;
	tooltip = "Add 3 Evac way points"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_evacInsertionTitle: MCC_RscText
{
	idc = -1;
	text = "Insertion:"; //--- ToDo: Localize;
	x = 0.184961 * safezoneW + safezoneX;
	y = 0.86403 * safezoneH + safezoneY;
	w = 0.0509924 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacInsertion: MCC_RscCombo
{
	idc = MCC_EVAC_INSERTION;

	x = 0.240968 * safezoneW + safezoneX;
	y = 0.86403 * safezoneH + safezoneY;
	w = 0.0560069 * safezoneW;
	h = 0.0140012 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacDelHeli: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\evac\delete_heli.sqf'");

	text = "Del. Evac"; //--- ToDo: Localize;
	x = 0.184961 * safezoneW + safezoneX;
	y = 0.808026 * safezoneH + safezoneY;
	w = 0.049006 * safezoneW;
	h = 0.0140012 * safezoneH;
	colorText[] = {1,0,0,0.7};
	tooltip = "Delete the evac vehicle"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacFlightHightTitle: MCC_RscText
{
	idc = -1;
	text = "F. Height:"; //--- ToDo: Localize;
	x = 0.184961 * safezoneW + safezoneX;
	y = 0.892033 * safezoneH + safezoneY;
	w = 0.0509924 * safezoneW;
	h = 0.0170008 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacFlightHight: MCC_RscCombo
{
	idc = MCC_EVAC_FLIGHTHIGHT;

	x = 0.240968 * safezoneW + safezoneX;
	y = 0.892033 * safezoneH + safezoneY;
	w = 0.0560069 * safezoneW;
	h = 0.0140012 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacDelPilot: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\evac\delete_heli.sqf'");

	text = "Del. Driver"; //--- ToDo: Localize;
	x = 0.240968 * safezoneW + safezoneX;
	y = 0.808026 * safezoneH + safezoneY;
	w = 0.049006 * safezoneW;
	h = 0.0140012 * safezoneH;
	colorText[] = {1,0,0,0.7};
	tooltip = "Delete the evac driver"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_evacResHeli: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\evac\delete_heli.sqf'");

	text = "Res. Driver"; //--- ToDo: Localize;
	x = 0.296975 * safezoneW + safezoneX;
	y = 0.808026 * safezoneH + safezoneY;
	w = 0.049006 * safezoneW;
	h = 0.0140012 * safezoneH;
	colorText[] = {0,1,0,0.7};
	tooltip = "Delete the evac vehicle"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
//=====================Convoy=================================================================
class MCC_ConvoyTittle: MCC_RscText
{
	idc = -1;
	text = "Convoy:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.415981 * safezoneH + safezoneY;
	w = 0.065625 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar1Tittle: MCC_RscText
{
	idc = -1;
	text = "Car1:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.457991 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar2Tittle: MCC_RscText
{
	idc = -1;
	text = "Car2:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar3Tittle: MCC_RscText
{
	idc = -1;
	text = "Car3:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.542009 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar4Tittle: MCC_RscText
{
	idc = -1;
	text = "Car4:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.584019 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar5Tittle: MCC_RscText
{
	idc = -1;
	text = "Car5:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.626028 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar1: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR1;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.457991 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar2: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR2;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar3: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR3;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.542009 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar4: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR4;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.584019 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar5: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR5;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.626028 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyHVTTittle: MCC_RscText
{
	idc = -1;
	text = "HVT:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.668037 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyHVTCarTittle: MCC_RscText
{
	idc = -1;
	text = "HVT Car:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.710047 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
};
class MCC_ConvoyHVT: MCC_RscCombo
{
	idc = MCC_CONVOY_HVT;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.668037 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyHVTCar: MCC_RscCombo
{
	idc = MCC_CONVOY_HVTCAR;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.710047 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_convoySpawn: MCC_RscButton
{
	idc = -1;
	text = "Spawn"; //--- ToDo: Localize;
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\convoy\make_convoy_WP.sqf'");
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.752056 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	tooltip = "Spawn convoy and set WP"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_convoyReset: MCC_RscButton
{
	idc = -1;
	text = "Reset"; //--- ToDo: Localize;
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\convoy\reset_convoy_WP.sqf'");
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.752056 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	tooltip = "Reset convoy's waypoints"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_convoyStart: MCC_RscButton
{
	idc = -1;
	text = "Start"; //--- ToDo: Localize;
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\convoy\start_convoy.sqf'");
	x = 0.460625 * safezoneW + safezoneX;
	y = 0.752056 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	tooltip = "Start convoy movement"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_m2f1: MCC_RscFrame
{
	idc = -1;
	x = 0.168549 * safezoneW + safezoneX;
	y = 0.0919812 * safezoneH + safezoneY;
	w = 0.182493 * safezoneW;
	h = 0.2980618 * safezoneH;
};
class MCC_m2f2: MCC_RscFrame
{
	idc = -1;
	x = 0.168549 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.182493 * safezoneW;
	h = 0.131949 * safezoneH;
};
class MCC_m2f3: MCC_RscFrame
{
	idc = -1;
	x = 0.168549 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.182493 * safezoneW;
	h = 0.131949 * safezoneH;
};
class MCC_m2f4: MCC_RscFrame
{
	idc = -1;
	x = 0.168549 * safezoneW + safezoneX;
	y = 0.708919 * safezoneH + safezoneY;
	w = 0.182493 * safezoneW;
	h = 0.2 * safezoneH;
};
class MCC_m2f5: MCC_RscFrame
{
	idc = -1;
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.412034 * safezoneH + safezoneY;
	w = 0.182493 * safezoneW;
	h = 0.428833 * safezoneH;
};
class MCC_m2f6: MCC_RscFrame
{
	idc = -1;
	x = 0.533535 * safezoneW + safezoneX;
	y = 0.412034 * safezoneH + safezoneY;
	w = 0.0.20232 * safezoneW;
	h = 0.0879657 * safezoneH;
};
class MCC_m2f7: MCC_RscFrame
{
	idc = -1;
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.214111 * safezoneH + safezoneY;
	w = 0.481 * safezoneW;
	h = 0.197923 * safezoneH;
};
class MCC_m2f8: MCC_RscFrame
{
	idc = -1;
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
	w = 0.481 * safezoneW;
	h = 0.0439828 * safezoneH;
};
class MCC_m2f9: MCC_RscFrame
{
	idc = -1;

	x = 0.168549 * safezoneW + safezoneX;
	y = 0.0919812 * safezoneH + safezoneY;
	w = 0.6637 * safezoneW;
	h = 0.82 * safezoneH;
};
};
