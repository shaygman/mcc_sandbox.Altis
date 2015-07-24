//=================================================================MCC_fnc_rtsStartElectricity==============================================================================
//	Start electricity production
//  Parameter(s):
//     _ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl","_res","_varName","_stat"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];

//remove resources
[_res] spawn MCC_fnc_baseResourceReduce;

_varName = format ["MCC_rtsElecOn_%1", playerSide];
_stat = !(missionNamespace getVariable [_varName,false]);
missionNamespace setVariable [_varName,_stat];
publicVariable _varName;
[MCC_CONST_SELECTED] spawn MCC_fnc_baseSelected;
