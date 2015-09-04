//=================================================================MCC_fnc_rtsBuyTickets==============================================================================
//	Adds Tickets
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl","_res","_side","_varName"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];
_side = playerSide;

//Start building time
private ["_obj","_BuildTime"];
playsound "click";
if (count MCC_ConsoleGroupSelected <=0) exitWith {};
_obj = MCC_ConsoleGroupSelected select 0;

//progress bar
if !([_obj,_res] call MCC_fnc_rtsBuildingProgress) exitWith {};

[9989,"5 Tickets Added",5,true] call MCC_fnc_setIDCText;

[_side , 5] call BIS_fnc_respawnTickets;