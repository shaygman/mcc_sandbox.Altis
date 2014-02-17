//==================================================================fnc_DoInfPatrol===============================================================================================
// Validate if and organise transportation 
// 
// spirit 28-1-2014
//===========================================================================================================================================================================	
private ["_group"];

_group 			= _this select 0; 

_PosCloseRoadStart = [];
_PosCloseRoadEnd	 = [];
//where is this dude going?
_wpPos = (waypointPosition [_group ,(count(waypoints _group)-1)]);
_wptype = waypointType [_group ,(count(waypoints _group)-1)];

//Is he actualy going somewhere?
if (count(_wpPos)>0) then
	{
		
		//How fare does he need to travel?
		_dist = _wpPos distance (position leader _group);
		
		//If that is futther then the max range for slow speed groups, then he is legimate to receive transportation
		if (_dist > MCC_GAIA_MAX_SLOW_SPEED_RANGE) then
		{
			
			//Loop through all groups until we find a transportation dude
			{
				 _TransportGrp = _x;
				 if (
				   			//Seems like allgroups opens up with all sorts of empty groups, better check it
				   			((side _x) == (side _group))
				   			and
				   			(count(units _x)>0)
				   			and
				   			(alive (leader _x))
				   			and
				   			((behaviour leader _x)!="COMBAT")
				   			and
				   			//The transport vehicle must not be occupied
				   			((_x getVariable  ["GAIA_Order",""]) != "DoTransport")
				   			and
				   			// He must be able to do transport
				   			("DoTransport" in (_x getVariable  ["GAIA_Portfolio",[]])) 
				   			and
				   			//He must be able to hold all of us
				   			((count units _group)<=(_x getVariable  ["GAIA_cargo",0]))			
				   			and
				   			//The vehicle cannot be so far out from the requesting group that it even exeeds its own max range based on medium speed
				   			(((leader _group) distance (leader _x))< MCC_GAIA_MAX_MEDIUM_SPEED_RANGE)	
				   			and
				   			//The distance to transport must exceed the distance to the transport by 2 times.
				   			((_dist*2) >  ((leader _group) distance (leader _x)))
				   			and
				   			//A transporter takes atleast MCC_GAIA_TRANSPORT_RESTTIME seconds of breaktime before getting a new order
				   			((time-(_x getVariable  ["GAIA_Ordertime",0]))>MCC_GAIA_TRANSPORT_RESTTIME)
				   			and
				   			//Put in some random factor to prevent predictable behavior (chance is each cycle so can be low)
				   			(random(10)>8)	
				   		
			  		)
			   then
			   //We found a possible dude
			   {
			   	 _nearRoad 					= (leader _group nearRoads 300);
			   	 if (count(_nearroad)>0) then
			   	 	//Arrange a pickup on the side of the street, else we gonna have ai crazyness going on
			   	 	{_road = (([_nearRoad,[],{leader _group distance _x},"ASCEND"] call BIS_fnc_sortBy )   select 0);
						 _roadConnectedTo = roadsConnectedTo _road;
						 _connectedRoad = _roadConnectedTo select 0;
						 _direction = [_road, _connectedRoad] call BIS_fnc_DirTo;			   	 		
			   	 	 _PosCloseRoadStart = [(position _road), 7, (_direction - 45)] call BIS_fnc_relPos;
			   	 	};
			   	 	

			   	 _nearRoad 					= ( _wpPos nearRoads 300);
			   	 if (count(_nearroad)>0) then			   	 
			   	 {_PosCloseRoadEnd   = position(([_nearRoad,[],{_wpPos distance _x},"ASCEND"] call BIS_fnc_sortBy )   select 0);};
			   	 
			   	 if (
			   	 				//There is a road found to pickup and a road foudn to drop him off
			   	 				(count(_PosCloseRoadStart)>0) and (count( _PosCloseRoadEnd)>0)
			   	 				
			   	 				
			   	 		) then
			   	 {
				   	 //Make the transporter stop hiding
				   	 _dummy =[_x] call fnc_RemoveWayPoints;
				   	 _dummy =[_group] call fnc_RemoveWayPoints;
									   	 		   	 
		   	 			
				   	  // Get in
				   	 _wpGroup = _group addWaypoint [_PosCloseRoadStart, 0];
				   	 _wpGroup	setWaypointType "GETIN";
				   	 _wpGroup	setWaypointCompletionRadius 20;
				   	 
				   	 _wpTransporter	= _x addWaypoint [_PosCloseRoadStart, 0];
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
				   	 
				   	 _wpTransporter	= _x addWaypoint [_PosCloseRoadEnd, 0];
				   	 _wpTransporter	setWaypointType "TR UNLOAD";
				   	 _wpTransporter	setWaypointCompletionRadius 20;				   	 
				   	 //release both groups from each other
				   	 
				   	 
				   	 //Synchronize them
				   	 _wpGroup synchronizeWaypoint [_wpTransporter];
				   	 
				   	 //patrolling units will pick this up first
				   	 _group 	setVariable ["GAIA_OriginalDestination",_wpPos , false];
				   	 
				   	 	//Lets set the current Order of the vehilce transporting ( so he dont get a new DoTransport when we are going)
							_x 			setVariable ["GAIA_Order"							, "DoTransport", false];
							_group 	setVariable ["GAIA_Order"							, "DoTransport", false];
							//Also note when we gave that order and where the unit was. It gives us a chance to check his progress and to 'unstuck' him if needed.
							//Also all orders have a lifespan. MCC_GAIA_ORDERLIFETIME
							_x setVariable ["GAIA_OrderTime"					, Time, false];
							_x setVariable ["GAIA_OrderPosition"			, (_PosCloseRoadEnd), false];
							
							_x 		 setVariable ["GAIA_CombinedOrder"			, (_group), false];
							_group setVariable ["GAIA_CombinedOrder"			, (_x), false];
							
				   	 
				   	 
			   	 };
			 	 };
		  	
		  	//If we have waypoints, stop (more then 1 as the initial patrol waypoint is the first). 
		  	//If this fails, every transport in the universe will try to serve us, maybe something smarter 
		  	if (		((_group getVariable  ["GAIA_Order",""]) == "DoTransport")) exitwith {true;};
		  	
		  }forEach ([AllGroups,[],{(leader _group) distance (leader _x)},"ASCEND",{alive (leader _x)}] call fnc_SortGroupsByCA);
		  	//AllGroups;
			
		};
	};	
 
//Our result is waypoints
((count (waypoints _group)) - currentWaypoint _group)