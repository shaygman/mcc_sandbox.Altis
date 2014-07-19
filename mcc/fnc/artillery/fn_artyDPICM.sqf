//==================================================================MCC_fnc_artyDPICM===============================================================================================
// Create DPICM artillery barage
// Example: [_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_fnc_artyDPICM;
// _pos = position. Point of impact
//_shelltype = string. Ammuination class name
//_shellspread = integer. Spread radius.
// _nshell = integer. Number of shells per burst
// _sound = boolean, True - for impact wistle sound
//===========================================================================================================================================================================			
private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell", "_shell", "_i","_burst","_bombpos","_j","_disp","_hgt","_tr","_delay"];
_pos					 = _this select 0; 
_shelltype 			     = _this select 1; 
_shellspread			 = _this select 2; 
_nshell 				 = _this select 3; 
_sound 					 = _this select 4; 
_delay 					 = _this select 5; 
_hgt = 200;

if (isnil "_delay") then {_delay = 0};
for [{_i=0},{_i<_nshell},{_i=_i+1}] do
	{
		_shell = _shelltype createVehicle [(_pos select 0) + _shellspread - 2*(random _shellspread) ,(_pos select 1) + _shellspread - 2*(random _shellspread), _hgt];
		sleep 2; 
		if (_sound) then {[[[netid _shell,_shell],format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP}; 
		WaitUntil{(position _shell select 2)<100};
		_bombpos = getpos _shell;
		_burst = "HelicopterExploSmall" createVehicle _bombpos;
			sleep (0 + random 0.1);
		for "_j" from 1 to round 15 do
			{
			_disp = 40;
			_clusterb = "Mo_cluster_AP" createVehicle [(_bombpos select 0),(_bombpos select 1),(_bombpos select 2) + ((random 1) - (random 1))];
			_clusterb setVelocity [(random _disp) - (random _disp), (random _disp) - (random _disp), -50];
			
			/*
			_tr = "#particlesource" createVehicle getpos _clusterb;
			_tr setParticleRandom [0.2, [0.1, 0.1, 0.1], [0.1, 0.1, 0.1], 0.1, 0.2, [0, 0, 0, 0], 0.01, 0.01];
			_col = [[1,1,1,0.4], [1,1,1,0]];
			_tr setParticleParams [["A3\data_f\ParticleEffects\Universal\smoke.p3d", 16, 7, 48,1],"", "Billboard", 1, 4, [0, 0, 0],[0,0,0], 0.3, 1, 0.8, 0.75, [0.4],_col,[1],0.1,0.1,"","",_clusterb,random 360];    
			_tr setdropinterval 0.004; 
			
			_tr spawn {_tr = _this;sleep (1 + (random 0.5)); deletevehicle _tr};
			*/
			sleep (0.05 + random 0.05);
			};
		sleep _delay; 
	};
