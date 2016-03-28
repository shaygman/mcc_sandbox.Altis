//==================================================================MCC_fnc_moveToPos======================================================================================
// move an object to a new location
// Example: [[[netid _unit,_unit],_pos], "MCC_fnc_moveToPos", true, false] spawn BIS_fnc_MP;
// Params:
//	_unit: object, brocadcasting unit
//	_pos: array, position
//==============================================================================================================================================================================
private ["_unit","_pos"];
_unit = if (((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
_pos = _this select 1;
if (vehicle _unit == _unit) then {
	_unit setpos _pos;
} else {
	_pos = [_pos,1,100,2,1,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	if (driver vehicle _unit == _unit) then {vehicle _unit setpos _pos;};
};
