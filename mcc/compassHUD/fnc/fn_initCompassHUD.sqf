/*=================================================================MCC_fnc_initCompassHUD================================================================================
  Init HUD Compass
  IN <>
    Nothing
*/

//Not a client
private ["_compassTeamMates"];
if (!hasInterface || isDedicated) exitWith {};

waituntil {!(IsNull (findDisplay 46))};
sleep 1;
if (missionNamespace getVariable ["MCC_initCompassHUD",false]) exitWith {};

//Init
missionNamespace setVariable ["MCC_initCompassHUD",true];
(["MCC_hud_compass"] call BIS_fnc_rscLayer) cutRsc ["MCC_hud_compass", "PLAIN"];

_compassTeamMates = param [0,true,[true]];
_compassTeamMates spawn {
    disableSerialization;
    private ["_click","_dir","_pos","_wpPos","_index","_indexCounter","_orgDir","_iconPic","_iconColor","_iconSize"];
    _click = 0.816 / 180;
    _indexCounter = 10;
    while {(missionNamespace getVariable ["MCC_initCompassHUD",false])} do {
        _orgDir = ([player, positionCameraToWorld [0,0,100]] call BIS_fnc_dirTo);

        _offset = if (_orgDir > 180) then {0.6083} else {-1.023};
        _pos = _offset + (-_orgDir * _click);

        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 3) ctrlSetPosition [_pos, 0];
        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 3) ctrlCommit 0.05;

        //Wp marker
        _wpPos = waypointPosition [group player, currentWaypoint group player];
        if (str _wpPos != "[0,0,0]") then {
            _dir = _orgDir - ([positionCameraToWorld [0,0,0], _wpPos] call BIS_fnc_dirTo);
            if (_dir < -180) then {_dir = _dir + 360;};
            _offset = if (_dir > 180) then {1.847} else {0.216};
            _pos = _offset + (-_dir * _click);

            ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlShow true;
            ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlSetPosition [_pos, 0.07];
            ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlCommit 0.05;
        } else {
            ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlShow false;
        };

        //Group markers
        if (_this) then {
            {
                if (_x != player) then {
                    _index = _x getVariable ["MCC_hud_compass_unitMarker",-1];
                    _iconSize = (1-((player distance _x)/300 min 1))*0.04;

                    if (_index == -1) then {
                        //Create ctrl
                        _indexCounter = _indexCounter + 1;
                        (uiNamespace getVariable "MCC_hud_compass") ctrlCreate ["RscPicture", _indexCounter,((uiNamespace getVariable "MCC_hud_compass") displayCtrl 1)];
                        _x setVariable ["MCC_hud_compass_unitMarker",_indexCounter];
                        _index = _x getVariable ["MCC_hud_compass_unitMarker",-1];

                        //Get icon
                        switch (true) do {
                            case (_x == leader player): {
                                _iconPic = "iconManLeader";
                                _iconColor = [0.455,0,0,1];
                            };
                            case (((getNumber(configFile >> "CfgVehicles" >> typeOf _x >> "attendant")) == 1) || (toLower(_x getvariable ["CP_role",""]) == "corpsman")): {
                                _iconPic = "iconManMedic";
                                _iconColor = [0,0,0.455,1];
                            };
                            default {
                                _iconPic = getText((configfile >> "CfgVehicles" >> typeof _x >> "icon"));
                                _iconColor = [0,0.455,0,1];
                            };
                        };

                        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlSetText (getText(configfile >> "CfgVehicleIcons">>_iconPic));
                        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlSetTextColor _iconColor;
                    };

                    _dir = _orgDir - ([positionCameraToWorld [0,0,0], position _x] call BIS_fnc_dirTo);
                    if (_dir < -180) then {_dir = _dir + 360;};
                    _offset = if (_dir > 180) then {1.847} else {0.216};
                    _pos = _offset + (-_dir * _click);

                    ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlShow true;
                    ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlSetPosition [_pos, 0,_iconSize,_iconSize * (4/3)];
                    ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlCommit 0.05;
                };
           } forEach (units player);
        };

        sleep 0.05;

    };
};