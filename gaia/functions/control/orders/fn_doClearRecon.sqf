//==================================================================fnc_DoInfPatrol===============================================================================================
// Clear the area and or the house at the spot location
//
// spirit 26-1-2014
//===========================================================================================================================================================================
private ["_group","_NrOfBuildingWp","_zone","_pos"];

_group 			= _this select 0;
_pos				=	_this select 1;

_NrOfBuildingWp = 0;

[_group] call GAIA_fnc_removeWaypoints;

_NrOfBuildingWp 	 = [_group,_pos]call GAIA_fnc_generateBuildingPatrolWaypoints;
//when no buildings found, put an SAD waypoint down
		if (_NrOfBuildingWp == 0) then
		{
			_dummy 	=  [_group,_pos,"SAD"] call GAIA_fnc_addWaypoint;
		};

//Our result is waypoints
((count (waypoints _group)) - currentWaypoint _group)