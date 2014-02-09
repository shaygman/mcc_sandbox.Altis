/* ----------------------------------------------------------------------------
Function: fnc_GetGroupAssets

Description:
	A function to get the Initial and the current assets of the group (known!)
	As the group might loose number harsh, we just take a timestamp to judge.

Parameters:
	- Group 
	

Returns:
	[_InitAsset,_CurrAsset]

Author:
	Spirit, 7-1-2014

---------------------------------------------------------------------------- */

private ["_group"];

_group 		= _this select 0;

_InitAsset = _group getVariable "InitialAssets";
_CurrAsset = _group getVariable "CurrentAssets";

[_InitAsset,_CurrAsset]
