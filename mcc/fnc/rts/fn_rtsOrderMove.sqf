//=================================================================MCC_fnc_rtsOrderMove==============================================================================
//	Move the selected units
//  Parameter(s):
//     _ctrl: CONTROL
//==============================================================================================================================================================================
private ["_group"];

if (count MCC_ConsoleGroupSelected <=0) exitWith {};
{
	_group = _x;
	if (typeName _group == typeName grpNull) then {

	};
} forEach MCC_ConsoleGroupSelected;

