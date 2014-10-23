/*
    Description:
    Cache group far away from players.
    Can only be executed by server.

    Parameter(s):
    #0 ARRAY - Group Data

    Returns:
    nil
*/

if (!isServer) exitWith {};

_groupData = [_this, 0] call BIS_fnc_param;

_group = createGroup (_groupData select 2);
if (isNull _group) exitWith {};
_group  setVariable ["GAIA_zone_intend", _groupData select 3, true];
_group  setVariable ["MCC_GAIA_RESPAWN", _groupData select 9, true];

missionNamespace setVariable [format ["GAIA_RESPAWN_%1", str _group], _groupData select 10];

_group  setVariable ["mcc_gaia_cache", true, true];

{
	private ["_vehicle", "_createdVehicle"];
	_vehicle = _x;
	_createdVehicle = createVehicle [_vehicle select 0, _vehicle select 1, [], 0, "CAN_COLLIDE"];
	_createdVehicle setDamage (_vehicle select 2);
	_createdVehicle setFuel (_vehicle select 3);
	_createdVehicle setDir (_vehicle select 5);

	{
		private ["_createdUnit"];
		_createdUnit = _group createUnit [_x select 0, _x select 1, [], 0, "FORM"];
		_createdUnit setDamage (_x select 2);
		_createdUnit setSkill (_x select 3);
		_createdUnit setRank (_x select 4);


		((_x select 5) select 0) call {
			if (_this == "Driver") exitWith {_createdUnit moveInDriver _createdVehicle};
			if (_this == "Turret") exitWith {_createdUnit moveInTurret _createdVehicle};
			if (_this == "Cargo") exitWith {_createdUnit assignAsCargo _createdVehicle; _createdUnit moveInCargo _createdVehicle};
		};
	} forEach (_vehicle select 4);

	_group setFormDir (_vehicle select 4);
} forEach (_groupData select 0);

{
	private ["_createdUnit"];
	_createdUnit = _group createUnit [_x select 0, _x select 1, [], 0, "CAN_COLLIDE"];
	_createdUnit setPosASL (_x select 1);
	_createdUnit setDamage (_x select 2);
	_createdUnit setSkill (_x select 3);
	_createdUnit setRank (_x select 4);
	_createdUnit setDir (_x select 5);
} forEach (_groupData select 1);

_group setBehaviour (_groupData select 4);
_group setCombatMode (_groupData select 5);
_group setSpeedMode (_groupData select 6);
_group setFormation (_groupData select 7);

while {(count waypoints _group) > 0} do
{
	deleteWaypoint ((waypoints _group) select 0);
};

if ((count (_groupData select 8)) > 1) then
{
	{
		if (((_x select 0) distance [0, 0, 0]) > 0) then
		{
			private ["_waypoint"];
			_waypoint = _group addWaypoint [_x select 0, 0];
			_waypoint setWaypointType (_x select 1);
			_waypoint setWaypointBehaviour (_x select 2);
			_waypoint setWaypointSpeed (_x select 3);
			_waypoint setWaypointCombatMode (_x select 4);
			_waypoint setWaypointFormation (_x select 5);
			_waypoint setWaypointStatements (_x select 6);
			_waypoint setWaypointTimeout (_x select 7);
			_waypoint setWaypointHousePosition (_x select 8);
		};
	} forEach ((_groupData select 8) select 0);

	_group setCurrentWaypoint [_group, (_groupData select 8) select 1];
};
