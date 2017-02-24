/* ======================================================MCC_fnc_spawnCratesInHouses==============================================================================
	Spawn lootable crates in houeses

	<IN>
		Nothing

	<OUT>
		Nothing
==============================================================================================================================================================*/
if (!isServer) exitWith {};
private ["_index","_buildings","_availablePos","_buildingPos"];
params [
		["_pos",[0,0,0],[[]]],
		["_radius",300,[0]],
		["_density",1,[0]],
		["_debug",false,[false]]
	];


if (_pos isEqualTo [0,0,0]) exitWith {};

_buildings = _pos nearObjects ["House",_radius];
_index = missionNamespace getVariable ["MCC_itemMarker_index",0];

{
	_availablePos = [];

	for "_i" from 0 to 20 do {
	    _buildingPos = _x buildingpos _i;
	    if (str _buildingPos == "[0,0,0]") exitwith {};
	    _availablePos pushBack _buildingPos;
	};

	{
		if (random 100 < _density) then {
			_object = (["Land_Sack_F","Land_MetalBarrel_F","Land_MetalCase_01_small_F","Land_PlasticCase_01_small_F"] call BIS_fnc_selectRandom) createVehicle _x;
			_object setPos _x;
			_object setDir (random 360);
			_index = _index +1;

			//Debug
			if (_debug) then {
				_eib_marker = createMarker [format ["itemMarker_%1", _index],_x];
				_eib_marker setMarkerType "mil_dot";
				_eib_marker setMarkerColor "ColorRed";
			};
		};
	} forEach _availablePos;
} foreach _buildings;

missionNamespace setVariable ["MCC_itemMarker_index",_index];
//Debug
if (_debug) then {
	systemChat format ["Total of %1 items created", _index];
};


/*
{
	_temploc = [_mapCenter,5000,_x] call MCC_fnc_MWbuildLocations;
	{
		_buildings = (getpos (_x select 0)) nearObjects ["House",500];

	    {
	    	_availablePos = [];

			for "_i" from 0 to 20 do {
			    _buildingPos = _x buildingpos _i;
			    if (str _buildingPos == "[0,0,0]") exitwith {};
			    _availablePos pushBack _buildingPos;
			};

			{
				if (random 100 < 3) then {
					_object = (["Land_Sack_F","Land_MetalBarrel_F","Land_MetalCase_01_small_F","Land_PlasticCase_01_small_F"] call BIS_fnc_selectRandom) createVehicle _x;
					_object setPos _x;
					_object setDir (random 360);
				};
			} forEach _availablePos;
	    } foreach _buildings;
	} forEach _temploc;
} forEach ["city","mil","nature"];
*/