if (!isServer) exitWith {};

private [ "_condition", "_targetlist", "_mklist", "_ActualTargets", "_cntC", "_target", "_mkname", "_i","_vehicleClass","_Handle","_gaiaunitsfound"];


_HQ_side = _this select 0;

_mklist	 = [];
//GAIA is down

switch (_HQ_side) do
			{
			  case west				: {MCC_GAIA_OPERATIONAL_WEST  = FALSE;};
			  case east				: {MCC_GAIA_OPERATIONAL_EAST  = FALSE;};
			  case independent: {MCC_GAIA_OPERATIONAL_INDEP = FALSE;};
			};

// 
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									Phase 0: GAIA never dies, even if all her units are destroyed. All HAIL GAIA!
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  

if (MCC_GAIA_DEBUG) then{[_HQ_side,"HQ"] sideChat format ["Waking up GAIA...............%1",_HQ_side]; };
Sleep 2;
 
while {true} do	
{
		
		// This code checks if GAIA units are there (the code sucs as it was produced fast)
		_gaiaunitsfound = false;
		
		while {!_gaiaunitsfound} 
		do {
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
			  		then {_gaiaunitsfound=true;};
			  		//stop 
			  		if (_gaiaunitsfound) exitwith {true};
		  		 }  forEach allgroups;
		  		 
		  		 //if not found go sleep
		  		 if !(_gaiaunitsfound) then {sleep 20;};
			 } ;
		 
		
		//GAIA IS A GO!
		if (MCC_GAIA_DEBUG) then{[_HQ_side,"HQ"] sideChat format ["GAIA %1 wakes up and looks around the place. Man what a night. Time to destroy some player.",_HQ_side]; };
						
		while { ( {side _x == _HQ_side } count allunits > 0 ) } do
		{
				MCC_GAIA_CYCLE = MCC_GAIA_CYCLE + 1;
				publicVariable "MCC_GAIA_CYCLE" ;
				//vlag setvariable ['gaia_cycle',MCC_GAIA_CYCLE,true];
				
				GAIA_CACHE_STAGE_2				= (2*GAIA_CACHE_STAGE_1);
				
				
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
				//									Phase: Analyze Enemy
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  	
				if (MCC_GAIA_DEBUG) then{[_HQ_side,"HQ"] sideChat format["Analyze Target...............................%1",_HQ_side]; };
				_mklist = [_HQ_side,_mklist] call fnc_GAIA_AnalyzeTargets;
				sleep 1;
	
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
				//									Phase: Organise Contact Area's (CA's)
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  	
				if (MCC_GAIA_DEBUG) then{[_HQ_side,"HQ"] sideChat format["Organise Contact Areas.......................%1",_HQ_side]; };
				_dummy = [_HQ_side] CALL fnc_GAIA_ConflictAreas;		
				sleep 1;

				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
				//									Phase: Analyze GAIA Forces and Zones
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  	
				if (MCC_GAIA_DEBUG) then{[_HQ_side,"HQ"] sideChat format["Analyze Forces...............................%1",_HQ_side]; };
				_dummy = [_HQ_side] CALL fnc_GAIA_AnalyzeForces;
				sleep 1;
								
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
				//									Phase: Classify GAIA controlled groups
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  			
				if (MCC_GAIA_DEBUG) then{[_HQ_side,"HQ"] sideChat format["Classify GAIA controlled groups...............%1",_HQ_side]; };
				_dummy = [_HQ_side] CALL fnc_GAIA_Classify;	
				sleep 1;
				
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
				//									Phase: Issue Orders
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  							
				if (MCC_GAIA_DEBUG) then{[_HQ_side,"HQ"] sideChat format["Issue Orders.,,,,,,,,,,,,,,,,,,,..............%1",_HQ_side]; };
				_dummy = [_HQ_side] CALL fnc_GAIA_IssueOrders;
				sleep 1;
				
		
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
				//									Phase: Sleep
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
				if (MCC_GAIA_DEBUG) then{[_HQ_side,"HQ"] sideChat format["Sleep........................................%1",_HQ_side]; };
				uisleep MCC_GAIA_SHARETARGET_DELAY;		
				
				
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
				//									Phase: Operational!
				// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
									
					switch (_HQ_side) do
				{
				  case west				: {MCC_GAIA_OPERATIONAL_WEST  = TRUE;};
				  case east				: {MCC_GAIA_OPERATIONAL_EAST  = TRUE;};
				  case independent: {MCC_GAIA_OPERATIONAL_INDEP = TRUE;};
				};
		};		
		
	//GAIA is down	
					switch (_HQ_side) do
				{
				  case west				: {MCC_GAIA_OPERATIONAL_WEST  = FALSE;};
				  case east				: {MCC_GAIA_OPERATIONAL_EAST  = FALSE;};
				  case independent: {MCC_GAIA_OPERATIONAL_INDEP = FALSE;};
				};

};

true