private ["_comboBox","_spawnArray","_pos","_spawn","_nearObjects","_spawnErrorCode","_safepos","_targets","_target","_groups","_countRole","_roleLimit","_role","_spawnPos","_playerDeployPos"];
disableSerialization;

#define CP_RESPAWNPANEL_IDD (uiNamespace getVariable "CP_RESPAWNPANEL_IDD")
#define CP_respawnPointsList (uiNamespace getVariable "CP_respawnPointsList")
#define CP_ticketsWestText (uiNamespace getVariable "CP_ticketsWestText")
#define CP_ticketsEastText (uiNamespace getVariable "CP_ticketsEastText")
#define CP_respawnPanelRoleCombo (uiNamespace getVariable "CP_respawnPanelRoleCombo")
#define CP_deployPanelMiniMap (uiNamespace getVariable "CP_deployPanelMiniMap")
#define CP_gearPanelPiP (uiNamespace getVariable "CP_gearPanelPiP")

#define CP_RscMainXPUI (uiNamespace getVariable "CP_RscMainXPUI")
#define XPTitle (uiNamespace getVariable "XPTitle")
#define XPValue (uiNamespace getVariable "XPValue")

_spawnErrorCode = 0;
/*
1 - no group
2 - no role
3 - enemy near by
4 - no room in vehicle
*/

//==================================================Deploy pressed============================================================
private ["_activeSpawn"];

//Find spawn pos or use the default one
if (isNull (missionNamespace getVariable ["CP_activeSpawn",objNull])) then {
	_spawnPos = [player] call BIS_fnc_getRespawnPositions;
	if (count _spawnPos > 0) then {
		missionNamespace setVariable ["CP_activeSpawn",(_spawnPos select 0)];
	};
};

_activeSpawn = missionNamespace getVariable ["CP_activeSpawn",objNull];

//Check if alive
if (isnull _activeSpawn) exitWith {[9999,"Select spawn point!",3,true] spawn MCC_fnc_setIDCText};
if (typeName _activeSpawn == "GROUP") then {_activeSpawn = leader CP_activeSpawn};

if (!alive _activeSpawn) exitWith {
	_activeSpawn setVariable ["dead",true,true];
	[9999,"Spawn Point destroyed, select another!",3,true] spawn MCC_fnc_setIDCText
};


if (missionNamespace getVariable ["CP_activated",false]) then {

	_spawnErrorCode = 1;

	//Check if player assigned to group
	_groups	 = switch (side player) do {
					case west:			{CP_westGroups};
					case east:			{CP_eastGroups};
					case resistance:	{CP_guarGroups};
					case civilian:		{CP_guarGroups};
				};


	for [{_i=0},{_i < count _groups},{_i=_i+1}] do {
		if ((group player) == (_groups select _i) select 0) exitWith {_spawnErrorCode = 0};
	};

	if (player getvariable ["CP_role","n/a"] == "n/a") then {_spawnErrorCode = 2};
};

//Check if no enemy is close by
if (_activeSpawn == leader player) then {
	_targets = ["Car","Tank","Man"];
	_nearObjects = (getpos _activeSpawn) nearObjects 100;

	if ((count _nearObjects) > 0) then {
		private ["_enemySides"];
		_enemySides = [player] call BIS_fnc_enemySides;

		{
			_target = _x;
			{
				if ((_target isKindOf _x) && ((side _target) in _enemySides)) exitWith {_spawnErrorCode = 3};
			} foreach _targets;
		} foreach _nearObjects;
	};

	//The unit is inside vehicle
	if (vehicle _activeSpawn != _activeSpawn) then {
		if (((vehicle _activeSpawn) emptyPositions "Cargo") <= 0) then {_spawnErrorCode = 4};
	};
};

//Error in spawning
if (_spawnErrorCode > 0) exitWith {
	switch (_spawnErrorCode) do
	{
		case 1: {[9999,"You must join a squad first!",3,true] spawn MCC_fnc_setIDCText};
		case 2: {[9999,"You must select a role first!",3,true] spawn MCC_fnc_setIDCText};
		case 3: {[9999,"Enemies nearby can't spawn select another spawn point!",3,true] spawn MCC_fnc_setIDCText};
		case 4: {[9999,"Can't respawn no free space in leader vehicle!",3,true] spawn MCC_fnc_setIDCText};
	};
};

//looking for a spawn point
private ["_maxPos","_cpPos"];
_maxPos = 1;
_cpPos = getpos _activeSpawn;

waitUntil {
	_maxPos = _maxPos +1;
	_playerDeployPos  =_cpPos findEmptyPosition [0,_maxPos];
	count _playerDeployPos > 0;
};

if (format["%1",_playerDeployPos] == "[-500,-500,0]" ) exitWith {
	[9999,"No good position found! Try again.",3,true] spawn MCC_fnc_setIDCText
};
playerDeploy = true;

//Is it a spawn tent and we spawned as the squad leader - delete the tent
if (((_activeSpawn getVariable ["type","FOB"]) == "Rally_Point") && ((player == leader player) || ((player getvariable ["CP_role","n/a"]) == "Officer"))) then {
	_activeSpawn spawn {sleep 5; _this setDamage 1};
};

//Lets spawn
cutText ["Deploying ....","BLACK IN",5];

private _teleportAtStart = _activeSpawn getVariable ["teleport",1];

//wait until detach
waitUntil {isNull attachedTo player};

//Spawn in vehicle
if (_activeSpawn == leader player && (vehicle _activeSpawn != _activeSpawn)) then {
	player assignAsCargo (vehicle _activeSpawn);
	player moveInCargo (vehicle _activeSpawn);
} else {

	if (_teleportAtStart != 0) then {

		//Teleport
		if (_teleportAtStart == 1) then {
			player setpos _playerDeployPos;
		} else {
			private _helo = _teleportAtStart ==3;
			[_safePos, ["",player], _helo, 5000, floor (random 40)] call MCC_fnc_paradrop;
		};
	};
};

//Remove escape event handlers and reseting menu
if (!isnil "CP_RESPAWNPANEL_IDD") then {CP_RESPAWNPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
if (!isnil "CP_SQUADPANEL_IDD") then {CP_SQUADPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
if (!isnil "CP_GEARPANEL_IDD") then {CP_GEARPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
if (!isnil "CP_WEAPONSPANEL_IDD") then {CP_WEAPONSPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
if (!isnil "CP_ACCESPANEL_IDD") then {CP_ACCESPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
if (!isnil "CP_UNIFORMSPANEL_IDD") then {CP_UNIFORMSPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
CP_respawnPanelOpen = false;