//==================================================================MCC_fnc_uavDetect===============================================================================================
// detects enemy units and mark them on the map
// Example: [_uav, _time] call MCC_fnc_uavDetect;
// _uav = OBJECT
// _time = INTEGER - time until the uav got deleted
//===========================================================================================================================================================================
private ["_uav","_time","_markUnits","_varName"];
params ["_uav","_time"];

_time = time + _time;
_range = missionNamespace getVariable ["MCC_uavdetectRange",500];
_varName = format ["MCC_uavSpotted_%1", side _uav];

//Mark enemy units
while {time < _time && alive _uav && canMove _uav} do {
	_markUnits = [];

	if ((missionNamespace getVariable ["MCC_uavdetectRange",500])>0) then {
		{
			if ((_x distance2D _uav)<_range
			    && alive _x
			    && (side _x != side _uav)
			   ) then {
				_markUnits pushBack _x;
			};
		} forEach allUnits;

		missionNamespace setVariable [_varName,_markUnits];
		publicVariable _varName;
	};
	sleep 5;
};

//cleanup
missionNamespace setVariable [_varName,[]];
publicVariable _varName;

if (alive _uav) exitWith {
	{
		deleteVehicle _x
	} forEach crew _uav;

	deleteVehicle _uav;
};