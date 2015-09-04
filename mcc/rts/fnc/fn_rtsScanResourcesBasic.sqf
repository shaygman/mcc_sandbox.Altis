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

//Start building time
private ["_obj","_BuildTime"];
playsound "click";
if (count MCC_ConsoleGroupSelected <=0) exitWith {};
_obj = MCC_ConsoleGroupSelected select 0;

//Start building time
if !([_obj,_res] call MCC_fnc_rtsBuildingProgress) exitWith {};

//Another mission was on
_time = missionNamespace getVariable [format ['MCC_rtsMissionTime_%1', _side] ,time-3600];
if ((time - _time) < 3600) exitWith {
	[9989,format ["You can only scan for resources mission once every real life hour. Wait %1 more minutes", 60 - (floor ((time - _time)/60))],5,true] call MCC_fnc_setIDCText;
};

//broadcast mission time
missionNamespace setVariable [format ['MCC_rtsMissionTime_%1', _side] ,time];
publicVariable format ['MCC_rtsMissionTime_%1', _side];


//broadcast mission on
missionNamespace setVariable [_varName ,true];
publicVariable _varName;

[MCC_ConsoleGroupSelected] spawn MCC_fnc_baseSelected;

[[_side,10,false],"MCC_fnc_rtsScanResources",false,false] spawn BIS_fnc_MP;
