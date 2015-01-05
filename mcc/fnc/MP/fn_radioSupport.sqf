//==================================================================MCC_fnc_radioSupport=========================================================================================
// Broadcast radio support to all elements not including the broadcaster group
// Example:[_caller, _messege] call MCC_fnc_radioSupport;
//===============================================================================================================================================================================
private ["_caller","_type","_vehicle","_broadcast","_messege"];
_caller 	=_this select 0;
_messege	=_this select 1;

//No dedi no HC
if (isDedicated || !hasInterface) exitWith {};

//Do not use radio on the group calling it
if (_caller in (units player)) exitWith {};

_caller globalRadio _messege;
