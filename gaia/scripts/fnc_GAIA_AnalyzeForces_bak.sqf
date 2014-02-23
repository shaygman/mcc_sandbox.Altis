/* ----------------------------------------------------------------------------
Function: fnc_GAIA_AnalyzeForces.sqf

Description:
	This fills the MCC_GAIA_GROUPS_%SIDE% for each GROUP that is under control of GAIA.
	Also fills the active zones for this side.

Parameters:
	- Side

Returns:
	true

Author:
	Spirit, 17-1-2014

---------------------------------------------------------------------------- */

private ["_side","_TempGroups","__ZoneStatus","_Targets","_TargetInZone","_TargetNear"];

_side = _this select 0;
_TempGroups 			= [];
_TempZones				= [];
_gaia_zone_intend	= [];
_zone							= "";
_ZoneStatus				= [];
_Targets					= [];
_TargetInZone			= false;
_TargetNear				= false;
_TempTargets			= [];

switch (_side) do
		{
		  case west				: {
		  										_ZoneStatus = MCC_GAIA_ZONESTATUS_WEST;
		  										_Targets		= MCC_GAIA_TARGETS_WEST;
		  									};
		  case east				: {
		  										_ZoneStatus = MCC_GAIA_ZONESTATUS_EAST;
		  										_Targets		= MCC_GAIA_TARGETS_EAST
		  									};
		  case independent: {
		  										_ZoneStatus = MCC_GAIA_ZONESTATUS_INDEP;
		  										_Targets		=	MCC_GAIA_TARGETS_INDEP;
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
 	 			if (count([_x] call fnc_GetZoneIntendFomGroup)>0) then {_TempGroups = _TempGroups + [_x];};
 	 			_gaia_zone_intend = _x getVariable ["GAIA_ZONE_INTEND",[]];
 	 			if ((count _gaia_zone_intend)>0) then
 	 			{
 	 				_zone = _gaia_zone_intend select 0;
 	 				if !(_zone in _TempZones) then
 	 					{
 	 						
 	 						_TempZones = _TempZones + [_Zone];
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
					if ([(position (_TempTargets select _T)),_Zone] call fnc_PosIsInMarker				) exitWith {_TargetInZone= true;}; 
					
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

//Update Child Zones of the danger.

//Update FORCES based on Zone Status


switch (_side) do
		{
		  case west				: {
		  										MCC_GAIA_GROUPS_WEST		=_TempGroups;
		  										MCC_GAIA_ZONES_WEST			=_TempZones;
		  										MCC_GAIA_ZONESTATUS_WEST=_ZoneStatus;
		  									};
		  case east				: {
		  										MCC_GAIA_GROUPS_EAST		=_TempGroups;
		  										MCC_GAIA_ZONES_EAST			=_TempZones;
		  										MCC_GAIA_ZONESTATUS_EAST=_ZoneStatus;
		  									};
		  case independent: {
		  										MCC_GAIA_GROUPS_INDEP 	=_TempGroups;
		  										MCC_GAIA_ZONES_INDEP		=_TempZones;
		  										MCC_GAIA_ZONESTATUS_INDEP=_ZoneStatus;
		  									};
		};
	
	




	
	 
true;