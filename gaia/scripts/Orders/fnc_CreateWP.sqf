/* ----------------------------------------------------------------------------
Function: fnc_CreatePatrolWP

Description:
	Create waypoints for a group

Parameters:
	- Group 
	- Zone
	

Returns:
	Nr of generated waypoints

Author:
	Spirit
---------------------------------------------------------------------------- */

private ["_group", "_newpos ","_zone","_max","_i","_wp"];
_group 		 = _this select 0;
_zone			 = _this select 1;
_goal			 = _this select 2;


//Combined orders store the original location (where he wanted to go before getting in the transporter) in this variable. So check if it holds a position
_newpos = _group getVariable  ["GAIA_OriginalDestination",[]];
_group setVariable ["GAIA_OriginalDestination", [], false];
if (count(_newpos)==0) then 
{
		_newpos 	=  [_zone,_goal,(side _group)] call fnc_GetPosition;
		
};	


if (count(_newpos)>0) then
{
 	//Now where ever a unit has last been, place a breadcrumb (so even static guards).
 	// This is used for making the patrols as optimized as possible. We try to avoid those positions. 

	_dummy 	=  [_group,_newpos,"MOVE"] call fnc_addWaypoint;
};




_newpos