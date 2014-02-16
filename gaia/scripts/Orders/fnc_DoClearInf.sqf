//==================================================================fnc_DoInfPatrol===============================================================================================
// Clear the area and or the house at the spot location
// 
// spirit 26-1-2014
//===========================================================================================================================================================================	
private ["_group","_NrOfBuildingWp","_zone","_pos"];

_group 			= _this select 0; 
_pos				=	_this select 1;

_NrOfBuildingWp = 0;

[_group] call fnc_RemoveWayPoints;

_NrOfBuildingWp 	 = [_group,_pos]call fnc_CreateBuildingWP;
//when no buildings found, put an SAD waypoint down
		if (_NrOfBuildingWp == 0) then
		{
			_dummy 	=  [_group,_pos,"SAD"] call fnc_addWaypoint;
		};
	
//Our result is waypoints
((count (waypoints _group)) - currentWaypoint _group)