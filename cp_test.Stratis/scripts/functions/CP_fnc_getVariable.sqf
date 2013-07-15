
//==================================================================CP_fnc_getVariable======================================================================================
// Global execute a command on server only  - SERVER ONLY
// Example: [[varName,playerID,VarDefaultValue], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================

private ["_varName","_id","_value"];
_varName 	= _this select 0;			
_id 		= _this select 1; 
_varDefault	= _this select 2; 

_value = profileNamespace getVariable format ["%1_%2",_varName,_id];
if (isnil "_value") then {														//if it's first time then set us default. 
	profileNamespace setVariable [format ["%1_%2",_varName,_id], _varDefault];
	};
_value = profileNamespace getVariable format ["%1_%2",_varName,_id];	
[[_varName,_value,_id], "CP_fnc_setValue", true, false] spawn BIS_fnc_MP;			//returns value		
