//==================================================================MCC_fnc_createRestrictedZones===============================================================================================
/************************************************************
Author:	Shay_gman

Parameters: [_markerName <string>,  _sides<Array>,_time <Integer>,_inside <boolean>,_air <boolean>,_delete<boolean>]

_logic:	if called by a function always leave objNull
_markerName: Marker Name or marker array.
_sides: array containg the sides that will be punished.
_time: time need to ellapsed before punishment
_inside: does the unit should be inside the zone or outside the zone inorder no to be punished
_air: Should air unis be punished
_delete: Should we delete the marker after placment if not then the trigger will move with the marker if the marker is moved
Create a restriction zone on a marker defined in mission sqf init.sqf

Example:[["west_spawn", [east],10,false,false,	false], "MCC_fnc_createRestrictedZones", false, false] spawn BIS_fnc_MP;

************************************************************/
private ["_logic","_markerName","_markerShape","_sides","_inside","_trg","_time","_air","_delete","_pos"];

_logic	= _this select 0;

//Did we got here by  a function call or by module
if (isNull _logic) then
{
	_markerName = _this select 1;
	_sides      = _this select 2;
	_time       = _this select 3;
	_inside     = _this select 4;
	_air        = _this select 5;
	_delete     = _this select 6;
}
else
{
	_markerName = call compile (_logic getvariable ["markerNames","[]"]);
	_sides = call compile (_logic getvariable ["sides","-1"]);
	_time = call compile (_logic getvariable ["time","10"]);
	_inside = if ((_logic getvariable ["inside","0"])== "0") then {false} else {true};
	_air 	= if ((_logic getvariable ["air","0"])== "0") then {false} else {true};
	_delete = if ((_logic getvariable ["delete","0"])== "0") then {false} else {true};
	
	_sides = if (_sides == -1) then {[east,west,resistance,civilian]} else {[_sides call bis_fnc_sideType]}; 
};

//Case we have multiple zones
if (typeName _markerName == "ARRAY") exitWith 
{
	{
		[objNull, _x, _sides ,_time ,_inside ,_air ,_delete] spawn MCC_fnc_createRestrictedZones;
	} foreach _markerName;
};

_markerShape = if ((markerShape _markerName) == "RECTANGLE") then {true} else {false};
_pos = markerPos _markerName;
_trg = createTrigger["EmptyDetector",_pos];
_trg setTriggerArea[(markerSize _markerName) select 0,(markerSize _markerName) select 1,markerDir _markerName,_markerShape];
_trg setTriggerActivation["ANY","PRESENT",true];

if (_inside) then
{
	_trg setTriggerStatements[format ["!(vehicle player in thislist) && (((player getVariable ['CP_side', playerside])) in %1)",_sides], format ["[thisTrigger,%1,%2,%3] spawn MCC_fnc_RestrictZoneEffect",_time,_inside,_air], ""];
}
else
{
	_trg setTriggerStatements[format ["(vehicle player in thislist) && (((player getVariable ['CP_side', playerside])) in %1)",_sides], format ["[thisTrigger,%1,%2,%3] spawn MCC_fnc_RestrictZoneEffect",_time,_inside,_air], ""];
};

if (_delete) then {_markerName setMarkerAlpha 0};

//Waituntil the marker has been moved
while {str _pos == str (markerPos _markerName)} do {sleep 10};
deleteVehicle _trg;

[[objNull, _markerName,_sides,_time,_inside,_air,_delete], "MCC_fnc_createRestrictedZones", true, false] spawn BIS_fnc_MP;

/*
{[[_x, [west,east],10,false,false, false], "MCC_fnc_createRestrictedZones", false, false] spawn BIS_fnc_MP;} foreach ["r1","r2","r3","r4"]
*/

