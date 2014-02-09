private["_targets","_enemies","_enemySides","_side","_unit","_UPosG","_range","_UPosR","_me","_Dist"];

_range   = _this select 1;
_me      = _this select 0;
_targets = _me nearTargets _range;

_enemies = [];

_enemySides = _me call BIS_fnc_enemySides;

{
	_unit  = (_x select 4);
	_side  = (_x select 2);
	_UPosG = (_x select 0);
	_UPosR = [];

	if ((_side in _enemySides) && (count crew _unit > 0)) then
	{
		if ((side driver _unit) in _enemySides) then
		{
			_UPosR = position _unit;
			_Dist  = [_UPosR, _UPosG] call CBA_fnc_getDistance;
			_TDist = [(position _me),_UPosG] call CBA_fnc_getDistance;
			
			_enemies set [count _enemies, [_unit,_UPosG, _UPosR, _Dist,_TDist, (_me knowsabout _unit) ]];
		};
	};
}
forEach _targets;

_enemies