//==================================================================MCC_fnc_settingsRadio===============================================================================================
// module
// Example: [] call MCC_fnc_settingsRadio;
//===========================================================================================================================================================================
private ["_logic","_var"];

_logic	= _this select 0;

MCC_VonRadio = true;

//radio distances
MCC_vonRadioDistanceGlobal = _logic getvariable ["radioGlobal",2000];
MCC_vonRadioDistanceSide = _logic getvariable ["radioSide",5000];
MCC_vonRadioDistanceCommander = _logic getvariable ["radioCommander",10000];
MCC_vonRadioDistanceGroup = _logic getvariable ["radioGroup",500];

//Kick idle
_var 	= _logic getvariable ["kickIdle",1];
MCC_vonRadioKickIdle = if (_var == 0) then {false} else {true};
MCC_vonRadioKickIdleTime = _logic getvariable ["kickIdleTime",10];
