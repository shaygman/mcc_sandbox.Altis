//============================================================MCC_fnc_curatorNightEffects========================================================================================
// Manage doors status
//===========================================================================================================================================================================
private ["_pos","_module","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;

_resualt = ["Lock/Unlock Doors",[
 						["Radius",500],
 						["Destroy Lights",["Lock All","Lock Random","Unlock All"]]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

private ["_radius"];
_radius = _resualt select 0;

[[_pos, _radius, (_resualt select 1)+10], "MCC_fnc_deleteBrush", false, false] call BIS_fnc_MP;

deleteVehicle _module;