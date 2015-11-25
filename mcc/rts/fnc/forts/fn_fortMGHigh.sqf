//=================================================================MCC_fnc_fortMGHigh==============================================================================
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
		    case west: {"B_HMG_01_high_F"};
		    case east: {"O_HMG_01_high_F"};
		    default {"I_HMG_01_high_F"};
		};

[_side,_varName,_res] call MCC_fnc_buildFort;