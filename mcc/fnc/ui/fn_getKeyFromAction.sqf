//==================================================================MCC_fnc_getKeyFromAction=================================================================================
//Get the keys name from an action defined in CfgActions
// In: action - string
// Out: keys names - string
//==============================================================================================================================================================================
private ["_action","_name"];
_action = _this select 0;

_name = "";
{
	_name = _name + keyName _x + " ";
} forEach (actionKeys _action);

_name

