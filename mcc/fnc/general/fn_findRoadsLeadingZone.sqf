//======================================================MCC_fnc_findRoadsLeadingZone=========================================================================================================
// Create a pick intel objective
// Example:[_pos,_radius] call MCC_fnc_findRoadsLeadingZone; 
// Return - handler
//========================================================================================================================================================================================
private ["_pos","_radius","_arrayOne","_arrayTwo","_goodArray","_current","_close"];

_pos		= _this select 0; 
_radius		= _this select 1; 
_goodArray 	= []; 

_arrayOne = [_pos, _radius, []] call MCC_fnc_nearestRoad; 

_radius = _radius + 50;
_arrayTwo = [_pos, _radius, _arrayOne] call MCC_fnc_nearestRoad; 

//remove positions that are closer then 50 meters
if (count _arrayTwo > 0) then		
{
	{
		_current = _x; 
		_close = false; 
		{
			if (((_x distance _current)!=0) && ((_x distance _current) < 200)) then {_close = true}; 
		} foreach _goodArray;
		if (!_close) then {_goodArray set [count _goodArray,_x]}; 
	} foreach _arrayTwo;
};

_goodArray;

				
		
