/*=================================================================MCC_fnc_bdStart==================================================================================
  randomize the defuse bomb panel
*/
private ["_difficulty","_modules","_noModules","_isEngineer","_disarmTime","_pos","_target","_realIED"];
_target = _this select 0;
_realIED = _target getVariable ["realIed",objNull];

if (isNull _realIED) exitWith {};

//is engineer
_isEngineer = if (((getNumber(configFile >> "CfgVehicles" >> typeOf player >> "canDeactivateMines")) == 1) || ((player getvariable ["CP_role",""]) == "Specialist")) then {true} else {false};
_disarmTime = (_realIED getvariable ["MCC_disarmTime",0]) max 30;
_pos = [((getposATL _target) select 0),(getposATL _target) select 1,((getPosATL _target) select 2)];

_difficulty = if (_disarmTime < 30 || _isEngineer) then {["easy","medium"] call bis_fnc_selectRandom} else {["medium","hard"] call bis_fnc_selectRandom};
_noModules = (floor (_disarmTime/30) max 2) min 11;
_modules = [];

for "_i" from 1 to _noModules do {
  _modules pushBack (["wires","buttons","numpad"] call bis_fnc_selectRandom);
};

if !([_difficulty,_modules,_disarmTime] call MCC_fnc_initBombDefuse) then {
  _realIED setvariable ["armed",false,true];
  "SmallSecondary" createVehicle _pos;
  sleep 1;
  _realIED setvariable ["iedTrigered",true,true];
} else {
  player addrating 500;
  _realIED setvariable ["armed",false,true];
  _realIED setVariable ["MCC_isInteracted",false,true];
};