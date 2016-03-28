/*=================================================================MCC_fnc_bdButtonsModule==================================================================================
  start a bomb defuse buttons module
  IN <>
    _difficulty - STRING
    _ctrlGroup - CTRL
    _serialNumber - INTEGER
*/

private ["_difficulty","_ctrlGroup","_display","_idc","_buttons","_buttonsCombinations","_ratio","_ctrl","_xPos","_ctrls","_serialNumber","_answers","_symbol","_index"];
disableSerialization;
_difficulty = _this select 0;
_ctrlGroup = _this select 1;
_serialNumber = _this select 2;

_display = ctrlParent _ctrlGroup;
_idc = ctrlIDC _ctrlGroup *1000;

_buttons = switch (toLower _difficulty) do {
  case "hard": {7};
  default {5};
};

if ((_serialNumber mod 3) == 0 && (_serialNumber mod 7) == 0) then {
    _buttonsCombinations = [["@",false],["1",false],["^",true],["~",true],[")",true],["]",true],["(",false],["[",true],["|",true],["\",false],["/",false],["?",false],["3",false],["%",false],["*",true],["L",true],["8",true],["5",false],[";",true],["A",false],["a",true],["g",false],["G",true],["b",false],["B",true],["p",false],["P",true],["w",true],["W",false],["m",true],["n",false],["N",true],["M",false],["t",true],["T",false],["`",true],[":",false],["o",true],["0",false]];
} else {
    if ((_serialNumber mod 3) == 0) then {
     _buttonsCombinations = [["@",false],["1",false],["^",false],["~",true],[")",true],["]",true],["(",false],["[",true],["|",true],["\",false],["/",false],["?",false],["3",false],["%",true],["*",false],["L",true],["8",false],["5",false],[";",true],["A",true],["a",false],["g",false],["G",true],["b",true],["B",true],["p",true],["P",false],["w",true],["W",false],["m",false],["n",false],["N",false],["M",true],["t",true],["T",true],["`",false],[":",false],["o",true],["0",false]];
    } else {
        _buttonsCombinations = [["@",false],["1",false],["^",true],["~",false],[")",true],["]",false],["(",true],["[",false],["|",false],["\",false],["/",false],["?",true],["3",true],["%",true],["*",true],["L",true],["8",true],["5",false],[";",false],["A",false],["a",true],["g",true],["G",false],["b",false],["B",true],["p",false],["P",false],["w",false],["W",false],["m",true],["n",false],["N",true],["M",false],["t",true],["T",false],["`",true],[":",false],["o",false],["0",false]];
    };
};

_ratio =safezoneW / safezoneH;
_ctrls = [];
_answers = [];
_xPos = 0.01;

for "_i" from 1 to _buttons do {
    _index = floor random count _buttonsCombinations;
    _symbol = _buttonsCombinations select _index;
    _buttonsCombinations set [_index,-1];
    _buttonsCombinations = _buttonsCombinations - [-1];
    _answers pushBack (_symbol select 1) ;

    //Create Symbol
    _ctrl = _display ctrlCreate ["RscText", -1,_ctrlGroup];
    _ctrl ctrlSetText (_symbol select 0);
    _ctrl ctrlSetTextColor [0,0.8,0,0.8];
    _ctrl ctrlSetBackgroundColor [0,0,0,0.8];
    _ctrl ctrlSetPosition [(_xPos+0.003)*_ratio, 0.07*_ratio, 0.025*_ratio, 0.03*_ratio];
    _ctrl ctrlCommit 0;

    //Create button
    _ctrl = _display ctrlCreate ["RscCheckBox", _idc+_i,_ctrlGroup];
    _ctrl ctrlSetPosition [_xPos*_ratio, 0.1*_ratio, 0.03*_ratio, 0.03*_ratio];
    _ctrl ctrlCommit 0;
    _ctrls pushBack _idc+_i;

    //Next button
    _xPos = _xPos + 0.03;
};

//Add submit button
_ctrl = _display ctrlCreate ["RscButtonMenu", _idc+10,_ctrlGroup];
_ctrl ctrlSetPosition [0.08*_ratio, 0.16*_ratio, 0.08*_ratio, 0.05*_ratio];
_ctrl ctrlSetTextColor [0,0.8,0,0.8];
_ctrl ctrlsetText "Submit";
_ctrl ctrlAddEventHandler ["MouseButtonUp",format [
        "
        _display = (ctrlParent (_this select 0));
        _input = [];
        {
            _input pushback (cbChecked (_display displayctrl _x));
        } forEach %1;

        if (str _input == str %2) then {
            (_display displayctrl %3) ctrlshow false;
            playsound 'RscDisplayCurator_ping02';
        } else {
            player setVariable ['MCC_bombDefuseStrikes',(player getVariable ['MCC_bombDefuseStrikes',0])+1];
            playsound 'AlarmCar';
        };
    ",_ctrls,_answers,ctrlIDC _ctrlGroup]];
_ctrl ctrlCommit 0;