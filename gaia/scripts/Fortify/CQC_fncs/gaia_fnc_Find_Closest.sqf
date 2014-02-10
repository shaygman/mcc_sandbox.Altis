private ["_unit","_toIgnore","_dist","_number","_array","_pos","_sameFloor","_otherFloors","_closest","_sel","_closestDist"];
_unit = _this select 0;
_number = _this select 1; if (isNil ("_number")) then {_number = 1};
_array = _this select 2; if (isNil ("_array")) then {_array = _unit nearentities [["Man"],100]};
_toIgnore = _this select 3; if (isNil ("_toIgnore")) then {_toIgnore = [_unit]};	
_pos = getPosATL _unit;

_sameFloor = [];
{
	_uPos = getPosATL _x;
	_diff = abs ((_uPos select 2) - (_pos select 2));
	
	if (_diff < 2) then
	{
		_sameFloor set [(count _sameFloor),_x];
	};	
} forEach _array;

_otherFloors = _array - _sameFloor;

_closest = [];
for "_i" from 1 to _number do
{
	_closestDist = 51;
	_sel = objNull;
	
	{
		_dist = _unit distance _x;
		
		if (_x in _otherFloors) then
		{
			_dist = _dist + 3;
		};
		
		if (_dist < _closestDist) then
		{
			if (!(_x in _toIgnore)) then
			{
				_closestDist = _dist;
				_sel = _x;
			};
		};
	} forEach _array;
	_closest set [(count _closest),_sel];
	_toIgnore set [(count _toIgnore),_sel];
};

_closest