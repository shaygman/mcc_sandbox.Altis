//=================================================================MCC_fnc_medicDragCarry=======================================================================================
//Handle drag and carry units
//=============================================================================================================================================================================
private ["_unit","_targetUnit","_carry","_subArray","_fatigueEffect"];
_unit = _this select 0;
_targetUnit = _this select 1;
_carry = _this select 2;

if (_carry) then
{
	_targetUnit attachTo [_unit,[0.3, 0, -1.4], "water_surface"];
	_targetUnit setdir 180;
	_unit playMoveNow "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon";
	[[[_targetUnit],{(_this select 0) playactionNow "grabCarried"}], "BIS_fnc_spawn", _targetUnit, false] call BIS_fnc_MP;
	WaitUntil {!(alive _unit) || (animationstate player in ["acinpercmstpsraswrfldnon","acinpercmrunsraswrfldf","acinpercmrunsraswrfldr","acinpercmrunsraswrfldl"])};
	detach _targetUnit;
	_targetUnit attachTo [_unit,[0.7, -0.1, -1.25], "LeftShoulder"];
	_targetUnit setdir 180;
	_unit setVariable ["mcc_draggedObject", _targetUnit];
}
else
{
	[_targetUnit] call MCC_fnc_dragObject;
	[[[_targetUnit],{(_this select 0) switchMove "AinjPpneMrunSnonWnonDb_still"}], "BIS_fnc_spawn", true, false] call BIS_fnc_MP;
};

sleep 1;
waituntil
{
	sleep 0.01;
	(MCC_interactionKey_down) || isNull (_unit getVariable ["mcc_draggedObject", objNull]) || !(alive _unit) || !(alive _targetUnit) || (_unit getVariable ["MCC_medicUnconscious",false]) || !(_targetUnit getvariable ["MCC_medicUnconscious",false]) || (vehicle _unit != _unit) || (isnull _unit) || (isNull _targetUnit);

};

[] call MCC_fnc_releaseObject;

[[[_targetUnit],{(_this select 0) playactionNow "released"}], "BIS_fnc_spawn", _targetUnit, false] spawn BIS_fnc_MP;

if (_targetUnit getVariable ["MCC_medicUnconscious",false]) then
{
	[[[_targetUnit],{(_this select 0) playactionNow "Unconscious"}], "BIS_fnc_spawn", _targetUnit, false] spawn BIS_fnc_MP;
};


[[[_unit],{(_this select 0) playactionNow "released"}], "BIS_fnc_spawn", _unit, false] spawn BIS_fnc_MP;
if (_carry && !(_unit getVariable ["MCC_medicUnconscious",false])) then {sleep 2; _unit switchMove ""};