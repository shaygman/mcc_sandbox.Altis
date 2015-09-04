//=================================================================MCC_fnc_rtsDestroyObject==============================================================================
//	Destroy the selected logic
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl","_answer","_obj"];
disableSerialization;
_ctrl = _this select 0;

if (count MCC_ConsoleGroupSelected <=0) exitWith {};
_obj = MCC_ConsoleGroupSelected select 0;

{
	deleteVehicle _x
} forEach crew _obj;

deleteVehicle _obj;