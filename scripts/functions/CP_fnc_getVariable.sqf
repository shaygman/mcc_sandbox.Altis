//==================================================================CP_fnc_getVariable======================================================================================
// Global execute a command on server only  - SERVER ONLY
// Example: [[varName,playerID,VarDefaultValue], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================

private ["_varName","_id","_value","_player","_varType","_valueExist"];
_varName 	= _this select 0;			
_player		= _this select 1; 
_varDefault	= _this select 2; 
_varType	= toUpper (_this select 3); 

if(!isServer) exitWith {};
if (isnil "_player") exitWith {}; 

_id = getPlayerUID _player;

_value = [name _player, _id, _varName, _varType] call iniDB_read;

switch _varType do 
{
	case "STRING" : 
	{
		if (isnil "_value") then {_value = ""};
		_valueExist = if (_value == "") then {false} else {true}; 
	}; 
	
	case "ARRAY" : 
	{
		if (isnil "_value") then {_value = []};
		_valueExist = if (count _value == 0) then {false} else {true}; 
	};
	
	case "SCALAR" : 
	{
		if (isnil "_value") then {_value = 0};
		_valueExist = if (_value == 0) then {false} else {true}; 
	};
};

if (!_valueExist) then
{
	[name _player, _id, _varName, _varDefault, _varType] call iniDB_write;
	_value = _varDefault;
}; 

//returns value		
[[_varName,_value,_id], "CP_fnc_setValue", _player, false] spawn BIS_fnc_MP;			