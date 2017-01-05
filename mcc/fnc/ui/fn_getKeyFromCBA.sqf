//==================================================================MCC_fnc_getKeyFromCBA=================================================================================
//Get a pretty name from CBA key binds
// In: 	_modName - string
//		_ActionName - string
// Out: keys names - string
//==============================================================================================================================================================================
private ["_modName","_ActionName","_keySetup","_specKeys","_name"];
_modName = _this select 0;
_ActionName = _this select 1;

_name = "";
_keySetup = (([_modName,_ActionName] call CBA_fnc_getKeybind) select 5) ;
if (isNil "_keySetup") exitWith {};
if (count _keySetup == 0) exitWith {};

_specKeys = _keySetup select 1;

{
	if (_specKeys select _foreachindex) then {_name = _name + _x + " + "};
} forEach ["Shift","Ctrl","Alt"];

_name = _name + (keyName (_keySetup select 0));

_name

