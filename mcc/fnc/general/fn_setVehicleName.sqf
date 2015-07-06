//==================================================================MCC_fnc_setVehicleName======================================================================================
// Sets vehicle name
// Example: [[[netid _unit,_unit], _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
// Params:
//	_unit: object, vehicle we want to set its init.
//	_name: string, the new name
//==============================================================================================================================================================================
private ["_unit","_unitname"];

_unit = if (((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
_unitname = _this select 1;

_unit setVehicleVarName _unitname;
_unit setVariable ["text",_unitname,true];
_unit call compile format ["%1=_This; PublicVariable ""%1""",_unitname];
