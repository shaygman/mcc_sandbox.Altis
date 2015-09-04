//===================================================MCC_fnc_settingsMedical===============================================================================================
// module
// Medical system settings
//===========================================================================================================================================================================
private ["_logic","_var"];

_logic	= _this select 0;

//if ACE enabled exit
if (MCC_isACE) exitWith {};

//Enable system
MCC_medicSystemEnabled = true;
[] spawn MCC_fnc_initMedic;

//Complex
_var 	= _logic getvariable ["medicComplex",1];
MCC_medicComplex = if (_var == 0) then {false} else {true};

//bleeding
_var 	= _logic getvariable ["medicBleedingEnabled",1];
MCC_medicBleedingEnabled = if (_var == 0) then {false} else {true};

//BleedingTime
MCC_medicBleedingTime = (_logic getvariable ["BleedingTime",200]);

//DamageCoef
MCC_medicDamageCoef = (_logic getvariable ["DamageCoef",1]);

//XPmesseges
_var 	= _logic getvariable ["medicXPmesseges",1];
MCC_medicXPmesseges = if (_var == 0) then {false} else {true};

//PunishTK
_var 	= _logic getvariable ["medicPunishTK",1];
MCC_medicPunishTK = if (_var == 0) then {false} else {true};