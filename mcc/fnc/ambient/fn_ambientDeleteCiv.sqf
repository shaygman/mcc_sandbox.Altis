//============================================================MCC_fnc_ambientDeleteCiv==========================================================================================
// Delete civilians when not in range and not seen by players
// In:
//	_spawnCenters:	ARRAY of players that can see the civilians
//	_civSpawnDistance: INTEGER distance to delete
//
//<OUT>
//	Nothing
//===========================================================================================================================================================================
private ["_civArray", "_spawnCenters","_civ","_civSpawnDistance"];
_spawnCenters =  [_this, 0, [], [[]]] call BIS_fnc_param;
_civSpawnDistance = [_this, 1, 250, [250]] call BIS_fnc_param;

_civArray = missionNamespace getVariable ["MCC_ambientCivilians",[]];
{
	_civ = _x;
	if (isNull _civ) then {
		_civArray set [_forEachIndex, -1];
	} else {
		if (({(_x distance _civ < _civSpawnDistance) || !(lineintersects [eyepos _x,getposasl _civ,_x,_civ])} count _spawnCenters)==0) then {
			deleteVehicle _civ;
			_civArray set [_forEachIndex, -1];
		};
	}
} forEach _civArray;

_civArray = _civArray - [-1];
missionNamespace setVariable ["MCC_ambientCivilians",_civArray];
publicVariable "MCC_ambientCivilians";