//==================================================================MCC_fnc_LootGet======================================================================================
// Global execute a command on server only  - SERVER ONLY
// Example: [[varName,playerID,VarDefaultValue], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================
private ["_varName1","_varName2","_varName3","_read","_id","_value","_player","_varType","_valueExist","_var"];
_varName1 	=  [_this,0,"",[""]] call bis_fnc_param;
_varName2 	=  [_this,1,"",[""]] call bis_fnc_param;
_varName3 	=  [_this,2,"",[""]] call bis_fnc_param;
_varType	=  [_this,3,"",[""]] call bis_fnc_param;
_player		= [_this,4,objNull,[objNull]] call bis_fnc_param;
_read		= [_this,5,true,[true]] call bis_fnc_param;
_value		= [_this,6,[]] call bis_fnc_param;

_var = switch (toupper _varType) do {
			    case "ARRAY": {[]};
			    case "SCALAR": {0};
			    default {""};
			};

//systemChat format ["this: %1 %2 %3 %4", _varName1, _varName2, _varName3, _varType];
if(!isServer) exitWith {};
if (isNull _player || !(isPlayer _player)) exitWith {};

_id = getPlayerUID _player;

if (_read) exitWith {
	if (missionNamespace getVariable ["MCC_iniDBenabled",false]) then {
			_value = [_varName1, _varName2, _varName3, "read",_var,_varName1] call MCC_fnc_handleDB;
		} else {
			_value = missionNamespace getVariable [_varName1 + _varName2 + _varName3,_var];
		};

	//returns value
	[[_value,_id], "MCC_fnc_inidbSet", _player, false] spawn BIS_fnc_MP;
};


//Update server
if (missionNamespace getVariable ["MCC_iniDBenabled",false]) then {
	[_varName1, _varName2, _varName3, "write",_value,_varName1] call MCC_fnc_handleDB;
} else {
	missionNamespace setVariable [_varName1 + _varName2 + _varName3,_value];
};

true;