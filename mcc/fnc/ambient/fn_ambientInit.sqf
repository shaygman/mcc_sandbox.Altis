//============================================================MCC_fnc_ambientInit===============================================================================================
// Spawn selected units around the player
// _isCiv:				BOOLEAN - units running around?
// _isCar:				BOOLEAN - Will have driving cars around
// _isParkedCar:		BOOLEAN - Will have parked cars around
// _isLocked			BOOLEAN - Will the parked cars will allways be locked
// _civSpawnDistance	INTEGER - Spawn distance around the players
// _civSpawnDistance	INTEGER - max units spawned around the player
// _factionCiv			STRING - the units' faction
// _factionCivCar		STRING - the units' cars faction
//===========================================================================================================================================================================
private ["_spawnCenters","_isCiv","_player","_civArray","_civCount","_civSpawnDistance","_maxCivSpawn","_factionCiv","_unitsArray","_vehiclesArray","_isCar","_carCount","_carArray","_isParkedCar","_isLocked"];
_isCiv =  [_this, 0, true, [true]] call BIS_fnc_param;
_isCar = [_this, 1, true, [true]] call BIS_fnc_param;
_isParkedCar = [_this, 2, true, [true]] call BIS_fnc_param;
_isLocked  = [_this, 3, false, [true]] call BIS_fnc_param;
_civSpawnDistance = [_this, 4, 250, [250]] call BIS_fnc_param;
_maxCivSpawn = [_this, 5, 4, [4]] call BIS_fnc_param;
_factionCiv	= [_this, 6, "CIV_F", [""]] call BIS_fnc_param;
_factionCivCar = [_this, 7, "CIV_F", [""]] call BIS_fnc_param;

//Let's build the faction unit's array
_unitsArray 	= [_factionCiv,"soldier","men"] call MCC_fnc_makeUnitsArray;
if(count _unitsArray < 4) then {
	_unitsArray = [_factionCiv,"soldier"] call MCC_fnc_makeUnitsArray;
};

//Let's build the faction vehicles's array
_vehiclesArray	= [_factionCivCar,"carx","car"] call MCC_fnc_makeUnitsArray;
if(count _vehiclesArray < 4) then {
	_vehiclesArray = [_factionCivCar,"carx"] call MCC_fnc_makeUnitsArray;
};

while {true} do {
	_spawnCenters = if (isMultiplayer) then {playableUnits} else {[player]};

	//Do we have units going around?
	{
		_player = _x;
		if (isPlayer _player) then {
			if (_isCiv) then {
				[_spawnCenters,_civSpawnDistance] call MCC_fnc_ambientDeleteCiv;
				_civCount = 0;
				_civArray = missionNamespace getVariable ["MCC_ambientCivilians",[]];
				{
					if (_x distance _player < _civSpawnDistance) then {
						_civCount = _civCount + 1;
					};
				} forEach _civArray;

				if (_civCount < _maxCivSpawn) then {
					[getpos _player, (_maxCivSpawn -_civCount),_factionCiv,_civSpawnDistance,_unitsArray] call MCC_fnc_ambientSpawnCiv;
				};
			};

			//Do we have traffic going around?
			if (_isCar) then {
				[_spawnCenters,_civSpawnDistance*2] call MCC_fnc_ambientDeleteCar;

					_carCount = 0;
					_carArray = missionNamespace getVariable ["MCC_ambientCars",[]];
					{
						if (_x distance _player < _civSpawnDistance*2) then {
							_carCount = _carCount + 1;
						};
					} forEach _carArray;

					if (_carCount < _maxCivSpawn/2) then {
						[getpos _player, (_maxCivSpawn/2 -_carCount),_factionCiv,_civSpawnDistance*2,_vehiclesArray] call MCC_fnc_ambientSpawnCar;
					};
			};

			//Do we have parked cars going around?
			if (_isParkedCar) then {
				[_spawnCenters,_civSpawnDistance] call MCC_fnc_ambientDeleteCarParked;

				_carCount = 0;
				_carArray = missionNamespace getVariable ["MCC_ambientParkedCars",[]];
				{
					if (_x distance _player < _civSpawnDistance) then {
						_carCount = _carCount + 1;
					};
				} forEach _carArray;

				if (_carCount < _maxCivSpawn) then {
					[getpos _player, (_maxCivSpawn -_carCount),_civSpawnDistance,_vehiclesArray,_isLocked] call MCC_fnc_ambientSpawnCarParked;
				};
			};
		};
	} forEach _spawnCenters;

	sleep 5;
};

