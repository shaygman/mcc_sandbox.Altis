/* ----------------------------------------------------------------------------
Function: fnc_CreateBlacklistMarker

Description:
	Create a _from and a _to Marker for each group, that is used to blacklist possible waypoint positions.

Parameters:
	- Group
		
Optional:
	- <NONE>

Returns:
	true/false

Author:
	Spirit

---------------------------------------------------------------------------- */

private ["_group","_zone","_shape","_mshape"];

_group = _this select 0;
_zone	 = _this select 1;

//Every group has a from and a to blackzone. So where they are from and where they go to are no longer used as possible waypoint position.
_from = format ["%1_from"	,_group];
_to 	= format ["%1_to"		,_group];

//Awesome not have the getmarkershape command
_shape = _zone call fnc_getMarkerShape;
if (_shape in ["SQUARE","RECTANGLE"]) then 
	{_mshape = "RECTANGLE"}
else
	{_mshape = "ELLIPSE"};

_from_marker = createMarker [_from, (position (leader _group))];
if !(MCC_GAIA_DEBUG) then {_from_marker setMarkerAlpha 0; };

_from_marker setMarkerShape _mshape;
_from_marker setMarkerSize (MCC_GAIA_BLACKLIST_SIZE select (parseNumber _zone ) );

_to_marker   = createMarker [_to, (position (leader _group))];
if !(MCC_GAIA_DEBUG) then {_to_marker setMarkerAlpha 0; };
_to_marker setMarkerShape _mshape;
_to_marker setMarkerSize (MCC_GAIA_BLACKLIST_SIZE select (parseNumber _zone ) );
_to_marker setMarkerColor "ColorGreen";

true