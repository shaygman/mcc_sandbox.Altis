//=================================================================MCC_fnc_rtsScanResourcesBasic==============================================================================
//	Start basic resources mission
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

if (missionNamespace getVariable [_varName ,false]) exitWith {};

_time = missionNamespace getVariable [format ['MCC_rtsMissionTime_%1', _side] ,time-3600];
if ((time - _time) < 3600) exitWith {systemChat format ["You can only scan form resources mission once every real life hour. Wait %1 more minutes", 60 - (floor ((time - _time)/60))]};

//broadcast mission time
missionNamespace setVariable [format ['MCC_rtsMissionTime_%1', _side] ,time];
publicVariable format ['MCC_rtsMissionTime_%1', _side];


//broadcast mission on
missionNamespace setVariable [_varName ,true];
publicVariable _varName;

[MCC_CONST_SELECTED] spawn MCC_fnc_baseSelected;

[[_side,10,false],"MCC_fnc_rtsScanResources",false,false] spawn BIS_fnc_MP;
