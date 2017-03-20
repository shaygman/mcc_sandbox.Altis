/*
Deploy respawn tents

*/
#define REQUIRE_MEMBERS 2
#define REQUIRE_DISTANCE 15

private ["_object","_caller","_index","_nearby","_pos","_safePos","_tentType","_obj"];

// Who activated the action?
_object 	= param [0,objNull,[objNull]];
_caller 	= param [1,objNull,[objNull]];
_index 		= _this select 2;

//How many players from my squads are near
_nearby = {alive _x && {_x in (units _caller)}} count (getPosATL _caller nearEntities ["CAManBase", REQUIRE_DISTANCE]);

if (_nearby < REQUIRE_MEMBERS) exitWith {
	_str = "<t size='0.8' t font = 'puristaLight' color='#FFFFFF'>" +format ["Need %1 more squad members within %2m",REQUIRE_MEMBERS-_nearby,REQUIRE_DISTANCE] + "</t>";
	_null = [_str,0,0.2,2,0.1,0.0] spawn bis_fnc_dynamictext;
};

_pos = ATLtoASL(_caller modelToWorld [0,3,0]);

while {!lineIntersects [_pos, [_pos select 0, _pos select 1, (_pos select 2) + 1]] && _pos select 2 > getTerrainHeightASL _pos} do {
	_pos set [2, (_pos select 2) - 0.1];
};

if (_pos select 2 < getTerrainHeightASL _pos) then {
	_pos set [2, getTerrainHeightASL _pos];
};

while {lineIntersects [_pos, [_pos select 0, _pos select 1, (_pos select 2) + 1]]} do {
	_pos set [2, (_pos select 2) + 0.01];
};

_obj = lineIntersectsObjs [_pos, getposASL player, player, player, true, 32];

if (lineIntersects [getPosASL player, _pos] || count _obj > 0) exitWith {
	_str = "<t size='0.8' t font = 'puristaLight' color='#FFFFFF'>" +"No suitable position found" + "</t>";
	_null = [_str,0,0.2,2,0.1,0.0] spawn bis_fnc_dynamictext;
};

_safePos = ASLtoATL _pos;

["Deploying",10] call MCC_fnc_interactProgress;
if !(isnil "_index") then {
	_tentType = secondaryWeapon player;
	player removeWeaponGlobal _tentType;
} else {
	_tentType = if (playerSide == west) then {"MCC_TentDome"} else {"Land_TentA_F"};
};

//Spawn the rally
private ["_dir","_type","_rally"];
_dir    = direction player;
_type   = if (_tentType == "MCC_TentDome") then {"Land_TentDome_F"} else {"Land_TentA_F"};

_rally = _type createVehicle _safePos;
_rally setDir _dir;
_rally setPosATL _safePos;

//Let the server handle the rally point
[[player, _rally], "MCC_fnc_createRespawnTent", false] call BIS_fnc_mp;