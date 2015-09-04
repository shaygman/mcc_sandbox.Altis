//==================================================================MCC_fnc_getActiveSides=======================================================================================
// Return an array of the active sides in a role selection game
// Example:[] call MCC_fnc_getActiveSides;
// IN		<nothing>
//Out		<Sides with start location>
//===============================================================================================================================================================================
private ["_activeSides"];

//Find the active sides
_activeSides = [];

{
	if !(isNil format["MCC_START_%1",_x]) then {_activeSides set [count _activeSides, _x]}
} foreach [west, east, resistance];

_activeSides