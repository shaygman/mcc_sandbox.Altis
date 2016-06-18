//==================================================================MCC_fnc_createRespawnTent===============================================================================================
/************************************************************
Author:	Shay_gman

Parameters: [_player <Unit>,  _rally<Object>]

_player:			unit and the Group that will have access to the respawn tent
_rally: 			object serve as the rally point
************************************************************/
private ["_squad","_rally","_player"];

if (isServer) then {
	_player = param [0,objNull,[objNull,missionNamespace]];
	_rally = param [1,objNull,[objNull,missionNamespace]];

	if (isNull _player || isNull _rally) exitWith {};

	_squad 	= group _player;
	_player setVariable ["MCC_rallyPoint",_rally,true];

	_rally setVariable ["type","Rally_Point",true];
	_rally setVariable ["MCC_rally_deployTime", time, true];
	_rally setVariable ["MCC_rally_squad",_squad, true];
	_rally setVariable ["teleportAtStart",2, true];

	_rally addEventHandler [
		"killed",
		{deleteVehicle (_this select 0)}
	];

	_rally addEventHandler [
		"hit",
		{
			if (damage (_this select 0) > 0.3) then
			{
				deleteVehicle (_this select 0);
			};
		}
	];

	[_squad, _rally] call BIS_fnc_addRespawnPosition;
};
