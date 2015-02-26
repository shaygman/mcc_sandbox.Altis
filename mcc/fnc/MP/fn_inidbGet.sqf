//==================================================================MCC_fnc_LootGet======================================================================================
// Global execute a command on server only  - SERVER ONLY
// Example: [[varName,playerID,VarDefaultValue], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================
private ["_varName1","_varName2","_varName3","_read","_id","_value","_player","_varType","_valueExist"];
_varName1 	=  [_this,0,"",[""]] call bis_fnc_param;
_varName2 	=  [_this,1,"",[""]] call bis_fnc_param;
_varName3 	=  [_this,2,"",[""]] call bis_fnc_param;
_varType	=  [_this,3,"",[""]] call bis_fnc_param;
_player		= [_this,4,objNull,[objNull]] call bis_fnc_param;
_read		= [_this,5,true,[true]] call bis_fnc_param;
_value		= [_this,6,[]] call bis_fnc_param;

//systemChat format ["this: %1 %2 %3 %4", _varName1, _varName2, _varName3, _varType];
if(!isServer) exitWith {};
if (isNull _player || !(isPlayer _player)) exitWith {};

_id = getPlayerUID _player;

if (_read) exitWith
{
	_value = [_varName1, _varName2, _varName3, _varType] call iniDB_read;

	//returns value
	[[_value,_id], "MCC_fnc_inidbSet", _player, false] spawn BIS_fnc_MP;
};


//Update server
[_varName1, _varName2,_varName3,_value, _varType] call iniDB_write;
true;