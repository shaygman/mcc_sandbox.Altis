//=================================================================MCC_fnc_rtsDestroyLogic==============================================================================
//	Destroy the selected object
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl"];
disableSerialization;
_ctrl = _this select 0;

if (count MCC_ConsoleGroupSelected <=0) exitWith {};

_answer = ["<t font='TahomaB'>Are you sure you want to destroy it?</t>","Destroy",nil,true] call BIS_fnc_guiMessage;
waituntil {!isnil "_answer"};
if (_answer) then {
	[MCC_ConsoleGroupSelected select 0, true] call MCC_fnc_rtsClearBuilding;
};
