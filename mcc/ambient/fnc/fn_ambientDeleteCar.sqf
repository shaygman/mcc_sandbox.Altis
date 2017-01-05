//============================================================MCC_fnc_ambientDeleteCar==========================================================================================
// Delete cars when not in range and not seen by players
// In:
//	_spawnCenters:	ARRAY of players that can see the cars
//	_carSpawnDistance: INTEGER distance to delete
//
//<OUT>
//	Nothing
//===========================================================================================================================================================================
private ["_carArray", "_spawnCenters","_car","_carSpawnDistance"];
_spawnCenters =  [_this, 0, [], [[]]] call BIS_fnc_param;
_carSpawnDistance = [_this, 1, 250, [250]] call BIS_fnc_param;

_carArray = missionNamespace getVariable ["MCC_ambientCars",[]];
{
	_car = _x;
	if (isNull _car) then {
		_carArray set [_forEachIndex, -1];
	} else {
		if (({(_x distance _car < _carSpawnDistance*3) || !(lineintersects [eyepos _x,getposasl _car,_x,_car])} count _spawnCenters)==0) then {
			{deleteVehicle _x} forEach crew _car;
			deleteVehicle _car;
			_carArray set [_forEachIndex, -1];
		};
	}
} forEach _carArray;

_carArray = _carArray - [-1];
missionNamespace setVariable ["MCC_ambientCars",_carArray];
publicVariable "MCC_ambientCars";