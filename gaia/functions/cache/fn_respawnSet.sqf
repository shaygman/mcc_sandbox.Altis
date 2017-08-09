/*========================================      GAIA_fnc_respawnSet     ====================================
        Sets a group respawn params

        <IN>
                0:      GROUP
                1:      INTEGER - number of respawns

        <OUT>
                NOTHING
*/

private ["_group","_respawnNumber"];

_group = param [0,grpNull,[grpNull]];
_respawnNumber = param [1,-1,[0]];

if (isNull _group) exitWith {};

if (_respawnNumber > 0) then {
     _group setVariable ["MCC_GAIA_RESPAWN",_respawnNumber,true];

     if (alive leader _group) then {
        _group setVariable ["MCC_GAIA_RESPAWN_POSITON",getpos (leader _group),true];
     };
};