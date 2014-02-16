/* ----------------------------------------------------------------------------
Function: fnc_GetCAPoints

Description:
	Get the points of the CA

Parameters:
	- Side

Returns:
	true

Author:
	Spirit, 24-1-2014

---------------------------------------------------------------------------- */

private ["_side","_CA","_grp","_zns","_trg","_Zone","_CA","_TargetList"];

_side 				= _this select 0;
_CA						=	_this select 1;
_grp					= [];
_zns					= [];
_trg					= [];
_Zone					= "";
_TargetList		= [];
_CACost				= [];


	
// CA ATTACK ORDERS
switch (_side) do
			{
			  case west				: {
			  		  						 
			  		  						 _grp	= MCC_GAIA_GROUPS_WEST;
			  		  						 _zns	=	MCC_GAIA_ZONES_WEST;
			  		  						 _trg	= (MCC_GAIA_TARGETS_WEST select 0)+(MCC_GAIA_TARGETS_WEST select 1)+(MCC_GAIA_TARGETS_WEST select 2);
			  									};
			  case east				: {
			  									 
			  									 _grp	= MCC_GAIA_GROUPS_EAST;
			  									 _zns	=	MCC_GAIA_ZONES_EAST;
			  									 _trg	= (MCC_GAIA_TARGETS_EAST select 0)+(MCC_GAIA_TARGETS_EAST select 1)+(MCC_GAIA_TARGETS_EAST select 2);
			  									};
			  case independent: {
			  	                 
			  	                 _grp	= MCC_GAIA_GROUPS_INDEP;
			  	                 _zns	=	MCC_GAIA_ZONES_INDEP;
			  	                 _trg	= (MCC_GAIA_TARGETS_INDEP select 0)+(MCC_GAIA_TARGETS_INDEP select 1)+(MCC_GAIA_TARGETS_INDEP select 2);
			  	                };
			};



	{		
		if ([_CA,_x] call fnc_PosIsInMarker				) exitWith {_Zone=_x;}; 
	}foreach _zns;
		
	
	
		
	
	//Get the targets in the CA
	{
			
			if (count(_x getVariable ["GAIA_TargetInfo",[]])>0) then
			{
				if ((((_x getVariable ["GAIA_TargetInfo",[]])select 1) distance _CA)<100) then
				 {
				 		if (_x iskindof "CAMANBASE") then
				 		{_TargetList	= _TargetList+ [_x];}
				 		else	
				 		{_TargetList	= _TargetList+ (units _x);}
				 }; 
			};
	} foreach _trg;
	
	
	//Get the points of the CA
	_CACost	=  ([_TargetList] call fnc_ClassifyUnits);
	
	//Lets work on the points, this has to leave this function when we implement terrain factors and other stuff that also influences points
	//For now its dirty in here by check if in zone then more points then outside
	_Points = _CACost select 2 ;	
	
	//Calculate with multipliers
	if !isnil(_Zone) then {_points = _points *3} else {_points = _points *2};
	
	_CACost set [2,_Points ];
	
	_CACost
			

	
	

	 

	 
