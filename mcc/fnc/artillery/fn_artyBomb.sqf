//================================================================MCC_fnc_artyBomb===============================================================================================
// Create artillery strike with sounds on given spot
// Example: [_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_fnc_artyBomb;
// _pos = position. Point of impact
//_shelltype = string. Ammuination class name
//_shellspread = integer. Spread radius.
// _nshell = integer. Number of shells per burst
// _sound = boolean, True - for impact wistle sound
//===========================================================================================================================================================================
private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell", "_shell", "_i","_delay"];
_pos					 = _this select 0;
_shelltype 			     = _this select 1;
_shellspread			 = _this select 2;
_nshell 				 = _this select 3;
_sound 					 = _this select 4;
_delay 					 = _this select 5;
if (isnil "_delay") then {_delay = 1};
for [{_i=0},{_i<_nshell},{_i=_i+1}] do
	{
		_shell = _shelltype createVehicle [(_pos select 0) + _shellspread - 2*(random _shellspread) ,(_pos select 1) + _shellspread - 2*(random _shellspread), 100];
		_shell setVelocity [0, 0, -50];
		WaitUntil{(position _shell select 2)<35};
		if (_sound) then {[[[netid _shell,_shell],format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
		sleep _delay;
	};
