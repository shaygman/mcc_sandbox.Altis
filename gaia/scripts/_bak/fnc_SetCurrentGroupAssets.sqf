/* ----------------------------------------------------------------------------
Function: fnc_SetCurrentGroupAssets

Description:
	A function to save the stuff we currently have AFTER we got destroyed, raped, etc
	It is saved to a group variable CurrentAssets.

Parameters:
	- Group 
	

Returns:
	true

Author:
	Spirit, 7-1-2014

---------------------------------------------------------------------------- */

private ["_group"];

_group 		= _this select 0;

_group setVariable ["CurrentAssets", ([_group] call fnc_countgroup), false];

true;