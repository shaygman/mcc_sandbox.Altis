//============================================================MCC_fnc_curatorSetEvac=============================================================================================
//Mark Vehicle as Evac Vehicle
//===========================================================================================================================================================================
private ["_pos","_module","_object","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;
_object = missionNamespace getVariable ["MCC_curatorMouseOver",[]];

//if no object selected or not a vehicle
if (count _object <2) exitWith {systemchat "No vehicle selected"; deleteVehicle _module};
_object = _object select 1;

//if no empty positions
if (_object emptyPositions "cargo" <=0 || isplayer driver _object) exitWith {deleteVehicle _module};

//if already an evac
if (count (_object getVariable ["MCC_evacStartPos", []]) > 0) exitWith {deleteVehicle _module};

_resualt = ["Add the vehicle as MCC evac vehicle",[
 						["Side",["East","West","Resistance"]],
 						["Add gunners",true]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

[[_object, (_resualt select 0) call BIS_fnc_sideType, (_resualt select 1)], "MCC_fnc_setEvac", false, false] call BIS_fnc_MP;


deleteVehicle _module;