//=================================================================MCC_fnc_forthBarrierCorner==============================================================================
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl","_res","_side","_varName"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];
_side = playerSide;

[_side,"Land_HBarrierWall_corner_F",_res] call MCC_fnc_buildFort;