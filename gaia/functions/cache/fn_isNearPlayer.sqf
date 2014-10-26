/*
    Description:
    Tests if given position is at least given distance away from any player.

    Parameter(s):
    #0 POSITION - Position to be checked
    #1 NUMBER - Distance to be considered near player

    Returns:
    BOOL - true if position is less than distance away from any player, false otherwise.
*/

private ["_ent", "_distance", "_pos", "_players"];

_pos = [_this, 0] call BIS_fnc_param;
_distance = [_this, 1] call BIS_fnc_param;

// Create a list of all players
_players = [];

if ((count playableUnits) == 0) then
{
    _players = [player];
}
else
{
    {
        if (isPlayer _x) then {_players pushBack _x};
    } forEach playableUnits;
};

// Check whether a player is in the given distance - return true if yes
if (({_x distance _pos < _distance} count _players) > 0) exitWith {true};
false
