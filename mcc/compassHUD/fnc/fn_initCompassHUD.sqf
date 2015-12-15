/*=================================================================MCC_fnc_initCompassHUD================================================================================
  Init HUD Compass
  IN <>
    Nothing
*/

//Not a client
if (!hasInterface || isDedicated || (missionNamespace getVariable ["MCC_initCompassHUD",false])) exitWith {};

//Init
missionNamespace setVariable ["MCC_initCompassHUD",true];
(["MCC_hud_compass"] call BIS_fnc_rscLayer) cutRsc ["MCC_hud_compass", "PLAIN"];


0 spawn {
    private ["_click","_dir","_pos"];
    _click = 0.816 / 180;
    while {(missionNamespace getVariable ["MCC_initCompassHUD",false])} do {
        _dir = ([player, positionCameraToWorld [0,0,100]] call BIS_fnc_dirTo);

        _offset = if (_dir > 180) then {0.6083} else {-1.023};
        _pos = _offset + (-_dir * _click);

        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 3) ctrlSetPosition [_pos, 0];
        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 3) ctrlCommit 0.05;

        /*
        _dir = _dir - ([positionCameraToWorld [0,0,0], [5000,5000,0]] call BIS_fnc_dirTo);
        if (_dir < -180) then {_dir = _dir + 360;};
        _offset = if (_dir > 180) then {1.847} else {0.216};
        _pos = _offset + (-_dir * _click);

        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlSetPosition [_pos, (2.5/(2048/64)*(4/3)) - (0.023 * (4/3)) + 0.01];
        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlCommit 0.05;
        */
        sleep 0.05;

    };
};