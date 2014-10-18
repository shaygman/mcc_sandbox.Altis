/* ----------------------------------------------------------------------------
Function: fnc_GAIA_AnalyzeForces.sqf

Description:
	Updates all GAIA controlled groups (MCC_GAIA_GROUPS_%SIDE%)
	Updates the active zones (zones that still hold units) (MCC_GAIA_ZONES_%SIDE)
	Updates the status of zones (MCC_GAIA_ZONESTATUS_%SIDE)
	Updates all the troup behaviour based on MCC_GAIA_ZONESTATUS_%SIDE.

Parameters:
	- Side

Returns:
	true

Author:
	Spirit, 17-1-2014

---------------------------------------------------------------------------- */

private ["_side","_TempGroups","__ZoneStatus","_Targets","_TargetInZone","_TargetNear","_ParentStatus","_class"];

_side = _this select 0;
_TempGroups 			= [];
_TempZones				= [];

_gaia_zone_intend	= [];
_zone							= "";
_ZoneStatus				= [];
_Targets					= [];
_factions         = [];
_TargetInZone			= false;
_TargetNear				= false;
_TempTargets			= [];
_ParentStatus			= 0;
_ChildStatus			= 0;
_ZoneBehave				= [];
_ZoneIntend				= [];
_gaia_LeadPos			= [];
_class						= "";

switch (_side) do
		{
		  case west				: {
		  										_ZoneStatus = MCC_GAIA_ZONESTATUS_WEST;
		  										_Targets		= MCC_GAIA_TARGETS_WEST;
		  										_factions	  = MCC_GAIA_FACTIONS_WEST;
		  									};
		  case east				: {
		  										_ZoneStatus = MCC_GAIA_ZONESTATUS_EAST;
		  										_Targets		= MCC_GAIA_TARGETS_EAST;
		  										_factions	  = MCC_GAIA_FACTIONS_EAST;
		  									};
		  case independent: {
		  										_ZoneStatus = MCC_GAIA_ZONESTATUS_INDEP;
		  										_Targets		=	MCC_GAIA_TARGETS_INDEP;
		  										_factions	  = MCC_GAIA_FACTIONS_INDEP;		  										
		  									};
		  case civilian		: {
		  										_ZoneStatus = MCC_GAIA_ZONESTATUS_CIV;
		  										_Targets		=	MCC_GAIA_TARGETS_CIV;
		  										_factions	  = MCC_GAIA_FACTIONS_CIV;
		  									};
		};



 //Get all zones that still hold forces.
 {
	 if (
   			//Seems like allgroups opens up with all sorts of empty groups, better check it
   			((side _x) == _side)
   			and
   			(count(units _x)>0)
 			)
 	 then
 	 		{
 	 			if (count([_x] call GAIA_fnc_getZoneIntendOfGroup)>0) then {_TempGroups = _TempGroups + [_x];};
 	 			_gaia_zone_intend = _x getVariable ["GAIA_ZONE_INTEND",[]];
 	 			if ((count _gaia_zone_intend)>0) then
 	 			{
 	 				//Lets build all active factions here
 	 				_faction = faction leader _x;
 	 				if  !(_faction in _factions) then {_factions=_factions + [ _faction];};
 	 				
 	 				_zone = _gaia_zone_intend select 0;
 	 				
 	 				if !(_zone in _TempZones) then
 	 					{

 	 						_TempZones = _TempZones + [_Zone];

 	 						//Remember the position of the zone, so we can see if it is updated
 	 						//The issue Orders function, in phase 'cancel orders' will react on this trigger
							_var  = "gaia_zone_lastpos_" + _zone;
							_var2 = "gaia_zone_changed_" + _zone;
							if (((missionNamespace getVariable [ _var,[0,0,0]]) distance [0,0,0])>0) then
							{

								if ( ( (getmarkerpos _zone ) distance (missionNamespace getVariable [ _var,[0,0,0]]) )>0) then
									{

										missionNamespace setVariable [_var2, true ];
									}
							 	else
							 		{
							 				missionNamespace setVariable [_var2, false ];
							 		};
							};

  						missionNamespace setVariable [_var, (getmarkerpos _zone ) ];
 	 					};
 	 			};
 	 		};
	 }  forEach AllGroups;



//Update ZONE status
_zone							= "";
_TempTargets			= (_Targets select 0)+(_Targets select 1)+(_Targets select 2)+(_Targets select 3);
{
	//For anything we have not cleared yet, we keep the zone alarm ringing "ALL ON BOARD!"
	_TargetInZone 			= false;
	_TargetNear					= false;
	_Zone	= _x;
	if ((count(getmarkerpos _Zone))>0) then
	{
			for "_T" from 0 to (count(_TempTargets)-1) do
				{

					//Target is in the zone
					if ([(position (_TempTargets select _T)),_Zone] call GAIA_fnc_isPositionInMarker				) exitWith {_TargetInZone= true;};

					//Check if we got a target close by (Relatively 2 times bigger then largest of x and y of the marker size)
					_Dist	= ((((Getmarkersize _Zone)select 0) max ((Getmarkersize _Zone)select 1))*2);
					if (((position (_TempTargets select _T)) distance (getmarkerpos _Zone))<_Dist) then {_TargetNear= true;};
				};

				switch(true)do
				{
						//Status Red
						case (_TargetInZone): {
																		_ZoneStatus set  [(parseNumber _zone ),2];
																		if (MCC_GAIA_DEBUG and _side==(Side player)) then {_zone setMarkerColorLocal 	"ColorRed"};
																	};
						//Orange
						case (_TargetNear)	: {
																		_ZoneStatus set  [(parseNumber _zone ),1];
																		if (MCC_GAIA_DEBUG and _side==(Side player)) then {_zone setMarkerColorLocal 	"ColorOrange"};
																	};
						//Green
						default							  {
																		_ZoneStatus set  [(parseNumber _zone ),0];
																		if (MCC_GAIA_DEBUG and _side==(Side player)) then {_zone setMarkerColorLocal 	"ColorGreen"};
																	};
				};
	};
}ForEAch _TempZones;


//Now make sure that any child zones (the ones that have a center position inside a zone) are also warned of this upcoming danger
//Ofcourse to the max level of Orange as Red is a private indication (inside your zone).

{
	_zone = _x;
	_ZoneBehave	=([_Zone,_side] call GAIA_fnc_getZoneStatusBehavior);
	_ParentStatus		= (_ZoneBehave select 0);
	{

			_ZoneBehave	=([_x,_side] call GAIA_fnc_getZoneStatusBehavior);
			_ChildStatus=(_ZoneBehave select 0);
			if ( _Childstatus!=2 and _ParentStatus>0 and ([(getmarkerpos _x),_Zone] call GAIA_fnc_isPositionInMarker)) then
								//Set the child in Orange mode as Red is a private indication (is target in zone)
								{
									_ZoneStatus set  [(parseNumber _x ),1];
									if (MCC_GAIA_DEBUG and _side==(Side player)) then {_x setMarkerColorLocal 	"ColorOrange"};
								};
	//Exclude yourself here.
	}ForEAch (_TempZones - [_x]);

}ForEAch _TempZones;



//Update FORCES based on Zone Status. Be warned brother!
//For now we choose to inform only GAIA controlled groups, but why not update all?
//Also check the progress of a unit. Is he a candidate stuck unit?
{
	 if (
   			//Seems like allgroups opens up with all sorts of empty groups, better check it
   			((side _x) == _side)
   			and
   			(count(units _x)>0)
//   			and
//   			(behaviour _x	!="COMBAT")
   		)
   then
   {


   		//Monitor the leaders progress.
   		//We count the number of cycles he has not move while he did have waypoints.
   		_gaia_LeadPos = _x getVariable ["GAIA_LeadPosition",[]];
   		if (count(_gaia_LeadPos)>0) then
   				{
   					//The dude has waypoints and he has done jackshit
   					if ((((count (waypoints _x)) - currentWaypoint _x)>0) and (((position leader _x) distance (_gaia_LeadPos select 0))<6)   )
   					then
   						{_x setVariable ["GAIA_LeadPosition", [(_gaia_LeadPos select 0),((_gaia_LeadPos select 1)+1)], false];}
   					else
   						{_x setVariable ["GAIA_LeadPosition", [(position leader _x),1], false];	};

   					 _class = _x getVariable ["GAIA_class",[]];
   					 /*
   					 if ((_class in ["Infantry","ReconInfantry"]) and (behaviour leader _x	!="COMBAT") and ((_gaia_LeadPos select 1)>7)) then
   						{(leader _x) setpos (position(([((units _x)-[leader _x])] call BIS_fnc_selectRandom)select 0))};
   					*/

   				}
   		else
   				{
   						_x setVariable ["GAIA_LeadPosition", [(position leader _x),1], false];
   				};





   		_ZoneIntend =	[(_x)] call GAIA_fnc_getZoneIntendOfGroup;
   		if (count(_zoneintend)>0) then
   		//Zone info on group found.
   		{
   				_ZoneBehave	=([(_zoneintend select 0),_side] call GAIA_fnc_getZoneStatusBehavior);
   				if (	count(_zonebehave)>0
   							and
   							(behaviour leader _x	!="COMBAT")
   							and
   							(behaviour leader _x	!="STEALTH")
   							and
   							((_x getVariable  ["GAIA_Order",""])!="DoFortify")
   					 )
   				then
   				//We even found the expected bheavior.
   				{
   					/*
   					_Behaviour="SAFE";		_CombatMode="GREEN";	_Formation="COLUMN";	_Speed = "LIMITED";
						_Behaviour="AWARE";	_CombatMode="YELLOW";	_Formation="WEDGE";		_Speed = "NORMAL";
						_Behaviour="AWARE";	_CombatMode="RED";		_Formation="VEE";			_Speed = "NORMAL";
						*/
						//(currentWaypoint _x) setWaypointBehaviour 				(_ZoneBehave select 1);
						//(currentWaypoint _x) setWaypointCombatMode 				(_ZoneBehave select 2);
						//(currentWaypoint _x) setWaypointSpeed 						(_ZoneBehave select 4);
						//(currentWaypoint _x) setWaypointFormation 				(_ZoneBehave select 3);
						if !([(position leader _x),((_x getVariable  ["GAIA_zone_intend",[]]) select 0)] call GAIA_fnc_isPositionInMarker) then
							 {
							 		_x  setSpeedMode "NORMAL";
							 		_x  setBehaviour "AWARE";
							 }
						else
							 {

							 	_x  setSpeedMode  (_ZoneBehave select 4);
							  _x  setBehaviour	(_ZoneBehave select 1);
								//_x  setCombatMode	(_ZoneBehave select 2);
								_x  setFormation	(_ZoneBehave select 3);

							 };


   				};
   		};
   };
}ForEach _TempGroups;


switch (_side) do
		{
		  case west				: {
		  										MCC_GAIA_GROUPS_WEST		=_TempGroups;
		  										MCC_GAIA_ZONES_WEST			=_TempZones;
		  										MCC_GAIA_ZONESTATUS_WEST=_ZoneStatus;
		  										MCC_GAIA_FACTIONS_WEST  = _factions;
		  									};
		  case east				: {
		  										MCC_GAIA_GROUPS_EAST		=_TempGroups;
		  										MCC_GAIA_ZONES_EAST			=_TempZones;
		  										MCC_GAIA_ZONESTATUS_EAST=_ZoneStatus;
		  										MCC_GAIA_FACTIONS_EAST  = _factions;
		  									};
		  case independent: {
		  										MCC_GAIA_GROUPS_INDEP 	=_TempGroups;
		  										MCC_GAIA_ZONES_INDEP		=_TempZones;
		  										MCC_GAIA_ZONESTATUS_INDEP=_ZoneStatus;
		  										MCC_GAIA_FACTIONS_INDEP  = _factions;
		  									};
		  case civilian: {
		  										MCC_GAIA_GROUPS_CIV		 	=_TempGroups;
		  										MCC_GAIA_ZONES_CIV			=_TempZones;
		  										MCC_GAIA_ZONESTATUS_CIV	=_ZoneStatus;
		  										MCC_GAIA_FACTIONS_CIV   = _factions;
		  									};
		};








true;