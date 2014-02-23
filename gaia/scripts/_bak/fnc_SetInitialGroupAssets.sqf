/* ----------------------------------------------------------------------------
Function: fnc_SetInitialGroupAssets

Description:
	A function to save the stuff we initialy got (before we got destroyed, raped, etc)
	It is saved to a group variable InitialAssets.

Parameters:
	- Group 
	

Returns:
	true

Author:
	Spirit, 7-1-2014

---------------------------------------------------------------------------- */

private ["_group"];

_group 		= _this select 0;

_group setVariable ["InitialAssets", ([_group] call fnc_countgroup), false];

true;
