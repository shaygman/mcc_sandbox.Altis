/*==========================================================MCC_fnc_curatorGAIARespawn====================================================================================
// Sets a group or unit to respawns certain number of times
========================================================================================================================================================================*/
private ["_module","_resualt","_object","_respawns"];
_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

//did we get here from the 2d editor?
if (typeName (_module getVariable ["Respawns",true]) == typeName 0) exitWith {

	_respawns = _module getVariable ["respawns",1];

	{
		if (typeName _x == typeName grpNull) then {
			[_x,_respawns] spawn GAIA_fnc_respawnSet;
		} else {
			[group _x,_respawns] spawn GAIA_fnc_respawnSet;
		};
	} forEach (synchronizedObjects _module);
};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_object = missionNamespace getVariable ["MCC_curatorMouseOver",[]];

//if no object selected or not a vehicle
if (count _object <2) exitWith {systemchat "No vehicle selected"; deleteVehicle _module};
_object = _object select 1;



 _resualt = ["GAIA Respawns",[
 						["Number of Respawns",10]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

_respawns = (_resualt select 0);

if (typeName _object == typeName grpNull) then {
	[_object,_respawns] spawn GAIA_fnc_respawnSet;
} else {
	[group _object,_respawns] spawn GAIA_fnc_respawnSet;
};

deleteVehicle _module;