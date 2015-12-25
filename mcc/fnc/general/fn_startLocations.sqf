//===================================================================MCC_fnc_startLocations=========================================================================================
// Teleport the player when start location has been found
// Example: []  call MCC_fnc_startLocations;
// <IN>	side : integer - side number to take effect
//<OUT>	Nothing
//==============================================================================================================================================================================
private ["_playerClass","_playerSideNr","_safePos","_null","_side","_startLocationName","_teleportAtStart","_helo","_cpActivated","_respawnDialog","_markerName","_pos","_respawnName","_starLoc","_openDialog"];
_side = _this select 0;
if (!local player || missionNameSpace getVariable ["MCC_startLocationsRuning", false]) exitWith {};

waituntil {alive player && !(IsNull (findDisplay 46))};

_playerClass = typeOf player;
_playerSideNr =  getNumber (configFile >> "CfgVehicles" >> _playerClass >> "side");

if (isnil "_side") then {
	_side = _playerSideNr;
};

if (_side !=  _playerSideNr) exitWith {};

missionNameSpace setVariable ["MCC_startLocationsRuning", true];

//Is role selection on
_cpActivated = missionNamespace getVariable ["CP_activated",false];

//Respawn menu on
_respawnDialog = missionNamespace getVariable ["MCC_openRespawnMenu",true];

//Player side
switch (_playerSideNr) do {
    case 0: {
    	_startLocationName = "MCC_START_EAST";
    	_markerName = "MCC_StartMarkerE";
       	_respawnName = "RESPAWN_EAST";
    };

    case 1: {
    	_startLocationName = "MCC_START_WEST";
    	_markerName = "MCC_StartMarkerW";
      	_respawnName = "RESPAWN_WEST";
    };

   case 2: {
    	_startLocationName = "MCC_START_GUER";
    	_markerName = "MCC_StartMarkerG";
    	_respawnName = "RESPAWN_GUERRILA";
    };

    default {
     	_startLocationName = "MCC_START_CIV";
    	_markerName = "MCC_StartMarkerC";
       	_respawnName = "RESPAWN_CIVILIANS";
    };
};


while {str (missionNamespace getVariable [_startLocationName,[]]) == "[]"} do {sleep 3};
missionNameSpace setVariable ["MCC_startLocationsRuning", false];

//Black Screen on mission startup
if (!_cpActivated && _respawnDialog) then {

	cutText ["","BLACK",0.1];
	sleep 3;
	_startLocations = [player] call BIS_fnc_getRespawnPositions;
	_openDialog = {(_x getVariable ["teleport",0]) != 0} count _startLocations > 0;

	if (_openDialog) then {
		player setVariable ["cpReady",false,true];
		playerDeploy = false;
		sleep 0.1;

		_ok = createDialog "CP_RESPAWNPANEL";
		if !(_ok) exitWith { hint "createDialog failed"; diag_log  "CP: create respawn Dialog failed";};

		waituntil {playerDeploy};
		closedialog 0;
		waituntil {!dialog};
		//Respawning

		player setVariable ["cpReady",true,true];
	};

	cutText ["Deploying ....","BLACK IN",5];

	_starLoc = missionNamespace getVariable ["CP_activeSpawn",objNull];

	if (isNull _starLoc) then {
		if (count _startLocations > 0) then {_starLoc = _startLocations select 0};
	};

	_teleportAtStart = _starLoc getVariable ["teleport",0];

	if (_teleportAtStart != 0) then {
		if (surfaceIsWater (playerDeployPos)) then {
			_safePos = [(playerDeployPos),10,50,1,2,900,0] call BIS_fnc_findSafePos;
		} else {
			_safePos = [(playerDeployPos),10,50,1,0,900,0] call BIS_fnc_findSafePos;
		};

		//Teleport
		if (_teleportAtStart == 1) then {
			player setPosATL [_safepos select 0, _safepos select 1, 0];
		} else {
			_helo = if (_teleportAtStart ==2) then {false} else {true};
			[_safePos, ["",player], _helo, 5000, floor (random 40)] call MCC_fnc_paradrop;
		};
	};
};

_pos = missionNamespace getVariable [_startLocationName,position player];
if (!_cpActivated && !_respawnDialog) then	{
	player setpos _pos;
};

if (!isnil _markerName) then {deleteMarkerLocal _markerName};
missionNamespace setVariable [_markerName,createMarkerLocal [_markerName, _pos]];
_markerName setMarkerShapeLocal "ICON";
_markerName setMarkerTypeLocal  "mil_start";
_markerName setMarkerColorLocal "ColorGreen";

//create the respawn locations

if (str getMarkerPos _respawnName != "[0,0,0]") then {deleteMarkerLocal _respawnName};
//missionNamespace setVariable [_respawnName,createMarkerLocal [_respawnName, _pos]];
createMarkerLocal [_respawnName, _pos];
_respawnName setMarkerShapeLocal "ICON";
_respawnName setMarkerTypeLocal  "mil_objective";
_respawnName setMarkerColorLocal "ColorRed";

//BTC - Revive
if (!isnil "BTC_respawn_marker") then {
	BTC_respawn_marker = format ["respawn_%1",playerSide];
	if (BTC_respawn_marker == "respawn_guer") then {BTC_respawn_marker = "respawn_guerrila"};

	if (!isNil "BTC_r_base_spawn") then {deletevehicle BTC_r_base_spawn};

	BTC_r_base_spawn = "Land_HelipadEmpty_F" createVehicleLocal getMarkerPos BTC_respawn_marker;
};