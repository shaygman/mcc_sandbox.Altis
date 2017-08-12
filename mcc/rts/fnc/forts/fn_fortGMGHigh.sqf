//=================================================================MCC_fnc_fortGMGHigh==============================================================================
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl","_res","_side","_varName"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];
_side = playerSide;

_varName = switch (_side) do {
		    case west: {"B_GMG_01_high_F"};
		    case east: {"O_GMG_01_high_F"};
		    default {"I_GMG_01_high_F"};
		};

[_side,_res,_varName] call MCC_fnc_buildFort;