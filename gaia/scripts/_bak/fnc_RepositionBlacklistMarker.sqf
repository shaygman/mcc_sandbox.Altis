/* ----------------------------------------------------------------------------
Function: fnc_RepositionBlacklistMarker

Description:
	Reposition the _from and a _to Marker for each group (usualy at the end of a waypoint).
	That is used to blacklist possible waypoint positions.

Parameters:
	- Group
	- Zone
	- Position TO (where are we going to)
		
Optional:
	- <NONE>

Returns:
	true/false

Author:
	Spirit

---------------------------------------------------------------------------- */

private ["_group","_zone","_position_to","_position_from"];

_group 				= _this select 0;
_zone	 				= _this select 1;
_position_to 	= _this select 2;

//Every group has a from and a to blackzone. So where they are from and where they go to are no longer used as possible waypoint position.
_from = format ["%1_from"	,_group];
_to 	= format ["%1_to"		,_group];

_position_from = getmarkerpos _to;

_from setmarkerpos _position_from;
_to		setmarkerpos _position_to;

true