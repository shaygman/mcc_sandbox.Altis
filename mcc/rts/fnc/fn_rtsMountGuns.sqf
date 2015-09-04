//=================================================================MCC_fnc_rtsFncMountGuns==============================================================================
//	Mount turrets on civilian vehicles
//  Parameter(s):
//     _ctrl: CONTROL
//==============================================================================================================================================================================
private ["_ctrl","_cfgName","_obj","_pos","_dir","_damage","_res","_BuildTime"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];


if (count MCC_ConsoleGroupSelected <=0) exitWith {};
_obj = MCC_ConsoleGroupSelected select 0;
if !(alive _obj) exitWith {};

_pos = getPos _obj;
_dir = getdir _obj;
_damage = getDammage _obj;

//remove resources
[_res] spawn MCC_fnc_baseResourceReduce;

//get time
_BuildTime = 0;
{
	if ((_x select 0)=="time") exitWith {_BuildTime = (_x select 1)};
} foreach _res;

//eject units
{
	_x action ["EJECT",_obj];
} forEach crew _obj;

deleteVehicle _obj;

_obj = "B_G_Offroad_01_armed_F" createVehicle _pos;
_obj setpos _pos;
_obj setdir _dir;
_obj setDamage _damage;

