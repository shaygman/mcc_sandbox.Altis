//==================================================================MCC_fnc_artyFlare===============================================================================================
// Create artillery strike with sounds on given spot
// Example: [_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_fnc_artyFlare;
// _pos = position. Point of impact
//_shelltype = string. Ammuination class name
//_shellspread = integer. Spread radius.
// _nshell = integer. Number of shells per burst
// _sound = boolean, True - for impact wistle sound
//===========================================================================================================================================================================	
private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell", "_i","_delay"];
_pos					 = _this select 0; 
_shelltype 			     = _this select 1; 
_shellspread			 = _this select 2; 
_nshell 				 = _this select 3; 
_sound 					 = _this select 4; 
_delay 					 = _this select 5;

if (isnil "_delay") then {_delay = 0};

for [{_i=0},{_i<_nshell},{_i=_i+1}] do
	{
		_bomb = _shelltype createVehicle [(_pos select 0) + _shellspread - 2*(random _shellspread) ,(_pos select 1) + _shellspread - 2*(random _shellspread), 250];
		_bomb setVelocity [(random 10) - (random 10), (random 10) - (random 10), -10];
		sleep 1; 
		if (_sound) then {[[[netid _bomb,_bomb],"SN_Flare_Fired_4"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP}; 
		sleep _delay;
	};
