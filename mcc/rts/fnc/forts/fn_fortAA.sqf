//=================================================================MCC_fnc_fortAA==============================================================================
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
		    case west: {"B_static_AA_F"};
		    case east: {"O_static_AA_F"};
		    default {"I_static_AA_F"};
		};

[_side,_res,_varName] call MCC_fnc_buildFort;