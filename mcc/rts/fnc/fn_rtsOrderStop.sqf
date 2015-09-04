//=================================================================MCC_fnc_rtsOrderStop==============================================================================
//	Stop WP
//  Parameter(s):
//     _ctrl: CONTROL
//==============================================================================================================================================================================
private ["_group"];

if (count MCC_ConsoleGroupSelected <=0) exitWith {};

{
	_group = _x;
	if (typeName _group == typeName grpNull) then {
		[[1,getpos leader _group,[0,"YELLOW","NO CHANGE","FULL","AWARE","true","",0],[_group],true],"MCC_fnc_manageWp", leader _group, false] spawn BIS_fnc_MP;
	};
} forEach MCC_ConsoleGroupSelected;

