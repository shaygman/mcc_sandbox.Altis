//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our attack
// Example: [_group,_targetpos] call fnc_DoAttackInf
// spirit 20-1-2014
//===========================================================================================================================================================================
private ["_group","_TargetPos","_pos","_Degree","_NrOfBuildingWp"];

_group 			= _this select 0;
_TargetPos	=	_this select 1;



[_group] call GAIA_fnc_removeWaypoints;

_dummy	=[_group,_TargetPos, "SAD"] call GAIA_fnc_addAttackWaypoint;

((count (waypoints _group)) - currentWaypoint _group)



