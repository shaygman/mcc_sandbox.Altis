//==================================================================Conflict Area's===============================================================================================
//a=[WEST] call fnc_GAIA_ConflictAreas; PLAYER setPoS (A SELECT 1) 
//
//
//===========================================================================================================================================================================	
private ["_units","_class","_TargetInfo"];

_HQ_side 		= _this select 0; 
_class			= "";
_Targets		= [];
_CA					= [];
_Spots			= [];


switch (_HQ_side) do
			{
			  case west				: {_Targets = (MCC_GAIA_TARGETS_WEST select 0)+(MCC_GAIA_TARGETS_WEST select 1)+(MCC_GAIA_TARGETS_WEST select 2);
			  									 _Spots		= (MCC_GAIA_TARGETS_WEST select 3);
			  									 
			  									 _CA = MCC_GAIA_CA_WEST;
			  									};
			  case east				: {_Targets = (MCC_GAIA_TARGETS_EAST select 0)+(MCC_GAIA_TARGETS_EAST select 1)+(MCC_GAIA_TARGETS_EAST select 2);
			  									 _Spots		= (MCC_GAIA_TARGETS_EAST select 3);
			  									 
			  									 _CA = MCC_GAIA_CA_EAST;
			  									};
			  case independent: {_Targets = (MCC_GAIA_TARGETS_INDEP select 0)+(MCC_GAIA_TARGETS_INDEP select 1)+(MCC_GAIA_TARGETS_INDEP select 2);
			  									 _Spots		= (MCC_GAIA_TARGETS_INDEP select 3);
			  	                 
			  	                 _CA = MCC_GAIA_CA_INDEP;
			  	                };
			};
// Delete all CA's that no longer hold any Targets + 
// Removed spots from selection (we leave that up to clear patrols, no longer attacks
//SPOTS (so fully cleared)

{
	_SelectedCA = _x;
	_delete 		= true;
	{
		_TargetInfo = (_x getVariable ["GAIA_TargetInfo",[]]);
		if (count(_TargetInfo)>0) then
			{
				_TargetPos = _TargetInfo select 1;
				if ((_SelectedCA distance _TargetPos)<100) exitwith {_delete = false;}
			};		
	}forEach (_Targets /*+_Spots*/);	
	if (_delete) then {_ca=_ca - [_x]};
}forEach _Ca;

// Do create a CA on each position of a target that is not in range of 200 within the next the CA		
{
	_TargetInfo = _x getVariable ["GAIA_TargetInfo",[]];	
	if !((count([_ca, {((_x distance (_TargetInfo select 1))<200)}] call BIS_fnc_conditionalSelect))>0)
	then
		{_ca  = _ca + [(_TargetInfo select 1)];	};
}forEach _Targets;

// Order the CA's. The one who is the closest to any zone wins
//_ca=[_ca,[],{[_HQ_side,_x] CALL fnc_GetDistanceClosestZone;},"ASCEND"] call BIS_fnc_sortBy;
if (count(_ca)>0) then
	{
		_CA=[_CA,[],{[_HQ_side,_x] CALL fnc_GetDistanceClosestZone;}] call BIS_fnc_sortBy; 
	};
	
	
//Debug info about the CA's
if (MCC_GAIA_DEBUG and _HQ_side==(Side player)) then
{
	{	
		deleteMarkerLocal _x;
	}
	foreach MCC_GAIA_CA_DEBUG;
	
	MCC_GAIA_CA_DEBUG = [];
		
		{
			_marker = createMarkerLocal  [str(_x), _x ];
			MCC_GAIA_CA_DEBUG = MCC_GAIA_CA_DEBUG + [str(_x)];
			_marker setMarkerShapeLocal  "ELLIPSE";
			 _marker setMarkerSizeLocal [100, 100]
		}forEach _CA;
	
};

//Give the CA to the right side
switch (_HQ_side) do
			{
			  case west				: {
			  										MCC_GAIA_CA_WEST = _CA;
			  									};
			  case east				: {
			  										MCC_GAIA_CA_EAST = _CA;
			  									};
			  case independent: {
			  										MCC_GAIA_CA_INDEP = _CA;
			  	                };
			};
			

_ca