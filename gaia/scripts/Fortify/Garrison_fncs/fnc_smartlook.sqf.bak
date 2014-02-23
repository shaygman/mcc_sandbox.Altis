private ["_dir","_unit","_infront","_willsee"];
_unit = _this select 0;
_dir = getdir _unit;
_group = group _unit;
_staying = _group getvariable ["defending",true];

//hint "running smart look";

_pos = getposATL _unit;

_build = _unit getVariable ["homebuild",nil]; if (isNil ("_build")) then { _build = (nearestobjects [getposATL _unit,["house"],30] select 0);};

_bpos = _unit getvariable ["homepos",0];

_dest = [];

_sleep_check = 
{
	sleep ((random 3) + 1);
	if !((group _unit) getVariable ["Garrisoning",false]) exitWith {};
};

while {alive _unit && ((group _unit) getVariable ["Garrisoning",false])} do 
{
	//if !((_unit getVariable ["forcedspeed",-1]) >= 0) exitWith {hint (str(_unit getVariable ["forcedspeed",-1]))};
	call _sleep_check;
	call _sleep_check;
	call _sleep_check;
	call _sleep_check;
	call _sleep_check;
	
	_bMoving = _unit getVariable ["Garrison_Moving",false];

	if  (!_bMoving) then 
	{
		_action = 2;
		_waittime = 0.1;
		
		_rand = random 10;
		if (_rand <= 1) then {_action = 1;_waittime = 5};
		if ((_rand > 1) && (_rand <= 6)) then {_action = 0;_waittime = 3};
		
		
		// if meant to be indoors and not indoors... go back inside before deciding to move anywhere
		if (_staying) then 
		{
			if (_action == 0) then 
			{
				if (_unit getvariable ["indoors",false]) then 
				{
					_indoors = [_unit] call fnc_indoors;
					if (!(_indoors)) then 
					{
						_action = 1;_waittime = 5
					};
				}
				else
				{
					_homePos = _build buildingpos _bpos;
					if ((_pos distance _homePos) > 15) then
					{
						_action = 1;_waittime = 5
					};
				};
			};
		};
	
		switch (_action) do 
		{
			case 0 : 
			{
				_willwalk = false;
				_i = 0;
				while {!(_willwalk)} do 
				{
					_rdir = random 360;

					_homedir = [_unit,_pos] call fnc_get_angle;

					_ofdir = if ((_rdir - _homedir) < 0) then {(_rdir - _homedir) + 360} else {_rdir - _homedir};
					_dir = if (_ofdir > 180) then {_rdir + ((360 - _ofdir) / 2)} else {_homedir + (_ofdir / 2)};

					_walkfncarray = [_unit,_dir] call fnc_willwalk;
					_willwalk = _walkfncarray select 0;
					_dest = _walkfncarray select 1;
					/*
					_ball1 = "Sign_Sphere25cm_F" createVehicle [0,0,0];
					_ball1 setPosATL _dest;
					hint (format ["%1 \n %2",_willwalk,_dest]);
					sleep 2;
					*/
					//hint "walking";
					if ((_i >= 20) && (!_willwalk)) exitwith {_dest = (getposATL _unit)};
					_i = _i + 1;
				};
					//_ball1 = "Sign_Sphere25cm_F" createVehicle [0,0,0];
					//_ball1 setPosATL _dest;
			};

			case 1 : 
			{	
				_dest = _build buildingpos _bpos;
				
				//hint "retuning";
			}; 

			default 
			{
				_dest = (getposATL _unit);	

				//hint "staying";
			};
		

		};
		
		if ((combatmode (group _unit)) == "RED") then {(group _unit) setcombatmode "YELLOW"};
		if !((group _unit) getVariable ["Garrisoning",false]) exitWith {};
		
		if ((group _unit) getVariable ["Garrisoning",false]) then
		{
			_unit forcespeed 2;
			
			[_unit,_dest] call fnc_MoveTo;

			waituntil {sleep _waittime;true};
		};

		_unit forcespeed (_unit getvariable ["forcedspeed",-1]);

	


		waituntil {(time - (_unit getvariable ["alerted",0])) > 10};

		_willsee = false;
		_infront = [];
	
		while {!(_willsee)} do 
		{
			_dir = random 360;
			_fncarray = [_unit,_dir] call fnc_willsee;
			_willsee = _fncarray select 0;
			_infront = _fncarray select 1;
		};
		
		//hint "looking";
		
		_unit lookat objNull;
		_unit lookat (ASLtoATL _infront);
	}
	else
	{
		_unit forcespeed 2;
	};
};
_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit enableAI "FSM";
//_unit allowfleeing 1;
