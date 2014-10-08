/* ----------------------------------------------------------------------------
Function: fnc_addWaypoint

Description:
	A function used to add a waypoint to a group.

Parameters:
	- Group 
	- Position 
	_ Zone
	_ Type

Returns:
	Waypoint

Author:
	Spirit, 7-1-2014

---------------------------------------------------------------------------- */

private ["_group","_position","_Zone","_waypoint","_ZoneBehaviour"];

_group 		= _this select 0;
_position = _this select 1;
_WPType		= _this select 2;

_Radius		= 40;


_waypoint = _group addWaypoint 						[_position, 0];
_waypoint setWaypointType 								_WPType;

if (behaviour (leader _group) != "COMBAT") then
	{_waypoint setWaypointBehaviour 				"AWARE";};
	
_waypoint setWaypointCombatMode 					"RED";
_waypoint setWaypointSpeed 								"FULL" ;
_waypoint setWaypointFormation 						"VEE" ;
_waypoint setWaypointCompletionRadius 		_Radius;
_waypoint;


