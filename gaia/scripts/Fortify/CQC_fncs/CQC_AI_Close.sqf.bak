private ["_unit","_proximity","_enemies","_enemy","_speed"];

_unit = _this select 0;

_proximity = _unit nearentities [["Man"],5];
_enemies = [];
_enemy = objNull;

{
	if (((side _x) getfriend (side _unit) <= 0.5)) then 
	{
		_enemies set [(count _enemies),_x];
	};
} foreach _proximity;

{
	_speed = speed _x;
	if (_speed < 5) then
	{
		_enemies = _enemies - [_x];
	};
} foreach _enemies;

if (count _enemies > 1) then 
{
	_enemies = [_unit,1,_enemies] call fnc_Find_Closest;
};

if ((count _enemies) > 0) then
{
	_enemy = _enemies select 0;
	[_unit,_enemy] call fnc_cqc_target;
};