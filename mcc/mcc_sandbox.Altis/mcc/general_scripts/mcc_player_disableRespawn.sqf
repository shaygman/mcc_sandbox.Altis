
/*
	by Sickboy (sb_at_dev-heaven.net)
*/

if (isDedicated) exitWith {}; // not a player machine

private ["_safePos", "_startMarker", "_trainingMode", "_pos","_dummyObject","_null"];

while { !alive player } do {sleep 1};
sleep 3;

_playerClass = typeOf player;
_playerSideNr =  getNumber (configFile >> "CfgVehicles" >> _playerClass >> "side");

if (_playerSideNr == 1) then 
  { 
    
     while { (isnil ("MCC_START_WEST"))  } do {sleep 1};
	
	if (MCC_teleportAtStart) then
	{
		if (surfaceIsWater (MCC_START_WEST)) then {
			_safePos = [(MCC_START_WEST),1,50,1,2,900,0] call BIS_fnc_findSafePos;
			} else {
				_safePos = [(MCC_START_WEST),1,50,1,0,900,0] call BIS_fnc_findSafePos;
				};
		player setPos [_safepos select 0, _safepos select 1, 0];
	};
	if (CP_activated) then {_null=[] execVM CP_path + "scripts\player\player_init.sqf"};
	_startMarkerW = createMarkerLocal ["STARTLOCATIONW", (MCC_START_WEST)];
	_startMarkerW setMarkerShapeLocal "ICON";	
	_startMarkerW setMarkerTypeLocal  "mil_start";
	_startMarkerW setMarkerColorLocal "ColorGreen";

	//create the respawn locations
	_respawnMarkerW = createMarkerLocal ["RESPAWN_WEST", (MCC_START_WEST)];
	_respawnMarkerW setMarkerShapeLocal "ICON";	
	_respawnMarkerW setMarkerTypeLocal  "mil_objective";
	_respawnMarkerW setMarkerColorLocal "ColorRed";
  };
if (_playerSideNr == 0) then 
  { 

    while { (isnil ("MCC_START_EAST"))  } do {sleep 1};
	if (MCC_teleportAtStart) then
	{
		if (surfaceIsWater (MCC_START_EAST)) then {
			_safePos = [(MCC_START_EAST),1,50,1,2,900,0] call BIS_fnc_findSafePos;
			} else {
				_safePos = [(MCC_START_EAST),1,50,1,0,900,0] call BIS_fnc_findSafePos;
				};
		player setPos [_safepos select 0, _safepos select 1, 0];;
	};
	
	if (CP_activated) then {_null=[] execVM CP_path + "scripts\player\player_init.sqf"};
	_startMarkerE = createMarkerLocal ["STARTLOCATIONE", ( MCC_START_EAST)];
	_startMarkerE setMarkerShapeLocal "ICON";	
	_startMarkerE setMarkerTypeLocal  "mil_start";
	_startMarkerE setMarkerColorLocal "ColorGreen";

	//create the respawn locations
	_respawnMarkerE = createMarkerLocal ["RESPAWN_EAST", ( MCC_START_EAST)];
	_respawnMarkerE setMarkerShapeLocal "ICON";	
	_respawnMarkerE setMarkerTypeLocal  "mil_objective";
	_respawnMarkerE setMarkerColorLocal "ColorRed";
  };
if (_playerSideNr == 2) then 
  { 
    
    while { (isnil ("MCC_START_GUER")) } do {sleep 1};
	if (MCC_teleportAtStart) then
	{
		if (surfaceIsWater (MCC_START_GUER)) then {
			_safePos = [(MCC_START_GUER),1,50,1,2,900,0] call BIS_fnc_findSafePos;
			} else {
				_safePos = [(MCC_START_GUER),1,50,1,0,900,0] call BIS_fnc_findSafePos;
				};
		player setPos [_safepos select 0, _safepos select 1, 0];;
	};
	
	if (CP_activated) then {_null=[] execVM CP_path + "scripts\player\player_init.sqf"};
	_startMarkerG = createMarkerLocal ["STARTLOCATIONG", (MCC_START_GUER)];
	_startMarkerG setMarkerShapeLocal "ICON";	
	_startMarkerG setMarkerTypeLocal  "mil_start";
	_startMarkerG setMarkerColorLocal "ColorGreen";

	//create the respawn locations
	_respawnMarkerG = createMarkerLocal ["RESPAWN_GUERRILA", (MCC_START_GUER)];
	_respawnMarkerG setMarkerShapeLocal "ICON";	
	_respawnMarkerG setMarkerTypeLocal  "mil_objective";
	_respawnMarkerG setMarkerColorLocal "ColorRed";
  };
  
if (_playerSideNr == 3) then 
  { 
    
    while { (isnil ("MCC_START_CIV")) } do {sleep 1};
	if (MCC_teleportAtStart) then
	{
		if (surfaceIsWater (MCC_START_CIV)) then {
			_safePos = [(MCC_START_CIV),1,50,1,2,900,0] call BIS_fnc_findSafePos;
			} else {
				_safePos = [(MCC_START_CIV),1,50,1,0,900,0] call BIS_fnc_findSafePos;
				};
		player setPos [_safepos select 0, _safepos select 1, 0];;
	};
	_startMarkerG = createMarkerLocal ["STARTLOCATIONG", (MCC_START_CIV)];
	_startMarkerG setMarkerShapeLocal "ICON";	
	_startMarkerG setMarkerTypeLocal  "mil_start";
	_startMarkerG setMarkerColorLocal "ColorGreen";

	//create the respawn locations
	_respawnMarkerG = createMarkerLocal ["RESPAWN_CIVILIANS", (MCC_START_CIV)];
	_respawnMarkerG setMarkerShapeLocal "ICON";	
	_respawnMarkerG setMarkerTypeLocal  "mil_objective";
	_respawnMarkerG setMarkerColorLocal "ColorRed";
  };
// TODO: What about the base respawn markers? What happens when a unit inside the six_sys_bc_safezone that gets respawned? Should test.

//BTC - Revive
BTC_respawn_marker = format ["respawn_%1",playerSide];
if (BTC_respawn_marker == "respawn_guer") then {BTC_respawn_marker = "respawn_guerrila";};
BTC_r_base_spawn = "Land_HelipadEmpty_F" createVehicleLocal getMarkerPos BTC_respawn_marker;

_dummyObject = "Land_Pier_F" createvehicle [-9999, -9999, -1];
_dummyObject setpos [-9999, -9999, -1];
// Basicly wait till mission start
while { (isnil ("MCC_TRAINING"))  } do {sleep 1};
while { true } do
{
	"RESPAWN_GUERRILA" setMarkerPosLocal [-9999, -9999, 0.5];
	"RESPAWN_EAST" setMarkerPosLocal [-9999, -9999, 0.5];
	"RESPAWN_WEST" setMarkerPosLocal [-9999, -9999, 0.5];
	"RESPAWN_CIVILIANS" setMarkerPosLocal [-9999, -9999, 0.5];
	while { (alive player) } do {sleep 1};

    waitUntil { (alive player) && (player isKindOf "CAManBase") };
	cutText ["You Died...","BLACK OUT",2];
	
	sleep 1;
	
	if (side player == west) then {KEGsShownSides = [west];};
	if (side player == east) then {KEGsShownSides = [east];};
	if (side player == resistance) then {KEGsShownSides = [resistance];};
	if (side player == civilian) then {KEGsShownSides = [civilian];};
	
	player setCaptive true;
	[player] join MCC_deadGroup;
	
	sleep 2;
	[player,player,"noWait"] execVM MCC_path + "f\common\f_spect\specta.sqf";
};
