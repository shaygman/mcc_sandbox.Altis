//==================================================================MCC_fnc_garrisonBehavior=====================================================================================
//Make garrison units patroling from house to house
// Example: [_group, static] spawn MCC_fnc_garrisonBehavior;
// _group = object. unit
//static = boolean. true if it should be static false if not
//===========================================================================================================================================================================
#define MAX_WP 4

private ["_group","_radius","_nearHouses","_building","_wp","_pos","_leader"];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;
_radius = [_this, 1, 100, [100]] call BIS_fnc_param;

if (isnull _group) exitWith {};

_leader = leader _group;
if (!alive _leader) exitWith {};

//Find nearest houses
_nearHouses = [getpos _leader,_radius] call MCC_fnc_findCivHouse;

if (isnil "_nearHouses") exitWith {};
if (count _nearHouses == 0) exitWith {};

for "_i" from 0 to MAX_WP do {
	_building = _nearHouses call bis_fnc_selectRandom;
	_pos = getPos _building;
	_wp = _group addWaypoint [_pos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointHousePosition (floor random (_building call MCC_fnc_buildingPosCount));
	_wp setWaypointTimeout [10, 30, 120];
	_wp waypointAttachObject _building;
};
_wp = _group addWaypoint [_pos,(count waypoints _group)];
_wp setWaypointType "Cycle";