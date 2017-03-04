/*=================================================================MCC_fnc_initNameTags================================================================================
  Init HUD Name Tags
  IN <>
    Nothing
*/

//Not a client
0 spawn {
    if (!hasInterface || isDedicated) exitWith {};

    waituntil {!(IsNull (findDisplay 46))};
    sleep 1;
    if (missionNamespace getVariable ["MCC_initNameTags",false]) exitWith {};

    //Init
    missionNamespace setVariable ["MCC_initNameTags",true];

    //Name Tags
    MCC_fnc_NameTagsEVH = {
        if ((missionNamespace getvariable ["MCC_nameTags",false]) || (missionNamespace getvariable ["MCC_medicShowWounded",false])) then {
            private ["_color","_textSize","_pic","_direct","_pos","_units","_leader","_alpha","_radius","_aimedAt","_captiveSideId"];
            _radius = 30;
            _direct = missionNamespace getVariable ["MCC_NameTags_direct",true];

            //all units around or just what we looking at
            _units = if (!_direct || (missionNamespace getvariable ["MCC_medicShowWounded",false])) then {(getpos player nearEntities _radius)} else {[cursorTarget]};

            _captiveSideId = switch (side player) do
                    {
                        case east: {20};
                        case west: {30};
                        case resistance: {40};
                        default {50};
                    };

            {
                if (isNull _X) exitWith {};

                if (
                       _x != player &&
                       ((player getVariable ["CP_side",  playerside]) == (_x getVariable ["CP_side",  side _x]) || (captiveNum _x == _captiveSideId)) &&
                       alive _x
                    ) then {

                    if (_direct) then {
                         _aimedAt = cursorTarget == _x;
                         _radius = _radius * 4;
                    } else {
                        _aimedAt = true;
                    };

                    _textSize = 0.03;
                    _alpha = linearConversion [0,_radius,player distance _x,1,0.4];

                    if  (_aimedAt && player distance2D _x < _radius) then {
                        if (_x isKindOf "Man") then {
                            _color = if (_x in units player) then {[0,1,0,1]} else {[1,1,1,1]};
                            _color set [3,_alpha];
                            _pic = if ((_x getvariable ["CP_roleImage", ""]) != "") then {_x getvariable ["CP_roleImage", ""]} else {[_x,"texture"] call BIS_fnc_rankParams};
                            _pos = _x selectionPosition "head";
                            _pos = _pos vectorAdd [0,0,0.5];
                            _pos = _x modelToWorld _pos;
                        } else {

                            //if (_x isKindOf "Car" || _x isKindOf "Tank" || _x isKindOf "Air" || _x isKindOf "ship") then {
                                _pic = getText (configFile >> "cfgVehicles" >> (typeOf _x) >> "picture");
                                _leader = leader _X;
                                _name = if (alive _leader) then {name _leader} else {"Unknown"};

                                _color = if (_leader in units player) then {[0,1,0,1]} else {[1,1,1,1]};
                                _pos = visiblePosition _X;
                                _pos = _pos vectorAdd [0,0,3];
                           // };
                        };

                        drawIcon3D ["", [1,1,1,_alpha],  _pos, 0, 0, 0, name _x, 2, _textSize,"PuristaSemiBold"];
                        drawIcon3D [_pic, _color,  _pos, 0.8, 0.8, 0, "", 2, 0,"PuristaSemiBold"];
                    };

                    //Add wounded icon
                    if ((_x isKindOf "Man") && damage _x > 0.3 && (missionNamespace getvariable ["MCC_medicShowWounded",true])) then {
                        _pos = _x modelToWorld (_x selectionPosition "pelvis");
                        drawIcon3D [MCC_path + "mcc\interaction\data\IconBleeding.paa", [1,0,0,_alpha], _pos, 0.8, 0.8, 0, "", 2, 0,"PuristaSemiBold"];
                    };
               };
           } forEach _units;


           if (player != vehicle player) then {
                private ["_nameVehicle","_driver","_gunner","_commander","_emptyPos","_string"];
                _nameVehicle    = getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "displayName");
                _pic            = getText (configFile >> "cfgVehicles" >> (typeOf vehicle player) >> "picture");
                _driver         = if (alive (driver vehicle player)) then {name (driver vehicle player)} else {"Empty"};
                _gunner         = if (alive (gunner vehicle player)) then {name (gunner vehicle player)} else {"Empty"};
                _commander      = if (alive (commander vehicle player)) then {name (commander vehicle player)} else {"Empty"};
                _emptyPos       = (vehicle player) emptyPositions "cargo";

                _string = format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748' underline='true'>%1 </t><img align='left' size='0.45' image='%2'/><br/>",_nameVehicle,_pic];
                _string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>Commander: %1 </t><br/>",_commander];
                _string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>Driver: %1 </t><br/>",_driver];
                _string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>Gunner: %1 </t><br/>",_gunner];
                _string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>Empty Spaces: %1 </t><br/>",_emptyPos];

                [_string,1.2,0.8,0.01,0,0,4] spawn BIS_fnc_dynamicText;
            };
        };
    };

    MCC_initNameTagsEH = addMissionEventHandler ["Draw3D",{if (alive player && !(player getVariable ["MCC_medicUnconscious",false])) then {[30] call MCC_fnc_NameTagsEVH}}];
};