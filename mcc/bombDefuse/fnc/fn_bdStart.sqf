/*=================================================================MCC_fnc_bdStart==================================================================================
  randomize the defuse bomb panel
*/
private ["_difficulty","_modules","_noModules","_isEngineer","_disarmTime","_pos","_target","_realIED"];
_targetIsRealIED = param [1,false,[true]];

if (_targetIsRealIED) then {
	_realIED = _this select 0;
	_target = _realIED getvariable ["fakeIed",objNull];
} else {
	_target = _this select 0;
	_realIED = _target getVariable ["realIed",objNull];
};

_pos = position _target;
_pos set [2,(_pos select 2) + 0.2];

if (isNull _realIED) exitWith {};

//is engineer
_isEngineer = if (((getNumber(configFile >> "CfgVehicles" >> typeOf player >> "canDeactivateMines")) == 1) || ((player getvariable ["CP_role",""]) == "Specialist")) then {true} else {false};
_disarmTime = (_realIED getvariable ["MCC_disarmTime",0]) max 120;

_difficulty = ["easy","medium","hard"] call bis_fnc_selectRandom;
_noModules = (floor (_disarmTime/60) max 2) min 11;
_modules = [];
for "_i" from 1 to _noModules do {
  _modules pushBack (["wires","buttons","numpad"] call bis_fnc_selectRandom);
};

if !([_difficulty,_modules,_disarmTime] call MCC_fnc_initBombDefuse) then {
  _realIED setvariable ["armed",false,true];
  "SmallSecondary" createVehicle _pos;
  sleep 0.5;
  _realIED setvariable ["iedTrigered",true,true];
} else {
  player addrating 500;
  _realIED setvariable ["armed",false,true];
  _realIED setVariable ["MCC_isInteracted",false,true];
};