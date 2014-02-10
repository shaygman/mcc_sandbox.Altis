private ["_infront","_pos","_target","_willsee","_bDoor"];
_unit = _this select 0;
_firer = _this select 1;
_build = _unit getVariable "homebuild";

/*
if (isnil("debugball")) then {
	debugball = "Sign_Sphere25cm_F" createVehicle [0,0,0];
};
*/
_t = time;

_alerted = time - (_unit getVariable ["alerted",0]);
if (_alerted < 1) exitWith {};

_unit setvariable ["alerted",time];

_willseearray = [_unit,_firer] call fnc_willseetarget;
	
if (_willseearray select 0) then 
{
	_currentTarget = assignedTarget _unit;
	
	if (! (isNull _currentTarget)) then
	{
		_currentDist = _currentTarget Distance _unit;
		_newDist = _firer Distance _unit;
		
		if (_newDist <= (_currentDist + 1)) then
		{
			//if (isPlayer _firer) then {hint ((str(side _unit)) + " is Targeting you")};
			[_unit,_firer] call fnc_cqc_target;

			_unit doWatch objNull;	
			_unit doTarget objNull;			
			_unit doTarget _firer;
			//_unit dofire _firer;
			sleep 1;
			//hint "";
		};
	}
	else
	{
		[_unit,_firer] call fnc_cqc_target;

		_unit doWatch objNull;	
		_unit doTarget objNull;			
		_unit doTarget _firer;
		//_unit dofire _firer;
	};
} 
else 
{
	/*
	_seeking = _build getVariable ["Seeking",false];
	if (!_seeking) then
	{
		_alertPos = getPosATL _firer;
		_build setVariable ["Seeking",true];
		_groupUnits = units group _unit;
		_buildUnits = [];
		{
			_homebuild = _x getVariable "homebuild";
			if (_build == _homebuild) then
			{
				_buildUnits set [(count _buildUnits),_x];
			};
		} foreach _groupUnits;
		
		if ((count _buildUnits) >= 4) then
		{
			_searchTeam = [_buildUnits select 0,_buildUnits select 1];
			[_searchTeam,_alertPos,_build] spawn fnc_seek;
		};
	};
	*/
	
	_dist = _unit distance _firer;
	
	if ((_unit getVariable ["tgtdist",51]) < _dist) exitWith {};

	_unit setvariable ["tgtdist",_dist];

	_angle = ([_unit,_firer] call fnc_get_angle);
	_willsee = false;
	_target = [];
	_targetATL = [];
	_acnt = 0;
	_mod = 0;
	_bDoor = false;
	
	//_ball1 = "Sign_Sphere10cm_F" createVehicle [0,0,0];
	
	_cntC = 0;
	_ct = time;
	while {!_willsee} do 
	{	
		if (!(alive _unit)) exitWith {};
		_angle = if (_acnt == 0) then {_angle + _mod} else {_angle - _mod};
		//if (_angle <= 0) then {_angle = _angle + 360};
		if (_angle >= 360) then {_angle = _angle - 360};
		//_unit GlobalChat ("cycle" + (str(_cntC)) + (str(_unit)));
		if (_cntC > 120) exitWith {};

		_willseearray = [_unit,_angle,_dist] call fnc_willseeincombat;
		_willsee = _willseearray select 0;
		_target = _willseearray select 1;
		_targetATL = ASLtoATL _target;
		_bDoor = _willseearray select 2;
		_acnt = if (_acnt == 0) then {_acnt + 1} else {_acnt - 1}; 
		_mod = _mod + 3;
		//_ball1 setPosASL _target;
		_cntC = _cntC + 1;	
	};
	_ct = time - _ct;
	
	//if (!_willsee) then {hint "still wont see"};
	
	[_unit,_targetATL] call fnc_cqc_target;
	
	if (_willsee) then
	{
	/*
		_unit doWatch objNull;
		sleep 0.02;
		_unit doWatch _targetATL;
		_unit lookAt _targetATL;
	*/
	}
	else
	{
		if (_bDoor) then
		{
			_targetDistFirer = _target distance (getPosASL _firer);
			_randomNumber = ceil (random 9);
			
			if ((_targetDistFirer < 3) && (_randomNumber >= 6)) then
			{
				[_unit,_targetATL] call fnc_cqc_target;

				_randomNumber = ceil (random 5);
				for "_i" from 0 to _randomNumber do
				{
					//_unit action ["useWeapon",currentWeapon _unit,_unit,0];
					_unit Fire (currentWeapon _unit); // a bit broken, units fire into the air on occasion.
					sleep 0.2;
				};
			};
		};
	};
	
	//debugball setPos _target;

	nul = [_unit] spawn {_unit = _this select 0; sleep ((random 7) + 5); _unit setvariable ["tgtdist",51];};
	
	//sleep 2;
	//deleteVehicle _ball1;
};



