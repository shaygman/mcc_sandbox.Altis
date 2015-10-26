/*=================================================================MCC_fnc_bdWireModule==================================================================================
  start a bomb defuse wire module
  IN <>
    _difficulty - STRING
    _ctrlGroup - CTRL
    _serialNumber - INTEGER
*/

private ["_difficulty","_ctrlGroup","_display","_idc","_wires","_wiresColor","_ratio","_ctrl","_yPos","_ctrls","_color","_colorName","_serialNumber","_correctWireIndex"];
disableSerialization;
_difficulty = _this select 0;
_ctrlGroup = _this select 1;
_serialNumber = _this select 2;

_display = ctrlParent _ctrlGroup;
_idc = ctrlIDC _ctrlGroup *1000;

_wires = 3 + random (switch (toLower _difficulty) do {
  case "hard": {5};
  default {3};
});

_wiresColor = [[1,0,0,0.8],[0,1,0,0.8],[0,0,1,0.8],[1,1,1,0.8],[0,0,0,0.8]];
_ratio =safezoneW / safezoneH;
_ctrls = [];
_colorArray = [];
_yPos = 0.05;

for "_i" from 1 to _wires do {
    _ctrl = _display ctrlCreate ["RscButtonMenu", _idc+_i,_ctrlGroup];
    _ctrl ctrlSetPosition [0.03*_ratio, _yPos*_ratio, 0.15*_ratio, 0.01*_ratio];
    _color = _wiresColor call bis_fnc_selectRandom;
    _colorName = switch (str _color) do {
            case "[1,0,0,0.8]": {"red"};
            case "[0,1,0,0.8]": {"green"};
            case "[0,0,1,0.8]": {"blue"};
            case "[1,1,1,0.8]": {"white"};
            case "[0,0,0,0.8]": {"black"};
       };
    _ctrl ctrlSetBackgroundColor _color;
    _ctrl ctrlCommit 0;
    _ctrls pushBack _ctrl;
    _colorArray pushBack _colorName;

    //Wire Start
    _ctrl = _display ctrlCreate ["RscPicture", -1,_ctrlGroup];
    _ctrl ctrlsetText format ["%1mcc\bombDefuse\data\wireStart.paa",MCC_path];
    _ctrl ctrlSetPosition [0.015*_ratio, (_yPos-0.005)*_ratio, 0.025*_ratio, 0.025*_ratio];
    _ctrl ctrlCommit 0;

    //Wire End
    _ctrl = _display ctrlCreate ["RscPicture", -1,_ctrlGroup];
    _ctrl ctrlsetText format ["%1mcc\bombDefuse\data\wireEnd.paa",MCC_path];
    _ctrl ctrlSetPosition [0.17*_ratio, (_yPos-0.005)*_ratio, 0.025*_ratio, 0.025*_ratio];
    _ctrl ctrlCommit 0;

    //Next line
    _yPos = _yPos + 0.035;
};

if ((_serialNumber mod 3) == 0) then {
    _correctWireIndex = switch (true) do {
        case (count _ctrls <=3): {
            if !("red" in _colorArray) then {0} else {
                if ("green" == _colorArray select ((count _colorArray) -1)) then {count _colorArray -1} else {
                    if (_colorArray find "blue" !=-1) then {_colorArray find "blue"} else {
                        if (_colorArray find "black" !=-1) then {_colorArray find "black"} else {1};
                    };
                };
            };
        };

        case (count _ctrls > 3 && count _ctrls <=5): {
            if !("white" in _colorArray) then {1} else {
                if ("black" == _colorArray select ((count _colorArray) -1)) then {count _colorArray -1} else {
                    if (_colorArray find "green" !=-1) then {_colorArray find "green"} else {
                        if (_colorArray find "red" !=-1) then {_colorArray find "red"} else {2};
                    };
                };
            };
        };

        default {
            if !("green" in _colorArray) then {2} else {
                if ("blue" == _colorArray select ((count _colorArray) -1)) then {count _colorArray -1} else {
                    if (_colorArray find "black" !=-1) then {_colorArray find "black"} else {
                        if (_colorArray find "white" !=-1) then {_colorArray find "white"} else {0};
                    };
                };
            };
        };
    };
} else {
    _correctWireIndex = switch (true) do {
        case (count _ctrls <=3): {
            if !("green" in _colorArray) then {0} else {
                if ("white" == _colorArray select ((count _colorArray) -1)) then {count _colorArray -1} else {
                    if (_colorArray find "black" !=-1) then {_colorArray find "black"} else {
                        if (_colorArray find "blue" !=-1) then {_colorArray find "blue"} else {1};
                    };
                };
            };
        };

        case (count _ctrls > 3 && count _ctrls <=5): {
            if !("blue" in _colorArray) then {1} else {
                if ("white" == _colorArray select ((count _colorArray) -1)) then {count _colorArray -1} else {
                    if (_colorArray find "red" !=-1) then {_colorArray find "red"} else {
                        if (_colorArray find "blue" !=-1) then {_colorArray find "blue"} else {2};
                    };
                };
            };
        };

        default {
            if !("red" in _colorArray) then {2} else {
                if ("black" == _colorArray select ((count _colorArray) -1)) then {count _colorArray -1} else {
                    if (_colorArray find "white" !=-1) then {_colorArray find "white"} else {
                        if (_colorArray find "green" !=-1) then {_colorArray find "green"} else {0};
                    };
                };
            };
        };
    };
};

{
   if (_forEachIndex == _correctWireIndex) then {
        _x ctrlAddEventHandler ["MouseButtonUp",format ["(ctrlParent (_this select 0) displayCtrl %1) ctrlshow false;playsound 'RscDisplayCurator_ping02';",ctrlIDC _ctrlGroup]];
    } else {
        _x ctrlAddEventHandler ["MouseButtonUp","(_this select 0) ctrlshow false; playsound 'AlarmCar'; player setVariable ['MCC_bombDefuseStrikes',(player getVariable ['MCC_bombDefuseStrikes',0])+1]"];
    };
} forEach _ctrls;