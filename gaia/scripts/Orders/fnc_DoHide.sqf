//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our support guys. Yes they are 'easy' at the moment. Just make it work is the goal for release 1.
// 
// spirit 14-1-2014
//===========================================================================================================================================================================	
private ["_group","_pos","_zone"];

//Get the group
_group 			= _this select 0; 

//Clear what ever orders we had before.
[_group] call fnc_RemoveWayPoints;

//Get the zone
_zone	 = (((_group) getVariable ["GAIA_zone_intend",[]])select 0);

if !(isnil("_Zone")) then
{
	//Go somewhere
	_pos= [_group,_zone,"VEH_HILLS_FOREST_FLAT"] call fnc_CreateWP;
	
	if (count(_pos)>0) then 
		{
	
				//Sentry has the nice habit to end the waypoint ones they seen enemy. That is good as they will "hide" again then.
				_dummy 	=  [_group,_pos,"MOVE"] call fnc_addWaypoint;				
				_dummy 	=  [_group,_Pos,"SENTRY"] call fnc_addWaypoint;
					
				//Lets set the current Order.
				_group setVariable ["GAIA_Order"							, "DoHide", false];
				//Also note when we gave that order and where the unit was. It gives us a chance to check his progress and to 'unstuck' him if needed.
				//Also all orders have a lifespan. MCC_GAIA_ORDERLIFETIME
				_group setVariable ["GAIA_OrderTime"					, Time, false];
				_group setVariable ["GAIA_OrderPosition"			, (position leader _group), false];
					
					
			
	
		};
};
//Our result is waypoints
((count (waypoints _group)) - currentWaypoint _group)