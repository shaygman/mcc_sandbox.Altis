/*
    Description:
    Synchronize leader of Group to known state.

    Parameter(s):
    _this GROUP - Group to be synchronized

    Returns:
    nil
*/

#define AI_SKILLTYPES ["TARGET", "AUTOTARGET", "MOVE", "ANIM", "FSM"]

if (isNull _this) exitWith {};

if (!(simulationEnabled leader _this)) then
{
    private ["_leader"];
    _leader = leader _this;

    _leader enableSimulation true;
    _leader allowDamage true;

    {
        _leader enableAI _x;
    } forEach AI_SKILLTYPES;
};
