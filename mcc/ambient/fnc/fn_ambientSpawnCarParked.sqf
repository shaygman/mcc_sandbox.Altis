//============================================================MCC_fnc_ambientSpawnCarParked===========================================================================
// Spawn parked cars on street shulders
// In:
//	_pos:				ARRAY of players that can see the civilians
//	_counter:  			INTEGER max civilians to spawn
//	_carSpawnDistance: 	INTEGER distance to delete
//	_vehiclesArray: 	ARRAY vehicles class array
//	_locked				BOOLEAN car spawned locked or random locked
//<OUT>
//	Nothing
//===============================================================================================================================================================
#define MAX_PARKED_CARS 15
#define MAX_PARKED_CARS_PER_AREA 5

private ["_pos","_nearHouses","_houseConuter","_counter","_carSpawnDistance","_vehiclesArray","_locked","_carArray","_carInArea","_house","_road","_roadConnectedTo","_connectedRoad","_dir","_spawnPos","_vehicleClass","_vehicle","_civRelations","_sidePlayer","_roadPos","_radius"];
_pos = param [0, [], [[]]];
_counter = param [1, 1,[1]];
_carSpawnDistance = param [2, 250, [250]];
_vehiclesArray = param [ 3, [], [[]]];
_locked = param [ 4, true, [true]];
_sidePlayer = param [5,west];
_civRelations = param [6,0.8,[0]];

if (count _vehiclesArray <= 0) exitWith {};

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

for "_i" from 1 to (_houseConuter min _counter) do {
	_house = _nearHouses call BIS_fnc_selectRandom;
	_nearHouses = _nearHouses - [_house];
	_road = [getpos _house,20,[]] call bis_fnc_nearestRoad;

	//Are we inside denied zone
	private ["_spawn","_isIED"];
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
			_roadPos = _road modelToWorld [5,0,0];

			_isIED = (_civRelations < 0.4 && random 1 < 0.1);

			_vehicleClass = if (_isIED && random 1 < 0.2) then {
				 ((MCC_ied_hidden) call bis_fnc_selectRandom) select 1} else {
				 	(_vehiclesArray call bis_fnc_selectRandom) select 0;
				 };

			//Make sure the vehicle is not in a wall on the road side
			_spawnPos = [];
			_radius = 5;

			while {_spawnPos isEqualTo []} do {
				_spawnPos = _roadPos findEmptyPosition [0.1,_radius, _vehicleClass];
				_radius = _radius +5;
				sleep 0.1;
			};

			_vehicle= _vehicleClass createVehicle _spawnPos;
			waituntil {alive _vehicle};
			_vehicle setDir _dir;

			if (_vehicle isKindOf "car") then {
				_vehicle setpos _spawnPos;
				_vehicle allowDamage false;
				sleep 0.1;

				if (!isTouchingGround _vehicle || !alive _vehicle) then {
					deleteVehicle _vehicle;
				} else {
					_vehicle allowDamage true;

					if (_locked || random 1 > 0.5) then {
						_vehicle setVehicleLock "LOCKED";
					};
				};
			};

			if (alive _vehicle) then {
				if (_isIED) then {
					_vehicle setVariable ["isIED",true,true];
					[_vehicle,(["small","medium","large"] call bis_fnc_selectRandom),([0,2] call bis_fnc_selectRandom),15,true,0,25,_sidePlayer] spawn MCC_fnc_createIED;
				};

				_carArray pushBack _vehicle;
				//Curator
				{_x addCuratorEditableObjects [[_vehicle],false]} forEach allCurators;
			};
		};
	};
};

missionNamespace setVariable ["MCC_ambientParkedCars",_carArray];
publicVariable "MCC_ambientParkedCars";