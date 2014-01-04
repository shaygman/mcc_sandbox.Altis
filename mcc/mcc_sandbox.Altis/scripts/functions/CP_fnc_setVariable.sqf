
//==================================================================CP_fnc_setVariable======================================================================================
// Global execute a command on server only  - SERVER ONLY
// Example: [[varName,playerID,VarValue], "CP_fnc_setVariable", false, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================

private ["_varName","_id","_value"];
_varName 	= _this select 0;			
_id 		= _this select 1; 
_value		= _this select 2; 

profileNamespace setVariable [format ["%1_%2",_varName,_id], _value];