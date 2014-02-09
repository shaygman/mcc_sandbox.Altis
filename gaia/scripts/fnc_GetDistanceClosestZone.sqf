//  In: [side,position]
// Out: Distance to Closest Zone
// Spirit 19-1-2014

private ["_side","_ClosestZone","_zones","_Distance"];

_side 		= _this select 0;
_pos			= _this select 1;
_Distance	= 0;

Switch (_side) do
			{
			  case west				: {_Zones = MCC_GAIA_ZONES_WEST;};
			  case east				: {_Zones = MCC_GAIA_ZONES_EAST;};
			  case independent: {_Zones = MCC_GAIA_ZONES_INDEP;};
			};

_ClosestZone=(([_Zones,[],{_pos distance (getMarkerPos _x)},"ASCEND"] call BIS_fnc_sortBy)select 0);

if IsNil("_ClosestZone") then
	{_Distance = 99999;}
else
	{		
		_Distance = ((getMarkerPos _ClosestZone) distance _pos);
	};
	
_Distance


