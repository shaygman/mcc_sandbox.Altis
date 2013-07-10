private ["_hostage","_caller","_index","_nul","_action"];
// Who activated the action?
_hostage = _this select 0;
_caller = _this select 1;
_index = _this select 2; 
_action = _this select 3; 

if (_action == 0) then {	//Save Hostage
	_hostage playMoveNow "AmovPercMstpSlowWrflDnon";
	_hostage enableAI "MOVE";
	_hostage removeAction _index;
	[_hostage] join _caller;
	_hostage setcaptive false;
	_nul = _caller addaction ["Disband Hostage",MCC_path + "mcc\general_scripts\hostages\hostage.sqf",1,6,false,true,"","_target == _this"];
	};
	
if (_action == 1) then {	//Save Hostage
	_hostage removeAction _index;
	_hostage enableAI "MOVE";
	[_hostage] join grpNull;
	};
	
if (_action == 2) then {	//Join player
	_hostage removeAction _index;
	[_hostage] join _caller;
	};