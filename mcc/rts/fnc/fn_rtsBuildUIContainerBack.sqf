//=================================================================MCC_fnc_rtsBuildUIContainerBack==============================================================================
//	Upgrad building
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl"];
disableSerialization;
_ctrl = _this select 0;

if (count MCC_ConsoleGroupSelected <=0) exitWith {};

[MCC_ConsoleGroupSelected] spawn MCC_fnc_baseSelected;

