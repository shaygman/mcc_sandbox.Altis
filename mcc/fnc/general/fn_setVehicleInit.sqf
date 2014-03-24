//==================================================================MCC_fnc_setVehicleInit======================================================================================
// Sets vehicle init
// Example: [[[netID _unit,_unit], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
// Params: 
//	_unit: object, vehicle we want to set its init. 
//	_init: string, the new init command (use _this instead of this)
//==============================================================================================================================================================================	
private ["_unit","_unitinit"];

_unit = if (((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
_unitinit = _this select 1;

_unit setVariable ["vehicleinit",_unitinit];
_unit call compile format ["%1",_unitinit];
