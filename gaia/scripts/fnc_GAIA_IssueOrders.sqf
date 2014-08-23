/* ----------------------------------------------------------------------------
Function: fnc_GAIA_Issue orders.

Description:
	This function sends all groups of GAIA on their new destination. May the force be with us!

Parameters:
	- Side

Returns:
	true

Author:
	Spirit, 24-1-2014

---------------------------------------------------------------------------- */

private ["_side"
				,"_CA"
				,"_grp"
				,"_zns"
				,"_trg"
				,"_tbc"
				,"_CaPoints"
				,"_GrpIsInCombat"
				,"_SelectCAisClosesttoGroup"
				,"_Grpcost"
				,"_PointsSpend"
				,"_NrGrpsSend"
				,"_StartTimeIssueOrders"
				,"_GroupIsFleeing"
				,"_EnoughPointsSpend"
				,"_MinimumResponseSend"
				,"_NumberOfForces"
				,"_CanDoClear"
				,"_GroupBusy"
				,"_CanAttackCA"
				,"_CanDoAttack"
				,"_MortarFired"
				,"_CaHoldsValidTargets"
				,"_IsGaiaControlled"
				,"_Spot"];

_side 										= _this select 0;
_CA												=	[];
_grp											= [];
_zns											= [];
_trg											= [];
_tbc											= [];
_CaPoints									= 0;
_SelectCA									= [];
_GrpIsInCombat						= false;
_SelectCAisClosesttoGroup = false;
_GroupBusy								= false;
_IsGaiaControlled					= false;
_CanDoClear								= false;
_Grpcost									= 0;
_PointsSpend							= 0;
_NrGrpsSend								= 0;
_GroupHasOrdersThisRound	= false;
_GroupIsFleeing						= false;
_EnoughPointsSpend				= false;
_MinimumResponseSend			= false;
_NumberOfForces						= 0;
_Spot											= [];
_CanAttackCA							= false;
_CaHoldsValidTargets			= false;
_CanDoAttack							= false;
_mpos											= [];

	
//Get the right side arrays in
switch (_side) do
			{
			  case west				: {
			  		  						 _CA 	= MCC_GAIA_CA_WEST;			  		  						 
			  		  						 _zns	=	MCC_GAIA_ZONES_WEST;			 
			  		  						 _tbc	= (MCC_GAIA_TARGETS_WEST select 3)
			  		  						 
			  									};
			  case east				: {
			  									 _CA 	= MCC_GAIA_CA_EAST;			  									 
			  									 _zns	=	MCC_GAIA_ZONES_EAST;
			  									 _tbc	= (MCC_GAIA_TARGETS_WEST select 3)
			  									 
			  									};
			  case independent: {
			  	                 _CA 	= MCC_GAIA_CA_INDEP;			  	                 
			  	                 _zns	=	MCC_GAIA_ZONES_INDEP;			  	  
			  	                 _tbc	= (MCC_GAIA_TARGETS_WEST select 3)               
			  	                 
			  	                };
			};
			
//Note the time, as this is the time where THIS round is running the show. 
_StartTimeIssueOrders = time;
			
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									CANCEL OBSOLETE ORDERS
//
//									Cancel Orders of groups Attacking CA'S that no longer exist.
//									Cancel all Hide orders that are in combat(so they build a new one).
//									Cancel orders of a group that has changed his class.
//
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  

{
	 if (
			   			//Seems like allgroups opens up with all sorts of empty groups, better check it
			   			((side _x) == _HQ_side)
			   			and
			   			(count(units _x)>0)
			   			and
			   			(alive (leader _x))
		  )
	then			
	{
			
			
			
			//Count the current number of groups (see under for need of it).
			_NumberOfForces	 = _NumberOfForces+ 1;
			
			
			//Mortar group is firing on a CA that no longer exists 
			//We cancel it to simulate that the spotter has died		
			if 	(
						//The Target of the mortar is no longer a CA
						!((_x getVariable  ["GAIA_MortarTarget",[0,0,0]]) in _ca)	
						and 
						//The order he has is indeed mortar stuff.
						((_x getVariable  ["GAIA_Order",""]) != "DoMorter")					
						and			
						//He has actualy opened up his mortar rounds by atleast first cycle
						(_x getVariable ["GAIA_MortarRound",0]>0)
					)
			then {
							/*player globalchat "1";*/
							[_x] call fnc_RemoveWayPoints; 
							
							_x setVariable ["GAIA_MortarRound"					, 0, false];
							_x setVariable ["GAIA_MortarTarget"					,[0,0,0] , false];		
					 };			
			
			//Cancel orders when the class has changed			
			
			if ((_x getVariable ["GAIA_class","None"])!=(_x getVariable ["GAIA_PreviousClass","None"])) 
			then {[_x] call fnc_RemoveWayPoints;/*player globalchat "2"; */};			
			
			
			//Chancel orders when the zone is moved, except when attacking, fortifying or in combat (combat cancel orders are later)
		  if  (
			  		(count(_x getVariable  ["GAIA_zone_intend",[]])>1)
			  		and
			   		((_x getVariable  ["GAIA_Order",""]) != "DoAttack")
						and
						((_x getVariable  ["GAIA_Order",""]) != "DoFortify")	 
						and
						(behaviour(leader _x)!="COMBAT")				
					)
			then
		  	{
		  		//Check if the trigger detector for changed zone is active (zee analzye forces)
		  		if (missionNamespace getVariable [ "gaia_zone_changed_"+((_x getVariable  ["GAIA_zone_intend",[]])select 0),false]) then
		  			{
		  				[_x] call fnc_RemoveWayPoints; 
		  			};
	  		};
		
	
			
			//On combined order, the group that is combined must be on same order 
			if (
						 (!isnull(_x getVariable  ["GAIA_CombinedOrder",grpNull]) )		
						 and
						 (_x getVariable  ["GAIA_Order",""])!=((_x getVariable  ["GAIA_Combinedorder",grpNull]) getVariable  ["GAIA_Order",""])						 						 				 
					)
			then {
							[_x] call fnc_RemoveWayPoints;
							/*player globalchat "3";*/
					 };
      
      					 
					 
			//The group where i combine with must be combined to me
			if (
						 (!isnull(_x getVariable  ["GAIA_CombinedOrder",grpNull]) )								 
						 
					)
			then {
							if ((((_x getVariable  ["GAIA_CombinedOrder",grpNull]))getVariable  ["GAIA_CombinedOrder",grpNull])!=_x)
						  then {[_x] call fnc_RemoveWayPoints;/*player globalchat "4";*/};
					 };
					 
		
			
			// Cancel orders when unit is in combat and not doing a DoAttack
			//But DONT do that if it holds the air boyx
			//And not when he is in fortify
			if (
						 ((_x getVariable  ["GAIA_Order",""]) != "DoAttack")
						 and
						  ((_x getVariable  ["GAIA_Order",""]) != "DoFortify")	 
						  and
						 (behaviour(leader _x)=="COMBAT")			
						 and						 
						 !((([_HQ_side,([_CA,leader _x] call BIS_fnc_nearestPosition)] call fnc_GetCAPoints) select 0 )in ["Helicopter","Autonomous"])
					)
			then {[_x] call fnc_RemoveWayPoints;/*player globalchat "5"+(_x getVariable  ["GAIA_Order",""]);*/};
			
			// This order is so old, Cancel it. No clue wtf he is doing.
			//Except when fortify
			if (
						 ((time - (_x getVariable  ["GAIA_OrderTime",0])) > MCC_GAIA_MAX_ORDER_AGE)			
						 and
						 ((_x getVariable  ["GAIA_Order",""]) != "DoFortify")	 
					)
			then {[_x] call fnc_RemoveWayPoints;/*player globalchat "Timeout6";*/};
			
			//Candel DoAttack order that attacks a no longer existing CA
			if (
						!((_x getVariable  ["GAIA_OrderPosition",[0,0,0]]) in _ca)
						and
						((_x getVariable  ["GAIA_Order",""]) == "DoAttack")
					) 
			then	{[_x] call fnc_RemoveWayPoints;/*player globalchat "7";*/};
	};
}forEach AllGroups;

// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									ORGANISE DEFENSIVE ORDERS (FOR NOW FORTIFY)
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
{
	 if (
			   			//Seems like allgroups opens up with all sorts of empty groups, better check it
			   			((side _x) == _HQ_side)
			   			and
			   			(count(units _x)>0)
			   			and
			   			(alive (leader _x))
			   			and
			   			(count(_x getVariable  ["GAIA_zone_intend",[]])>1)			  
			   			and
			   			((_x getVariable  ["GAIA_Order",""]) != "DoFortify")
		  )
	then			
	{
		if (((_x getVariable  ["GAIA_zone_intend",[]]) select 1)=="FORTIFY") then
			{_dummy=[_x,(position leader _x)] call fnc_DoFortify;};
	};
		  
}forEach AllGroups;



// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									ORGANISE ATTACKS ON Conflict Area's (CA's)
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  



{

	_SelectCA = _x;
	
	//How many groups shall we maximum send in to one conflict area? That is depending on how many ca and how many groups we command.
	//Lets say not more then half the forces shoudl respond to a maximum, but 2 at a minimum (unless you have one)
	//_MinimumResponse =   round(random(3)); 
	
	//Dynamic set max response to CA variable
	//If not set, then set it (so we dont determine this each cycle again). Based on CA priority the numbers might not be met.
	 _CAvar = "CA" + str(_SelectCA); 
	 _MinimumResponse = missionNamespace getVariable [_CAvar,0];
	 if (_MinimumResponse==0) then	 
   	{
  		missionNamespace setVariable [_CAvar, (round(random(2))) ];
  		_MinimumResponse = missionNamespace getVariable [_CAvar,1];
   	};
   
	
	
	//Determine Points of current CA (with how much do we need to attack this? (already taking multipier in effect)).
	_CaPoints = ([_side,_SelectCA] call fnc_GetCAPoints) select 2;
	
	 
	
	//We start with zero points spend, each attacking group has a point cose. We stop when we meet the CA Cost
	_PointsSpend = 0;
	
	// Send a minimum of groups, even if points are met
	_NrGrpsSend  = 0;
	
	//Now for each group make sure we check what he needs to do.
	{
		 if (
			   			//Seems like allgroups opens up with all sorts of empty groups, better check it
			   			((side _x) == _HQ_side)
			   			and
			   			(count(units _x)>0)
			   			and
			   			(alive (leader _x))
			   			and
			   			(count(_x getVariable  ["GAIA_zone_intend",[]])>1)
		   			)
		 then
		 {				
				
				//Zone intend holds ["Zonenumber","DEFEND"] (Or ATTACK or FORTIFY)
				if (count(_x getVariable  ["GAIA_zone_intend",[]])>1) then
				{
					_CanDoAttack = (	
													(((_x getVariable  ["GAIA_zone_intend",[]]) select 1)=="MOVE")
												 	or
												 	(
												 		(((_x getVariable  ["GAIA_zone_intend",[]]) select 1)=="NOFOLLOW")
												 		and
												 		([_SelectCA,((_x getVariable  ["GAIA_zone_intend",[]]) select 0)] call fnc_PosIsInMarker)
												 	)
												 );
					
					
				}
				else
				{
					
					_CanDoAttack = false;
					/*
					_grp = _x;
					//Non GAIA controlled units will be send into the attack if they are inside a zone
					{
						if ([(position leader _grp ),_x] call fnc_PosIsInMarker) exitwith {_CanDoAttack=true};
					}foreach _zns;
					*/
				};
				
				//Check the range of our dude. If however the CA is in our zone, then we dont care about the range
				
				if ((_CanDoAttack) and (count(_x getVariable  ["GAIA_zone_intend",[]])>1)) then
				{
					_CanDoAttack =
					(
					 (
					 	((_x getVariable  ["GAIA_speed",""])=="SLOW" and ((leader _x) distance _SelectCA)<MCC_GAIA_MAX_SLOW_SPEED_RANGE)
					 	or 
					 	([_SelectCA,((_x getVariable  ["GAIA_zone_intend",[]]) select 0)] call fnc_PosIsInMarker)
					 )
					 or 
					 (
					 	((_x getVariable  ["GAIA_speed",""])=="MEDIUM" and ((leader _x) distance _SelectCA)<MCC_GAIA_MAX_MEDIUM_SPEED_RANGE)
					 	or 
					 	([_SelectCA,((_x getVariable  ["GAIA_zone_intend",[]]) select 0)] call fnc_PosIsInMarker)
					 )			
					 or
					 (
					 	((_x getVariable  ["GAIA_speed",""])=="FAST" and ((leader _x) distance _SelectCA)<MCC_GAIA_MAX_FAST_SPEED_RANGE)
					 	or 
					 	([_SelectCA,((_x getVariable  ["GAIA_zone_intend",[]]) select 0)] call fnc_PosIsInMarker)
					 )								 	 
					);
				};
				
				
				//Futher checks on if we are allowed to attack 
				if (_CanDoAttack) then
				{
						//Does the group have the order DoAttack in its portfolio?
						_CanDoAttack							= ( 
																					 ("DoAttack" in (_x getVariable  ["GAIA_Portfolio",[]])) 
																					 and
																					 ( 
																							(((_x getVariable ["GAIA_class",""]) in ["Ship","Submarine"]) and (surfaceIsWater(_SelectCA)))
																							or
																							!(((_x getVariable ["GAIA_class",""]) in ["Ship","Submarine"]) and !(surfaceIsWater(_SelectCA)))
																					 )
																					);
				
				};
				//Is the group in combat?
				_GrpIsInCombat 						= (behaviour(leader _x)=="COMBAT");				
							
				//Is the selected Conflict Area the most close to the current group?
				_SelectCAisClosesttoGroup	= ((([_CA,leader _x] call BIS_fnc_nearestPosition) distance _SelectCA)==0);
				
				//Are we under control of gaia
				_IsGaiaControlled = (count(_x getVariable  ["GAIA_zone_intend",[]])>1);
				
				
				_CaHoldsValidTargets			= !((([_HQ_side,_SelectCA] call fnc_GetCAPoints)select 0) in ["Helicopter","Autonomous"]);
				
				//What is the cost in points of the current group?
				_Grpcost 									= _x getVariable ["GAIA_points",0];				
				
				
				//Did we already give this group an order or was it last round?
				_GroupHasOrdersThisRound	= ((_x getVariable  ["GAIA_Ordertime",0]) > _StartTimeIssueOrders);
				
				//Is this group fleeing?
				_GroupIsFleeing						= fleeing (leader _x);
				
				//Did we send more then enough points in troops already  compared to the points in the ca?
				_EnoughPointsSpend				= (_PointsSpend >_CaPoints);
				
				//The maximum number of groups that will be send to this CA (apart from points, that form the bare minimum
				_MinimumResponseSend			= (_NrGrpsSend>_MinimumResponse);
				


			 //The cases below are winner cases. In other words, the conditions to allow an attack				
		   switch (true) do
								{
					  			//Group is fleeing, spending points on this shit is useless. Execute him?		  							
					  			case (					  							
					  							_GroupIsFleeing
								  				)										: {	
								  					 														//Clear the dude till he clears his mind.
								  					 														//We do not count him into the attack
								  					 														_dummy=[_x] call fnc_RemoveWayPoints;								  					 														
								  															};
					  			
					  			
					  			
					  			//First come first serve, so the order is important here
					  			case (
					  							//The Group is in Combat, his is allowed to attack and the CA we check is the closest CA for him
					  							//Even if the points are already spend, he is simply "involved" (combat) and not by choice. So count him in.
					  							_GrpIsInCombat 
					  							and 	
					  							_CanDoAttack 
					  							and
					  							_IsGaiaControlled
					  							and 
					  							_SelectCAisClosesttoGroup
					  							and
					  							!_GroupHasOrdersThisRound
					  							and
					  							!_GroupIsFleeing
					  							and
					  							_CaHoldsValidTargets
								  					 )										: {	
								  					 														
								  					 														_dummy=[_x,_SelectCA] call fnc_DoAttack;
								  					 														_PointsSpend = _PointsSpend + _Grpcost;
								  					 														_NrGrpsSend	 = _NrGrpsSend + 1;
								  																	};
					  			case (
					  							//Not in combat and can do an attack. The most potential of all groups we look for.
					  							(!_EnoughPointsSpend	or !_MinimumResponseSend)				  							
					  							and
					  							!_GrpIsInCombat 
					  							and 	
					  							_CanDoAttack 			
					  							and
					  							_IsGaiaControlled		  							
					  							and
					  							!_GroupHasOrdersThisRound
					  							and
					  							!_GroupIsFleeing
					  							and
					  							_CaHoldsValidTargets
								  					 )										: {	
								  					 														
								  					 														_dummy=[_x,_SelectCA] call fnc_DoAttack;
								  					 														_PointsSpend = _PointsSpend + _Grpcost;
								  					 														_NrGrpsSend	 = _NrGrpsSend + 1;
								  																	};

								};  
		   	 			      	 	
			
		 };			
		 //Next CA
		 sleep 0.1;
	}forEach 	([AllGroups,[],{_SelectCA distance (leader _x)},"ASCEND",{alive (leader _x)}] call fnc_SortGroupsByCA); 
	


	//We boot through all Conflict Area's in already pre-sorted order of priority
} forEach _CA;

// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									Do Clear Spots (old targets) -> Boots on the ground needed
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  

{
	_Spot = _x;
	_SpotInfo = (_Spot getVariable ["GAIA_TargetInfo",[]]);
	if (count(_SpotInfo)>0) then
		{
		 _SpotPos = _SpotInfo select 1;
				{
				 if (
					   			//Seems like allgroups opens up with all sorts of empty groups, better check it
					   			((side _x) == _HQ_side)
					   			and
					   			(count(units _x)>0)
					   			and
					   			(alive (leader _x))
					   			and
					   			(count(_x getVariable  ["GAIA_zone_intend",[]])>1)		   				

				  )
					then			
					{			
				
						//Prepare checking conditions for our dear spots
						
						
						//Is the group in combat?
						_GrpIsInCombat 						= (behaviour(leader _x)=="COMBAT");							
						
						//Does the group have the order DoClear in its portfolio?
						_CanDoClear								=  ("DoClear" in (_x getVariable  ["GAIA_Portfolio",[]])) ;
						
						//Is this group fleeing?
						_GroupIsFleeing						= fleeing (leader _x);				
						
						
						//Group is  busy to attack by DoAttack?
						_GroupBusy				=	((_x getVariable  ["GAIA_Order",""]) in ["DoAttack","DoClear"]) ;
						
						//Is somebody already moving over there? 
						_SpotIsBeingCleared				= [_SpotPos,_side] call fnc_isblacklisted;
						
						//The dude should be hiding outside a CA (or we will already attack it)
						_SpotIsOutsideCA					= !((count([_CA, {(_x distance (_SpotPos)<100)}] call BIS_fnc_conditionalSelect))>0);			
						
						//He cannot be to far out (only one range as only footmobiles can clear)
						//Or the spot is in the zone from the group, we clear it, no matter how far we need to go!
						_SpotIsWithinRange				= (
																					(((leader _x) distance _SpotPos)<MCC_GAIA_MAX_SLOW_SPEED_RANGE  	)
																				  or 						 	
						 															([_SpotPos,((_x getVariable  ["GAIA_zone_intend",[]]) select 0)] call fnc_PosIsInMarker)
																				);
								   switch (true) do
										{
							  			//The Clear spot dude cases are here. So far i can think of only one case. Who knows later more? I love switch true
							  			case (					  							
							  							!_GrpIsInCombat
							  							and
							  							_CanDoClear
							  							and
							  							!_GroupIsFleeing
							  							and 
							  							!_GroupBusy
							  							and
							  							!_SpotIsBeingCleared							  							
							  							and
							  							_SpotIsOutsideCA
							  							and
							  							_SpotIsWithinRange
							  							
							  							
							  							
										  		 )										: {	
										  					 														//Clear the area, something fishy happened here recently
										  					 														_dummy=[_x,_SpotPos] call fnc_DoClear;								  					 														
										  														};
					  			
					  			

										};  
					};
				}forEach ([AllGroups,[],{_SpotPos distance (leader _x)},"ASCEND",{alive (leader _x)}] call fnc_SortGroupsByCA); 
		};		

}forEach _tbc;




// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									MORTAR & ARTILLERY ORDERS
//									REMARK: Version 1 of GAIA has same functionality for artillery as for mortar
//										
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
{
		_grp = _x;
		
				 if (
			   			//Seems like allgroups opens up with all sorts of empty groups, better check it
			   			((side _x) == _HQ_side)
			   			and
			   			(count(units _x)>0)
			   			//and
			   			//((behaviour leader _x)!="COMBAT")
			   			and
					   	(alive (leader _x))
					   	and
					   	(count(_x getVariable  ["GAIA_Portfolio",[]])>0)
					   	and
					   	(count(_x getVariable  ["GAIA_zone_intend",[]])>1)
					   	and
					   	(	
					   		("DoMortar" in (_x getVariable  ["GAIA_Portfolio",[]])) 					   			   	
					   		or
					   		("DoArtillery" in (_x getVariable  ["GAIA_Portfolio",[]])) 					   			   	
					   	)
					   	
					   	and
					   	//if we are already busy mortaring, forget the time out, ofcourse
					   	(
						   	((_x getVariable ["GAIA_MortarRound",0])>0)
						   	or					   	
						   	((time - (_x getVariable  ["GAIA_OrderTime",-MCC_GAIA_MORTAR_TIMEOUT])) > MCC_GAIA_MORTAR_TIMEOUT)		
					   	)
		   			)
		   	 then
		   	 {
		   	 	
		   	 		
		   	 		_MortarFired = false;
		   	 		{
		   	 			_SelectCA = _x;
		   	 			
		   	 			
		   	 				 ([_side,_SelectCA] call fnc_GetCAPoints) select 2;
		   	 			//Anybody of us near?
		   	 			if 	(			   	 					
			   	 					!({side _x == (_HQ_side)} count nearestObjects [_SelectCA,["Man","Car","Tank"],200] >0) 
			   	 					and
			   	 					//dont go for stupid targets please.
			   	 					//if mixed, he will still fire (unknown)
			   	 					!((([_HQ_side,_SelectCA] call fnc_GetCAPoints)select 0) in ["Car","Tank","Helicopter","Ship","Support","Autonomous","Submarine"])
			   	 					and
			   	 					//Dont fire on something we already fire on
			   	 					!(({(side _x == (_HQ_side)) and alive (leader _x) and (( _x getVariable ["GAIA_MortarTarget",[0,0,0]] distance _SelectCA )==0)} count (allgroups-[_grp]))>0)
			   	 					and
			   	 					(	
													(((_grp getVariable  ["GAIA_zone_intend",[]]) select 1)=="MOVE")
												 	or
												 	(
												 		(((_grp getVariable  ["GAIA_zone_intend",[]]) select 1)=="NOFOLLOW")
												 		and
												 		([_SelectCA,((_grp getVariable  ["GAIA_zone_intend",[]]) select 0)] call fnc_PosIsInMarker)
												 	)
										)
		   	 					)
		   	 			then
		   	 				{
		   	 						
		   	 				   
		   	 				   //player globalchat format ["Mortar fired:%1",_grp];		
		   	 					_MortarFired = [_grp,_SelectCA] call fnc_domortar;		   	 					
		   	 				}
		   	 			else
		   	 				{
		   	 					
		   	 					//Cancel! We got troops close!
		   	 					if ((_grp getVariable ["GAIA_MortarRound",0])>0)
			   	 				then
			   	 					{
			   	 						_grp setVariable ["GAIA_MortarRound"					, 0, false];
											_grp setVariable ["GAIA_MortarTarget"					, [0,0,0], false];	
										};
			   	 				
			   	 				
		   	 				};
		   	 		  if (_MortarFired) exitwith {true;};
		   	 		} forEach _CA;
		   	 };
		   	
}  forEach allgroups;
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									NON COMBAT ORDERS
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
				 {
				 if (
			   			//Seems like allgroups opens up with all sorts of empty groups, better check it
			   			((side _x) == _HQ_side)
			   			and
			   			(count(units _x)>0)
			   			and
			   			((behaviour leader _x)!="COMBAT")
			   			and
					   	(alive (leader _x))
					   	and
					   	(count(_x getVariable  ["GAIA_Portfolio",[]])>0)
							and
							(count(_x getVariable  ["GAIA_zone_intend",[]])>1)
							and
							//He is not fortifying
							((_x getVariable  ["GAIA_Order",""]) != "DoFortify")

		   			)
		   	 then
		   	 		{
		   	 			 //backward compatible fortify command

		   	 			 	
		   	 			 if (count (waypoints _x ) == (currentWaypoint _x)) then
		   	 			 	{	
		   	 			 			 		
		   	 			 			 				   switch (true) do
										{
					  						//Group is patrolling
								  			case ("DoPatrol" in (_x getVariable  ["GAIA_Portfolio",[]]))	: 
								  							{	
  					 														//Clear the dude till he clears his mind.
  					 														//We do not count him into the attack
  					 														_dummy=[_x] call fnc_DoPatrol;								  					 														
  															};
					  						//Group needs to wait (heli's)
								  			case ("DoWait" in (_x getVariable  ["GAIA_Portfolio",[]]))	: 
								  							{	
  					 														//Clear the dude till he clears his mind.
  					 														//We do not count him into the attack
  					 														_dummy=[_x] call fnc_DoWait;								  					 														
  															};  															
  															
					  						//Lets give the support guys something to do.
								  			case ("DoSupport" in (_x getVariable  ["GAIA_Portfolio",[]]))	: 
								  							{	
  					 														//Clear the dude till he clears his mind.
  					 														//We do not count him into the attack
  					 														_dummy=[_x] call fnc_DoSupport;								  					 														
  															};  															\
  															
  											//Units that need to hide like AA are set here.
								  			case ("DoHide" in (_x getVariable  ["GAIA_Portfolio",[]]))	: 
								  							{	
  					 														//Clear the dude till he clears his mind.
  					 														//We do not count him into the attack
  					 														_dummy=[_x] call fnc_DoHide;								  					 														
  															};  											
  											
  											//Units that need to hide like AA are set here.
								  			case ("DoPark" in (_x getVariable  ["GAIA_Portfolio",[]]))	: 
								  							{	
  					 														//Clear the dude till he clears his mind.
  					 														//We do not count him into the attack
  					 														_dummy=[_x] call fnc_DoPark;								  					 														
  															};  											
  											
								  	};
		   	 			 	};
		   	 		};
				 }  forEach allgroups;
				 
				 
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									TRANSPORTATION SUPPORT PHASE
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
{
			if (count(_x getVariable  ["GAIA_zone_intend",[]])>1)		then
			{
			 if (
			   			//The the one asking transport must be on our side
			   			((side _x) == _HQ_side)
			   			and
			   			//There must be units in the group of the requester
			   			(count(units _x)>0)
			   			and
			   			//The group cannot be in combat
			   			((behaviour leader _x)!="COMBAT")
			   			and
			   			//The leader must be alive (null group check)
					   	(alive (leader _x))
					   	and
					   	//There must be something to do in your portfolio
					   	(count(_x getVariable  ["GAIA_Portfolio",[]])>0)
					   	and
					   	
					   	(
					   		((_x getVariable  ["GAIA_Order",""]) == "DoPatrol")
					   		and
					   		!([(position leader _x),((_x getVariable  ["GAIA_zone_intend",["",[0,0,0]]]) select 0)] call fnc_PosIsInMarker)
					   	)
					   	and
					   	//You belong to a footmobile class or you wont be able to getin
					   	((_x getVariable  ["GAIA_class",""]) in ["Infantry","ReconInfantry"])
					   	
		   			)
		   		//If that is all the case, then go check if somebody can transport you and if you are allowed to be transported based on transport specific rule bases
		   	 then  { _dummy= [_x] call fnc_DoOrganizeTransportation};
		  };

}  forEach allgroups;

// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									AMBIENT BEHAVIOR PHASE ( FOR GOOD LOOKS)
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
{
				
			if (MCC_GAIA_AMBIANT)
			then
			{
				 if (
			   			//The the one asking transport must be on our side
			   			((side _x) == _HQ_side)
			   			and
			   			//There must be units in the group of the requester
			   			(count(units _x)>0)
			   			and
			   			//The group is in combat
			   			((behaviour leader _x)=="COMBAT")
			   			and
			   			//The leader must be alive (null group check)
					   	(alive (leader _x))
					   	and
					   	//There must be something to do in your portfolio
					   	(count(_x getVariable  ["GAIA_Portfolio",[]])>0)				
					   	and
					   	((_x getVariable  ["GAIA_Order",""]) != "DoFortify")		   	
		   			)
		   		
		   	 then  
		   	 {
		   	 		 
		   	 		 _IsNight			= (((selectBestPlaces [position (leader _x),2, "night", 1, 1]) select 0 select 1)>0.8);
		   	 		 _LetsDoSome	= ((round(random(MCC_GAIA_AMBIANT_CHANCE)))==1);
		   	 		 _ClosestCA		= ([_CA,leader _x] call BIS_fnc_nearestPosition);
		   	 		 _PosLead			= position leader _x;
		   	 		 
		   	 		 //Footmobile specific behavior
					   if ((_x getVariable  ["GAIA_class",""]) in ["Infantry","ReconInfantry"]) then
					   {
					   		
					   		//and _LetsDoSome and count(_ca)>0
					   		//For flares: it must be night, we must have a ca within 400, the random factor must be met and closest enemy is futher then 100
					   		if (_IsNight and count(_ca)>0 and ((_ClosestCA distance (leader _x))<400) and _LetsDoSome and (((leader _x) findNearestEnemy _PosLead) distance _PosLead >100)  ) then
					   			{ 		
					   				
					   				[[(_ClosestCA select 0),(_ClosestCA select 1),100],[(_PosLead select 0),(_PosLead select 1),40],50,30,"F_40mm_Green"] call fnc_fireflare;
					   			};
					   			
					   		//Check if this unit needs some smoke for cover. Make sure to check if previous points is bigger then 0, we dont like devide by zero
					   		if (((_x getVariable ["GAIA_previouspoints",0])>0) and ((_x getVariable ["GAIA_points",0])>0)) then
					   		{
					   			
					   			//did we have more then 20% loss? go smoke it
					   			if ((_x getVariable ["GAIA_PreviousPoints",1])>(_x getVariable ["GAIA_points",1])) then
					   			//if (((((_x getVariable ["GAIA_PreviousPoints",1])-(_x getVariable ["GAIA_points",1]))/(_x getVariable ["GAIA_PreviousPoints",1]))*100)>20) then
					   				{ 
					   					
					   						if (alive leader _x) then {"SmokeShell" createVehicle (position leader _x);};
					   				};
					   		};
					   		
					   };
		   	 		 
		   	 };
			};
}  forEach allgroups;

true;