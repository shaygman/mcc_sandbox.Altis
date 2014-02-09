/* ----------------------------------------------------------------------------
Function: fnc_TimeOut

Description:
	Used to make FSM code wait.

Parameters:
	- _wait
	

Returns:
	true

Author:
	Spirit, 13-1-2014

---------------------------------------------------------------------------- */

private ["_wait"];

_wait 		= _this select 0;
sleep _wait;

true
