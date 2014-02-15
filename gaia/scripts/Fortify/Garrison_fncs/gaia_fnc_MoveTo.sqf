private ["_unit","_pos","_move","_reached","_uPos","_dist","_cnt"];
_unit = _this select 0;
_pos =_this select 1; if ((typeName _pos) != "ARRAY") then {_pos = (getPosATL _pos)};

_move = 
{
	doStop _unit;
	sleep 0.01;
	_unit MoveTo _pos;
};

call _move;

_reached = false;

_cnt = 0;
_idleCnt = 0;
_idle = false;

while {!_reached} do
{
	_uPos = getPosATL _unit;
	_dist = _uPos distance _pos;
	_speed = speed _unit;
	_interupted = if ((time - (_unit getVariable ["alerted",0])) > 10) then {false} else {true};
	
	if (!(alive _unit)) exitwith {};
	
	if (_speed <= 0.1) then {_idleCnt = _idleCnt + 1} else {_idleCnt = 0; _idle = false};
	if (_idleCnt >= 2) then {_idle = true};
	
	if (_idle && (!_interupted)) then 
	{
		_cnt = _cnt + 1;
		call _move;
	};
	
	if (_dist < 1) exitwith {_reached = true};
	if (_cnt > 3) exitwith {};
	sleep 1.5;
};

if (_reached) then {doStop _unit};

if (_reached) then 
{
	_indoors = [_unit] call gaia_fnc_indoors;
	_uh = (getposATL _unit) select 2;
	// if he's not indoors and he is over 1 meter from the ground, crouch. if crouching makes him blind (from a wall) he will stand back up.
	if ((!(_indoors)) && (_uh > 1)) then 
	{

		_unit setunitpos "Middle";
		sleep 2; 
		if (!([_unit] call gaia_fnc_cansee)) then {_unit setunitpos "auto"};
		// check to make sure that when he is inside or on the ground again he stops crouching.
		nul = [_unit] spawn {

			_unit = _this select 0;

			while {sleep 2;alive _unit} do 
			{	
				_indoors = [_unit] call gaia_fnc_indoors;
				_uh = (getposATL _unit) select 2;

				if ((_indoors) or (_uh < 2)) exitwith {_unit setunitpos "AUTO";};
			};

		}; 

	};

	(group _unit) setCombatMode "YELLOW";
	
	if (_indoors) then {
		_unit setvariable ["indoors",true];
		
		nul = [_unit] spawn gaia_fnc_Prone_Limit;
		
		_unit forcespeed 0;
		_unit setvariable ["forcedspeed",0];

	};

//	if (_staying) then {
		(group _unit) setCombatMode "YELLOW";
		_unit disableAI "TARGET";
		//_unit disableAI "AUTOTARGET";
		//_unit disableAI "FSM";
		//_unit allowfleeing 0;
	//};
	// make them randomly look around and move within the building.
	nul = [_unit] spawn gaia_fnc_smartlook;

};	


//hint (str(_reached));
_reached

