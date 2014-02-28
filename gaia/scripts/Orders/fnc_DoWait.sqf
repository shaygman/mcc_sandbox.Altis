//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our support guys. Yes they are 'easy' at the moment. Just make it work is the goal for release 1.
// 
// spirit 14-1-2014
//===========================================================================================================================================================================	
private ["_group","_pos","_zone","_newpos","_landpos","_landpad"];

//Get the group
_group 			= _this select 0; 

_landpos  = [];


//Clear what ever orders we had before.
[_group] call fnc_RemoveWayPoints;

//Get the zone
_zone	 = (((_group) getVariable ["GAIA_zone_intend",[]])select 0);



if !(isnil("_Zone")) then
{
	
	//Check if the dude already has a 'home'. All helicopters need position where they land and go home to.
	if (  ((_group) getVariable ["GAIA_LandingSpot",[0,0,0]] distance [0,0,0]==0)  ) then	
	{ 
		if (isTouchingGround (vehicle leader _group)) then
			{_landpos = (position leader _group);}
		else
			{_landpos =  [([_zone,"ARM_HILLS_FLAT",(side _group)] call  fnc_GetPosition), 0,100, 12, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;};
		
		_dummy = ("Land_HelipadEmpty_F" createvehicle _landpos);
		_group setVariable ["GAIA_LandingSpot"							, _landpos  , false]; 
	};
	
	
	if (  ((_group) getVariable ["GAIA_LandingSpot",[0,0,0]] distance [0,0,0]!=0)  ) then	
	{
		_wp = _group addWaypoint [((_group) getVariable ["GAIA_LandingSpot",[0,0,0]]), 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 20;
		_wp setWaypointSpeed "LIMITED";					
		_wp setWaypointStatements ["true","(Vehicle this) land 'land'"];
		
		_dummy 	=  [_group,((_group) getVariable ["GAIA_LandingSpot",[0,0,0]]),"SENTRY"] call fnc_addWaypoint;
		
		/*
		_wp setWaypointStatements ["true", "player globalchat 'hoi hoi';(vehicle  leader _group) land 'LAND';"];
		(vehicle  leader _group) land "LAND";
		_wp = _group addWaypoint [position((_group) getVariable ["GAIA_LandingSpot",objNull]), 0];
		_wp setWaypointType "HOLD";
		_wp setWaypointCompletionRadius 10;
		_wp setWaypointSpeed "LIMITED";					
		
		*/				
		//Lets set the current Order.
		_group setVariable ["GAIA_Order"							, "DoWait", false];
		//Also note when we gave that order and where the unit was. It gives us a chance to check his progress and to 'unstuck' him if needed.
		//Also all orders have a lifespan. MCC_GAIA_ORDERLIFETIME
		_group setVariable ["GAIA_OrderTime"					, Time, false];
		_group setVariable ["GAIA_OrderPosition"			, (position leader _group), false];
							
	};	
	
		
};
//Our result is waypoints
((count (waypoints _group)) - currentWaypoint _group)