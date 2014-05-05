//==================================================================MCC_fnc_createTask===============================================================================================
// create a simple task with trigger assigned to a specific object
// Example: [_group1] call MCC_fnc_countGroup;
// _group1 = group, the group name
//===========================================================================================================================================================================	
private ["_mccdialog","_type","_name","_string","_desc","_action","_preTask","_pos","_side"];

_side			= _this select 0; 
_action			= _this select 1; 
_name 			= _this select 2; 
_desc 			= _this select 3; 
_pos			= _this select 4;
_preTask		= _this select 5;

if (!isServer) exitWith {}; 

[[0, _name, _desc, _pos, _side],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;

if (_preTask != 0) then 
{
	while {!(taskCompleted ((MCC_tasks select (_preTask-1)) select 1))} do {sleep 5};
};

[[_action, _name, _desc, _pos, _side],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;


