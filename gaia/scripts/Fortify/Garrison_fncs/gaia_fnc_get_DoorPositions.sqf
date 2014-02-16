private ["_house","_uACfg","_sel","_position","_doorPositions"];
_house = _this select 0;

_uACfg = (configFile >> "cfgVehicles" >> (typeOf _house) >> "UserActions");
if ((count _uACfg) <= 0) exitwith {};

_doorPositions = [];

for "_i" from 0 to ((count _uACfg) - 1) step 3 do
{
	if (_i >= (count _uACfg)) exitwith {};
	_sel = _uACfg select _i;
	_position = getText (_sel >> "position");
	_doorPositions set [(count _doorPositions),(_house selectionPosition _position)];
};

_doorPositions