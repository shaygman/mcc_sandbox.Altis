//==================================================================MCC_fnc_createRestrictedZones===============================================================================================
/************************************************************
Author:	Shay_gman

Parameters: [_markerName <string>,  _sides<Array>,_time <Integer>,_inside <boolean>,_air <boolean>,_delete<boolean>]

_markerName: Marker Name.
_sides: array containg the sides that will be punished.
_time: time need to ellapsed before punishment
_inside: does the unit should be inside the zone or outside the zone inorder no to be punished
_air: Should air unis be punished
_delete: Should we delete the marker after placment if not then the trigger will move with the marker if the marker is moved
Create a restriction zone on a marker defined in mission sqf init.sqf

Example:[["west_spawn", [east],10,false,false,	false], "MCC_fnc_createRestrictedZones", false, false] spawn BIS_fnc_MP;

************************************************************/
private ["_markerName","_markerShape","_sides","_inside","_trg","_time","_air","_delete","_pos"];

_markerName = _this select 0;
_sides      = _this select 1;
_time       = _this select 2;
_inside     = _this select 3;
_air        = _this select 4;
_delete     = _this select 5;

_markerShape = if ((markerShape _markerName) == "RECTANGLE") then {true} else {false};
_pos = markerPos _markerName;
_trg = createTrigger["EmptyDetector",_pos];
_trg setTriggerArea[(markerSize _markerName) select 0,(markerSize _markerName) select 1,markerDir _markerName,_markerShape];
_trg setTriggerActivation["ANY","PRESENT",true];
_trg setTriggerStatements[format ["(vehicle player in thislist) && (((player getVariable ['CP_side', playerside])) in %1)",_sides], format ["[thisTrigger,%1,%2,%3] spawn MCC_fnc_RestrictZoneEffect",_time,_inside,_air], ""];

if (_delete) exitWith {_markerName setMarkerAlphaLocal 0};

while {str _pos == str (markerPos _markerName)} do {sleep 10};
deleteVehicle _trg;

[[_markerName,_sides,_time,_inside,_air,_delete], "MCC_fnc_createRestrictedZones", false, false] spawn BIS_fnc_MP;

/*
{[[_x, [west,east],10,false,false, false], "MCC_fnc_createRestrictedZones", false, false] spawn BIS_fnc_MP;} foreach ["r1","r2","r3","r4"]
*/

