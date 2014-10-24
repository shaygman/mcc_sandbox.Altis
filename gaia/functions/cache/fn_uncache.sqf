/*
    Description:
    Uncache group close to player.
    Can only be executed by server.

    Parameter(s):
    _this GROUP - Group to be uncached

    Returns:
    nil
*/

#define AI_SKILLTYPES ["TARGET", "AUTOTARGET", "MOVE", "ANIM", "FSM"]

if (!isServer) exitWith {};

{
    private ["_unit"];
    _unit = _x;
    if (_unit != leader _this && !("Driver" in assignedVehicleRole _unit)) then
    {
        if (vehicle _unit == _unit) then
        {
            private ["_formationPosition"];
            _formationPosition = formationPosition _unit;
            _unit setPos [_formationPosition select 0, _formationPosition select 1];
        };

        _unit enableSimulation true;
        _unit allowDamage true;

        {
            _unit enableAI _x;
        } forEach AI_SKILLTYPES;
    };
} forEach units _this;

_this setVariable ["GAIA_CACHED_STAGE_1", false, false];
