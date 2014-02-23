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

//Blacklist the target position (so no other dudes go here before we arrive and for that make us useless.

	switch (side _group) do
			{
			  case WEST				: {MCC_GAIA_WPPOS_WEST = MCC_GAIA_WPPOS_WEST + [[_position,_group]];};
			  case EAST				: {MCC_GAIA_WPPOS_EAST = MCC_GAIA_WPPOS_EAST + [[_position,_group]];};
			  case independent: {MCC_GAIA_WPPOS_INDEP = MCC_GAIA_WPPOS_INDEP + [[_position,_group]];};
			};

//Do what you say you do. Go there.
_waypoint = _group addWaypoint 				[_position, 0];
_waypoint setWaypointType 						_WPType;
_waypoint setWaypointCompletionRadius _Radius;
_waypoint	setWaypointTimeout [20, 30, 25];

_waypoint;


