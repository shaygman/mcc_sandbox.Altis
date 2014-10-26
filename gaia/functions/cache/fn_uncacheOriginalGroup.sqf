/*
    Description:
    Uncache Group used with GAIA Respawn.
    Can only be executed by server.

    Parameter(s):
    #0 ARRAY - Group Data
    #1 NUMBER - Number of Respawn tickets left
    #2 BOOL - Cache group
    #3 ARRAY - GAIA Zone Intend

    Returns:
    nil
*/

if (!isServer) exitWith {};

_groupData = [_this, 0] call BIS_fnc_param select 0;
_respawn = [_this, 1, -1, [0]] call BIS_fnc_param;
_cache = [_this, 2, false, [true]] call BIS_fnc_param;
_zoneIntend = [_this, 3, [], [[]]] call BIS_fnc_param;

if (_respawn >= 0) then
{
	_group = createGroup (_groupData select 2);
	if (isNull _group) exitWith {};
	_group setVariable ["GAIA_zone_intend", _zoneIntend, true];
	_group setVariable ["mcc_gaia_cache", _cache];
	_group setVariable ["MCC_GAIA_RESPAWN", _respawn - 1];

	{
		private ["_vehicle"];
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

		_group setFormDir (_vehicle select 5);
	} forEach (_groupData select 0);

	{
		private ["_createdUnit"];
		_createdUnit = _group createUnit [_x select 0, _x select 1, [], 0, "CAN_COLLIDE"];
		_createdUnit setDamage (_x select 2);
		_createdUnit setSkill (_x select 3);
		_createdUnit setRank (_x select 4);
		_createdUnit setPosASL (_x select 1);
		_createdUnit setDir (_x select 5);
	} forEach (_groupData select 1);

	_group setSpeedMode (_groupData select 6);
	_group setFormation (_groupData select 7);
	_group setBehaviour (_groupData select 4);
	_group setCombatMode (_groupData select 5);

	while {(count waypoints _group) > 0} do
	{
		deleteWaypoint ((waypoints _group) select 0);
	};

	if (count (_groupData select 8) > 1) then
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
};
