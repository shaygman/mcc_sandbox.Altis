//============================================================MCC_fnc_ambientSpawnCarParked======================================================================================
// Spawn parked cars on street shulders
// In:
//	_pos:				ARRAY of players that can see the civilians
//	_counter:  			INTEGER max civilians to spawn
//	_carSpawnDistance: 	INTEGER distance to delete
//	_vehiclesArray: 	ARRAY vehicles class array
//	_locked				BOOLEAN car spawned locked or random locked
//<OUT>
//	Nothing
//===========================================================================================================================================================================
#define MAX_PARKED_CARS 15
#define MAX_PARKED_CARS_PER_AREA 5

private ["_pos","_nearHouses","_houseConuter","_counter","_carSpawnDistance","_vehiclesArray","_locked","_carArray","_carInArea","_house","_road","_roadConnectedTo","_connectedRoad","_dir","_spawnPos","_vehicleClass","_vehicle"];
_pos = [_this, 0, [], [[]]] call BIS_fnc_param;
_counter =[_this, 1, 1,[1]] call BIS_fnc_param;
_carSpawnDistance = [_this, 2, 250, [250]] call BIS_fnc_param;
_vehiclesArray = [_this, 3, [], [[]]] call BIS_fnc_param;
_locked = [_this, 4, true, [true]] call BIS_fnc_param;

_carArray = missionNamespace getVariable ["MCC_ambientParkedCars",[]];

_nearHouses = [_pos,_carSpawnDistance] call MCC_fnc_findCivHouse;
_houseConuter = count _nearHouses;

//No houses or too many parked cars - exit
if (_houseConuter < 1 || count _carArray >= MAX_PARKED_CARS) exitWith {};

//Don't spawn more the treshold per area
_carInArea = (MAX_PARKED_CARS_PER_AREA - ({_x distance _pos < _carSpawnDistance} count _carArray));
if (_counter > _carInArea) then {_counter = _carInArea};

//Denied zones
_deniedZones = (_pos nearEntities ["MCC_Module_ambientCiviliansDenied", 2000]) + (_pos nearEntities ["MCC_Module_ambientCiviliansCuratorDenied", 2000]);

for "_i" from 1 to (_houseConuter min _counter) do
{
	_house = _nearHouses call BIS_fnc_selectRandom;
	_nearHouses = _nearHouses - [_house];
	_road = [getpos _house,20,[]] call bis_fnc_nearestRoad;

	//Are we inside denied zone
	private ["_spawn"];
	_spawn = true;
	{
		if (_x distance _road < (_x getVariable ["radius",100])) exitWith {_spawn = false};
	} forEach _deniedZones;

	if (!(isNull _road) && _spawn) then {
		_roadConnectedTo 	= roadsConnectedTo _road;
		_connectedRoad 		= _roadConnectedTo select 0;

		if (!isnil "_connectedRoad") then {
			_dir = [_road, _connectedRoad] call BIS_fnc_DirTo;
			if (isnil "_dir") then {_dir = getdir _road};
			_spawnPos = _road modelToWorld [5,0,0];

			//Make sure the vehicle is not in a wall on the road side
			_spawnPos = _spawnPos findEmptyPosition [0.1,10];

			_vehicleClass = (_vehiclesArray call bis_fnc_selectRandom) select 0;
			_vehicle= _vehicleClass createVehicle _spawnPos;
			waituntil {alive _vehicle};

			_vehicle setpos _spawnPos;
			_vehicle setDir _dir;
			if (_locked || random 1 > 0.5) then {
				_vehicle setVehicleLock "LOCKED";
			};

			_carArray pushBack _vehicle;
			//Curator
			MCC_curator addCuratorEditableObjects [[_vehicle],false];
		};
	};
};

missionNamespace setVariable ["MCC_ambientParkedCars",_carArray];
publicVariable "MCC_ambientParkedCars";