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

if (isServer) then
{
	_squad 	= _this select 0;
	_pos    = _this select 1;
	_dir    = _this select 2;
	_type   = if ((_this select 3) == "MCC_TentDome") then {"Land_TentDome_F"} else {"Land_TentA_F"};
	
	_rally = _type createVehicle _pos;
	_rally setDir _dir;
	_rally setPosATL _pos;
	
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
};
