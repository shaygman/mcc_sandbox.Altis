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

#define MCC_MARKER_TEXT 3050
#define MCC_MARKER_COLOR 3051
#define MCC_MARKER_TYPE 3052
#define MCC_MARKER_SHAPE 3053
#define MCC_MARKER_BRUSH 3054

#define MCC_BRIEFING_TEXT 3055

#define MCC_TASKS_NAME 3056
#define MCC_TASKS_DESCRIPTION 3057
#define MCC_TASKS_LIST 3058

#define MCC_JUKEBOX_VOLUME 3059
#define MCC_JUKEBOX_TRACK 3060
#define MCC_JUKEBOX_ACTIVATE 3061
#define MCC_JUKEBOX_CONDITION 3062
#define MCC_JUKEBOX_ZONE 3063

#define MCC_TRIGGERS_ACTIVATE 3064
#define MCC_TRIGGERS_CONDITION 3065
#define MCC_TRIGGERS_SHAPE 3066
#define MCC_TRIGGERS_LIST 3067
#define MCC_TRIGGERS_NAME 3068 
#define MCC_TRIGGERS_TIME_MIN 3071
#define MCC_TRIGGERS_TIME_MAX 3072
#define MCC_TRIGGERS_STAT_COND 3073
#define MCC_TRIGGERS_STAT_DEACTIVE 3075

#define MCC_UAV_TYPE 3069


class MCC_Sandbox3 {
	  idd = MCC_SANDBOX3_IDD;
	  movingEnable = true;
	  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_gui_init3.sqf'");
	  
	  controlsBackground[] = 
	  {
	  MCC_pic,
	  MCC_background,
	  MCC_markerTextFrame,
	  MCC_briefingTextFrame,
	  MCC_TasksNameFrame,
	  MCC_TasksDescriptionFrame,
	  MCC_triggerGenNameFrame,
	  MCC_triggerStatCondFrame,
	  MCC_triggerStatDeactiveFrame,
	  MCC_triggerGenTimeMinFrame,
	  MCC_triggerGenTimeMaxFrame,
	  MCC_mapBckg,
	  MCC_m3f1,
	  MCC_m3f2,
	  MCC_m3f3,
	  MCC_m3f4,
	  MCC_m3f5,
	  MCC_m3f6,
	  MCC_m3f7,
	  MCC_m3f8,
	  MCC_m3f9
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
		MCC_markerGeneratorTittle,
		MCC_markerColorTittle,
		MCC_markerTypeTittle,
		MCC_markerShapeTittle,
		MCC_markerBrushTittle,
		MCC_markerTextTittle,
		MCC_markerText,
		MCC_markerColor,
		MCC_markerType,
		MCC_markerShape,
		MCC_markerBrush,
		MCC_markerSpawnMarker,
		MCC_markerSpawnBrush,
		MCC_markerDeleteMarker,
		MCC_briefingGeneratorTittle,
		MCC_briefingtext,
		MCC_briefingBriefing,
		MCC_briefingEnemy,
		MCC_briefingFriendly,
		MCC_briefingMission,
		MCC_briefingSpecial,
		MCC_briefingSupport,
		MCC_TasksGeneratorTittle,
		MCC_TasksNameTittle,
		MCC_TasksDescriptionTittle,
		MCC_TasksName,
		MCC_TasksDescription,
		MCC_Taskslist,
		MCC_TasksCreate,
		MCC_TasksWP,
		MCC_TasksWPCin,
		MCC_TasksSucceed,
		MCC_TasksFailed,
		MCC_TasksCancled,
		MCC_TasksDelete,
		MCC_JukeboxTittle,
		MCC_JukeboxMusic,
		MCC_JukeboxSound,
		MCC_JukeboxTrackTittle,
		MCC_JukeboxVolumeTittle,
		MCC_JukeboxActivateTittle,
		MCC_JukeboxConditionTittle,
		MCC_JukeboxZoneTittle,
		MCC_JukeboxLink,
		MCC_JukeboxVolume,
		MCC_JukeboxTrack,
		MCC_JukeboxActivate,
		MCC_JukeboxCondition,
		MCC_JukeboxZone,
		MCC_JukeboxPlay,
		MCC_JukeboxStop,
		MCC_triggerGenTittle,
		MCC_triggerGenActivateTittle,
		MCC_triggerGenConditionTittle,
		MCC_triggerGenShapeTittle,
		MCC_triggerGenNameTittle,
		MCC_triggerGenTriggerTittle,
		MCC_triggerGenActivate,
		MCC_triggerGenCondition,
		MCC_triggerGenShape,
		MCC_triggerGenTrigger,
		MCC_triggerGenName,
		MCC_triggerGenCreate,
		MCC_triggerGenMove,
		MCC_triggerGenTimeMinTittle,
		MCC_triggerGenTimeMaxTittle,
		MCC_triggerGenTimeMin,
		MCC_triggerGenTimeMax,
		MCC_triggerStatCondTittle,
		MCC_triggerStatCond,
		MCC_triggerStatDeactive,
		MCC_triggerStatDeactiveTittle,
		MCC_UAVTittle,
		MCC_UAVTypeTittle,
		MCC_UAVType,
		MCC_UAVSpawn
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
	x = 0.355521 * safezoneW + safezoneX;
	y = 0.176985 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_factionCombo: MCC_RscCombo {idc = FACTIONCOMBO;
	x = 0.43201 * safezoneW + safezoneX;
	y = 0.176985 * safezoneH + safezoneY;
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
	x = 0.545833 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0572917 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_zone: MCC_RscCombo {idc = MCCZONENUMBER;	
	x = 0.614583 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	onLBSelChanged = __EVAL("[0,0,0] execVM '"+MCCPATH+"mcc\pop_menu\zones.sqf'");
};
class MCC_zoneLocTittle: MCC_RscText {idc = -1;	text = "Location:"; 
	x = 0.545833 * safezoneW + safezoneX;
	y = 0.472951 * safezoneH + safezoneY;
	w = 0.0572917 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_zoneLoc: MCC_RscCombo {idc = MCC_ZONE_LOC;	
	x = 0.614583 * safezoneW + safezoneX;
	y = 0.472951 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_zoneUpdate: MCC_RscButton {idc = -1;	text = "Update Zone"; 
	x = 0.734896 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0329871 * safezoneH;
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
//============================== Marker Genrator ================================================
class MCC_markerGeneratorTittle: MCC_RscText
{
	idc = -1;
	text = "Marker Generator:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.121916 * safezoneH + safezoneY;
	w = 0.144375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_markerColorTittle: MCC_RscText
{
	idc = -1;
	text = "Color:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.163925 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerTypeTittle: MCC_RscText
{
	idc = -1;
	text = "Type:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.205934 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerShapeTittle: MCC_RscText
{
	idc = -1;
	text = "Shape:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.247944 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerBrushTittle: MCC_RscText
{
	idc = -1;
	text = "Brush:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.289953 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerTextTittle: MCC_RscText
{
	idc = -1;
	text = "Text:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.331963 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerText: MCC_RscText
{
	idc = MCC_MARKER_TEXT;
	type = MCCCT_EDIT;
	x = 0.230938 * safezoneW + safezoneX;
	y = 0.331963 * safezoneH + safezoneY;
	w = 0.105 * safezoneW;
	h = 0.0420094 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerColor: MCC_RscCombo
{
	idc = MCC_MARKER_COLOR;
	x = 0.230938 * safezoneW + safezoneX;
	y = 0.163925 * safezoneH + safezoneY;
	w = 0.065625 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerType: MCC_RscCombo
{
	idc = MCC_MARKER_TYPE;
	x = 0.230938 * safezoneW + safezoneX;
	y = 0.205934 * safezoneH + safezoneY;
	w = 0.065625 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerShape: MCC_RscCombo
{
	idc = MCC_MARKER_SHAPE;
	x = 0.230938 * safezoneW + safezoneX;
	y = 0.247944 * safezoneH + safezoneY;
	w = 0.065625 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerBrush: MCC_RscCombo
{
	idc = MCC_MARKER_BRUSH;
	x = 0.230938 * safezoneW + safezoneX;
	y = 0.289953 * safezoneH + safezoneY;
	w = 0.065625 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerSpawnMarker: MCC_RscButton
{
	idc = -1;
	text = "Marker"; //--- ToDo: Localize;
	x = 0.303125 * safezoneW + safezoneX;
	y = 0.163925 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0420094 * safezoneH;
	onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\pop_menu\markers_req.sqf'");
	tooltip = "Create a marker"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerSpawnBrush: MCC_RscButton
{
	idc = -1;
	text = "Brush"; //--- ToDo: Localize;
	x = 0.303125 * safezoneW + safezoneX;
	y = 0.219938 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0420094 * safezoneH;
	onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\markers_req.sqf'");
	tooltip = "Create a brush"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerDeleteMarker: MCC_RscButton
{
	idc = -1;
	text = "Delete"; //--- ToDo: Localize;
	x = 0.303125 * safezoneW + safezoneX;
	y = 0.27595 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0420094 * safezoneH;
	onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\pop_menu\markers_req.sqf'");
	tooltip = "Delete marker or brush with the give name"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_markerTextFrame: MCC_RscFrame
{
	idc = -1;
	x = 0.230938 * safezoneW + safezoneX;
	y = 0.331963 * safezoneH + safezoneY;
	w = 0.105 * safezoneW;
	h = 0.0420094 * safezoneH;
};
//============================ Briefing =================================================
class MCC_briefingGeneratorTittle: MCC_RscText
{
	idc = -1;
	text = "Briefing Generator:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.219938 * safezoneH + safezoneY;
	w = 0.13125 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_briefingtext: MCC_RscText
{
	idc = MCC_BRIEFING_TEXT;
	type = MCCCT_EDIT;
	x = 0.493437 * safezoneW + safezoneX;
	y = 0.247944 * safezoneH + safezoneY;
	w = 0.315 * safezoneW;
	h = 0.0560125 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_briefingTextFrame: MCC_RscFrame
{
	idc = -1;
	x = 0.493437 * safezoneW + safezoneX;
	y = 0.247944 * safezoneH + safezoneY;
	w = 0.315 * safezoneW;
	h = 0.0560125 * safezoneH;
};
class MCC_briefingBriefing: MCC_RscButton
{
	idc = -1;
	text = "Situation"; //--- ToDo: Localize;
	x = 0.362187 * safezoneW + safezoneX;
	y = 0.261947 * safezoneH + safezoneY;
	w = 0.0525 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\pop_menu\briefing.sqf'");
	tooltip = "Add the given text to mission briefings"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_briefingEnemy: MCC_RscButton
{
	idc = -1;
	text = "Enemy forces"; //--- ToDo: Localize;
	x = 0.494218 * safezoneW + safezoneX;
	y = 0.214728 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\briefing.sqf'");
	tooltip = "Add the given text to mission's Enemy forces intel"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
};
class MCC_briefingFriendly: MCC_RscButton
{
	idc = -1;
	text = "Friendly forces"; //--- ToDo: Localize;
	x = 0.57375 * safezoneW + safezoneX;
	y = 0.214729 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\pop_menu\briefing.sqf'");
	tooltip = "Add the given text to mission's friendly forces intel"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
};
class MCC_briefingMission: MCC_RscButton
{
	idc = -1;
	text = "Mission"; //--- ToDo: Localize;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.261947 * safezoneH + safezoneY;
	w = 0.0590625 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\pop_menu\briefing.sqf'");
	tooltip = "Add the given text to mission overview"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_briefingSpecial: MCC_RscButton
{
	idc = -1;
	text = "Special Tasks"; //--- ToDo: Localize;
	x = 0.653594 * safezoneW + safezoneX;
	y = 0.213426 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[4] execVM '"+MCCPATH+"mcc\pop_menu\briefing.sqf'");
	tooltip = "Add the given text to mission's special tasks"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
};
class MCC_briefingSupport: MCC_RscButton
{
	idc = -1;
	text = "Support"; //--- ToDo: Localize;
	x = 0.73625 * safezoneW + safezoneX;
	y = 0.213426 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[5] execVM '"+MCCPATH+"mcc\pop_menu\briefing.sqf'");
	tooltip = "Add the given text to mission's support intel"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
};
//=============================== Tasks ====================================================
class MCC_TasksGeneratorTittle: MCC_RscText
{
	idc = -1;
	text = "Tasks Generator:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.317959 * safezoneH + safezoneY;
	w = 0.137812 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_TasksNameTittle: MCC_RscText
{
	idc = -1;
	text = "Name:"; //--- ToDo: Localize;
	x = 0.493437 * safezoneW + safezoneX;
	y = 0.317959 * safezoneH + safezoneY;
	w = 0.0590625 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TasksDescriptionTittle: MCC_RscText
{
	idc = -1;
	text = "Description:"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.357056 * safezoneH + safezoneY;
	w = 0.0590626 * safezoneW;
	h = 0.0280063 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_TasksName: MCC_RscText
{
	idc = MCC_TASKS_NAME;
	type = MCCCT_EDIT;
	x = 0.559062 * safezoneW + safezoneX;
	y = 0.317959 * safezoneH + safezoneY;
	w = 0.164062 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_TasksDescription: MCC_RscText
{
	idc = MCC_TASKS_DESCRIPTION;
	type = MCCCT_EDIT;
	x = 0.588917 * safezoneW + safezoneX;
	y = 0.357056 * safezoneH + safezoneY;
	w = 0.217708 * safezoneW;
	h = 0.0549786 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
}
class MCC_TasksNameFrame: MCC_RscFrame
{
	idc = -1;
	x = 0.559062 * safezoneW + safezoneX;
	y = 0.317959 * safezoneH + safezoneY;
	w = 0.164062 * safezoneW;
	h = 0.0280062 * safezoneH;
};
class MCC_TasksDescriptionFrame: MCC_RscFrame
{
	idc = -1;
	x = 0.588917 * safezoneW + safezoneX;
	y = 0.357056 * safezoneH + safezoneY;
	w = 0.217708 * safezoneW;
	h = 0.0549786 * safezoneH;
};

class MCC_Taskslist: MCC_RscCombo
{
	idc = MCC_TASKS_LIST;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.357056 * safezoneH + safezoneY;
	w = 0.131249 * safezoneW;
	h = 0.0280063 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_TasksCreate: MCC_RscButton
{
	idc = -1;
	text = "Create"; //--- ToDo: Localize;
	x = 0.73625 * safezoneW + safezoneX;
	y = 0.317959 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");
	tooltip = "Create Task with the given name and description"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
};
class MCC_TasksWP: MCC_RscButton
{
	idc = -1;
	text = "WP"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.034375 * safezoneW;
	h = 0.0329871 * safezoneH;
	onButtonClick = __EVAL ("[7] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");
	tooltip = "Add Waypoint to the selected task"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};

class MCC_TasksWPCin: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

	text = "WP (cin)"; //--- ToDo: Localize;
	x = 0.396875 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.034375 * safezoneW;
	h = 0.0329871 * safezoneH;
	tooltip = "Add Waypoint to the selected task with an establish shot"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_TasksSucceed: MCC_RscButton
{
	idc = -1;
	text = "Succeed"; //--- ToDo: Localize;
	x = 0.551563 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.034375 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,1,0,0.5};
	onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");
	tooltip = "Mark the selected task as succeeded"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TasksFailed: MCC_RscButton
{
	idc = -1;
	text = "Failed"; //--- ToDo: Localize;
	x = 0.511458 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.034375 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {1,0,0,0.7};
	onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");
	tooltip = "Mark the selected task as Failed"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TasksCancled: MCC_RscButton
{
	idc = -1;
	text = "Cancel"; //--- ToDo: Localize;
	x = 0.436979 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.034375 * safezoneW;
	h = 0.0329871 * safezoneH;
	onButtonClick = __EVAL ("[4] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");
	tooltip = "Mark the selected task as cancelled"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};

class  MCC_TasksDelete: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL ("[8] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

	text = "Delete"; //--- ToDo: Localize;
	x = 0.477083 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.0286458 * safezoneW;
	h = 0.0329871 * safezoneH;
	tooltip = "Delete the selected task"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
//=========================== Jukebox =====================================================
class MCC_JukeboxTittle: MCC_RscText
{
	idc = -1;
	text = "Juke Box:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.443988 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxMusic: MCC_RscButton
{
	idc = -1;
	text = "Music"; //--- ToDo: Localize;
	x = 0.26375 * safezoneW + safezoneX;
	y = 0.443988 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[6] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Switch to music tracks"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxSound: MCC_RscButton
{
	idc = -1;
	text = "Sound"; //--- ToDo: Localize;
	x = 0.309687 * safezoneW + safezoneX;
	y = 0.443988 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[7] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Switch to sound tracks"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxTrackTittle: MCC_RscText
{
	idc = -1;
	text = "Track:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.485997 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxVolumeTittle: MCC_RscText
{
	idc = -1;
	text = "Volume:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.528006 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxActivateTittle: MCC_RscText
{
	idc = -1;
	text = "Activate:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.570016 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxConditionTittle: MCC_RscText
{
	idc = -1;
	text = "Condition:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.612025 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_JukeboxZoneTittle: MCC_RscText
{
	idc = -1;
	text = "Zone:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.654034 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxLink: MCC_RscButton
{
	idc = -1;
	text = "Link"; //--- ToDo: Localize;
	x = 0.309687 * safezoneW + safezoneX;
	y = 0.654034 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[5] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Link the sound or music to the selected zone"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxVolume: MCC_RscSlider
{
	idc = MCC_JUKEBOX_VOLUME;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.528006 * safezoneH + safezoneY;
	w = 0.0590625 * safezoneW;
	h = 0.0280062 * safezoneH;
	onSliderPosChanged = __EVAL ("[4] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
};
class MCC_JukeboxTrack: MCC_RscCombo
{
	idc = MCC_JUKEBOX_TRACK;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.485997 * safezoneH + safezoneY;
	w = 0.111562 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxActivate: MCC_RscCombo
{
	idc = MCC_JUKEBOX_ACTIVATE;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.570016 * safezoneH + safezoneY;
	w = 0.111562 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxCondition: MCC_RscCombo
{
	idc = MCC_JUKEBOX_CONDITION;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.612025 * safezoneH + safezoneY;
	w = 0.111562 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxZone: MCC_RscCombo
{
	idc = MCC_JUKEBOX_ZONE;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.654034 * safezoneH + safezoneY;
	w = 0.0590625 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxPlay: MCC_RscButton
{
	idc = -1;
	text = ">"; //--- ToDo: Localize;
	x = 0.303125 * safezoneW + safezoneX;
	y = 0.528006 * safezoneH + safezoneY;
	w = 0.0196875 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Play track"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxStop: MCC_RscButton
{
	idc = -1;
	text = "[]"; //--- ToDo: Localize;
	x = 0.329376 * safezoneW + safezoneX;
	y = 0.528006 * safezoneH + safezoneY;
	w = 0.0196875 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Stop track"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
//================================= Triggers ======================================================
class MCC_triggerGenTittle: MCC_RscText
{
	idc = -1;
	text = "Triggers Generator:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.144375 * safezoneW;
	h = 0.0280063 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerGenActivateTittle: MCC_RscText
{
	idc = -1;
	text = "Activate:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.478009 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0219914 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerGenConditionTittle: MCC_RscText
{
	idc = -1;
	text = "Condition:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.510996 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0219914 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_triggerGenShapeTittle: MCC_RscText
{
	idc = -1;
	text = "Shape:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.719914 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0219914 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_triggerGenNameTittle: MCC_RscText
{
	idc = -1;
	text = "Name:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.752901 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0219914 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_triggerGenTriggerTittle: MCC_RscText
{
	idc = -1;
	text = "Trigger:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0219914 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_triggerGenActivate: MCC_RscCombo
{
	idc = MCC_TRIGGERS_ACTIVATE;
	x = 0.408333 * safezoneW + safezoneX;
	y = 0.478009 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_triggerGenCondition: MCC_RscCombo
{
	idc = MCC_TRIGGERS_CONDITION;
	x = 0.408333 * safezoneW + safezoneX;
	y = 0.510996 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_triggerGenShape: MCC_RscCombo
{
	idc = MCC_TRIGGERS_SHAPE;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.719914 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_triggerGenTrigger: MCC_RscCombo
{
	idc = MCC_TRIGGERS_LIST;
	x = 0.408333 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_triggerGenName: MCC_RscText
{
	idc = MCC_TRIGGERS_NAME;
	type = MCCCT_EDIT;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.752901 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerGenNameFrame: MCC_RscFrame
{
	idc = -1;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.752901 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_triggerGenCreate: MCC_RscButton
{
	idc = -1;
	text = "Create"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.785888 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
	onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\general_scripts\triggers\triggers.sqf'");
	tooltip = "Create trigger"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_triggerGenMove: MCC_RscButton
{
	idc = -1;
	text = "Move"; //--- ToDo: Localize;
	x = 0.448438 * safezoneW + safezoneX;
	y = 0.785888 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
	onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\general_scripts\triggers\triggers.sqf'");
	tooltip = "Move the selected trigger"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerGenTimeMinTittle: MCC_RscText
{
	idc = -1;
	
	text = "Time Min:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.543983 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerGenTimeMaxTittle: MCC_RscText
{
	idc = -1;

	text = "Time Max:"; //--- ToDo: Localize;
	x = 0.43125 * safezoneW + safezoneX;
	y = 0.543983 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerGenTimeMin: MCC_RscText
{
	idc = MCC_TRIGGERS_TIME_MIN;
	type = MCCCT_EDIT;
	text = "0";
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerGenTimeMinFrame: MCC_RscFrame
{
	idc = -1;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerGenTimeMax: MCC_RscText
{
	idc = MCC_TRIGGERS_TIME_MAX;
	type = MCCCT_EDIT;
	text = "0";
	x = 0.43125 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerGenTimeMaxFrame: MCC_RscFrame
{
	idc = -1;
	x = 0.43125 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerStatCondTittle: MCC_RscText
{
	idc = -1;

	text = "Condition:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerStatCond: MCC_RscText
{
	idc = MCC_TRIGGERS_STAT_COND;
	text = "this";
	type = MCCCT_EDIT;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerStatCondFrame: MCC_RscFrame
{
	idc = -1;

	x = 0.414063 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerStatDeactive: MCC_RscText
{
	idc = MCC_TRIGGERS_STAT_DEACTIVE;
	type = MCCCT_EDIT;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.664936 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerStatDeactiveFrame: MCC_RscFrame
{
	idc = -1;

	x = 0.414063 * safezoneW + safezoneX;
	y = 0.664936 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_triggerStatDeactiveTittle: MCC_RscText
{
	idc = -1;

	text = "On Dea:"; //--- ToDo: Localize;
	x = 0.356771 * safezoneW + safezoneX;
	y = 0.664936 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
//===========================UAV============================================
class MCC_UAVTittle: MCC_RscText
{
	idc = -1;

	text = "UAV:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.710047 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_UAVTypeTittle: MCC_RscText
{
	idc = -1;

	text = "UAV Type:"; //--- ToDo: Localize;
	x = 0.18501 * safezoneW + safezoneX;
	y = 0.752022 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0329871 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_UAVType: MCC_RscCombo
{
	idc = MCC_UAV_TYPE;

	x = 0.236458 * safezoneW + safezoneX;
	y = 0.752901 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0329871 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_UAVSpawn: MCC_RscButton
{
	idc = -1;

	text = "Spawn UAV"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.796884 * safezoneH + safezoneY;
	w = 0.0572917 * safezoneW;
	h = 0.0329871 * safezoneH;
	onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\general_scripts\uav\uavSpawn.sqf'");
	tooltip = "Click on the minimap to spawn a UAV "; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_m3f1: MCC_RscFrame
{
	idc = -1;

	x = 0.167708 * safezoneW + safezoneX;
	y = 0.0931586 * safezoneH + safezoneY;
	w = 0.183333 * safezoneW;
	h = 0.296884 * safezoneH;
};
class MCC_m3f2: MCC_RscFrame
{
	idc = -1;

	x = 0.167708 * safezoneW + safezoneX;
	y = 0.434026 * safezoneH + safezoneY;
	w = 0.183333 * safezoneW;
	h = 0.263897 * safezoneH;
};
class MCC_m3f3: MCC_RscFrame
{
	idc = -1;

	x = 0.167708 * safezoneW + safezoneX;
	y = 0.697923 * safezoneH + safezoneY;
	w = 0.183333 * safezoneW;
	h = 0.2135 * safezoneH;
};
class MCC_m3f4: MCC_RscFrame
{
	idc = -1;

	x = 0.351042 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
	w = 0.48125 * safezoneW;
	h = 0.0439828 * safezoneH;
};
class MCC_m3f5: MCC_RscFrame
{
	idc = -1;

	x = 0.351042 * safezoneW + safezoneX;
	y = 0.214111 * safezoneH + safezoneY;
	w = 0.48125 * safezoneW;
	h = 0.0989614 * safezoneH;
};
class MCC_m3f6: MCC_RscFrame
{
	idc = -1;

	x = 0.351042 * safezoneW + safezoneX;
	y = 0.313073 * safezoneH + safezoneY;
	w = 0.48125 * safezoneW;
	h = 0.120953 * safezoneH;
};
class MCC_m3f7: MCC_RscFrame
{
	idc = -1;

	x = 0.528646 * safezoneW + safezoneX;
	y = 0.434026 * safezoneH + safezoneY;
	w = 0.303646 * safezoneW;
	h = 0.0659743 * safezoneH;
};
class MCC_m3f8: MCC_RscFrame
{
	idc = -1;

	x = 0.351042 * safezoneW + safezoneX;
	y = 0.434026 * safezoneH + safezoneY;
	w = 0.177604 * safezoneW;
	h = 0.478 * safezoneH;
};
class MCC_m3f9: MCC_RscFrame
{
	idc = -1;

	x = 0.168549 * safezoneW + safezoneX;
	y = 0.0919812 * safezoneH + safezoneY;
	w = 0.6637 * safezoneW;
	h = 0.82 * safezoneH;
};
};
