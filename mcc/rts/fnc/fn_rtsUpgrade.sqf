//=================================================================MCC_fnc_rtsUpgrade==============================================================================
//	Upgrad building
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl","_res","_side","_cfgName","_obj"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];
_cfgName = _this select 2;

if (count MCC_ConsoleGroupSelected <=0) exitWith {};
_obj = MCC_ConsoleGroupSelected select 0;
_side = playerSide;

//Remove old marker
[[objNull]] spawn MCC_fnc_baseSelected;
[] call MCC_fnc_rtsMakeMarkersGroups;

//remove resources
[_res] spawn MCC_fnc_baseResourceReduce;

private ["_pos","_dir"];
_pos = getpos _obj;
_dir = getdir _obj;
[_obj, false] call MCC_fnc_rtsClearBuilding;
[[_pos, _dir,_cfgName, 1, _side],"MCC_fnc_construct_base",false] spawn bis_fnc_MP