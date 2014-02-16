private ["_indoors","_pos","_unit","_posh","_abovehead","_house"];
_unit = _this select 0;

	_pos = getposASL _unit;
	_posh = _pos select 2;
	_pos set [2,(_posh + 0.5)];
	_abovehead = [_pos select 0,_pos select 1,(_pos select 2) + 10];

	_house = (lineintersectswith [_pos,_abovehead,_unit]) select 0;

	_indoors = if (isnil("_house")) then {false} else {true};

_indoors

