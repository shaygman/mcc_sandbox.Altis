/* ----------------------------------------------------------------------------
Function: fnc_AddGroupToGAIA

Description:
	This function sets the group under GAIA control for the given side and the given intend.

Parameters:
	- Group
	_ zone
	_ intend 
	

Returns:
	true

Author:
	Spirit, 7-1-2014

---------------------------------------------------------------------------- */

private ["_group","_zone","_intend"];

_group 		= _this select 0;
_zone 		= _this select 1;
_intend		= _this select 2;




_group setVariable ["GAIA_ZONE_INTEND",[_zone,_intend], false];


true;