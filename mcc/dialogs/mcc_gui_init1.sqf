#define MCC_SANDBOX_IDD 1000

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
#define SPAWNTASK 1025
#define MCC_ZONE_LOC 1026
#define MCCENABLECP 1027

private ["_mccdialog","_comboBox","_displayname","_it","_x","_index"];
disableSerialization;
MCC_GUI1initDone = false; 
 
ctrlEnable [MAIN,false]; //Disable switching menus till the init is done
ctrlEnable [MENU2,false];
ctrlEnable [MENU3,false];
ctrlEnable [MENU4,false];
ctrlEnable [MENU5,false];

if (CP_activated) then {ctrlenable [MCCENABLECP,false]};

_mccdialog = findDisplay MCC_SANDBOX_IDD;

if (!MCC_enable_respawn) then { ctrlEnable [MCCDISABLERESPAWN,false];};
if (!MCC_capture_state) then { ctrlEnable [MCCSTOPCAPTURE,false];};

MCC_months_index = (date select 1) - 1;
MCC_day_index = (date select 2) - 1;
MCC_hours_index = (date select 3);
MCC_minutes_index = (date select 4);

_comboBox = _mccdialog displayCtrl MCCZONENUMBER; //fill combobox zone's numbers
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach MCC_zones_numbers;
	_comboBox lbSetCurSel MCC_zone_index;

_comboBox = _mccdialog displayCtrl MCC_ZONE_LOC;		//fill zone locations
	lbClear _comboBox;
	{
		_displayname = _x select 0;
		_comboBox lbAdd _displayname;
	} foreach MCC_ZoneLocation;
	_comboBox lbSetCurSel mcc_hc;	//MCC_ZoneLocation_index;	

_comboBox = _mccdialog displayCtrl FACTIONCOMBO;		//fill combobox CFG factions
	lbClear _comboBox;
	{
		_displayname = format ["%1(%2)",_x select 0,_x select 1];
		_comboBox lbAdd _displayname;
	} foreach U_FACTIONS;
	_comboBox lbSetCurSel MCC_faction_index;
//--------------------------------------Mission settings--------------------------------------------------------------------------

_comboBox = _mccdialog displayCtrl TSMONTH;		//fill combobox MONTH
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_months_array;
_comboBox lbSetCurSel MCC_months_index;

_comboBox = _mccdialog displayCtrl TSDAY;			//fill combobox Days
lbClear _comboBox;
{
	_displayname = format ["%1",_x];
	_comboBox lbAdd _displayname;
} foreach MCC_days_array;
_comboBox lbSetCurSel MCC_day_index;

_comboBox = _mccdialog displayCtrl TSHOUR;		//fill combobox HOUR
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_hours_array;
_comboBox lbSetCurSel MCC_hours_index;

_comboBox = _mccdialog displayCtrl TSMINUTE;			//fill combobox Minutes
lbClear _comboBox;
{
	_displayname = format ["%1",_x];
	_comboBox lbAdd _displayname;
} foreach MCC_minutes_array;
_comboBox lbSetCurSel MCC_minutes_index;

_comboBox = _mccdialog displayCtrl MCCWEATHER;		//fill combobox WEATHER
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_weather_array;
_comboBox lbSetCurSel MCC_weather_index;

_comboBox = _mccdialog displayCtrl MCCFOG;		//fill combobox FOG
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_fog_array;
_comboBox lbSetCurSel MCC_fog_index;
//----------------------------------------------------------Client Side settings----------------------------------------------------------------------------

_comboBox = _mccdialog displayCtrl MCCGRASSDENSITY;		//fill combobox Grass
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_grass_array;
_comboBox lbSetCurSel MCC_grass_index;

_comboBox = _mccdialog displayCtrl MCCVIEWDISTANCE;		//fill combobox View distance
lbClear _comboBox;
{
	_displayname = format ["%1",_x];
	_comboBox lbAdd _displayname;
} foreach MCC_view_array;
_comboBox lbSetCurSel ((round ((viewdistance)/1000)) - 1); // set viewdistance index to current vd
//-----------------------------------------------------------------------------Spawn-----------------------------------------------------------------

_comboBox = _mccdialog displayCtrl SPAWNTYPE;		//fill combobox CFG group
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Singles", "Groups"];
_comboBox lbSetCurSel MCC_type_index;

if ((lbCurSel SPAWNTYPE) == 1) then {
	_comboBox = _mccdialog displayCtrl SPAWNBRANCH;		//Groups
		lbClear _comboBox;
		{
			_displayname = _x select 1;
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_groupTypes;
		_comboBox lbSetCurSel 0;
	} else {											//Singles
			_comboBox = _mccdialog displayCtrl SPAWNBRANCH;		//fill combobox CFG unit
			lbClear _comboBox;
			{
				_displayname =  _x;
				_index = _comboBox lbAdd _displayname;
			} foreach ["Infantry", "Vehicles", "Tracked/Static", "Motorcycle", "Helicopter", "Fixed-wing", "Ship", "D.O.C", "Ammo","Objects (Fortifications)", "Objects (Dead Bodies)", "Objects (Furniture)", 
			"Objects (Market)", "Objects (Construction)", "Objects (Signs)", "Objects (Flags)", "Objects (Military)","Objects (Small)", "Objects (Wrecks)", "Objects (Submerged)", "Objects (Tents)","Objects (Garbage)",
			"Objects (Lamps)","Objects (Container)","Objects (Structures)","Objects (Helpers)","Objects (Training)","Animals"];
			_comboBox lbSetCurSel 0; //MCC_class_index;	
			};
	
//----------------------------------------------------------------Spawn Settings-----------------------------------------------------------------------------------
_comboBox = _mccdialog displayCtrl SPAWNEMPTY;		//fill combobox Empty on/off
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_spawn_empty;
_comboBox lbSetCurSel MCC_empty_index;

_comboBox = _mccdialog displayCtrl SPAWNBEHAVIOR;		//fill combobox BEHAVIOR
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_index = _comboBox lbAdd _displayname;
	lbSetTooltip [SPAWNBEHAVIOR, _index, _x select 2];
} foreach MCC_spawn_behavior;
_comboBox lbSetCurSel MCC_behavior_index;

_comboBox = _mccdialog displayCtrl SPAWNTASK;		//fill combobox AWERNESS
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_spawn_awereness;
_comboBox lbSetCurSel MCC_awereness_index;

//-------------------------------------------------

sleep 0.3; // to allow server to notice mcc_missionmaker logging in..

ctrlSetText [MCCMISSIONMAKERNAME, format["%1",mcc_missionmaker]];

if (mcc_missionmaker == (name player)) then
 { 
	ctrlEnable [MAIN,false]; //Enable switching menus 
	ctrlEnable [MENU2,true];
	ctrlEnable [MENU3,true];
	ctrlEnable [MENU4,true];
	ctrlEnable [MENU5,true];
 };
 
if (MCCFirstOpenUI) then //First Lunch
	{
	MCCFirstOpenUI = false; 
	closeDialog 0;
	[0] execVM "mcc\dialogs\mcc_PopupMenu2.sqf"
	};

MCC_GUI1initDone = true; 
//-------------------------------------------------FPS Loop  -----------------------------
while {dialog} do 
{
	MCC_clientFPS  = round(diag_fps);
	ctrlSetText [MCCCLIENTFPS, format["%1",MCC_clientFPS]];
	
	if (isnil "mcc_fps_running") then {mcc_fps_running = false}; 
	if !(mcc_fps_running) then 
	{
		[[1],"MCC_fnc_FPS",true,false] spawn BIS_fnc_MP;
		sleep 0.5;
	};
		
	if !( MCC_isHC ) then 
	{		
		ctrlSetText [MCCSERVERFPS, format["%1",MCC_serverFPS]];
	}
	else 
	{
		ctrlSetText [MCCSERVERFPS, format[" %1 - HC FPS: %2", MCC_serverFPS, MCC_hcFPS]];
	};
	sleep 1;
};
//------------------------------------------------------------------------------------------
