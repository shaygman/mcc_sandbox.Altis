//============================================================MCC_fnc_curatorAtmoshphere========================================================================================
// Manage atmosphere
//===========================================================================================================================================================================
private ["_pos","_module","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;

_resualt = ["Add Atmosphere",[
 						["Atmosphere",["Sandstorm","Blizzard","Heat Wave","Clear All"]]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

[[_pos, 0, (_resualt select 0)+14], "MCC_fnc_deleteBrush", false, false] call BIS_fnc_MP;

deleteVehicle _module;