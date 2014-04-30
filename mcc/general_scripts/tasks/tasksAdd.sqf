private ["_mccdialog","_type","_name","_string","_desc","_action","_preTask"];
#define MCC_INITBOX 8004 
disableSerialization;

_type = _this select 0;

_mccdialog = uiNamespace getVariable "MCC3D_Dialog";

if (_type == 0) exitWith
{
	if (isnil "MCC_TaskSide") then {MCC_TaskSide = 0};
	_name = ctrlText (_mccdialog displayCtrl 8503);
	_desc = ctrlText (_mccdialog displayCtrl 8504);
	_action = switch (lbCurSel 8507) do 
				{ 
					case 0: {0}; 	//None
					case 1: {8};	//WP
					case 2: {10}; 	//WP Cinametic				
				};
				
	if (_name == "") exitWith {player sidechat "Name cannot be empty"}; 
	
	//Do we have to wait till task complete?
	_preTask = lbCurSel 8508;

	_string = ctrlText MCC_INITBOX;
	_string = _string + format [';if (isServer) then {[%1, %2, "%3", "%4", getpos _this, %5] spawn MCC_fnc_createTask};',MCC_TaskSide, _action, _name, _desc, _preTask];
	ctrlSetText [MCC_INITBOX,_string];
	_null = [1] execVM format["%1mcc\pop_menu\spawn_group3d.sqf",MCC_path];
};