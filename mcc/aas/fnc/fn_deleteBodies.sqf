/*=================================================================MCC_fnc_deleteBodies==============================================================================
 Loop for deleteing dead bodies
  IN <>
    _this select 0: INTEGER waiting interval

OUT <>
    Nothing

Example:
[60] call MCC_fnc_deleteBodies;

*/

params ["_waitTime"];

_waitTime spawn {
    private ["_timeOfDeath"];
    while {true} do {
        sleep 10;
        {
            _timeOfDeath = _x getVariable "MCC_timeOfDeath";
            if (isNil "_timeOfDeath") then {
                _x setVariable ["MCC_timeOfDeath",time];
                } else {
                    if ((time - _timeOfDeath) > _this) then {
                        deleteVehicle _x;
                    }
                };
        } forEach AllDead;
    };
};