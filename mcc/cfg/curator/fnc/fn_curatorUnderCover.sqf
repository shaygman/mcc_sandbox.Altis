//============================================================MCC_fnc_curatorUnderCover========================================================================================
// Sets units as undercover agents
//===========================================================================================================================================================================
private ["_object","_module","_resualt","_removeGear","_synced"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

//did we get here from the 2d editor?
if (typeName (_module getVariable ["removeGear",true]) == typeName 0) exitWith {

	_removeGear = (_module getVariable ["removeGear",0]) == 1;

	//Who synced with the module
	_synced = synchronizedobjects _module;

	if (player in _synced)then {
		[player,_removeGear] call MCC_fnc_undercoverInit;
	};
};

_object = missionNamespace getVariable ["MCC_curatorMouseOver",[]];

//if no object selected or not a vehicle
if (count _object <2) exitWith {systemchat "No vehicle selected"; deleteVehicle _module};
_object = _object select 1;

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_resualt = ["Undercover Agents",[
 						["Remove Weapons",true]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};
_removeGear = _resualt select 0;

[[_object,_removeGear], "MCC_fnc_undercoverInit", _object, false] call BIS_fnc_MP;

deleteVehicle _module;