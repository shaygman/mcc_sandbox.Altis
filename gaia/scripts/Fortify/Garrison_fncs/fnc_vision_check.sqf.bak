private ["_unit","_cansee","_bMoving","_bAlerted","_infront","_willsee","_fncarray","_dir"];

_unit = _this select 0;
_group = group _unit;

while {alive _unit && (_group getVariable ["Garrisoning",false])} do
{
	_bMoving = if ((speed _unit) > 0) then {true} else {false};
	_bAlerted = if ((abs (time - (_unit getvariable ["alerted",0]))) < 10) then {true} else {false};
	
	if (!(_bMoving or _bAlerted)) then
	{
		_cansee = [_unit] call fnc_cansee;
		
		if (!_cansee) then
		{
			_willsee = false;
			_infront = [];
		
			while {!(_willsee)} do 
			{
				_dir = random 360;
				_fncarray = [_unit,_dir] call fnc_willsee;
				_willsee = _fncarray select 0;
				_infront = _fncarray select 1;
			};
			
			[_unit,(ASLtoATL _infront)] call fnc_cqc_target;
		};
		
		//_nearUnits = [];
		//_nearUnits = _unit nearentities [["Man"],0.8];
		//_bTooClose = if ((count _nearUnits) > 0) then {true} else {false};
	};
	
	sleep 1.5;
};