#define MCC_SANDBOX_IDD 1000
#define MCCZONENUMBER 1023
#define MCC_ZONE_LOC 1026

private ["_pos", "_size","_nul","_previusZone"];
disableSerialization;

_type = _this select 0;
_pos  = _this select 1;
_size = _this select 2;

if ((lbCurSel MCCZONENUMBER) == -1) exitWith {}; 
mcc_zone_number = (MCC_zones_numbers select (lbCurSel MCCZONENUMBER));
if (isNil "mcc_zone_number") exitWith {}; 

mcc_zone_markername=format ["%1", mcc_zone_number];

if (mcc_active_zone != mcc_zone_number) then	{		//We selected a new zone let's gray the last one
	_previusZone = format ["%1", mcc_active_zone];
	_previusZone setMarkerColorLocal "colorBlack";
	_previusZone setMarkerBrushLocal "Solid";
	_previusZone setMarkerAlpha 0.4; 
	MCC_zone_index = (lbCurSel MCCZONENUMBER);
	};
	
if (_type == 1) then {						//Updating zone? Set zone properties 
	mcc_zone_markposition = _pos; 
	mcc_zone_marker_X = _size select 0;
	mcc_zone_marker_Y = _size select 1;
	mcc_active_zone = mcc_zone_number;
	_nul=[1] execVM MCC_path +"mcc\general_scripts\mcc_make_the_marker.sqf";
};

if (_type == 0) then {						//Selecting zone
	mcc_zone_markername	setMarkerColorLocal "colorYellow";
	mcc_zone_markername setMarkerBrushLocal "Solid";
	mcc_zone_markername setMarkerAlpha 0.4;
	mcc_active_zone = mcc_zone_number;
	};