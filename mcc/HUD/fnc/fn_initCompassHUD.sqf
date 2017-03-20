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

if (isnull (uiNamespace getVariable ["MCC_hud",objNull])) then {
    (["MCC_hud"] call BIS_fnc_rscLayer) cutRsc ["MCC_hud", "PLAIN"];
};

//Open Compass
((uiNameSpace getVariable "MCC_hud") displayCtrl 10) ctrlSetPosition  [(0.27), (safeZoneY + safeZoneH - (2.5/(2048/64)*(4/3))), (0.46), (2.5/(2048/64)*(4/3))];
((uiNameSpace getVariable "MCC_hud") displayCtrl 10) ctrlCommit 0.2;

_compassTeamMates = param [0,true,[true]];

uiNamespace setVariable ["MCC_HuD_compassTeamMates",_compassTeamMates];
uiNamespace setVariable ["MCC_HuD_indexCounter",10];
uiNamespace setVariable ["MCC_HuD_units",[]];


MCC_fnc_compHudEVH = {
    private ["_click","_dir","_pos","_wpPos","_index","_orgDir","_iconPic","_iconColor","_iconSize","_ctrls","_offset","_dialog"];
    _click = 0.816 / 180;

    _orgDir = ([player, positionCameraToWorld [0,0,100]] call BIS_fnc_dirTo);

    _offset = if (_orgDir > 180) then {0.6083} else {-1.023};
    _pos = _offset + (-_orgDir * _click);
    _dialog = (uiNamespace getVariable "MCC_hud");

    (_dialog displayCtrl 13) ctrlSetPosition [_pos, 0];
    (_dialog displayCtrl 13) ctrlCommit 0;

    //Wp marker
    _wpPos = waypointPosition [group player, currentWaypoint group player];
    if (str _wpPos != "[0,0,0]") then {
        _dir = _orgDir - ([positionCameraToWorld [0,0,0], _wpPos] call BIS_fnc_dirTo);
        if (_dir < -180) then {_dir = _dir + 360;};
        _offset = if (_dir > 180) then {1.847} else {0.216};
        _pos = _offset + (-_dir * _click);

        (_dialog displayCtrl 14) ctrlShow true;
        (_dialog displayCtrl 14) ctrlSetPosition [_pos, 0.07];
        (_dialog displayCtrl 14) ctrlCommit 0;
    } else {
        (_dialog displayCtrl 14) ctrlShow false;
    };

    //Group markers
    if (uiNamespace getVariable ["MCC_HuD_compassTeamMates",true]) then {
        _ctrls = [];

        {
           ctrlDelete (_dialog displayCtrl _x);
        } forEach (uiNamespace getVariable ["MCC_hud_compassUnits",[]]);

        {
            if (_x != player) then {
                _index =  (_foreachindex)+1000;
                _iconSize = ((1-((player distance _x)/300 min 1))*0.04) max 0.015;

                _dialog ctrlCreate ["RscPicture",_index,(_dialog displayCtrl 10)];
                _ctrls pushBack _index;

                uiNamespace setVariable ["MCC_hud_compassUnits",_ctrls];

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

                (_dialog displayCtrl _index) ctrlSetText (getText(configfile >> "CfgVehicleIcons">>_iconPic));
                (_dialog displayCtrl _index) ctrlSetTextColor _iconColor;


                _dir = _orgDir - ([positionCameraToWorld [0,0,0], position _x] call BIS_fnc_dirTo);
                if (_dir < -180) then {_dir = _dir + 360;};
                _offset = if (_dir > 180) then {1.847} else {0.216};
                _pos = _offset + (-_dir * _click);

                (_dialog displayCtrl _index) ctrlShow true;
                (_dialog displayCtrl _index) ctrlSetPosition [_pos, 0,_iconSize,_iconSize * (4/3)];
                (_dialog displayCtrl _index) ctrlCommit 0;
            };
        } forEach (units player);
    };
};

["MCC_fnc_compHudEVH", "onEachFrame", "MCC_fnc_compHudEVH"] call BIS_fnc_addStackedEventHandler;
