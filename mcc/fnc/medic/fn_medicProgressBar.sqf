//=================================================================MCC_fnc_medicProgressBar======================================================================================
//Handle medic progress
//=============================================================================================================================================================================
private ["_text","_ctrl","_time","_fail","_medicAnims"];
disableSerialization;
_text = _this select 0;
_time = _this select 1;
_unit = _this select 2;
_self = if (_unit == player) then {true} else {false};
_unitUnconcious = _unit getVariable ["MCC_medicUnconscious",false];

_fail = false;

_medicAnims = ["ainvpknlmstpsnonwrfldnon_medic0s","ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medicend","ainvpknlmstpsnonwrfldnon_ainvpknlmstpsnonwrfldnon_medic"];

//If self then no need for wounded anim
if (!_self && !_unitUnconcious) then {[[[_unit],{(_this select 0) playactionNow "agonyStart"}], "BIS_fnc_spawn", _unit, false] spawn BIS_fnc_MP};

player playactionNow "medicStart";

//Start progress bar
(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutRsc ["MCC_interactionPB", "PLAIN"];
_ctrl = ((uiNamespace getVariable "MCC_interactionPB") displayCtrl 2);
_ctrl ctrlSetText _text;
_ctrl = ((uiNamespace getVariable "MCC_interactionPB") displayCtrl 1);
sleep 2;
for [{_x=1},{_x<_time},{_x=_x+0.1}]  do
{
	_ctrl progressSetPosition (_x/_time);
	if (player distance _unit > 2 || !(animationState player in _medicAnims) || !alive player || !alive _unit || (player getvariable ["MCC_medicUnconscious",false]) || isNull ((uiNamespace getVariable "MCC_interactionPB"))) then {_fail = true; _x = _time};
	sleep 0.1;
};

(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];

player playactionNow "medicStop";

//If self then no need for wounded anim
if (!_self && !_unitUnconcious) then {[[[_unit],{(_this select 0) playactionNow "agonyStop"}], "BIS_fnc_spawn", _unit, false] spawn BIS_fnc_MP};

_fail