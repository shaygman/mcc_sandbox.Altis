private ["_dist","_angle","_willsee","_infront","_obstruction","_intersectPos","_zdif","_t"];
_unit = _this select 0;
_angle = _this select 1;
_eDist = _this select 2; if (_eDist > 10) then {_eDist = 10};
_modDist = (abs (5 - _eDist)) / 2;
_bDoor = false;

	_uposASL = getposASL _unit;
	_eyes = eyepos _unit;

	_hyp = if (_eDist < 5) then {5 - _modDist} else {_eDist};
	
	_adj = _hyp * (cos _angle);
	_opp = sqrt ((_hyp * _hyp) - (_adj * _adj));


	_infront = if ((_angle) >=  180) then 
	{
		[(_eyes select 0) - _opp,(_eyes select 1) + _adj,(_eyes select 2)]
	} 
	else 
	{
		[(_eyes select 0) + _opp,(_eyes select 1) + _adj,(_eyes select 2)]
	};
	
	_obstruction = (lineintersectswith [_eyes,_infront,_unit]) select 0;
	
	_willsee = if (isnil("_obstruction")) then {true} else {false};
	
	if (!(_willsee)) then
	{
		_uACfg = (configFile >> "cfgVehicles" >> (typeOf _obstruction) >> "UserActions");
		if ((count _uACfg) <= 0) exitwith {};
		
		_doorPositions = _obstruction getVariable ["doorPositions",nil]; if (isNil ("_doorPositions")) then {_doorPositions = [_obstruction] call fnc_get_DoorPositions};
		_intersectWorldPos = [_unit,_infront] call fnc_Intersect_Pos_Rough;
		_intersectPos = (_obstruction worldToModel (ASLtoATL _intersectWorldPos));
		
		{
			if ((abs((_intersectPos select 2) - (_x select 2))) <= 2) then
			{
				_intersectPos set [2,_x select 2];
			};
			_dist = _x distance _intersectPos;
		
			if (_dist <= 1.2) exitwith
			{
				_infront = _intersectWorldPos;
				_bDoor = true;
				_willsee = true;
			};	
		} forEach _doorPositions;
	};
	
[_willsee,_infront,_bDoor]
	
	



