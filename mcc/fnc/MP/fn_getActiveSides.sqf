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
	if (count ([_x] call BIS_fnc_getRespawnPositions) > 0) then {
		_activeSides pushBack _x;
	};
} foreach [west, east, resistance];

_activeSides