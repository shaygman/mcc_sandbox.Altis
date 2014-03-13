private ["_hostage","_caller","_index","_nul","_action","_init"];
// Who activated the action?
_hostage = _this select 0;
_caller = _this select 1;
_index = _this select 2; 
_action = (_this select 3) select 0; 

if (_action == 0) then {	//Save Hostage
	_init = "
			_this setcaptive false; 
			_this allowFleeing 1;
			_this enableAI 'MOVE';
			_this switchmove '';
			";
			
	[[[netID _hostage,_hostage], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
	sleep 1;
	_hostage removeAction _index;
	[_hostage] join _caller;
	[[[netID _hostage,_hostage], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
	_nul = _caller addaction [format ["Disband %1", name _hostage],MCC_path + "mcc\general_scripts\hostages\hostage.sqf",[1,_hostage],6,false,true,"","_target == _this"];
	};
	
if (_action == 1) then {	//disabnd Hostage TODO no leave group while doing so
	_hostage removeAction _index;
	_hostage enableAI "MOVE";
	[(_this select 3) select 1] join grpNull;
	};
	
if (_action == 2) then {	//Join player
	_hostage removeAction _index;
	(units group _hostage) join _caller;
	};