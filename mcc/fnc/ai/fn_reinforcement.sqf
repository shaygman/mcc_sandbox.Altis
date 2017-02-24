//==================================================================MCC_fnc_reinforcement===============================================================================================
//Contorol the paratroop reinforcement spawn
// Example:[_endPos,_side,_size,_zoneMarker,_faction,_startPosDir] spawn MCC_fnc_reinforcement;
// <IN>
//	_endPos:					Array- position.
//	_side:					String or side, side to call "West","East","Resistance"
//	_size:					Integer, 	0 -"small
//								1 - medium
//								2 - large
//	_zoneMarker				String, Zone number the reinforcement's cargo will patrol that zone.
//	_faction					String, Faction name.
//	_startPosDir				Array, spawn and de-spawn location for the reinforcement.
//===========================================================================================================================================================================
private ["_unitsArray","_endPos","_side","_size","_zoneMarker","_faction","_startPosDir","_vehiclesArray","_groupVehicles","_limit",
         "_counter","_vehicleClass","_nearRoads","_vehicle","_vehiclesTypesArray","_cargoyGroupArray"];
_endPos 				= _this select 0;
_side					= _this select 1;
_size 					=  if (TypeName  (_this select 2) == "STRING") then {call compile (_this select 2)} else {(_this select 2)};
_zoneMarker 			=  if (TypeName  (_this select 3) == "STRING") then {(_this select 3)} else {str (_this select 3)};
_faction				= _this select 4;
_startPosDir			= _this select 5;

if (TypeName _side == "STRING") then
{
	switch (toUpper _side) do
	{
		case "WEST": {_side = west};
		case "EAST": {_side = east};
		case "GUER": {_side = resistance};
		case "CIV": {_side = civilian};
	};
};

_unitsArray 	= [_faction,"soldier","men",false] call MCC_fnc_makeUnitsArray;
if (count _unitsArray < 4) then {
	_unitsArray = [_faction,"soldier","",false] call MCC_fnc_makeUnitsArray;
};

if ( (count _unitsArray) == 0 ) exitWith { diag_log format ["MCC Warning: no suitable reinforcement group found for %1", _this]; systemchat format ["Error: no suitable reinforcement group for this Faction"]; };

_vehiclesTypesArray 	= [_faction,"carx","car"] call MCC_fnc_makeUnitsArray;

if(count _vehiclesTypesArray < 2) then {
	_vehiclesTypesArray = [_faction,"carx"] call MCC_fnc_makeUnitsArray;
};

if ( (count _vehiclesTypesArray) == 0 ) exitWith { diag_log format ["MCC Warning: no suitable reinforcement group found for %1", _this]; systemchat format ["Error: no suitable reinforcement group for this Faction"]; };

//Find a road
_nearRoads = ([_startPosDir,500] call MCC_fnc_nearestRoad) select 0;

if ( isnull _nearRoads) exitWith { diag_log format ["MCC Warning: no suitable reinforcement place found for %1", _this]; systemchat format ["Error: no suitable reinforcement place found"]; };
_startPosDir = getposAtl _nearRoads;

//Let's build the group and vehicles
_groupVehicles = creategroup _side;

_size = _size - 9;
_limit = [2,3,4] select _size;
_counter = 1;
_vehiclesArray = [];

while {_counter <=_limit} do
{
	_vehicleClass = (_vehiclesTypesArray call BIS_fnc_selectRandom) select 0;

	if ((getNumber (configfile >> "CfgVehicles" >> _vehicleClass >> "transportSoldier") > 2) || (count (configfile >> "CfgVehicles" >> _vehicleClass >> "Turrets") >0)) then
	{
		_isFlat = _startPosDir findEmptyPosition [10, 100];
		if (count _isFlat == 0) then {_isFlat = _startPosDir};
		_vehicle = [_isFlat , ([_isFlat, _endPos] call BIS_fnc_dirTo), _vehicleClass, _groupVehicles] call BIS_fnc_spawnVehicle;
		_vehiclesArray set [count _vehiclesArray, (_vehicle select 0)];
		_counter = _counter + 1;

		//Curator
		{_x addCuratorEditableObjects [[(_vehicle select 0)],true]} forEach allCurators;
	};
};
sleep 0.5;
_groupVehicles setFormation "COLUMN";

_cargoyGroupArray = [];
{
	[_x]  call MCC_fnc_populateVehicle;
} foreach _vehiclesArray;

sleep 1;

//Find a road near destination
_nearRoads = ([_endPos,500] call MCC_fnc_nearestRoad) call BIS_fnc_selectRandom;

//Add WP
private ["_wpPos","_car1","_car","_transportCars","_transportCarsGroup"];
if (isnull  _nearRoads) then
{
	_wpPos = _endPos;
}
else
{
	_wpPos = getposAtl _nearRoads;
};

_wp = _groupVehicles addWaypoint [_wpPos, 30];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 500;
_wp setwaypointCombatMode "YELLOW";
_wp setWaypointFormation "COLUMN";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "FULL";

_car1 = vehicle leader _groupVehicles;
waitUntil {sleep 5; (!(canMove _car1) || (currentCommand _car1 == "") || (_car1 distance _wpPos) < 250); };

//Stop WP
[2,_wpPos,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[_groupVehicles]] call MCC_fnc_manageWp;
sleep 3;

private ["_transportCars","_transportCarsGroup"];
_transportCars = [];
_transportCarsGroup = createGroup _side;

{
	if !( isNil "_x" ) then
	{
		_car = _x;

		//If transport car
		if ((count (configfile >> "CfgVehicles" >> typeOF _car >> "Turrets")  == 0)) then {
			_transportCars pushBack _car;
			[_car] joinSilent _transportCarsGroup;
		};

		waitUntil { (currentCommand _car == "") };
		{
			if ( !( (_x == driver _car) || (_x == gunner _car) || (_x == commander _car) ) && ( alive _x ) ) then
			{
				if !(group _x in _cargoyGroupArray) then {_cargoyGroupArray set [count _cargoyGroupArray, group _x]};
				unassignVehicle _x;
				_x action ["getOut", _car];
				sleep 0.6;
			};
		} foreach crew _car;

	};
} foreach _vehiclesArray;

_vehiclesArray = _vehiclesArray - _transportCars;

{
	_x setVariable ["GAIA_ZONE_INTEND",[_zoneMarker,"MOVE"], true];
} foreach _cargoyGroupArray;

sleep 10;

_groupVehicles setVariable ["GAIA_ZONE_INTEND",[_zoneMarker,"MOVE"], true];
_transportCarsGroup setVariable ["GAIA_ZONE_INTEND",[_zoneMarker,"MOVE"], true];