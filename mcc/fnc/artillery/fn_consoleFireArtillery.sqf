//==================================================================MCC_fnc_consoleFireArtillery===============================================================================================
// Order AI or players to fire artillery
// Example: [_requestor,_x_correction,_y_correction,_missiontype] spawn MCC_fnc_consoleFireArtillery;
// _requestor: 			Object, Who called the artillery
// _x_correction: 		Integer
// _y_correction: 		Integer
//===========================================================================================================================================================================	

private ["_requestor","_x_correction","_y_correction","_cannons_to_fireReal","_cannonsObjects","_cannonsetup","_cannon","_splashpos","_firedelay",
         "_artitype","_nrshells","_spread"];

_requestor 				= _this select 0;
_x_correction 			= _this select 1;
_y_correction 			= _this select 2;

_cannons_to_fireReal 	= _requestor getVariable ["requesting_cannonsReal",[]];
	
//Find the real cannons		
_cannonsObjects = []; 
{
	_cannonsetup = _requestor getVariable format["Arti_%2_Cannon%1",_x, playerside];
	_cannonsObjects set [count _cannonsObjects, [MCC_bonCannons select (_x-1), _cannonsetup]]; 
} foreach _cannons_to_fireReal;

//initate fire mission
{
	_cannon 	= _x select 0;
	_splashpos 	= (_x select 1) select 0;
	_firedelay 	= (_x select 1) select 1;
	_artitype 	= (_x select 1) select 2;
	_nrshells 	= (_x select 1) select 3;
	_spread 	= (_x select 1) select 4;
	
	//X-correction
	_splashpos set [0, (_splashpos select 0) + (_x_correction *20)];
	_splashpos set [1, (_splashpos select 1) + (_y_correction *20)];
	
	if (isPlayer _cannon) then
	{
		[[_cannon,_splashpos,_firedelay,_artitype,_nrshells,_spread], "MCC_fnc_artyGetSolution", _cannon, false] spawn BIS_fnc_MP;
	}
	else
	{
		[_cannon,_splashpos,_firedelay,_artitype,_nrshells,_spread,side _requestor] spawn
		{
			_cannon 	= _this select 0;
			_splashpos 	= _this select 1;
			_firedelay 	= _this select 2;
			_artitype 	= _this select 3;
			_nrshells 	= _this select 4;
			_spread 	= _this select 5;
			_side	 	= _this select 6;
			
			_splashpos set [0, (_splashpos select 0) + (random _spread) - (random _spread)];
			_splashpos set [1, (_splashpos select 1) + (random _spread) - (random _spread)];
			
			//[[[netid _cannon,_cannon], 0],"MCC_fnc_broadcast",_side, false] spawn BIS_fnc_MP;
			for [{_i= 0},{_i < _nrshells},{_i = _i + 1}]  do
			{
				_splashpos set [0, (_splashpos select 0) + (random _spread) - (random _spread)];
				_splashpos set [1, (_splashpos select 1) + (random _spread) - (random _spread)];
			
				_cannon commandArtilleryFire [_splashpos, _artitype, 1];
				waituntil {canfire _cannon};
				sleep 3; 
				sleep _firedelay; 
			};
		};
	}; 
} foreach _cannonsObjects;