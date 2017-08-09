/*==================================================================MCC_fnc_savePlayer===============================================================================================
	Save persistent data about the player to the server  - must run on the server init

	EXAMPLE
		[10,true,true,true] spawn MCC_fnc_savePlayer;

	<IN>
		0		: INTEGER wait time between each save
		1		: BOOLEAN save player's position
		2		: BOOLEAN save player's Gear
		3		: BOOLEAN save player's health and stats


	<OUT>

		Nothing

//==================================================================================================================================================================================*/
IF (!isServer) exitWith {};

private ["_player","_tempArray","_waitTime","_position","_gear","_stats"];

_waitTime = param [0, 10, []];
_position = param [1, false, [false]];
_gear = param [2, false, [false]];
_stats = param [3, false, [false]];


//Don't allow more then one instanse of server monitoring
if (missionNamespace getVariable ["MCC_fnc_savePlayerIsrunning",false]) exitWith {};
missionNamespace setVariable ["MCC_fnc_savePlayerIsrunning",true];

addMissionEventHandler ["HandleDisconnect",{
	private ["_tempArray","_player"];
	_player = _this select 0;

	//Position
		if (_position) then {
			[format ["%1_%2_playerPos",worldname,missionName], _player,position _player, "ARRAY"] call MCC_fnc_setVariable;
		};

		//Gear
		if (_gear) then {
			_tempArray = [goggles _player,
						  headgear _player,
						  uniform _player,
						  vest _player,
						  backpack _player,
						  backpackItems _player,
						  primaryWeaponMagazine _player,
						  secondaryWeaponMagazine _player,
						  handgunMagazine _player,
						  assignedItems _player,
						  uniformItems _player,
						  vestItems _player,
						  primaryWeapon _player,
						  secondaryWeapon _player,
						  handgunWeapon _player,
						  primaryWeaponItems _player,
						  secondaryWeaponItems _player,
						  handgunItems _player];

			[format ["%1_%2_playerGear",worldname,missionName], _player,_tempArray, "ARRAY"] call MCC_fnc_setVariable;

		};

		//health and stats
		if (_stats) then {
			_tempArray = [damage _player,
						  _player getVariable ["MCC_valorPoints",50],
						  _player getVariable ["MCC_calories",4000],
						  _player getVariable ["MCC_water",200],
						  _player getVariable ["MCC_surviveIsSick",false]
						 ];

			[format ["%1_%2_playerStats",worldname,missionName], _player,_tempArray, "ARRAY"] call MCC_fnc_setVariable;
		};
}];

while {true} do {

	sleep _waitTime;

	{
		_player = _x;

		//Position
		if (_position) then {
			[format ["%1_%2_playerPos",worldname,missionName], _player,position _player, "ARRAY"] call MCC_fnc_setVariable;
		};

		//Gear
		if (_gear) then {
			_tempArray = [goggles _player,
						  headgear _player,
						  uniform _player,
						  vest _player,
						  backpack _player,
						  backpackItems _player,
						  primaryWeaponMagazine _player,
						  secondaryWeaponMagazine _player,
						  handgunMagazine _player,
						  assignedItems _player,
						  uniformItems _player,
						  vestItems _player,
						  primaryWeapon _player,
						  secondaryWeapon _player,
						  handgunWeapon _player,
						  primaryWeaponItems _player,
						  secondaryWeaponItems _player,
						  handgunItems _player];

			[format ["%1_%2_playerGear",worldname,missionName], _player,_tempArray, "ARRAY"] call MCC_fnc_setVariable;

		};

		//health and stats
		if (_stats) then {
			_tempArray = [damage _player,
						  _player getVariable ["MCC_valorPoints",50],
						  _player getVariable ["MCC_calories",4000],
						  _player getVariable ["MCC_water",200],
						  _player getVariable ["MCC_surviveIsSick",false]
						 ];

			[format ["%1_%2_playerStats",worldname,missionName], _player,_tempArray, "ARRAY"] call MCC_fnc_setVariable;
		};

	} forEach (if (isMultiplayer) then {playableUnits} else {[player]});
};