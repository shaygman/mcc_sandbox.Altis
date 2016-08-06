#define MCCZONENUMBER 1023

private ["_pos", "_size","_nul","_previusZone","_comboBox","_displayname"];
disableSerialization;

_type = _this select 0;
_pos  = _this select 1;
_size = _this select 2;

//Creating a zone
if (_type == 1) exitWith
{
	mcc_zone_number = (count (missionNamespace getVariable ["MCC_zones_numbers",[]])) + 1;
	MCC_zones_numbers = (missionNamespace getVariable ["MCC_zones_numbers",[]]);
	MCC_zones_numbers set [count MCC_zones_numbers, mcc_zone_number];
	mcc_zone_markposition = _pos;
	mcc_zone_marker_X = _size select 0;
	mcc_zone_marker_Y = _size select 1;
	MCC_zone_index = mcc_zone_number-1;

	//------------------------------------------- Update ZONES --------------------------------------------------------------------------------------------------
	_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 1023); //fill combobox zone's numbers
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach (missionNamespace getVariable ["MCC_zones_numbers",[]]);
	_comboBox lbSetCurSel MCC_zone_index;

	waituntil {mcc_active_zone == mcc_zone_number};
	_nul=[1] execVM MCC_path +"mcc\general_scripts\mcc_make_the_marker.sqf";
};

//Updating a zone
if (_type == 2) then
{
	mcc_zone_markposition = _pos;
	mcc_zone_marker_X = _size select 0;
	mcc_zone_marker_Y = _size select 1;
	mcc_active_zone = mcc_zone_number;
	_nul=[1] execVM MCC_path +"mcc\general_scripts\mcc_make_the_marker.sqf";
};

if ((lbCurSel MCCZONENUMBER) == -1) exitWith {};
mcc_zone_number = ((missionNamespace getVariable ["MCC_zones_numbers",[]]) select (lbCurSel MCCZONENUMBER));
if (isNil "mcc_zone_number") exitWith {};

mcc_zone_markername=format ["%1", mcc_zone_number];

//We selected a new zone let's gray the last one
if (mcc_active_zone != mcc_zone_number) then
{
	_previusZone = format ["%1", mcc_active_zone];
	_previusZone setMarkerColorLocal "colorBlack";
	_previusZone setMarkerBrushLocal "Solid";
	_previusZone setMarkerAlphalocal 0.2;
	MCC_zone_index = (lbCurSel MCCZONENUMBER);
};


//Selecting zone
if (_type == 0) then
{
	mcc_zone_markername	setMarkerColorLocal "colorYellow";
	mcc_zone_markername setMarkerBrushLocal "Solid";
	mcc_zone_markername setMarkerAlphalocal 0.2;
	mcc_active_zone = mcc_zone_number;
};


