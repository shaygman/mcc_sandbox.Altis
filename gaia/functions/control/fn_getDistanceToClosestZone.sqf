//  In: [side,position]
// Out: Distance to Closest Zone
// Spirit 19-1-2014

private ["_side","_closetZone","_zones","_distance","_fnc_closetZone"];

_side = _this select 0;
_pos = _this select 1;

//Find closest zone loop
_fnc_closetZone = {
	params ["_zones","_pos"];

	_closetZone = "";
	{
		_markerPos = getMarkerPos _x;
		if ((_pos distance _markerPos) < (_pos distance (getMarkerPos _closetZone))) then {_closetZone = _x};
	} forEach _zones;

	_closetZone
};

_ExcludeAmbientZone = if (count _this > 2) then {_this select 2} else {false};

_distance	= 0;

Switch (_side) do
			{
			  case west				: {_zones = missionNamespace getVariable ["MCC_GAIA_ZONES_WEST",[]]};
			  case east				: {_zones =  missionNamespace getVariable ["MCC_GAIA_ZONES_EAST",[]]};
			  case independent: {_zones =  missionNamespace getVariable ["MCC_GAIA_ZONES_INDEP",[]]};
			  case civilian		: {_zones =  missionNamespace getVariable ["MCC_GAIA_ZONES_CIV",[]]};
			};

if _ExcludeAmbientZone then {
	_zones = ([_zones, {parseNumber _x <1000}] call BIS_fnc_conditionalSelect);
};

_closetZone= [_zones,_pos] call _fnc_closetZone;

if (_closetZone == "") then {
		_distance = 99999;
} else {
	//if (!(getMarkerColor _ClosestZone == ""))then
	_distance = ((getMarkerPos _closetZone) distance _pos);
};

_distance


