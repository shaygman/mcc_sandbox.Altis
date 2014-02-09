/* ----------------------------------------------------------------------------
Function: fnc_GetZoneIntendFromGroup

Description:
	Gets the Zone and the Intend from the group as given. (by the mission maker).

Parameters:
	- Group

Returns:
 [ Zone, Intend]

Author:
	Spirit, 17-1-2014

---------------------------------------------------------------------------- */

private ["_group","_zone_intend"];

_group 				= _this select 0;

_zone_intend  = [];

_zone_intend	= _group getVariable ["GAIA_ZONE_INTEND",[]];

_zone_intend


