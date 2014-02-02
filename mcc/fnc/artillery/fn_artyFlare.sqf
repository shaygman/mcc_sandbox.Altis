//==================================================================MCC_fnc_artyFlare===============================================================================================
// Create artillery strike with sounds on given spot
// Example: [_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_fnc_artyFlare;
// _pos = position. Point of impact
//_shelltype = string. Ammuination class name
//_shellspread = integer. Spread radius.
// _nshell = integer. Number of shells per burst
// _sound = boolean, True - for impact wistle sound
//===========================================================================================================================================================================	
private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell", "_shell", "_i","_bomb","_bombpos","_delay"];
_pos					 = _this select 0; 
_shelltype 			     = _this select 1; 
_shellspread			 = _this select 2; 
_nshell 				 = _this select 3; 
_sound 					 = _this select 4; 
_delay 					 = _this select 5;

for [{_i=0},{_i<_nshell},{_i=_i+1}] do
	{
		_bomb = "GrenadeHand" createVehicle [(_pos select 0) + _shellspread - 2*(random _shellspread) ,(_pos select 1) + _shellspread - 2*(random _shellspread), 300];
		WaitUntil{(position _bomb select 2)<250};
		if (_sound) then {[[[netid _bomb,_bomb],format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP}; 
		WaitUntil{(position _bomb select 2)<220};
		_bombpos = position _bomb;
		deletevehicle _bomb;
		_bomb = "HelicopterExploSmall" createVehicle _bombpos;
		_shell = _shelltype createVehicle [_bombpos select 0,_bombpos select 1,(_bombpos select 2)+50];
		_shell setVelocity [(random 10) - (random 10), (random 10) - (random 10), -10];
		sleep _delay;
	};
