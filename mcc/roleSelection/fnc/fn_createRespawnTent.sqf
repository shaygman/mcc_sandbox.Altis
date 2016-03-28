//==================================================================MCC_fnc_createRespawnTent===============================================================================================
/************************************************************
Author:	Shay_gman

Parameters: [_squad <group>,  _pos<Array>,_dir <Integer>,_type <str>]

_squad:			Group that will have access to the respawn tent
_pos: 			Position to spawn
_dir:			Direction of spawn
_type:			Type of respawn tent (done or A-shape)
************************************************************/
private ["_squad","_pos","_dir","_type","_rally","_trg","_time","_air","_delete","_pos"];

if (isServer) then {
	_player = param [0,objNull,[objNull,missionNamespace]];
	if (isNull _player) exitWith {};

	_squad 	= group _player;
	_dir    = direction _player;
	_pos    = param [1,[0,0,0],[[]]];
	_type   = if ((_this select 2) == "MCC_TentDome") then {"Land_TentDome_F"} else {"Land_TentA_F"};

	_rally = _type createVehicle _pos;
	_rally setDir _dir;
	_rally setPosATL _pos;

	_player setVariable ["MCC_rallyPoint",_rally,true];

	_rally setVariable ["type","Rally_Point",true];
	_rally setVariable ["MCC_rally_deployTime", time, true];
	_rally setVariable ["MCC_rally_squad", _squad, true];

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
	/*
	//Delete after 10 minutes
	_rally spawn {sleep 30; if (alive _this) then {deleteVehicle _this}};
	*/
};
