//=================================================================MCC_fnc_rtsScanResourcesCancel==============================================================================
//	Cancel resources mission
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl","_res","_side","_varName"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];
_side = playerSide;
_varName = format ['MCC_rtsMissionOn_%1', _side];

if !(missionNamespace getVariable [_varName ,false]) exitWith {};

//broadcast mission on
missionNamespace setVariable [_varName ,false];
publicVariable _varName;

[MCC_ConsoleGroupSelected] spawn MCC_fnc_baseSelected;

[[_side,10,true],"MCC_fnc_rtsScanResources",false,false] spawn BIS_fnc_MP;
