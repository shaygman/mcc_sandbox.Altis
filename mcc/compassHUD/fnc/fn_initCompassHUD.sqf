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

uiNamespace setVariable ["MCC_HuD_compassTeamMates",_compassTeamMates];
uiNamespace setVariable ["MCC_HuD_indexCounter",10];
uiNamespace setVariable ["MCC_HuD_units",[]];


MCC_fnc_compHudEVH = {
    private ["_click","_dir","_pos","_wpPos","_index","_indexCounter","_orgDir","_iconPic","_iconColor","_iconSize","_ctrls","_units","_offset"];
    _click = 0.816 / 180;

    _indexCounter = uiNamespace getVariable ["MCC_HuD_indexCounter",10];
    _units = uiNamespace getVariable ["MCC_HuD_units",[]];

    _orgDir = ([player, positionCameraToWorld [0,0,100]] call BIS_fnc_dirTo);

    _offset = if (_orgDir > 180) then {0.6083} else {-1.023};
    _pos = _offset + (-_orgDir * _click);

    ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 3) ctrlSetPosition [_pos, 0];
    ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 3) ctrlCommit 0;

    //Wp marker
    _wpPos = waypointPosition [group player, currentWaypoint group player];
    if (str _wpPos != "[0,0,0]") then {
        _dir = _orgDir - ([positionCameraToWorld [0,0,0], _wpPos] call BIS_fnc_dirTo);
        if (_dir < -180) then {_dir = _dir + 360;};
        _offset = if (_dir > 180) then {1.847} else {0.216};
        _pos = _offset + (-_dir * _click);

        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlShow true;
        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlSetPosition [_pos, 0.07];
        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlCommit 0;
    } else {
        ((uiNamespace getVariable "MCC_hud_compass") displayCtrl 4) ctrlShow false;
    };

    //Group markers
    if (uiNamespace getVariable ["MCC_HuD_compassTeamMates",true]) then {
        {
            if (_x != player) then {
                _index = _x getVariable ["MCC_hud_compass_unitMarker",-1];
                _iconSize = (1-((player distance _x)/300 min 1))*0.04;

                if (_index == -1) then {
                    //Create ctrl
                    _indexCounter = _indexCounter + 1;
                    (uiNamespace getVariable "MCC_hud_compass") ctrlCreate ["RscPicture", _indexCounter,((uiNamespace getVariable "MCC_hud_compass") displayCtrl 1)];
                    _x setVariable ["MCC_hud_compass_unitMarker",_indexCounter];
                    _units pushBack [_indexCounter,_x];
                    uiNamespace setVariable ["MCC_HuD_indexCounter",_indexCounter];
                    uiNamespace setVariable ["MCC_HuD_units",_units];
                };

                _index = _x getVariable ["MCC_hud_compass_unitMarker",-1];

                //Get icon
                switch (true) do {
                    case (_x == leader player): {
                        _iconPic = "iconManLeader";
                    };
                    case (((getNumber(configFile >> "CfgVehicles" >> typeOf _x >> "attendant")) == 1) || (toLower(_x getvariable ["CP_role",""]) == "corpsman")): {
                        _iconPic = "iconManMedic";
                    };
                    default {
                        _iconPic = getText((configfile >> "CfgVehicles" >> typeof _x >> "icon"));
                    };
                };

                _iconColor = switch (assignedTeam _x) do {
                                case ("RED"): {[0.455,0,0,1]};
                                case ("GREEN"): {[0,0.455,0,1]};
                                case ("BLUE"): {[0,0,0.455,1]};
                                case ("YELLOW"): {[0.455,0.455,0,1]};
                                default {[1,1,1,1]};
                            };

                ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlSetText (getText(configfile >> "CfgVehicleIcons">>_iconPic));
                ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlSetTextColor _iconColor;


                _dir = _orgDir - ([positionCameraToWorld [0,0,0], position _x] call BIS_fnc_dirTo);
                if (_dir < -180) then {_dir = _dir + 360;};
                _offset = if (_dir > 180) then {1.847} else {0.216};
                _pos = _offset + (-_dir * _click);

                ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlShow true;
                ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlSetPosition [_pos, 0,_iconSize,_iconSize * (4/3)];
                ((uiNamespace getVariable "MCC_hud_compass") displayCtrl _index) ctrlCommit 0;
            };
       } forEach (units player);

       //Get rid of non available units
       {
            _unit = _x select 1;
            if (!(_unit in units player) || isNull _unit) then {
                ((uiNamespace getVariable "MCC_hud_compass") displayCtrl (_x select 0)) ctrlShow false;
                ctrlDelete ((uiNamespace getVariable "MCC_hud_compass") displayCtrl (_x select 0));
            };
       } forEach _units;
    };
};

["MCC_fnc_compHudEVH", "onEachFrame", "MCC_fnc_compHudEVH"] call BIS_fnc_addStackedEventHandler;
