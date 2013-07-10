private ["_mccdialog","_comboBox","_displayname","_pic", "_index", "_array", "_class"];
// By: Shay_gman
// Version: 1.1 (April 2012)
#define groupGen_IDD 2994

#define MCC_FACTION 8008
#define UNIT_TYPE 3010

#define MCC_GroupGenCurrentGroup_IDD 9003
#define MCC_GroupGenWPType_IDD 9004
#define MCC_GroupGenWPConbatMode_IDD 9005
#define MCC_GroupGenWPFormation_IDD 9006
#define MCC_GroupGenWPSpeed_IDD 9007
#define MCC_GroupGenWPBehavior_IDD 9008
#define MCC_GroupGenWPcondition_IDD 9009
#define MCC_GroupGenGroups_IDD 9010
#define MCC_WPTimeout_IDD 9011
#define MCC_GroupGenWPStatment_IDD 9012

disableSerialization;
_mccdialog = findDisplay groupGen_IDD;
MCC_groupGenCurrenGroupArray = []; 		//Reset the current group
_comboBox = _mccdialog displayCtrl MCC_FACTION; //fill combobox CFG factions
lbClear _comboBox;
	{
		_displayname = format ["%1(%2)",_x select 0,_x select 1];
		_comboBox lbAdd _displayname;
	} foreach U_FACTIONS;
_comboBox lbSetCurSel MCC_faction_index;

_comboBox = _mccdialog displayCtrl UNIT_TYPE;		//fill combobox CFG unit
lbClear _comboBox;
{
	_displayname =  _x;
	_index = _comboBox lbAdd _displayname;
} foreach ["Infantry", "Vehicles", "Tracked", "Motorcycle", "Helicopter", "Fixed-wing", "Ship"];
_comboBox lbSetCurSel MCC_class_index;

_comboBox = _mccdialog displayCtrl MCC_GroupGenWPType_IDD;		//WP Type
lbClear _comboBox;
{
	_displayname =  _x;
	_index = _comboBox lbAdd _displayname;
} foreach ["MOVE", "DESTROY", "GETIN", "SAD", "JOIN", "LEADER", "GETOUT", "CYCLE", "LOAD", "UNLOAD", "TR UNLOAD", "HOLD", "SENTRY"
		   ,"GUARD","TALK","SCRIPTED","SUPPORT","GETIN NEAREST","DISMISS","AND","OR"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_GroupGenWPConbatMode_IDD;		//WP Combat Mode
lbClear _comboBox;
{
	_displayname =  _x;
	_index = _comboBox lbAdd _displayname;
} foreach ["NO CHANGE", "BLUE", "GREEN", "WHITE", "YELLOW", "RED"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_GroupGenWPFormation_IDD;		//WP Formation
lbClear _comboBox;
{
	_displayname =  _x;
	_index = _comboBox lbAdd _displayname;
} foreach ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_GroupGenWPSpeed_IDD;		//WP Speed
lbClear _comboBox;
{
	_displayname =  _x;
	_index = _comboBox lbAdd _displayname;
} foreach ["UNCHANGED", "LIMITED", "NORMAL", "FULL"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_GroupGenWPBehavior_IDD;		//WP Behavior
lbClear _comboBox;
{
	_displayname =  _x;
	_index = _comboBox lbAdd _displayname;
} foreach ["UNCHANGED", "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_WPTimeout_IDD;		//WP Timeout
lbClear _comboBox;
{
	_displayname =  format ["%1",_x];
	_index = _comboBox lbAdd _displayname;
} foreach [0,5,10,15,20,30,60,90,120,180,240,300,360,420,480,540,600,660,720,780,840,900,960,1020,1080,1140,1200];
_comboBox lbSetCurSel 0;

//-------------------------------Group managment--------------------------------------------------------------------------------------------------------------
MCC_groupGenGroupArray = [];
_comboBox = _mccdialog displayCtrl MCC_GroupGenGroups_IDD;
lbClear _comboBox;

if (MCC_groupGenGroupStatus == 0) then 	//West
	{	
		{
		if ((side (leader _x) == west) && !(isPlayer leader _x)) then	
			{
				_unitsCount = [_x] call MCC_COUNT_GROUP;
				_displayname =  format ["%1 Inf:%2 Cars:%3 Tanks:%4 Air:%5 Ships:%6", _x, _unitsCount select 0, _unitsCount select 1, _unitsCount select 2, _unitsCount select 3, _unitsCount select 4];
				_comboBox lbAdd _displayname;
				MCC_groupGenGroupArray = MCC_groupGenGroupArray + [_x];
			};
		} forEach  allgroups;
	};
	
if (MCC_groupGenGroupStatus == 1) then 	//East
	{	
		{
		if ((side (leader _x) == east) && !(isPlayer leader _x)) then	
			{
				_unitsCount = [_x] call MCC_COUNT_GROUP;
				_displayname =  format ["%1 Inf:%2 Cars:%3 Tanks:%4 Air:%5 Ships:%6", _x, _unitsCount select 0, _unitsCount select 1, _unitsCount select 2, _unitsCount select 3, _unitsCount select 4];
				_comboBox lbAdd _displayname;
				MCC_groupGenGroupArray = MCC_groupGenGroupArray + [_x];
			};
		} forEach  allgroups;
	};
	
if (MCC_groupGenGroupStatus == 2) then 	//Guer 
	{	
		{
		if ((side (leader _x) == resistance) && !(isPlayer leader _x)) then	
			{
				_unitsCount = [_x] call MCC_COUNT_GROUP;
				_displayname =  format ["%1 Inf:%2 Cars:%3 Tanks:%4 Air:%5 Ships:%6", _x, _unitsCount select 0, _unitsCount select 1, _unitsCount select 2, _unitsCount select 3, _unitsCount select 4];
				_comboBox lbAdd _displayname;
				MCC_groupGenGroupArray = MCC_groupGenGroupArray + [_x];
			};
		} forEach  allgroups;
	};
	
if (MCC_groupGenGroupStatus == 3) then 	//Civ 
	{	
		{
		if ((side (leader _x) == civilian) && !(isPlayer leader _x)) then	
			{
				_unitsCount = [_x] call MCC_COUNT_GROUP;
				_displayname =  format ["%1 Inf:%2 Cars:%3 Tanks:%4 Air:%5 Ships:%6", _x, _unitsCount select 0, _unitsCount select 1, _unitsCount select 2, _unitsCount select 3, _unitsCount select 4];
				_comboBox lbAdd _displayname;
				MCC_groupGenGroupArray = MCC_groupGenGroupArray + [_x];
			};
		} forEach  allgroups;
	};
_comboBox lbSetCurSel MCC_groupGenGroupselectedIndex;


