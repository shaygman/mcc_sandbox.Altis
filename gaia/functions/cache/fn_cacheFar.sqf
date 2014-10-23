/*
    Description:
    Cache group far away from players.
    Can only be executed by server.

    Parameter(s):
    #0 GROUP - Group to be cached.

    Returns:
    nil
*/

if (!isServer) exitWith {};

private ["_group", "_units", "_vehicles", "_groupVehicles", "_unmountedUnits", "_waypoints"];

_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;
if (isNull _group) exitWith {};

_units = units _group;
_vehicles = [_group] call BIS_fnc_groupVehicles;

_groupVehicles = [];

{
    private ["_vehicle", "_crew"];
    _vehicle = _x;
    _crew = [];

    {
        private ["_unit"];
        _unit = _x;

        if (assignedVehicle _unit == _vehicle && alive _unit) then
        {
            _crew pushBack [typeOf _unit, getPos _unit, damage _unit, skill _unit, rank _unit, assignedVehicleRole _unit, getDir _unit];
            _units = _units - [_unit];
        };
    } forEach _units;

    _groupVehicles pushBack [typeOf _vehicle, getPos _vehicle, damage _vehicle, fuel _vehicle, _crew, getDir _vehicle];
} forEach _vehicles;

_unmountedUnits = [];

{
    if (alive _x) then
    {
        _unmountedUnits pushBack [typeOf _x, visiblePositionASL _x, damage _x, skill _x, rank _x, getDir _x];
    };
} forEach _units;

_waypoints = [];

if (((count waypoints _group) - currentWaypoint _group) > 0) then
{
    private ["_allWaypoints"];
    _allWaypoints = [];
    {
        if (((waypointPosition _x) distance [0, 0, 0]) > 0) then
        {
            _allWaypoints pushBack [waypointPosition _x, waypointType _x, waypointBehaviour _x, waypointSpeed _x, waypointCombatMode _x, waypointFormation _x, waypointStatements _x, waypointTimeout _x, waypointHousePosition _x];
        };
    } forEach waypoints _group;
    _waypoints = [_allWaypoints, currentWaypoint _group];
};

MCC_GAIA_CACHE_STAGE2 pushBack position leader _group;

missionNamespace setVariable [
    format ["GAIA_CACHE_%1", str position leader _group],
    [
        _groupVehicles,
        _unmountedUnits,
        side _group,
        _group getVariable ["GAIA_zone_intend", []],
        behaviour leader _group,
        combatMode _group,
        speedMode _group,
        formation _group,
        _waypoints,
        _group getVariable ["MCC_GAIA_RESPAWN", -1],
        missionNamespace getVariable [format ["GAIA_RESPAWN_%1", str _group], []]
    ]
];

{
    deleteVehicle _x;
} forEach (units _group + _vehicles);

deleteGroup _group;
