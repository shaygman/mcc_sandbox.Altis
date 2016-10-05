/*==================================================================MCC_fnc_loadPlayer===============================================================================================
	Load persistent data about the player from the server  - must run on the client only like in init.sqf

	EXAMPLE
		[true,true,true] spawn MCC_fnc_loadPlayer;

	<IN>
		0		: BOOLEAN load player's position
		1		: BOOLEAN load player's Gear
		2		: BOOLEAN load player's health and stats


	<OUT>

		Nothing

//==================================================================================================================================================================================*/
//if no server get out
if ((missionNamespace getVariable ["MCC_isLocalHC",false]) || !hasInterface || !(local player)) exitWith {};

private ["_varName","_var","_position","_gear","_stats"];

_position = param [0, false, [false]];
_gear = param [1, false, [false]];
_stats = param [2, false, [false]];


waituntil {alive player &&
			time > 0 &&
			!dialog &&
			!(IsNull (findDisplay 46)) &&
			((missionNameSpace getvariable ["playerDeploy",false]) || !(missionNameSpace getvariable ["CP_activated",false]))
		  };

//Get player location
if (_position) then {
	_varName = format ["%1_%2_playerPos",worldname,missionName];
	[_varName, player,position player, "ARRAY"] remoteExec ["MCC_fnc_getVariable", 2];
	waitUntil {!isNil _varName};

	if (count (missionNameSpace getVariable [_varName,position player]) >= 3) then {
		player setpos (missionNameSpace getVariable [_varName,position player]);
	};
};


//Set Gear
if (_gear) then {
	_varName = format ["%1_%2_playerGear",worldname,missionName];
	[_varName, player,[   goggles player,
						  headgear player,
						  uniform player,
						  vest player,
						  backpack player,
						  backpackItems player,
						  primaryWeaponMagazine player,
						  secondaryWeaponMagazine player,
						  handgunMagazine player,
						  assignedItems player,
						  uniformItems player,
						  vestItems player,
						  primaryWeapon player,
						  secondaryWeapon player,
						  handgunWeapon player,
						  primaryWeaponItems player,
						  secondaryWeaponItems player,
						  handgunItems player], "ARRAY"] remoteExec ["MCC_fnc_getVariable", 2];
	waitUntil {!isNil _varName};
	if (count (missionNameSpace getVariable [_varName,[]]) >0) then {
		(missionNameSpace getVariable [_varName,[]]) call MCC_fnc_loadGear;
	};
};

//Set player stats
if (_stats) then {
	_varName = format ["%1_%2_playerStats",worldname,missionName];
	[_varName, player,[], "ARRAY"] remoteExec ["MCC_fnc_getVariable", 2];
	waitUntil {!isNil _varName};
	_var = missionNameSpace getVariable [_varName,[]];

	player setDamage (_var param [0,0]);
	player setVariable ["MCC_valorPoints",(_var param [1,50]),true];
	player setVariable ["MCC_calories",(_var param [2,4000]),true];
	player setVariable ["MCC_water",(_var param [3,200]),true];
	player setVariable ["MCC_surviveIsSick",(_var param [4,false]),true];
};