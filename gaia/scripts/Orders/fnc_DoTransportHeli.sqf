/* ----------------------------------------------------------------------------
Function: fnc_DoTransportCar

Description:
	Organise transport Car

Parameters:
	- group (to be transported
	- group (transporter)

Returns:
	waypoints 

Author:
	Spirit, 17-2-2014

---------------------------------------------------------------------------- */
_group 								= _this select 0;
_trnsprtgrp						= _this select 1;

//player globalchat format ["%1 instappper, %2 vervoer",_group,_trnsprtgrp];

_PosCloseRoadStart = [];
_PosCloseRoadEnd	 = [];

//where is this dude going?
_wpPos = (waypointPosition [_group ,(count(waypoints _group)-1)]);
_wptype = waypointType [_group ,(count(waypoints _group)-1)];

			   	 

 //Make the transporter stop hiding
 _dummy =[_trnsprtgrp] call fnc_RemoveWayPoints;
 _dummy =[_group] call fnc_RemoveWayPoints;

_PosCloseRoadStart = (position leader _group); 			   	 		   	 
_PosCloseRoadEnd	= 	_wpPos;
  // Get in
 _wpGroup = _group addWaypoint [_PosCloseRoadStart, 0];
 _wpGroup	setWaypointType "GETIN";
 _wpGroup	setWaypointCompletionRadius 20;
 
 _wpTransporter	= _trnsprtgrp addWaypoint [_PosCloseRoadStart, 0];
 _wpTransporter	setWaypointType "LOAD";
 _wpTransporter	setWaypointCompletionRadius 20;
 _wpTransporter	setWaypointSpeed "FULL";
 
 //Synchronize them
 _wpGroup synchronizeWaypoint [_wpTransporter];
 
 
  // Get the fuck out
 _wpGroup = _group addWaypoint [_PosCloseRoadEnd, 0];
 _wpGroup	setWaypointType "GETOUT";
 _wpGroup	setWaypointCompletionRadius 20;
 //We go on alone, set us free
 _wpGroup setWaypointStatements ["true", "	(group this) 	setVariable ['GAIA_Order'							, 'DoPatrol', false];(group this) 	setVariable ['GAIA_CombinedOrder'							, GrpNull, false];"];
 
 _wpTransporter	= _trnsprtgrp addWaypoint [_PosCloseRoadEnd, 0];
 _wpTransporter	setWaypointType "TR UNLOAD";
 _wpTransporter	setWaypointCompletionRadius 20;				   	 
 //release both groups from each other
 
 
 //Synchronize them
 _wpGroup synchronizeWaypoint [_wpTransporter];
 
 //patrolling units will pick this up first
 _group 	setVariable ["GAIA_OriginalDestination",_wpPos , false];
 
 	//Lets set the current Order of the vehilce transporting ( so he dont get a new DoTransport when we are going)
	_trnsprtgrp	setVariable ["GAIA_Order"							, "DoTransport", false];
	_group 			setVariable ["GAIA_Order"							, "DoTransport", false];
	//Also note when we gave that order and where the unit was. It gives us a chance to check his progress and to 'unstuck' him if needed.
	//Also all orders have a lifespan. MCC_GAIA_ORDERLIFETIME
	_trnsprtgrp setVariable ["GAIA_OrderTime"					, Time, false];
	_trnsprtgrp setVariable ["GAIA_OrderPosition"			, (_PosCloseRoadEnd), false];
	
	_x 		 setVariable ["GAIA_CombinedOrder"			, (_group), false];
	_group setVariable ["GAIA_CombinedOrder"			, (_trnsprtgrp), false];
	
 
 


