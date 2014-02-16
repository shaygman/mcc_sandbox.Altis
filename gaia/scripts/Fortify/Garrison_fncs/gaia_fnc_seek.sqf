_seekUnits = _this select 0;
_targetPos = _this select 1;
_build = _this select 2;

if (!isnil("_build")) then
{
	_buildpositions = [];
	_pcnt = 0;
	while {format ["%1", _build buildingPos (_pcnt)] != "[0,0,0]" } do {
		_pos = _build buildingPos (_pcnt);
		_buildpositions set [count _buildpositions, _pos];
		_pcnt = _pcnt + 1;
	};
	
	_cdist = 100;
	_closest = 0;
	
	for "_i" from 0 to ((count _buildpositions) - 1) do
	{
		_sel = _buildpositions select _i;
		if ((_sel distance _targetPos) < _cdist) then
		{
			_cdist = (_sel distance _targetPos);
			_closest = _i;
		};
	};
	
	{
		_x forcespeed 2;
		_x setVariable ["Garrison_Moving", true];
		doStop _x;
		sleep 0.1;
		_x doMove (_build buildingpos (_buildingpositions select _closest));
	} foreach _seekUnits;
	hint (str(_seekUnits));
}
else
{
	{
		_x forcespeed 2;
		_x setVariable ["Garrison_Moving", true];
		doStop _x;
		sleep 0.1;
		_x moveTo _targetPos;
	} foreach _seekUnits;
		hint "incoming";
};
