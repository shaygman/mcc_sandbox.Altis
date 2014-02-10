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
//hint (str(_reached));
_reached

