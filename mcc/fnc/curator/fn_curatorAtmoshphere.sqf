//============================================================MCC_fnc_curatorAtmoshphere========================================================================================
// Manage atmosphere
//===========================================================================================================================================================================
private ["_pos","_module","_resualt","_atmosphere"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;

//did we get here from the 2d editor?
if (typeName (_module getVariable ["atmosphere",true]) == typeName 0) exitWith {

	_atmosphere =  (_module getVariable ["_atmosphere",14]);
	[_pos, 0, _atmosphere] call MCC_fnc_deleteBrush;
};

_resualt = ["Add Atmosphere",[
 						["Atmosphere",["Sandstorm","Blizzard","Snow","Heat Wave","Clear All"]]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};
_atmosphere = (_resualt select 0)+14;

[[_pos, 0, _atmosphere], "MCC_fnc_deleteBrush", false, false] call BIS_fnc_MP;

deleteVehicle _module;