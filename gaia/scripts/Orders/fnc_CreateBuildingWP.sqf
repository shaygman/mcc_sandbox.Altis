/* ----------------------------------------------------------------------------
Function: fnc_CreateBuildingWP

Description:
	Create waypoints to patrol houses within the given radius

Parameters:
	- Group 
	- pos
	

Returns:
	Nr of generated waypoints

Author:
	Spirit
---------------------------------------------------------------------------- */

private ["_group", "_buildings ","_max","_i","_wp","_pos"];
_group 		 = _this select 0;
_pos			 = _this select 1;


//Then actualy go there.

_buildings = (nearestObjects [_pos, ["house"], 30]);
_nr =0;


	{
	_i=0;
	while {str(_x buildingPos _i) != "[0,0,0]"} do {_i = _i + 1;};
	
	_wp = _group addWaypoint [(getPos _x), 0];
	_wp setWaypointType "MOVE"; 
	_wp setWaypointHousePosition random(_i);
	_wp waypointAttachObject _x;		
	
	_nr= _nr +1;
	
	}	foreach _buildings;

//We found buildings? Make sure nobody else goes here
if (_nr>0) then	
{
		//Make sure we dont go here again.
	switch (side _group) do
			{
			  case WEST				: {MCC_GAIA_WPPOS_WEST = MCC_GAIA_WPPOS_WEST + [[_pos,_group]];};
			  case EAST				: {MCC_GAIA_WPPOS_EAST = MCC_GAIA_WPPOS_EAST + [[_pos,_group]];};
			  case independent: {MCC_GAIA_WPPOS_INDEP = MCC_GAIA_WPPOS_INDEP + [[_pos,_group]];};
			};
};

_nr