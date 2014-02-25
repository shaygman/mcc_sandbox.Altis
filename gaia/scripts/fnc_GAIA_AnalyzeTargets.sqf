if (!isServer) exitWith {};

private [ "_condition", "_targetlist", "_mklist", "_ActualTargets", "_cntC", "_target", "_mkname", "_i","_vehicleClass","_HQ_side"];


_HQ_side 	= _this select 0;
_mklist 	= _this select 1;



//If a unit has recently been within 50 meter of a target location in _tobecleared, 
//then if the time he has been there is more recent then the target, its called cleared.
_ClearedDistance = 50;

//AFter this period of time the target is automaticly cleared. (will not be searched by the ai).
_TArgetAutoCleared	= 1200;

//This sets how long a position of a unit is stored in the breadcrumb system. 
//Each set 'breadcrumb' holds a time and a location. As long as the breadcrumb is there, it will be use dto blacklist a location for possible patrolling.
//Also will it be used to 'clear' target locations. If a unit has recently been there, then we can savely say that it is clear.
_LiveTimeBreadcrumb = 300;
_targetlist = [];



//if (MCC_GAIA_DEBUG) then{[_HQ_side,"HQ"] sideChat "Gathering Intelligence......Waitout."; };
// 
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									Phase 1: Gather TArgets, drop breadcrumbs
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  

_ActualTargets 		= [];
_RecentTargets		= [];
_OldTargets				= [];
_ToBeCleared			= [];



_NearTargets		= [];
_OldTargetInfo	= [];
_NewTargetInfo	= [];




{
   if (
   			//Seems like allgroups opens up with all sorts of empty groups, better check it
   			((side _x) == _HQ_side)
   			and
   			(count(units _x)>0)
   		)
   then
   {
      _unit = leader _x;
      
      //sleep 2;
      //player globalchat format ["%1, %2, %3",(position _unit),_unit,_x];
      
      
      //Place a breadcrumb 
      	_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> typeof (vehicle _unit) >> "vehicleClass")); 
      //Except for air, as air is not 'clearing the ground'
      if ((_vehicleClass != "air")) then    
      {
      	//Now where ever a unit has last been, place a breadcrumb (so even static guards).
      	// This is used for making the patrols as optimized as possible. We try to avoid those positions.
      	
      	switch (_HQ_side) do
						{
						  case west				: {MCC_GAIA_BREADCRUMBS_WEST = MCC_GAIA_BREADCRUMBS_WEST + [[(position _unit),time]];};
						  case east				: {MCC_GAIA_BREADCRUMBS_EAST = MCC_GAIA_BREADCRUMBS_EAST + [[(position _unit),time]];};
						  case independent: {MCC_GAIA_BREADCRUMBS_INDEP = MCC_GAIA_BREADCRUMBS_INDEP + [[(position _unit),time]];};
						};
      	
      };
      
      
      {	      
      	_Target_Pos		= _x select 0;
      	_Target_PosAcc= _x select 5;
      	_Target_Side	= _x select 2;
      	_Target 			= _x select 4;
      	
      	if 	(
      				_Target_Side!= _HQ_side
      			 	and
      			 	((_Target_Side getFriend _HQ_side)<0.6) 	
      			 	and
      			 	alive(leader(group _Target))
      			 	and
      			 	!captive(_target)
	     			 	and	      			 
      			 	//How sure are we? For now accuracy of 18 seems to work ok
      			 	_Target_PosAcc < 18
      			 	and
      			 	(_Target iskindof "AllVehicles")
      			 	//and      			 	
      			 	//If the lead has a clear LOS to a unit, that is valid enough (might expand later to check on all members)
      			 	//([_unit,_Target,1500] call fnc_HasLOS)
      			 	     			 	
      		 	)
      		then
      		{	      			
      			_Target setVariable ["GAIA_TargetInfo", [time,_Target_Pos,_Target_posAcc], false];
 
      		};	      	
      }foreach (_unit neartargets 1500);
   };
} forEach AllGroups;

// 
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									Phase 3: Update Target Lists
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  


//if (MCC_GAIA_DEBUG) then {[_HQ_side,"HQ"] sideChat "Updating the targetlist."; };
{
	if 	(
	      	(((side _x) getFriend _HQ_side)<0.6)		      			 	
	     )
	then
	{
				 //[_HQ_side,"HQ"] sideChat "Found!"; 
				 _OldTargetInfo	= [];
				 _targetlist 		= [];
      	 _OldTargetInfo = _x getVariable ["GAIA_TargetInfo",[]];	      	
      	 if (count(_OldTargetInfo)>0 ) then
      	 	{      	 		
      	 		_OldTarget_Time		= time - (_OldTargetInfo select 0);
      	 		switch (true) do
						{
			  			case (_OldTarget_Time<60)											: {_ActualTargets = _ActualTargets + [_x];};
			  			case (_OldTarget_Time<200)										: {_RecentTargets = _RecentTargets + [_x];};
			  			case (_OldTarget_Time<360)										: {_OldTargets = _OldTargets + [_x];};
			  			case (_OldTarget_Time<_TargetAutoCleared)			: {_ToBeCleared = _ToBeCleared + [_x];};
						};      	 		   	 			      	 	
      	 	 	 		
      		};
	};

} forEach allUnits+vehicles;

// Debug to be cleared case (name the unit a)
//a  setVariable ["GAIA_TargetInfo", [(time -400),(position a),1], false];
//_ToBeCleared = _ToBeCleared + [a];

// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									Phase 4: Send _ToBeCleared locations to Cleared if a unit has recently been there.
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 


for [{_i=0},{_i < count _ToBeCleared},{_i=_i+1}] do 
{


	//Get the position of this dude
	_OldTargetInfo = (_ToBeCleared select _i) getVariable ["GAIA_TargetInfo",[]];
	
	//Check if we are in clear range and if so, clear this dude
	if ([(_OldTargetInfo select 1),_HQ_side ] call fnc_isCleared) then
		{
			(_ToBeCleared select _i) setVariable ["GAIA_TargetInfo", [(time-_TArgetAutoCleared),(_OldTargetInfo select 1),(_OldTargetInfo select 2)], false];
		}

};

// 
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									Phase 5: Share Target Lists
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
switch (_HQ_side) do
			{
			  case west				: {MCC_GAIA_TARGETS_WEST = [_ActualTargets,_RecentTargets,_OldTargets,_ToBeCleared];};
			  case east				: {MCC_GAIA_TARGETS_EAST = [_ActualTargets,_RecentTargets,_OldTargets,_ToBeCleared];};
			  case independent: {MCC_GAIA_TARGETS_INDEP = [_ActualTargets,_RecentTargets,_OldTargets,_ToBeCleared];};
			};



// 
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									Phase 6: Clear Outdated Breadcrumps
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
switch (_HQ_side) do
			{
			  case west				: {
			  											for [{_i=0},{_i < count MCC_GAIA_BREADCRUMBS_WEST},{_i=_i+1}] do 
															{
																 
																if ((time-((MCC_GAIA_BREADCRUMBS_WEST select _i) select 1))>_LiveTimeBreadcrumb) then
																{
																	MCC_GAIA_BREADCRUMBS_WEST set [_i, "REMOVE"];
																	MCC_GAIA_BREADCRUMBS_WEST = MCC_GAIA_BREADCRUMBS_WEST - ["REMOVE"];
																}
															};
			  									};
			  case east				: {
			  											for [{_i=0},{_i < count MCC_GAIA_BREADCRUMBS_EAST},{_i=_i+1}] do 
															{
																 
																if ((time-((MCC_GAIA_BREADCRUMBS_EAST select _i) select 1))>_LiveTimeBreadcrumb) then
																{
																	MCC_GAIA_BREADCRUMBS_EAST set [_i, "REMOVE"];
																	MCC_GAIA_BREADCRUMBS_EAST = MCC_GAIA_BREADCRUMBS_EAST - ["REMOVE"];
																}
															};
			  									};
			  case independent: {
			  											for [{_i=0},{_i < count MCC_GAIA_BREADCRUMBS_INDEP},{_i=_i+1}] do 
															{
																 
																if ((time-((MCC_GAIA_BREADCRUMBS_INDEP select _i) select 1))>_LiveTimeBreadcrumb) then
																{
																	MCC_GAIA_BREADCRUMBS_INDEP set [_i, "REMOVE"];
																	MCC_GAIA_BREADCRUMBS_INDEP = MCC_GAIA_BREADCRUMBS_INDEP - ["REMOVE"];
																}
															};
			  									};
			};





// 
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//									Phase 7: If debug is enabled, then show markers on the map
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
if (MCC_GAIA_DEBUG and _HQ_side==(Side player)) then
{
		hint format ["Actual Targets: %1, Recent Targets: %2, Old Targets: %3,TBC: %4", _ActualTargets,_RecentTargets,_OldTargets,_tobecleared];
	
	{	
		deleteMarkerLocal _x;
	}
	foreach _mklist;
	
	_mklist = [];
		
		{
			_mkname = "mk" + str(_x);
	
			createMarkerLocal  [_mkname, getPos _x ];
			_mklist = _mklist + [_mkname];
			switch true do 
				{						
					case ( _x isKindOf "Man" )					: 	{_mkname setMarkerTypeLocal "b_inf";};
					case ( _x isKindOf "Car" )					: {_mkname setMarkerTypeLocal "c_car";};
					case ( _x isKindOf "Motorcycle" )		: {_mkname setMarkerTypeLocal "b_car";};
					case ( _x isKindOf "Tank" )					: {_mkname setMarkerTypeLocal "b_armor";};
					case ( _x isKindOf "Air" )					: {_mkname setMarkerTypeLocal "b_air";}; 
					case ( _x isKindOf "Ship" )					: {_mkname setMarkerTypeLocal "b_naval";}; 
					case ( _x isKindOf "StaticWeapon" )	: {_mkname setMarkerTypeLocal "b_installation";};
					
	
				};	
					_OldTargetInfo = _x getVariable ["GAIA_TargetInfo",[]];
					_mkname setMarkerPosLocal (_OldTargetInfo select 1);
					_mkname setMarkerDirLocal  getDir _x;
					_mkname setMarkerAlphaLocal (1 - getDammage _x);
					if (_x in _ActualTargets) 	then {_mkname setMarkerColorLocal "ColorGreen"	};
					if (_x in _RecentTargets) 	then {_mkname setMarkerColorLocal "ColorOrange"	};
					if (_x in _OldTargets) 	 		then {_mkname setMarkerColorLocal 	"ColorRed"	};
					if (_x in _ToBeCleared) 	 	then {_mkname setMarkerColorLocal "ColorWhite"	};
		}forEach _ActualTargets+_RecentTargets+_OldTargets+_ToBeCleared;
	
};




_mklist

