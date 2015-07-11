//============================================================MCC_fnc_curatorSetArmedCivilian====================================================================================
// Make unit armed civilian
//===========================================================================================================================================================================
private ["_pos","_module","_object","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;
_object = missionNamespace getVariable ["MCC_curatorMouseOver",[]];

//if no object selected or not a vehicle
if (count _object <2) exitWith {systemchat "No unit selected"; deleteVehicle _module};
_object = _object select 1;

//if nis player
if (isPlayer _object || !(_object isKindOf "Man")) exitWith {deleteVehicle _module};

//if already an armed civilian
if ((_object getVariable ["MCC_IEDtype",""])=="ac") exitWith {deleteVehicle _module};

private ["_iedside","_static"];

//Suicide Bomber

_resualt = ["Make unit act as Suicide Bomber",[
 						["Attack Side",["East","West","Resistance"]],
 						["Patrol",false]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};
_object setVariable ["MCC_IEDtype","ac",true];

_iedside = (_resualt select 0) call BIS_fnc_sideType;
_static = !(_resualt select 1);
_object setVariable ["static",_static,true];
[[_object, _iedside, 25], "MCC_fnc_manageAC", _object, false] spawn BIS_fnc_MP;

deleteVehicle _module;