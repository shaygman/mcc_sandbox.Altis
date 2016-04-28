//============================================================MCC_fnc_ambientDeleteCiv==========================================================================================
// Delete civilians when not in range and not seen by players
// In:
//	_spawnCenters:	ARRAY of players that can see the civilians
//	_civSpawnDistance: INTEGER distance to delete
//
//<OUT>
//	Nothing
//===========================================================================================================================================================================
private ["_civArray", "_spawnCenters","_civ","_civSpawnDistance","_arrayName"];
_spawnCenters =  param [ 0, [], [[]]];
_civSpawnDistance = param [ 1, 250, [250]];
_arrayName = param [ 2, "", [""]];

_civArray = missionNamespace getVariable [_arrayName,[]];
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
missionNamespace setVariable [_arrayName,_civArray];
publicVariable _arrayName;