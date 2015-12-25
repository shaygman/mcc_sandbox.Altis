//==================================================================MCC_fnc_getVariable======================================================================================
// Global execute a command on server only  - SERVER ONLY
// Example: [[varName,playerID,VarDefaultValue], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================

private ["_varName","_id","_value","_player","_varType","_valueExist"];
_varName 	= _this select 0;
_player		= _this select 1;
_varDefault	= _this select 2;
_varType	= switch (toUpper (_this select 3)) do {
					case "STRING" :	{""};
					case "ARRAY" : 	{[]};
					case "SCALAR" : {0};
				};

if(!isServer) exitWith {};
if (isnil "_player") exitWith {};

_id = getPlayerUID _player;
_value = [name _player, _id, _varName, "read",_varType,true] call MCC_fnc_handleDB;
_valueExist = str _value != str _varType;

if (!_valueExist) then {
	_null = [name _player, _id, _varName, "write",_varDefault,true] call MCC_fnc_handleDB;
	_value = _varDefault;
};

//returns value
[[_varName,_value,_id], "MCC_fnc_setValue", _player, false] spawn BIS_fnc_MP;