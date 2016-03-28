//==================================================================MCC_fnc_mainBoxOpen===========================================================================
// Opens the main box (survival box on start location)
// Example:[_object]  call MCC_fnc_mainBoxOpen;
// <IN>
//      <_object>           The box vehicle
//
// <OUT>
//      <Nothing>
//===========================================================================================================================================================================
private ["_target"];
disableSerialization;

_object     = [_this,0,missionnamespace,[missionnamespace,objnull]] call bis_fnc_param;

_object setVariable ["mcc_mainBoxUsed", true,true];
_null = [] call MCC_fnc_mainBoxInit;
waituntil {!dialog};
_object setVariable ["mcc_mainBoxUsed", false,true];