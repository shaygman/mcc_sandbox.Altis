//===================================================================MCC_fnc_startLocations=========================================================================================
// Teleport the player when start location has been found
// Example: []  call MCC_fnc_startLocations; 
// <IN>	side : integer - side number to take effect
//<OUT>	Nothing
//==============================================================================================================================================================================	
private ["_playerClass","_playerSideNr","_safePos","_null","_side","_firstLoop"];
_side = _this select 0;

waituntil {alive player}; 
sleep 1;

_playerClass = typeOf player;
_playerSideNr =  getNumber (configFile >> "CfgVehicles" >> _playerClass >> "side");
_firstLoop = false; 
if (isnil "_side") then 
{
	_side = _playerSideNr;
	_firstLoop = true; 
}; 

if (_side !=  _playerSideNr) exitWith {};

if (_playerSideNr == 1) then 
{ 
	while {(isnil ("MCC_START_WEST"))} do {sleep 3};
	
	if (MCC_teleportAtStartWest != 0) then
	{
		if (surfaceIsWater (MCC_START_WEST)) then 
		{
			_safePos = [(MCC_START_WEST),1,50,1,2,900,0] call BIS_fnc_findSafePos;
		} 
		else 
		{
			_safePos = [(MCC_START_WEST),1,50,1,0,900,0] call BIS_fnc_findSafePos;
		};
		
		//Teleport
		if (MCC_teleportAtStartWest == 1) then
		{
			player setPosATL [_safepos select 0, _safepos select 1, 0];
		}
		else
		{
			private "_helo";
			_helo = if (MCC_teleportAtStartWest ==2) then {false} else {true}; 
			
			[_safePos, ["",player], _helo, 5000, floor (random 40)] call MCC_fnc_paradrop;			
		};
	};
	
	if (!isnil "MCC_StartMarkerW") then {deleteMarkerLocal MCC_StartMarkerW};
	MCC_StartMarkerW = createMarkerLocal ["STARTLOCATIONW", (MCC_START_WEST)];
	MCC_StartMarkerW setMarkerShapeLocal "ICON";	
	MCC_StartMarkerW setMarkerTypeLocal  "mil_start";
	MCC_StartMarkerW setMarkerColorLocal "ColorGreen";

	//create the respawn locations
	if (!isnil "MCC_RespawnMarkerW") then {deleteMarkerLocal MCC_RespawnMarkerW};
	MCC_RespawnMarkerW = createMarkerLocal ["RESPAWN_WEST", (MCC_START_WEST)];
	MCC_RespawnMarkerW setMarkerShapeLocal "ICON";	
	MCC_RespawnMarkerW setMarkerTypeLocal  "mil_objective";
	MCC_RespawnMarkerW setMarkerColorLocal "ColorRed";
};

if (_playerSideNr == 0) then 
  { 

	while { (isnil ("MCC_START_EAST"))  } do {sleep 3};
	
	if (MCC_teleportAtStartEast != 0) then
	{
		if (surfaceIsWater (MCC_START_EAST)) then 
		{
			_safePos = [(MCC_START_EAST),1,50,1,2,900,0] call BIS_fnc_findSafePos;
		} 
		else 
		{
			_safePos = [(MCC_START_EAST),1,50,1,0,900,0] call BIS_fnc_findSafePos;
		};
		
		//Teleport
		if (MCC_teleportAtStartEast == 1) then
		{
			player setPosATL [_safepos select 0, _safepos select 1, 0];
		}
		else
		{
			private "_helo";
			_helo = if (MCC_teleportAtStartEast ==2) then {false} else {true}; 
			
			[_safePos, ["",player], _helo, 5000, floor (random 40)] call MCC_fnc_paradrop;			
		};
	};
	
	if (!isnil "MCC_StartMarkerE") then {deleteMarkerLocal MCC_StartMarkerE};
	MCC_StartMarkerE = createMarkerLocal ["STARTLOCATIONE", ( MCC_START_EAST)];
	MCC_StartMarkerE setMarkerShapeLocal "ICON";	
	MCC_StartMarkerE setMarkerTypeLocal  "mil_start";
	MCC_StartMarkerE setMarkerColorLocal "ColorGreen";

	//create the respawn locations
	if (!isnil "MCC_RespawnMarkerE") then {deleteMarkerLocal MCC_RespawnMarkerE};
	MCC_RespawnMarkerE = createMarkerLocal ["RESPAWN_EAST", ( MCC_START_EAST)];
	MCC_RespawnMarkerE setMarkerShapeLocal "ICON";	
	MCC_RespawnMarkerE setMarkerTypeLocal  "mil_objective";
	MCC_RespawnMarkerE setMarkerColorLocal "ColorRed";
  };
if (_playerSideNr == 2) then 
  { 
	
	while { (isnil ("MCC_START_GUER")) } do {sleep 3};

	if (MCC_teleportAtStartGuer != 0) then
	{
		if (surfaceIsWater (MCC_START_GUER)) then 
		{
			_safePos = [(MCC_START_GUER),1,50,1,2,900,0] call BIS_fnc_findSafePos;
		} 
		else 
		{
			_safePos = [(MCC_START_GUER),1,50,1,0,900,0] call BIS_fnc_findSafePos;
		};
		
		//Teleport
		if (MCC_teleportAtStartGuer == 1) then
		{
			player setPosATL [_safepos select 0, _safepos select 1, 0];
		}
		else
		{
			private "_helo";
			_helo = if (MCC_teleportAtStartGuer ==2) then {false} else {true}; 
			
			[_safePos, ["",player], _helo, 5000, floor (random 40)] call MCC_fnc_paradrop;			
		};
	};
	
	//if (CP_activated && !_firstLoop) then {_null=[] execVM CP_path + "scripts\player\player_init.sqf"};
	
	if (!isnil "MCC_StartMarkerG") then {deleteMarkerLocal MCC_StartMarkerG};
	MCC_StartMarkerG = createMarkerLocal ["STARTLOCATIONG", (MCC_START_GUER)];
	MCC_StartMarkerG setMarkerShapeLocal "ICON";	
	MCC_StartMarkerG setMarkerTypeLocal  "mil_start";
	MCC_StartMarkerG setMarkerColorLocal "ColorGreen";

	//create the respawn locations
	if (!isnil "MCC_RespawnMarkerG") then {deleteMarkerLocal MCC_RespawnMarkerG};
	MCC_RespawnMarkerG = createMarkerLocal ["RESPAWN_GUERRILA", (MCC_START_GUER)];
	MCC_RespawnMarkerG setMarkerShapeLocal "ICON";	
	MCC_RespawnMarkerG setMarkerTypeLocal  "mil_objective";
	MCC_RespawnMarkerG setMarkerColorLocal "ColorRed";
  };
  
if (_playerSideNr == 3) then 
  { 
	
	while { (isnil ("MCC_START_CIV")) } do {sleep 3};

	if (MCC_teleportAtStartCiv != 0) then
	{
		if (surfaceIsWater (MCC_START_CIV)) then 
		{
			_safePos = [(MCC_START_CIV),1,50,1,2,900,0] call BIS_fnc_findSafePos;
		} 
		else 
		{
			_safePos = [(MCC_START_CIV),1,50,1,0,900,0] call BIS_fnc_findSafePos;
		};
		
		//Teleport
		if (MCC_teleportAtStartCiv == 1) then
		{
			player setPosATL [_safepos select 0, _safepos select 1, 0];
		}
		else
		{
			private "_helo";
			_helo = if (MCC_teleportAtStartCiv ==2) then {false} else {true}; 
			
			[_safePos, ["",player], _helo, 5000, floor (random 40)] call MCC_fnc_paradrop;			
		};
	};
	
	if (!isnil "MCC_StartMarkerC") then {deleteMarkerLocal MCC_StartMarkerC};
	MCC_StartMarkerC = createMarkerLocal ["STARTLOCATIONG", (MCC_START_CIV)];
	MCC_StartMarkerC setMarkerShapeLocal "ICON";	
	MCC_StartMarkerC setMarkerTypeLocal  "mil_start";
	MCC_StartMarkerC setMarkerColorLocal "ColorGreen";

	//create the respawn locations
	if (!isnil "MCC_RespawnMarkerC") then {deleteMarkerLocal MCC_RespawnMarkerC};
	MCC_RespawnMarkerC = createMarkerLocal ["RESPAWN_CIVILIANS", (MCC_START_CIV)];
	MCC_RespawnMarkerC setMarkerShapeLocal "ICON";	
	MCC_RespawnMarkerC setMarkerTypeLocal  "mil_objective";
	MCC_RespawnMarkerC setMarkerColorLocal "ColorRed";
  };

//BTC - Revive
if (!isnil "BTC_respawn_marker") then
{
	BTC_respawn_marker = format ["respawn_%1",playerSide];
	if (BTC_respawn_marker == "respawn_guer") then {BTC_respawn_marker = "respawn_guerrila"};

	if (!isNil "BTC_r_base_spawn") then {deletevehicle BTC_r_base_spawn};

	BTC_r_base_spawn = "Land_HelipadEmpty_F" createVehicleLocal getMarkerPos BTC_respawn_marker;
};