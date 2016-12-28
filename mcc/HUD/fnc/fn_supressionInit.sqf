/*=================================================================MCC_fnc_supressionInit================================================================================
  Init supression effects
  IN <>
    Nothing
*/

//Not a client
private ["_cPPEffect","_bPPEffect"];
if (!hasInterface || isDedicated) exitWith {};

waituntil {!(IsNull (findDisplay 46))};

//Init
if (missionNamespace getVariable ["MCC_initSupression",false]) exitWith {};
missionNamespace setVariable ["MCC_initSupression",true];

//Add onEachFram EH
["MCC_initSupression", "onEachFrame", {
    private ["_pDistance"];

    //in vehicle and not turned out
    if (vehicle player != player && !(isTurnedOut player)) exitWith {};
    _array = (missionNamespace getVariable ["MCC_supressionHitPos",[]]);

    {
        _x params ["_projectile","_distance","_unit"];
        _pDistance = player distance _projectile;
        _dir = [player,_unit] call BIS_fnc_relativeDirTo;
        if (_pDistance <= _distance) then {
           [(1 -(_pDistance/_distance)) max 0.3,_dir] spawn MCC_fnc_supressionEffects;
            _array set [_foreachindex,-1];
        } else {
            if (isNull _projectile) then {
               _array set [_foreachindex,-1];
            };
        };
    } foreach _array;

    _array = _array - [-1];
    missionNamespace setVariable ["MCC_supressionHitPos",_array];
}] call BIS_fnc_addStackedEventHandler;

//Init fired EH on each unit
0 spawn {
    while {true} do {
        {
            if !((vehicle _x) getVariable ["MCC_initSupression",false]) then {
                (vehicle _x) addEventHandler ["fired",{_this call MCC_fnc_supressionFiredEH}];
                (vehicle _x) setVariable ["MCC_initSupression",true];
            };
        } forEach allUnits;
        sleep 1;
    };
};