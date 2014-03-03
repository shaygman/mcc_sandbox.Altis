//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our awesome patrol
// Example: [_group,_zone] call fnc_DoInfPatrol
// spirit 14-1-2014
//===========================================================================================================================================================================	
private ["_group","_NrOfBuildingWp","_zone","_pos"];

_group 			= _this select 0; 
_zone				=	_this select 1;



[_group] call fnc_RemoveWayPoints;


//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our support guys. Yes they are 'easy' at the moment. Just make it work is the goal for release 1.
// 
// spirit 14-1-2014
//===========================================================================================================================================================================	
private ["_group","_pos","_zone","_newpos","_landpos","_landpad"];

//Get the group
_group 			= _this select 0; 

_landpos  = [];
_zns			= [];
_rounds		= 0 ;
_initial 	= false;

//Clear what ever orders we had before.
[_group] call fnc_RemoveWayPoints;

//Get the zone
_zone	 = (((_group) getVariable ["GAIA_zone_intend",[]])select 0);

switch (side leader _group) do
			{
			  case west				: {
			  		  						 
			  		  						 _zns	=	MCC_GAIA_ZONES_WEST;			 
			  		  						 
			  		  						 
			  									};
			  case east				: {
			  									 
			  									 _zns	=	MCC_GAIA_ZONES_EAST;
			  									 
			  									 
			  									};
			  case independent: {
			  	                 
			  	                 _zns	=	MCC_GAIA_ZONES_INDEP;			  	  
			  	                 
			  	                 
			  	                };
			};


if !(isnil("_Zone")) then
{
	
	//Check if the dude already has a 'home'. All helicopters need position where they land and go home to.
	if (  ((_group) getVariable ["GAIA_LandingSpot",[0,0,0]] distance [0,0,0]==0)  ) then	
	{ 
		
		if (isTouchingGround (assignedvehicle leader _group)) then
			{
					_landpos = (position assignedvehicle leader _group); 
					_dummy = ("Land_HelipadEmpty_F" createvehicle _landpos);
					_group setVariable ["GAIA_LandingSpot"							, _landpos  , false]; 
			}
		else
			{
	
				_landpos =  [([_zone,"ARM_HILLS_FLAT",(side _group)] call  fnc_GetPosition), 0,100, 12, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
					
				_dummy = ("Land_HelipadEmpty_F" createvehicle _landpos);
				_group setVariable ["GAIA_LandingSpot"							, _landpos  , false]; 
				
				
				_wp = _group addWaypoint [((_group) getVariable ["GAIA_LandingSpot",[0,0,0]]), 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointCompletionRadius 20;
				_wp setWaypointSpeed "LIMITED";					
				_wp setWaypointStatements ["true","(Vehicle this) land 'land'"];
			};
	
		

		
		_initial = true;
	};
	
	// In case we are sitting and waiting
	if (
				(round(random(20))==1)and (count (waypoints _group) == (currentWaypoint _group)) 
				and 
				!_initial 
				and 
				(count(_group getVariable  ["GAIA_zone_intend",[]])>1)
				and
				((_group) getVariable ["GAIA_LandingSpot",[0,0,0]] distance [0,0,0]!=0)
		 ) 
	then
	{
		_rounds =round(random(9));
		
		for "_x" from 1 to _rounds do
		{
		//Go somewhere
			//Defensive
			if (((_group getVariable  ["GAIA_zone_intend",[]]) select 1)=="NOFOLLOW") then
				{_pos= ([_zone ,"AIR",(side _group)] call  fnc_GetPosition);}
			else
				{_pos= ([(_zns  call BIS_fnc_selectRandom ) ,"AIR",(side _group)] call  fnc_GetPosition);};			
				
			_dummy 	=  [_group,_pos,"MOVE"] call fnc_addWaypoint;
		};

	
		
		_wp = _group addWaypoint [((_group) getVariable ["GAIA_LandingSpot",[0,0,0]]), 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 20;
		_wp setWaypointSpeed "LIMITED";					
		_wp setWaypointStatements ["true","(Vehicle this) land 'land'"];
	
	};	
	
	//In case we somehow end up in the air without waypoins or anything to do, bring the baby down
	if (!(isTouchingGround (vehicle leader _group)) and (count (waypoints _group) == (currentWaypoint _group)) and !_initial and ((_group) getVariable ["GAIA_LandingSpot",[0,0,0]] distance [0,0,0]!=0)) then
	{
		_wp = _group addWaypoint [((_group) getVariable ["GAIA_LandingSpot",[0,0,0]]), 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 20;
		_wp setWaypointSpeed "LIMITED";					
		_wp setWaypointStatements ["true","(Vehicle this) land 'land'"];
	};
	
	
};



//Our result is waypoints
((count (waypoints _group)) - currentWaypoint _group)