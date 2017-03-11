//===================================================MCC_fnc_settingsMedical===============================================================================================
// module
// Medical system settings
//===========================================================================================================================================================================
private ["_module","_var","_pos"];

_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

//if ACE enabled exit
if (missionNamespace getVariable ["MCC_isACE",false]) exitWith {};

//did we get here from the 2d editor?
if (typeName (_module getVariable ["medicComplex",true]) == typeName 0) exitWith {
	//Enable system
	MCC_medicSystemEnabled = true;
	[] spawn MCC_fnc_initMedic;

	//Complex
	_var 	= _module getvariable ["medicComplex",1];
	MCC_medicComplex = if (_var == 0) then {false} else {true};

	//bleeding
	_var 	= _module getvariable ["medicBleedingEnabled",1];
	MCC_medicBleedingEnabled = if (_var == 0) then {false} else {true};

	//BleedingTime
	MCC_medicBleedingTime = (_module getvariable ["BleedingTime",200]);

	//DamageCoef
	MCC_medicDamageCoef = (_module getvariable ["DamageCoef",1]);

	//XPmesseges
	_var 	= _module getvariable ["medicXPmesseges",1];
	MCC_medicXPmesseges = if (_var == 0) then {false} else {true};

	//PunishTK
	_var 	= _module getvariable ["medicPunishTK",1];
	MCC_medicPunishTK = if (_var == 0) then {false} else {true};

	//Medic HuD
	_var 	= _module getvariable ["MCC_medicShowWounded",1];
	MCC_medicShowWounded = _var == 1;
};

//Not curator exit
if !(local _module) exitWith {};

_pos = getpos _module;

_resualt = ["Medical System",[
 						["Complex System",true],
 						["Bleeding",true],
 						["Bleeding Time (Sec)",300],
 						["Kill Messages",true],
 						["Punish Team Kill",false],
 						["Medic HUD",true]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

missionNamespace setVariable ["MCC_medicSystemEnabled",true];
publicvariable "MCC_medicSystemEnabled";

{
	missionNamespace setVariable [_x,_resualt select _foreachindex];
	publicvariable _x;
} forEach ["MCC_medicComplex","MCC_medicBleedingEnabled","MCC_medicBleedingTime","MCC_medicXPmesseges","MCC_medicPunishTK","MCC_medicShowWounded"];

//Start ambient civilians
[] remoteExec ["MCC_fnc_initMedic", 0, true];

deleteVehicle _module;