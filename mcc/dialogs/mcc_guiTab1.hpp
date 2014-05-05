////////////////////////////////////////////////////////
// BY Shay Gman 03.2013
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

#define FACTIONCOMBO 1001
#define SPAWNTYPE 1002
#define SPAWNBRANCH 1003
#define SPAWNCLASS 1004
#define SPAWNBEHAVIOR 1005
#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007
#define MCCWEATHER 1008
#define MCCFOG 1009
#define TSMONTH 1010
#define TSDAY 1011
#define TSHOUR 1012
#define TSMINUTE 1013
#define MCCSTOPCAPTURE 1014
#define MCCSTARTWEST 1015
#define MCCSTARTEAST 1016
#define MCCSTARTGUAR 1017
#define MCCSTARTCIV 1018
#define MCCDISABLERESPAWN 1019
#define MCCMISSIONMAKERNAME 1020
#define MCCCLIENTFPS 1021
#define MCCSERVERFPS 1022
#define MCCZONENUMBER 1023
#define SPAWNEMPTY 1024
#define SPAWNAWARNESS 1025
#define MCC_ZONE_LOC 1026
#define MCCENABLECP 1027

class MCC_Sandbox {
	  idd = MCC_SANDBOX_IDD;
	  movingEnable = true;
	  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_gui_init1.sqf'");
	  
	  controlsBackground[] = 
	  {
	  MCC_pic,
	  MCC_background,
	  MCC_Title,
	  MCC_logo,
	  MCC_mapBckg,	  
	  MCC_m1f1,
	  MCC_m1f2,
	  MCC_m1f3,
	  MCC_m1f4,
	  MCC_m1f5,
	  MCC_m1f6,
	  MCC_m1f7,
	  MCC_m1f8,
	  MCC_m1f9,
	  MCC_m1f10
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
	  MCC_factioTittle,
	  MCC_factionCombo,
	  MCC_ghostMode,
	  MCC_spectator,
	  MCC_Teleport,
	  MCC_spawnType,
	  MCC_spawnBranch,
	  MCC_spawnClass,
	  MCC_spawnTypeTittle,
	  MCC_spawnBranchTittle,
	  MCC_spawnClassTittle,
	  MCC_spawnButton,
	  MCC_spawnEmptyTittle,
	  MCC_spawnAwareness,
	  MCC_spawnBehavior,
	  MCC_spawnBehaviorTittle,
	  MCC_viewDistanceTittle,
	  MCC_viewDistance,
	  MCC_grassDensityTittle,
	  MCC_FogTittle,
	  MCC_grassDensity,
	  MCC_WeatherTittle,
	  MCC_Weather,
	  MCC_Fog,
	  MCC_TSMonthTittle,
	  MCC_TSDayTittle,
	  MCC_TSHourTittle,
	  MCC_TSMinuteTittle,
	  MCC_TSMonth,
	  MCC_TSDay,
	  MCC_TSHour,
	  MCC_TSMinute,
	  MCC_TSSetButton,
	  MCC_TSSetWeatherButton,
	  MCC_stopCapture,
	  MCC_MissionSettings,
	  MCC_groupGenerator,
	  MCC_boxGenerator,
	  MCC_3DEditor,
	  MCC_StartWest,
	  MCC_StartEast,
	  MCC_StartGuar,
	  MCC_StartCiv,
	  MCC_StartDisableRespawn,
	  MCC_StartEnableCP,
	  MCC_FOBWest,
	  MCC_FOBEast,
	  MCC_FOBGuar,
	  MCC_StartLocationsTittle,
	  MCC_CSSettings,
	  MCC_EnvironmentTittle,
	  MCC_MissionMakerTittle,
	  MCC_MissionMakerName,
	  MCC_clientFPSTittle,
	  MCC_ServerFPSTittle,
	  MCC_clientFPS,
	  MCC_ServerFPS,
	  MCC_BenchmarkTittle,
	  MCC_zoneTittle,
	  MCC_zone,
	  MCC_zoneUpdate,
	  MCC_saveLoad,
	  MCC_login,
	  MCC_Close,
	  MCC_spawnEmpty,
	  MCC_spawnAwarenessTittle,
	  MCC_zoneLocTittle,
	  MCC_zoneLoc
	  
	   };

class MCC_logo: MCC_RscPicture	{idc = -1;text = __EVAL(MCCPATH +"mcc\pop_menu\mcc1.paa");x = 0.185546 * safezoneW + safezoneX;
	y = 0.159984 * safezoneH + safezoneY;
	w = 0.171476 * safezoneW;
	h = 0.22101 * safezoneH;
};
class MCC_Title: MCC_RscText	{idc = -1;text = __EVAL ("MCC Sandbox V"+MCCVersion+" By shay_gman, Spirit & Ollem");x = 0.185546 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.161476 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.52)";
};

class MCC_map: MCC_RscMapControl {idc = -1; moving = true; 	text = "";	
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
	x = 0.3625 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_factionCombo: MCC_RscCombo {idc = FACTIONCOMBO;
	x = 0.436979 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
	w = 0.144479 * safezoneW;
	h = 0.0340016 * safezoneH;
	onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");
};
class MCC_ghostMode: MCC_RscButton {idc = -1;text = "Ghost Mode"; 
	x = 0.597396 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Make the mission maker invisible to enemies"; 
	onButtonClick = "if (mcc_missionmaker == (name player)) then{if (captive player) then {player setcaptive false; [['Mission maker is no longer cheating'],'MCC_fnc_globalHint',true,false] call BIS_fnc_MP;} else {player setcaptive true; [['Mission maker is cheating'],'MCC_fnc_globalHint',true,false] spawn BIS_fnc_MP;}} else {player globalchat 'Access Denied'};";
};

class MCC_spectator: MCC_RscButton
{
	idc = -1;
	text = "Spectator"; 
	x = 0.671875 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
	tooltip = "Open spectator camera"; 
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
};

class MCC_Teleport: MCC_RscButton {idc = -1;text = "Teleport"; 
	x = 0.746354 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
	tooltip = "Teleport the mission maker and any vehicle he is in to a new location"; 
	onButtonClick = "if (mcc_missionmaker == (name player)) then {hint 'Click on the map';onMapSingleClick 'vehicle player setPos _pos;onMapSingleClick '''';true;'} else {player globalchat 'Access Denied'};";
};
class MCC_spawnType: MCC_RscCombo {idc = SPAWNTYPE;	
	x = 0.3625 * safezoneW + safezoneX;
	y = 0.258094 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0340016 * safezoneH;
	onLBSelChanged = __EVAL("[1] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");
};
class MCC_spawnBranch: MCC_RscCombo {idc = SPAWNBRANCH;
	x = 0.465625 * safezoneW + safezoneX;
	y = 0.258094 * safezoneH + safezoneY;
	w = 0.118982 * safezoneW;
	h = 0.0340016 * safezoneH;
	onLBSelChanged = __EVAL("[2] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");
};
class MCC_spawnClass: MCC_RscCombo {idc = SPAWNCLASS; 
	x = 0.603125 * safezoneW + safezoneX;
	y = 0.258094 * safezoneH + safezoneY;
	w = 0.212468 * safezoneW;
	h = 0.0340016 * safezoneH;
};
class MCC_spawnTypeTittle: MCC_RscText {idc = -1;text = "Type:"; 
	x = 0.3625 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnBranchTittle: MCC_RscText {idc = -1;text = "Branch:";
	x = 0.465625 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnClassTittle: MCC_RscText {idc = -1;text = "Class:"; 
	x = 0.603125 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnButton: MCC_RscButton {idc = -1;	text = "Spawn"; 
	x = 0.729167 * safezoneW + safezoneX;
	y = 0.313073 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	onButtonClick = __EVAL("[false] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group.sqf'");
	tooltip = "Spawn the selected unit/group inside the zone with the given behavior"; 
};
class MCC_spawnEmptyTittle: MCC_RscText {idc = -1;	text = "Empty:";
	x = 0.3625 * safezoneW + safezoneX;
	y = 0.302077 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnEmpty: MCC_RscCombo {idc = SPAWNEMPTY;	
	x = 0.3625 * safezoneW + safezoneX;
	y = 0.335064 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0340016 * safezoneH;
};
class MCC_spawnAwareness: MCC_RscCombo {idc = SPAWNAWARNESS;	
	x = 0.465625 * safezoneW + safezoneX;
	y = 0.335064 * safezoneH + safezoneY;
	w = 0.118982 * safezoneW;
	h = 0.0340016 * safezoneH;
};
class MCC_spawnAwarenessTittle: MCC_RscText {idc = -1; text = "Awareness:"; 
	x = 0.465625 * safezoneW + safezoneX;
	y = 0.302077 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnBehavior: MCC_RscCombo {idc = SPAWNBEHAVIOR;	
	x = 0.603125 * safezoneW + safezoneX;
	y = 0.335064 * safezoneH + safezoneY;
	w = 0.101985 * safezoneW;
	h = 0.0340016 * safezoneH;
};
class MCC_spawnBehaviorTittle: MCC_RscText {idc = -1; text = "Behavior:";
	x = 0.603125 * safezoneW + safezoneX;
	y = 0.302077 * safezoneH + safezoneY;
	w = 0.0764887 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_viewDistanceTittle: MCC_RscText {idc = -1; text = "View:"; 
	x = 0.185583 * safezoneW + safezoneX;
	y = 0.483067 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_grassDensityTittle: MCC_RscText {idc = -1; text = "Grass:"; 
	x = 0.185583 * safezoneW + safezoneX;
	y = 0.516933 * safezoneH + safezoneY;
	w = 0.0594912 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_viewDistance: MCC_RscCombo {idc = MCCVIEWDISTANCE; 
	x = 0.245052 * safezoneW + safezoneX;
	y = 0.494942 * safezoneH + safezoneY;
	w = 0.0802083 * safezoneW;
	h = 0.0219914 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onLBSelChanged =  __EVAL("[2] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
};
class MCC_grassDensity: MCC_RscCombo {idc = MCCGRASSDENSITY;
	x = 0.245052 * safezoneW + safezoneX;
	y = 0.529029 * safezoneH + safezoneY;
	w = 0.0802083 * safezoneW;
	h = 0.0219914 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onLBSelChanged =  __EVAL("[1] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
};
class MCC_WeatherTittle: MCC_RscText {idc = -1;	text = "Weather:"; 
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.631949 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_FogTittle: MCC_RscText {idc = -1;	text = "Fog:"; 
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.598961 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_Weather: MCC_RscCombo {idc = MCCWEATHER;	
	x = 0.253646 * safezoneW + safezoneX;
	y = 0.631949 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
};
class MCC_Fog: MCC_RscCombo {idc = MCCFOG;
	x = 0.253646 * safezoneW + safezoneX;
	y = 0.598961 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
};
class MCC_TSMonthTittle: MCC_RscText {idc = -1;	text = "Month:"; 
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.697923 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_TSDayTittle: MCC_RscText {idc = -1; text = "Day:"; 
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.73091 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_TSHourTittle: MCC_RscText {idc = -1; text = "Hour:"; 
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.763897 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_TSMinuteTittle: MCC_RscText {idc = -1; text = "Minute:";
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.796884 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_TSMonth: MCC_RscCombo {idc = TSMONTH;	
	x = 0.253646 * safezoneW + safezoneX;
	y = 0.697923 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_TSDay: MCC_RscCombo {idc = TSDAY;	
	x = 0.253646 * safezoneW + safezoneX;
	y = 0.73091 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_TSHour: MCC_RscCombo {idc = TSHOUR;
	x = 0.253646 * safezoneW + safezoneX;
	y = 0.763897 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_TSMinute: MCC_RscCombo {idc = TSMINUTE; 
	x = 0.253646 * safezoneW + safezoneX;
	y = 0.796884 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_TSSetButton: MCC_RscButton {idc = -1;	text = "Set Time"; 
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.819975 * safezoneH + safezoneY;
	w = 0.143229 * safezoneW;
	h = 0.0329871 * safezoneH;
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
};
class MCC_TSSetWeatherButton: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");

	text = "Set Weather"; //--- ToDo: Localize;
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.65394 * safezoneH + safezoneY;
	w = 0.144479 * safezoneW;
	h = 0.0340016 * safezoneH;
};
class MCC_stopCapture: MCC_RscButton {idc = MCCSTOPCAPTURE;	text = "Stop Capturing"; 
	x = 0.185583 * safezoneW + safezoneX;
	y = 0.39796 * safezoneH + safezoneY;
	w = 0.161477 * safezoneW;
	h = 0.0340016 * safezoneH;
	onButtonClick = "ctrlEnable [1014,false];MCC_capture_state=false;";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_MissionSettings: MCC_RscButton {idc = -1;	text = "Mission Settings";
	x = 0.36399 * safezoneW + safezoneX;
	y = 0.39796 * safezoneH + safezoneY;
	w = 0.101985 * safezoneW;
	h = 0.0340016 * safezoneH;
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'missionSettings';} else {player globalchat 'Access Denied'};";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_groupGenerator: MCC_RscButton {idc = -1;	text = "Group Generator"; 
	x = 0.474448 * safezoneW + safezoneX;
	y = 0.39796 * safezoneH + safezoneY;
	w = 0.101985 * safezoneW;
	h = 0.0340016 * safezoneH;
	tooltip = "Open Group Generator"; 
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'mcc_groupGen';} else {player globalchat 'Access Denied'};";
};
class MCC_boxGenerator: MCC_RscButton {idc = -1;	text = "Box Generator"; 
	x = 0.601979 * safezoneW + safezoneX;
	y = 0.39796 * safezoneH + safezoneY;
	w = 0.101985 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Open Box Generator"; 
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'boxGen';} else {player globalchat 'Access Denied'};";
};
class MCC_3DEditor: MCC_RscButton {idc = -1; text = "3D Editor"; 
	x = 0.712438 * safezoneW + safezoneX;
	y = 0.39796 * safezoneH + safezoneY;
	w = 0.101985 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Open 3D editor"; 
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
};
class MCC_StartWest: MCC_RscButton {idc = MCCSTARTWEST;	text = "West"; 	
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.489004 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,0,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set west start location"; 
	action = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartEast: MCC_RscButton {idc = MCCSTARTEAST;	text = "East"; 
	x = 0.442708 * safezoneW + safezoneX;
	y = 0.489004 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {1,0,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set east start location"; 
	action = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartGUAR: MCC_RscButton {idc = MCCSTARTGUAR; text = "Independent"; 
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.532987 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,1,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set GUAR start location"; 
	action = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartCiv: MCC_RscButton {idc = MCCSTARTCIV; text = "Civ";
	x = 0.442708 * safezoneW + safezoneX;
	y = 0.532987 * safezoneH + safezoneY;
	w = 0.0630208 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set civilians start location"; 
	action = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartDisableRespawn: MCC_RscButton {idc = MCCDISABLERESPAWN; text = "Disable Respawn"; 
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Disable respawn to all players"; 
	action = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartEnableCP: MCC_RscButton
{
	idc = MCCENABLECP;
	action = __EVAL("[6] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
	text = "Role Selection"; //--- ToDo: Localize;
	x = 0.43125 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.0744792 * safezoneW;
	h = 0.0329871 * safezoneH;
	tooltip = "If pressed before a start position to the given side has been set it will open a role selection menu to all players"; 
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_StartLocationsTittle: MCC_RscText {idc = -1; text = "Start Locations:"; 
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.101985 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_CSSettings: MCC_RscText {idc = -1; text = "Client Side Settings:"; 
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.127481 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_EnvironmentTittle: MCC_RscText {idc = -1;	text = "Environment Settings:"; 
	x = 0.184896 * safezoneW + safezoneX;
	y = 0.565974 * safezoneH + safezoneY;
	w = 0.126042 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_MissionMakerTittle: MCC_RscText {idc = -1; text = "Mission Maker"; 
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.73091 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_MissionMakerName: MCC_RscText {idc = MCCMISSIONMAKERNAME;	
	x = 0.442708 * safezoneW + safezoneX;
	y = 0.73091 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_clientFPSTittle: MCC_RscText {idc = -1;	text = "Client FPS:"; 
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.774893 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_ServerFPSTittle: MCC_RscText {idc = -1;	text = "Server FPS:";
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.818876 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_clientFPS: MCC_RscText {idc = MCCCLIENTFPS; 
	x = 0.442708 * safezoneW + safezoneX;
	y = 0.774893 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_ServerFPS: MCC_RscText {idc = MCCSERVERFPS;
	x = 0.442708 * safezoneW + safezoneX;
	y = 0.818876 * safezoneH + safezoneY;
	w = 0.06799 * safezoneW;
	h = 0.0340016 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_BenchmarkTittle: MCC_RscText {idc = -1; text = "Benchmark Tools:"; 
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.686927 * safezoneH + safezoneY;
	w = 0.101985 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_zoneTittle: MCC_RscText {idc = -1;	text = "Zone:";
	x = 0.528646 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0572917 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_zone: MCC_RscCombo {idc = MCCZONENUMBER;	
	x = 0.603125 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onLBSelChanged = __EVAL("[0,0,0] execVM '"+MCCPATH+"mcc\pop_menu\zones.sqf'");
};
class MCC_zoneLocTittle: MCC_RscText {idc = -1;	text = "Location:"; 
	x = 0.528646 * safezoneW + safezoneX;
	y = 0.478009 * safezoneH + safezoneY;
	w = 0.0572917 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_zoneLoc: MCC_RscCombo {idc = MCC_ZONE_LOC;	
	x = 0.603125 * safezoneW + safezoneX;
	y = 0.478009 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_zoneUpdate: MCC_RscButton {idc = -1;	text = "Update Zone"; 
	x = 0.717708 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0329871 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
	tooltip = "Click and drag on the minimap to make a zone"; 
	onButtonClick = "if (mcc_missionmaker == (name player)) then {MCC_zone_drawing= true;} else {player globalchat 'Access Denied'};";
};

class MCC_saveLoad: MCC_RscButtonMenu {idc = -1; text = "Save/Load"; x = 0.185546 * safezoneW + safezoneX;
	y = 0.857016 * safezoneH + safezoneY;
	w = 0.110484 * safezoneW;
	h = 0.0510023 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'MCC_SaveLoadScreen';} else {player globalchat 'Access Denied'};";
};
class MCC_login: MCC_RscButtonMenu {idc = -1; text = "Login/Logout"; x = 0.304529 * safezoneW + safezoneX;
	y = 0.857016 * safezoneH + safezoneY;
	w = 0.127481 * safezoneW;
	h = 0.0510023 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Login or logout as the mission maker"; 
	onButtonClick = __EVAL("nul=[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_login.sqf'");
};
class MCC_Close: MCC_RscButtonMenu {idc = -1; text = "Close"; x = 0.440509 * safezoneW + safezoneX;
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
//---------------------FOB------------------------------------------------
class MCC_FOBWest: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[7] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");

	text = "FOB"; //--- ToDo: Localize;
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.620953 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,0,1,1};
	tooltip = "Set west FOB (will work only if Role Selection is on)"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_FOBEast: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[8] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");

	text = "FOB"; //--- ToDo: Localize;
	x = 0.404762 * safezoneW + safezoneX;
	y = 0.620953 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {1,0,0,1};
	tooltip = "Set east FOB (will work only if Role Selection is on)"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_FOBGuar: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[9] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");

	text = "FOB"; //--- ToDo: Localize;
	x = 0.459896 * safezoneW + safezoneX;
	y = 0.620953 * safezoneH + safezoneY;
	w = 0.0458333 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorText[] = {0,1,0,1};
	tooltip = "Set resistance FOB (will work only if Role Selection is on)"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
//---------------------FRAMES---------------------------------------------
class MCC_m1f1: MCC_RscFrame
{
	idc = -1;
	x = 0.168549 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.159576 * safezoneW;
	h = 0.120953 * safezoneH;
};
class MCC_m1f2: MCC_RscFrame
{
	idc = -1;
	x = 0.168549 * safezoneW + safezoneX;
	y = 0.565974 * safezoneH + safezoneY;
	w = 0.159576 * safezoneW;
	h = 0.120953 * safezoneH;
};
class MCC_m1f3: MCC_RscFrame
{
	idc = -1;
	x = 0.168549 * safezoneW + safezoneX;
	y = 0.686927 * safezoneH + safezoneY;
	w = 0.159576 * safezoneW;
	h = 0.164936 * safezoneH;
};
class MCC_m1f4: MCC_RscFrame
{
	idc = -1;

	x = 0.328125 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.194792 * safezoneW;
	h = 0.241906 * safezoneH;
};
class MCC_m1f5: MCC_RscFrame
{
	idc = -1;

	x = 0.328125 * safezoneW + safezoneX;
	y = 0.686927 * safezoneH + safezoneY;
	w = 0.194792 * safezoneW;
	h = 0.164936 * safezoneH;
};

class MCC_m1f6: MCC_RscFrame
{
	idc = -1;

	x = 0.522917 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.309375 * safezoneW;
	h = 0.0549786 * safezoneH;
};
class MCC_m1f7: MCC_RscFrame
{
	idc = -1;

	x = 0.356771 * safezoneW + safezoneX;
	y = 0.379047 * safezoneH + safezoneY;
	w = 0.475521 * safezoneW;
	h = 0.0659743 * safezoneH;
};
class MCC_m1f8: MCC_RscFrame
{
	idc = -1;

	x = 0.356771 * safezoneW + safezoneX;
	y = 0.214111 * safezoneH + safezoneY;
	w = 0.475521 * safezoneW;
	h = 0.164936 * safezoneH;
};
class MCC_m1f9: MCC_RscFrame
{
	idc = -1;

	x = 0.356771 * safezoneW + safezoneX;
	y = 0.170129 * safezoneH + safezoneY;
	w = 0.475521 * safezoneW;
	h = 0.0439828 * safezoneH;
};
class MCC_m1f10: MCC_RscFrame
{
	idc = -1;

	x = 0.168549 * safezoneW + safezoneX;
	y = 0.0919812 * safezoneH + safezoneY;
	w = 0.6637 * safezoneW;
	h = 0.82 * safezoneH;
};

};