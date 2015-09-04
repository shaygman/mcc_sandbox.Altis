//=================================================================MCC_fnc_rtsOrderLand==============================================================================
//	Order land
//  Parameter(s):
//     _ctrl: CONTROL
//==============================================================================================================================================================================
private ["_group","_vehicle","_vehicles"];

if (count MCC_ConsoleGroupSelected <=0) exitWith {};

_vehicles = [];
{
	_group = _x;
	if (typeName _group == typeName grpNull) then {
		{
			if !(vehicle _x in _vehicles) then {_vehicles pushBack vehicle _x};
		} forEach units _group;
	};
} forEach MCC_ConsoleGroupSelected;

player globalRadio "CuratorWaypointPlaced";
{
	_vehicle = _x;
	[[1,getpos _vehicle,[17,"YELLOW","NO CHANGE","FULL","AWARE","true","",0],[group _x],true],"MCC_fnc_manageWp", leader group _x, false] spawn BIS_fnc_MP;
} forEach _vehicles;
