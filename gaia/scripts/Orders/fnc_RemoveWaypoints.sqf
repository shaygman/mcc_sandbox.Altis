/* ----------------------------------------------------------------------------
Function: fnc_RemoveWayPoints

Description:
	Delete all waypoints of a given group

Parameters:
	- Group
	
		
Optional:
	- <NONE>

Returns:
	true/false

Author:
	Spirit

---------------------------------------------------------------------------- */

private ["_group"];

_group = _this select 0;

_TempArray 			= [];
_wpTransporter	= [];

switch (side _group) do
		{
		  case west				: {_TempArray =MCC_GAIA_WPPOS_WEST; };
		  case east				: {_TempArray =MCC_GAIA_WPPOS_EAST; };
		  case independent: {_TempArray =MCC_GAIA_WPPOS_INDEP; };
		};

// Clear all way points
while {(count (waypoints _group)) > 0} do
{
 deleteWaypoint ((waypoints _group) select 0); 
};



//Clear the WP array also 
for [{_i=0},{_i < count _TempArray},{_i=_i+1}] do 
{
	
	if ((_TempArray select _i select 1)==_group) then
	{
			_TempArray set [_i, "REMOVE"];
			_TempArray = _TempArray - ["REMOVE"];
	};
};


//In case of combined orders (for now transportation), then in case of we are the transporting party do unload the load
if (!isnull(_group getVariable  ["GAIA_CombinedOrder",grpNull])) then
{
	
	if !(_group getVariable  ["GAIA_class",""] in ["Infantry","ReconInfantry"]) then
		{   	 _wpTransporter	= _x addWaypoint [(position leader _group), 0];
				   _wpTransporter	setWaypointType "TR UNLOAD";
				   _wpTransporter	setWaypointCompletionRadius 20;	
		};
   		
		
		
};

//Clear the current order also
_group setVariable ["GAIA_Order"							, "None", false];
_group setVariable ["GAIA_CombinedOrder"			, grpNull, false];

//Clear fortify specific if needed.
_group setVariable ["Garrisoning",false];  
_group setVariable ["GAIA_OriginalDestination", [], false];

switch (side _group) do
		{
		  case west				: {MCC_GAIA_WPPOS_WEST	=_TempArray ; };
		  case east				: {MCC_GAIA_WPPOS_EAST	=_TempArray ; };
		  case independent: {MCC_GAIA_WPPOS_INDEP	=_TempArray ; };
		};

true