//============================================================MCC_fnc_findCivHouse===============================================================================================
// find nearest civilian house
// In:
//	_pos:	ARRAY
//	_RADIUS: INTEGER
//
//<OUT>
//	_nearhouses ARRAY of objects - good houses found
//===========================================================================================================================================================================
private ["_pos","_nearHouses","_civSpawnDistance","_house"];
_pos = [_this, 0, [], [[]]] call BIS_fnc_param;
_civSpawnDistance = [_this, 1, 250, [250]] call BIS_fnc_param;

//Find nearest houses
_nearHouses = nearestObjects [_pos,["House","Church","FuelStation"],_civSpawnDistance];


//If vanila island make sure
if (tolower worldName in ["altis","stratis"]) then {
	//if not civ house remove from the list
	for "_i" from 0 to ((count _nearHouses)-1) do {
		_house = _nearHouses select _i;
		if !(["_i_house", str (typeof _house)] call BIS_fnc_inString) then {_nearHouses set [_i, -1]}
	};

	_nearHouses = _nearHouses -[-1];
};

_nearHouses