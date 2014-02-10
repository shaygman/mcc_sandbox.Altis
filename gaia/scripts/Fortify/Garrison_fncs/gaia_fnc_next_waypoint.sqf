private ["_group","_nextWaypointNumber"];
_unit = _this select 0;
_varName = _this select 1;
_storedGroup = _unit getVariable [_varName,grpNull];
_group = if (isNull _storedGroup) then {group _unit} else {_storedGroup};

_stuffToIgnore = ["TALK","SCRIPTED"];
//player sideChat (str(_group));

_waypoint = [_group,(currentWaypoint _group)];

_type = waypointType [_group,(currentWaypoint _group)];

_nextWaypointNumber = if (_type in _stuffToIgnore) then {(currentWaypoint _group) + 1} else {(currentWaypoint _group)};

_group setCurrentWaypoint [_group,_nextWaypointNumber];