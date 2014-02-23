/* ----------------------------------------------------------------------------
Function: fnc_UpdateBlacklistMarker

Description:
	Update a _from and a _to Marker for each group(resize), that is used to blacklist possible waypoint positions.

Parameters:
	- Group
	- Zone
		
Optional:
	- <NONE>

Returns:
	true/false

Author:
	Spirit

---------------------------------------------------------------------------- */

private ["_group","_zone"];

_group = _this select 0;
_zone	 = _this select 1;

//Every group has a from and a to blackzone. So where they are from and where they go to are no longer used as possible waypoint position.
_from = format ["%1_from"	,_group];
_to 	= format ["%1_to"		,_group];

_from 	setMarkerSize (MCC_GAIA_BLACKLIST_SIZE select (parseNumber _zone ) );
_to 		setMarkerSize (MCC_GAIA_BLACKLIST_SIZE select (parseNumber _zone ) );

true