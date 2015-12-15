//============================================================MCC_fnc_ambientSpawnCar==========================================================================================
// Spawn cars around the player
// In:
//	_pos:	ARRAY of players that can see the civilians
//	_counter:  INTEGER max civilians to spawn
//	_factionCiv			STRING spawned faction
//	_carSpawnDistance: INTEGER distance to delete
//	_vehiclesArray: 	ARRAY vehicles class array
//<OUT>
//	Nothing
//===========================================================================================================================================================================
#define MAX_TRESHOLD 5
#define MAX_TRESHOLD_PER_AREA 1
#define MAX_WP 2

private ["_pos","_counter","_carSpawnDistance","_nearRoads","_carArray","_road","_carClass","_carGroup","_unit","_wp","_vehiclesArray","_side","_nearRoads","_farRoads","_car"];
_pos = [_this, 0, [], [[]]] call BIS_fnc_param;
_counter =[_this, 1, 1,[1]] call BIS_fnc_param;
_factionCiv	= [_this, 2, "CIV_F", [""]] call BIS_fnc_param;
_carSpawnDistance = [_this, 3, 250, [250]] call BIS_fnc_param;
_vehiclesArray = [_this, 4, [], [[]]] call BIS_fnc_param;

_side = [(getNumber (configfile >> "CfgFactionClasses" >> _factionCiv >> "side"))] call BIS_fnc_sideType;
_carArray = missionNamespace getVariable ["MCC_ambientCars",[]];

//Find nearest houses
_nearRoads = _pos nearRoads _carSpawnDistance;
{
	if (_pos distance getPos _x < _carSpawnDistance/2) then {
		_nearRoads set [_foreachIndex, -1]
	};
} foreach _nearRoads;

_nearRoads = _nearRoads - [-1];

//No roads around? go home
if (count _nearRoads <= 0 || count _carArray >= MAX_TRESHOLD) exitWith {};

//Don't spawn more the treshold per area
_carInArea = (MAX_TRESHOLD_PER_AREA - ({_x distance _pos < _carSpawnDistance} count _carArray));
if (_counter > _carInArea) then {_counter = _carInArea};

//Don't spawn more AI then roads
_counter = _counter min (count _nearRoads);

//Denied zones
_deniedZones = (_pos nearEntities ["MCC_Module_ambientCiviliansDenied", 2000]) + (_pos nearEntities ["MCC_Module_ambientCiviliansCuratorDenied", 2000]);

//Spawn moving vehicels
for "_i" from 1 to _counter do {
	_road = _nearRoads call bis_fnc_selectRandom;
	_pos = getpos _road;
	_vehiclesArray resize 6;
	_carClass = (_vehiclesArray call bis_fnc_selectRandom) select 0;

	//Are we inside denied zone
	private ["_spawn"];
	_spawn = true;
	{
		if (_x distance _road < (_x getVariable ["radius",100])) exitWith {_spawn = false};
	} forEach _deniedZones;

	if (_spawn) then {
		_carGroup = creategroup _side;
		_car = ([_pos,getdir _road ,_carClass, _carGroup] call BIS_fnc_spawnVehicle) select 0;


		if (_side == civilian) then {
			_unit = driver _car;
			//Add coleteral damage EH
			_unit addEventHandler ["killed", {
												_killer = _this select 1;
												if (isplayer _killer) then {
													_killed = missionNamespace getvariable [format ["MCC_civiliansKilled_%1",side _killer],0];
													_killed = _killed +1;
													missionNamespace setvariable [format ["MCC_civiliansKilled_%1",side _killer],_killed];
													publicVariable format ["MCC_civiliansKilled_%1",side _killer];
												}}];
		};
		_carArray pushBack _car;

		_carGroup setspeedmode "LIMITED";
		_carGroup setBehaviour "SAFE";

		_nearRoads = _pos nearRoads _carSpawnDistance;

		for "_i" from 0 to MAX_WP do {
			_road = _nearRoads call bis_fnc_selectRandom;
			_pos = getPosASL _road;
			_wp = _carGroup addWaypoint [(getPos _road), 0];
			_wp setWaypointType "MOVE";
			_wp waypointAttachObject _road;
			[_carGroup,0] setWaypointCompletionRadius 50;
		};

		_wp = _carGroup addWaypoint [_pos,(count waypoints _carGroup)];
		_wp setWaypointType "Cycle";

		MCC_curator addCuratorEditableObjects [[_car],true];
	};
};

missionNamespace setVariable ["MCC_ambientCars",_carArray];
publicVariable "MCC_ambientCars";