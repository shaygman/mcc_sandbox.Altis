/*
    Description:
    Cache group close to player.
    Can only be executed by server.

    Parameter(s):
    _this GROUP - Group to be cached.

    Returns:
    nil
*/

#define AI_SKILLTYPES ["TARGET", "AUTOTARGET", "MOVE", "ANIM", "FSM"]

if (!isServer) exitWith {};

{
    private ["_unit"];
    _unit = _x;

    if(_unit != leader _this && !("Driver" in assignedVehicleRole _unit)) then
    {
        {
            _unit disableAI _x;
        } forEach AI_SKILLTYPES;

        _unit enableSimulation false;
        _unit allowDamage false;

        if (vehicle _unit == _unit) then
        {
            private ["_pos"];
            _pos = getPosATL _unit;
            _pos set [2, -100];
            _unit setPosATL _pos;
        };
    }
    else
    {
        _unit enableSimulation true;
        _unit allowDamage true;

        {
            _unit enableAI _x;
        } forEach AI_SKILLTYPES;
    };
} forEach units _this;

_this setVariable ["GAIA_CACHED_STAGE_1", true, false];
