//==================================================================MCC_fnc_IedDisablingExplosion===============================================================================================
// Create a disabling explosion, explosion dimiter will be decided by the _trapvolume
//Disabling explosion will disable vehicles without harming the troops inside or  it will incapitate infantry
// Example: [_pos,_trapvolume] spawn MCC_fnc_IedDisablingExplosion; 
// _pos = position, center of the explosion.
// _trapvolume = string, "small", "medium", "large"
//==================================================================================================================================================================================

private ["_pos", "_volume","_hitRadius","_killRadius","_targetUnits","_random","_shell","_effect"];
_pos 	= _this select 0;
_volume = _this select 1; 
_random	= 0;
switch (_volume) do
{
   case "small":	
	{ 
	   "SmallSecondary" createVehicle _pos;
	   _hitRadius 	= 20;
	   _killRadius	= 10;
	};
	
	case "medium":	
	{ 
	   "M_AT" createVehicle _pos;
		_hitRadius = 30;
		_killRadius	= 20;
	};
	
	case "large":	
	{ 
	   "M_AT" createVehicle _pos;
	   _hitRadius = 50;
	   _killRadius	= 30;
	};
};

_targetUnits = _pos nearObjects _hitRadius;
{
_random = random 10;
if(_x isKindOf "Man") then	
{
	if (((_x distance _pos) < _killRadius) && (_random > 1))then	
	{
		_x setHit ["legs", 0.9];
		_x setdamage 0.7;		
	};
};

if(_x isKindOf "Car") then
	{
		if (((_x distance _pos) < _killRadius) && (_random > 1))then	{
			_x setVariable ["ace_sys_vehicledamage_enable", false];					
			_x setdamage 0.7;
			[[2,compile format ["objectFromNetId '%1' setHit ['wheel_1_1_steering', 1]", netid _x]], "MCC_fnc_globalExecute", _x, false] spawn BIS_fnc_MP;
			[[2,compile format ["objectFromNetId '%1'  setHit ['wheel_2_1_steering', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			[[2,compile format ["objectFromNetId '%1'  setHit ['motor', 1]", _x]], "MCC_fnc_globalExecute", netid _x, false] spawn BIS_fnc_MP;
			[[2,compile format ["objectFromNetId '%1'  setHit ['glass1', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
			[[2,compile format ["objectFromNetId '%1'  setHit ['glass2', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
			[[2,compile format ["objectFromNetId '%1'  setHit ['glass3', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
			[[2,compile format ["objectFromNetId '%1'  setHit ['glass4', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
			[[2,compile format ["objectFromNetId '%1'  setHit ['glass5', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
			[[2,compile format ["objectFromNetId '%1'  setHit ['glass6', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
			if (isServer) then {_effect = "test_EmptyObjectForFireBig" createVehicle (getpos _x); _effect attachto [_x,[0,0,0]];};
			sleep 15;
			_x setdamage 1; 
			//[-2, {[_this,5,time,false,true] spawn BIS_Effects_Burn}, _x] call CBA_fnc_globalExecute;
		} else	{
					_x setVariable ["ace_sys_vehicledamage_enable", false];
					_x setdamage 0.4;
					[[2,compile format ["objectFromNetId '%1' setHit ['wheel_1_1_steering', 1]", netid _x]], "MCC_fnc_globalExecute", _x, false] spawn BIS_fnc_MP;
					[[2,compile format ["objectFromNetId '%1'  setHit ['wheel_2_1_steering', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					[[2,compile format ["objectFromNetId '%1' setHit ['motor', 0.7]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
					[[2,compile format ["objectFromNetId '%1' setHit ['glass1', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
					[[2,compile format ["objectFromNetId '%1' setHit ['glass2', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
					[[2,compile format ["objectFromNetId '%1' setHit ['glass3', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
					[[2,compile format ["objectFromNetId '%1' setHit ['glass4', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
					[[2,compile format ["objectFromNetId '%1' setHit ['glass5', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
					[[2,compile format ["objectFromNetId '%1' setHit ['glass6', 1]", _x]], "MCC_fnc_globalExecute",netid _x, false] spawn BIS_fnc_MP;
				}
	};
		
if(_x isKindOf "Tank") then
	{
		if (((_x distance _pos) < _killRadius) && (_random > 1))then	{
				_x setVariable ["ace_sys_vehicledamage_enable", false];					
				_x setdamage 0.7;
				[[2,compile format ["objectFromNetId '%1' setHit ['Ltrack', 1]",netid _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
				[[2,compile format ["objectFromNetId '%1' setHit ['Rtrack', 1]",netid _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
				[[2,compile format ["objectFromNetId '%1' setHit ['motor', 1]",netid _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
				if (isServer) then {_effect = "test_EmptyObjectForFireBig" createVehicle (getpos _x); _effect attachto [_x,[0,0,0]];};
				sleep 15;
				_x setdamage 1; 
				//[-2, {[_this,5,time,false,true] spawn BIS_Effects_Burn}, _x] call CBA_fnc_globalExecute;
			};
	};
} forEach _targetUnits;

