private ["_infront","_pos","_object","_obstructed","_dist","_zdif"];
_unit  = _this select 0;
_focus = _this select 1;

_array = [];

_uposASL = getposASL _unit;
_dist = _uposASL distance _focus;
_eyes = eyepos _unit;
_angle = [_unit,_focus] call fnc_get_angle;


if (isnil("fnc_intersects_old")) then 
{
fnc_intersects_old = 
	{
		private ['_pos','_infront','_obstructed','_object','_hyp','_adj','_opp'];
		_unit = _this select 0;
		_pos = _this select 1;
		_checkdist = _this select 2;

		_hyp = _checkdist;
		_adj = _hyp * (cos _angle);
		_opp = sqrt ((_hyp*_hyp) - (_adj * _adj));

		_infront = if ((_angle) >=  180) then {

			[(_pos select 0) - _opp,(_pos select 1) + _adj,(_pos select 2)]

		} else {

			[(_pos select 0) + _opp,(_pos select 1) + _adj,(_pos select 2)]

		};

		_object = (lineintersectswith [_pos,_infront,_unit]) select 0;

		if (isnil('_object')) then {_obstructed = false; _object = objNull} else {_obstructed = true};

		[_obstructed,_infront]
	}
};

_array = [_unit,_eyes,_dist] call fnc_intersects_old;
_obstructed = _array select 0;

if (!(_obstructed)) exitwith {(_array select 1)};

while {_obstructed} do 
{
	_dist = (_dist / 10) * 2;
	_array = [_unit,_eyes,_dist] call fnc_intersects_old;
	_obstructed = _array select 0;
	if (_dist < 0.1) exitWith {};
};

while {_obstructed} do 
{
	_dist = _dist + 1;
	_array = [_unit,_eyes,_dist] call fnc_intersects_old;
	_obstructed = _array select 0;
};

_infront = _array select 1;

_infront






