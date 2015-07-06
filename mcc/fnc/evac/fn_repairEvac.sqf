//===================================================================MCC_fnc_repairEvac======================================================================================
// Repair evac helicopter
// Params:
// 	_vehicle: OBJECT
// 	_onlyAI: BOOLEAN - only repair AI vehicle
//==============================================================================================================================================================================
private ["_vehicle","_onlyAI"];
_vehicle = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_onlyAI = [_this, 1, false, [false]] call BIS_fnc_param;

if (isNull _vehicle) exitWith {};
if (_onlyAI && isPlayer driver _vehicle) exitWith {};

_vehicle setfuel 1;
_vehicle setDamage 0;
