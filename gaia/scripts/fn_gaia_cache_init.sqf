if(!isServer ) exitWith {};
private["_count"];


while {!MCC_GAIA_CACHE} 
	do {
					{
						if (
					   			//Seems like allgroups opens up with all sorts of empty groups, better check it					   		
					   			(count(units _x)>0)
					   			and
					   			(alive (leader _x))			
					   			and
					   			((_x) getVariable ["MCC_GAIA_CACHE", false])	   			
			  				)
			  		then {MCC_GAIA_CACHE=true;};
			  		//stop 
			  		if (MCC_GAIA_CACHE) exitwith {true;};
		  		 }  forEach allgroups;
		  		 
		  		 //if not found go sleep
		  		 if !(MCC_GAIA_CACHE) then {sleep 20;};
		  		 
		  		 //player globalchat "we wachten";
		 } ;



while {MCC_GAIA_CACHE} do	
{
	 {
			if (
			   			//Seems like allgroups opens up with all sorts of empty groups, better check it
			   			(count(units _x)>0)
			   			and
			   			(alive (leader _x))
					)
			then
				{
							//player globalchat "time to check caches";
							//Cache stage 1
							switch(true)do
							{
											
											//We are not cached, closest player is out of range 1, not in combat, exclude artillery and mortars
											case (
																!(_x getVariable  ["GAIA_CACHED_STAGE_1",false])
																and
																!([getPosATL(leader _x),GAIA_CACHE_STAGE_1] call gaia_fn_nearPlayer)
																and
																(behaviour(leader _x)!="COMBAT")		
																and
																(
																	(	
																		(count(_x getVariable  ["GAIA_zone_intend",[]])>1)
																		and
																		!("DoMortar" in (_x getVariable  ["GAIA_Portfolio",[]])) 					   			   	
					   												and
					   												!("DoArtillery" in (_x getVariable  ["GAIA_Portfolio",[]])) 					   		
					   											)
					   											or
					   											(
					   												(count(_x getVariable  ["GAIA_zone_intend",[]])==0)
					   											)
																)					   										
													  ):  {	_x spawn gaia_fn_cache;};
													  
										 //We are cached, player is in range 1
											case (
																(_x getVariable  ["GAIA_CACHED_STAGE_1",false])
																and
																([getPosATL(leader _x),GAIA_CACHE_STAGE_1] call gaia_fn_nearPlayer)
													  ):  {_x spawn gaia_fn_uncache;};
													  
					  					//We are in combat, decache him at all times, no matter the range					  					
					  					case (
																(_x getVariable  ["GAIA_CACHED_STAGE_1",false])
																and
																(behaviour(leader _x)=="COMBAT")		
													  ):  {	_x spawn gaia_fn_uncache;};
													  
 											default {_x spawn gaia_fn_sync;};		  
							};									
								 
								 
							//Cache stage 2
							if (
											!([getPosATL(leader _x),GAIA_CACHE_STAGE_2] call gaia_fn_nearPlayer)	 
											//and
											//(behaviour(leader _x)!="COMBAT")	
											/*
											and
											(_x getVariable ["GAIA_class",""])!=""
											and
											!("DoMortar" in (_x getVariable  ["GAIA_Portfolio",[]])) 					   			   	
					   					and
					   					!("DoArtillery" in (_x getVariable  ["GAIA_Portfolio",[]])) 
					   					*/
					   		 )
					   	then 	{[_x] call gaia_fn_cache_stage_2;};	
								 
				};
				
			//chill out, no rush			
		  sleep 0.1;
		  
	 }  forEach ([ALLGROUPS, {_x getVariable ["mcc_gaia_cache", false]}] call BIS_fnc_conditionalSelect);
	 _idx = 0;
	 {
	 						
	 						
	 						if ([_x,GAIA_CACHE_STAGE_2] call gaia_fn_nearPlayer)	 
	 						then 
	 						{
	 							[(missionNamespace getVariable [ "GAIA_CACHE_" + str(_x),[0,0,0]])] call gaia_fn_uncache_stage_2;
	 							MCC_GAIA_CACHE_STAGE2 set [_idx, "delete_me"];
	 							
	 						};
	 						_idx= _idx + 1;
	 }  forEach MCC_GAIA_CACHE_STAGE2;
	 
	 // Delete respawned dudes
	 MCC_GAIA_CACHE_STAGE2 = MCC_GAIA_CACHE_STAGE2 - ["delete_me"];
	 //We checked allgroups so we need a break
	 sleep GAIA_CACHE_SLEEP;
};