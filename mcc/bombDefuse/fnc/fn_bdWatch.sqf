/*=================================================================MCC_fnc_bdWatch==================================================================================
  start the bomb watch
  IN <>
    _difficulty - STRING
    _ctrlGroup - CTRL
    _noModules - INTEGER
*/

#define IDC_BASE 100

private ["_difficulty","_ctrlGroup","_display","_endTime","_watchCtrl","_strikesCtrl","_ratio","_timeLeft","_s","_m","_ms","_html","_ls","_defused","_noModules","_time"];
disableSerialization;
_difficulty = _this select 0;
_ctrlGroup = _this select 1;
_noModules = _this select 2;
_time = param [3, -1, [0]];

_display = ctrlParent _ctrlGroup;

waitUntil {player getVariable ["MCC_bombDefuseReady",false]};

if (_time > 0) then {
  _endTime = time +_time;
} else {
  _endTime = switch (toLower _difficulty) do {
                case "hard": {time + 5*60};
                case "medium": {time + 7*60};
                default {time + 10*60};
              };
};

_ratio =safezoneW / safezoneH;
_watchCtrl = _display ctrlCreate ["RscStructuredText", 902,_ctrlGroup];
_watchCtrl ctrlSetPosition [0.04*_ratio, 0.05*_ratio, 0.15*_ratio, 0.07*_ratio];
_watchCtrl ctrlSetBackgroundColor [0,0,0,0.8];
_watchCtrl ctrlCommit 0;

_strikesCtrl = _display ctrlCreate ["RscStructuredText", 903,_ctrlGroup];
_strikesCtrl ctrlSetPosition [0.065*_ratio, 0.13*_ratio, 0.1*_ratio, 0.03*_ratio];
_strikesCtrl ctrlSetBackgroundColor [0,0,0,0.8];
_strikesCtrl ctrlCommit 0;

_ls = "";
//Main loop
while {!(player getVariable ["MCC_bombDefuseSuccess",false]) && (player getVariable ["MCC_bombDefuseStrikes",0])<3 && time < _endTime && !(isnull _display)} do {
    _timeLeft = _endTime - time;
    _ms =[floor ((_timeLeft mod 1)*100)] call MCC_fnc_time2string;
    _s = [floor(_timeLeft MOD 60)]call MCC_fnc_time2string;
    _m = [floor((_timeLeft/60) MOD 60)]call MCC_fnc_time2string;

    //timer
    if (_ls != _s) then {playSound "click"};
    _html = "<t color='#add118' size='1.7' shadow='1' underline='false'>"+ format ["%1:%2:%3", _m, _s, _ms] + "</t>";
    _watchCtrl ctrlSetStructuredText parseText _html;
    _ls = _s;

    //Strikes
    _html = "<t color='#add118' size='1' shadow='1' align='center' underline='false'>";
    for "_i" from 0 to (player getVariable ["MCC_bombDefuseStrikes",0])-1 do {
       _html = _html + " X ";
    };
    _html = _html + "</t>";
    _strikesCtrl ctrlSetStructuredText parseText _html;

    //Defuse the bombe if all moduled have been finished
    _defused = true;
    for "_i" from IDC_BASE to (IDC_BASE+_noModules)-1 do {
        if (ctrlshown (_display displayctrl _i)) exitWith {_defused = false};
    };

    if (_defused) then {player setVariable ["MCC_bombDefuseSuccess",true]};
    sleep 0.1;
};

if !(player getVariable ["MCC_bombDefuseSuccess",false]) then {
     closeDialog 0;
};