//============================================================MCC_fnc_ambientDenied====================================================================================
// Restrict zone for ambient AI
//===========================================================================================================================================================================
private ["_module","_resualt"];
_module = param [ 0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

//did we get here from the 2d editor?
if (typeName (_module getVariable ["radius",true]) == typeName 0) exitWith {};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_resualt = ["Ambient Civilians -  Restrict zone for ambient AI",[
 						["Radius",500]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

_module setVariable ["radius",_resualt select 0,true];