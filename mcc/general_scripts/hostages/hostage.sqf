private ["_hostage","_caller","_index","_nul","_action","_init","_group"];
// Who activated the action?
_hostage = _this select 0;
_caller = _this select 1;
_index = _this select 2;
_action = (_this select 3) select 0;

//Save Hostage
if (_action == 0) then
{
	_hostage setVariable ["MCC_neutralize",true,true];
	_init = "
			_this setcaptive false;
			_this allowFleeing 1;
			_this enableAI 'MOVE';
			_this setUnitPos 'AUTO';
			_this playmoveNow 'Acts_ExecutionVictim_Unbow';
			";

	sleep 1;
	[_hostage] join _caller;
	_nul = _caller addaction [format ["Disband %1", name _hostage],MCC_path + "mcc\general_scripts\hostages\hostage.sqf",[1,_hostage],6,false,true,"","_target == _this"];
	[[[netID _hostage,_hostage], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
	[_hostage] spawn MCC_fnc_deleteHelper;
};

//disabnd Hostage
if (_action == 1) then
{
	_hostage = (_this select 3) select 1;
	_caller removeAction _index;
	_hostage enableAI "MOVE";
	_group = createGroup (_hostage getVariable ["MCC_orgSide", civilian]);
	[_hostage] join _group;
	_hostage setVariable ["MCC_neutralize",true,true];
	[[_hostage, "Hold %1 to interact"], "MCC_fnc_createHelper", false] call BIS_fnc_MP;
};

//Join player
if (_action == 2) then
 {
	_hostage setVariable ["MCC_orgSide", side _hostage, true];
	(units group _hostage) join _caller;
	[[[_hostage],{(_this select 0) setUnitPos "AUTO"}],"BIS_fnc_spawn", _hostage, false] spawn BIS_fnc_MP;
	_nul = _caller addaction [format ["Disband %1", name _hostage],MCC_path + "mcc\general_scripts\hostages\hostage.sqf",[1,_hostage],6,false,true,"","_target == _this"];
	[_hostage] spawn MCC_fnc_deleteHelper;
};