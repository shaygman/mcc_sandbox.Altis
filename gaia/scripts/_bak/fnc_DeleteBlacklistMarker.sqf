/* ----------------------------------------------------------------------------
Function: fnc_DeleteBlacklistMarker

Description:
	Delete a _from and a _to Marker for each group(resize), that is used to blacklist possible waypoint positions.

Parameters:
	- Group
	
		
Optional:
	- <NONE>

Returns:
	true/false

Author:
	Spirit

---------------------------------------------------------------------------- */

private ["_group"];

_group = _this select 0;

//Every group has a from and a to blackzone. So where they are from and where they go to are no longer used as possible waypoint position.
_from = format ["%1_from"	,_group];
_to 	= format ["%1_to"		,_group];

deleteMarker _from;
deleteMarker _to;


true