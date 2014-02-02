//==================================================================CP_fnc_setVehicleInit======================================================================================
// Sets vehicle init
// Example: [[netID _unit, _init], "CP_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
// Params: 
//	_unit: object, vehicle we want to set its init. 
//	_init: string, the new init command (use _this instead of this)
//==============================================================================================================================================================================	
private ["_netID","_unit","_unitinit"];

_netID = _this select 0;
_unit = objectFromNetID _netID;
_unitinit = _this select 1;
_unit call compile format ["%1",_unitinit];
