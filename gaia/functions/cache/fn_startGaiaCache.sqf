if(!isServer ) exitWith {};
private["_count"];



while {true} do
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
																!([getPosATL(leader _x),(missionNamespace getVariable ["GAIA_CACHE_STAGE_1",1000])] call GAIA_fnc_isNearPlayer)
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
													  ):  {	_x spawn GAIA_fnc_cache;};

										 //We are cached, player is in range 1
											case (
																(_x getVariable  ["GAIA_CACHED_STAGE_1",false])
																and
																([getPosATL(leader _x),(missionNamespace getVariable ["GAIA_CACHE_STAGE_1",1000])] call GAIA_fnc_isNearPlayer)
													  ):  {_x spawn GAIA_fnc_uncache;};

					  					//We are in combat, decache him at all times, no matter the range
					  					case (
																(_x getVariable  ["GAIA_CACHED_STAGE_1",false])
																and
																(behaviour(leader _x)=="COMBAT")
													  ):  {	_x spawn GAIA_fnc_uncache;};

 											default {_x spawn GAIA_fnc_syncCachedGroup;};
							};


							//Cache stage 2
							if (
											!([getPosATL(leader _x),GAIA_CACHE_STAGE_2] call GAIA_fnc_isNearPlayer)
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
					   	then 	{[_x] call GAIA_fnc_cacheFar;};

				};

			//chill out, no rush
		  sleep 0.1;

	 }  forEach ([ALLGROUPS, {_x getVariable ["mcc_gaia_cache", false]}] call BIS_fnc_conditionalSelect);
	 _idx = 0;
	 {


	 						if ([_x,GAIA_CACHE_STAGE_2] call GAIA_fnc_isNearPlayer)
	 						then
	 						{
	 							[(missionNamespace getVariable [ "GAIA_CACHE_" + str(_x),[0,0,0]])] call GAIA_fnc_uncacheFar;
	 							MCC_GAIA_CACHE_STAGE2 set [_idx, "delete_me"];

	 						};
	 						_idx= _idx + 1;
	 }  forEach MCC_GAIA_CACHE_STAGE2;

	 // Delete respawned dudes
	 MCC_GAIA_CACHE_STAGE2 = MCC_GAIA_CACHE_STAGE2 - ["delete_me"];


	 //Delayed spawning
	 	 _idx = 0;
	 {


	 						if ([_x,GAIA_CACHE_STAGE_2] call GAIA_fnc_isNearPlayer)
	 						then
	 						{

	 							_ar = (missionNamespace getVariable [ "MCC_DELAY" + str(_x),[0,0,0]]);
	 							//Disable delayed (we are the delayed spawn)
	 							_ar set [27,false];
	 							//Enable the caching no matter what, delayed WILL be cached
	 							//_ar set [26,true];
	 							[_ar, "mcc_setup", false, false] spawn BIS_fnc_MP;
	 							MCC_DELAYED_SPAWNS set [_idx, "delete_me"];

	 						};
	 						_idx= _idx + 1;
	 }  forEach MCC_DELAYED_SPAWNS;

	 // Delete respawned dudes
	 MCC_DELAYED_SPAWNS = MCC_DELAYED_SPAWNS - ["delete_me"];


	 //We checked allgroups so we need a break
	 sleep GAIA_CACHE_SLEEP;
};