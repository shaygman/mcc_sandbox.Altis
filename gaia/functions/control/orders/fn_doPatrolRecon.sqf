//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our awesome patrol
// Example: [_group,_zone] call fnc_DoInfPatrol
// spirit 14-1-2014
//===========================================================================================================================================================================
private ["_group","_NrOfBuildingWp","_zone","_pos"];

_group 			= _this select 0;
_zone				=	_this select 1;



[_group] call GAIA_fnc_removeWaypoints;


//Go somewhere
_pos= [_group,_zone,"INF_HILLS_FLAT_FOREST"] call GAIA_fnc_generateWaypoints;
_NrOfBuildingWp 	 = [_group,_pos]call GAIA_fnc_generateBuildingPatrolWaypoints;

//Our result is waypoints
((count (waypoints _group)) - currentWaypoint _group)