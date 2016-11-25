private ["_hostage","_init"];
_hostage = _this;

removeallweapons _hostage;
dostop _hostage;
if (MCC_isACE) then {
	 [_hostage, true] call ACE_captives_fnc_setHandcuffed;
} else {
	_hostage allowFleeing 0;
	_hostage disableAI "MOVE";
	_hostage setVariable ["MCC_disarmed",true,true];
	removeallweapons _hostage;
	_hostage setcaptive true;
	_init = "_this switchmove 'Acts_ExecutionVictim_Loop';";
	[[[netID _hostage,_hostage], _init, false], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
	/*[[_hostage, "Hold %1 to interact"], "MCC_fnc_createHelper", false] call BIS_fnc_MP;*/
};

[
	_hostage,
	format ["Untie %1",name _hostage],
	"\a3\Data_f\clear_empty.paa",
	"\a3\Data_f\clear_empty.paa",
	"(alive _target) && (_target distance _this < 5)",
	"(alive _target) && (_target distance _this < 5)",
	{
		[name _target,"Hurry up!"] remoteExec ["BIS_fnc_showSubtitle", _caller];
	},
	{},
	{
		[name _target,"Thank you!"] remoteExec ["BIS_fnc_showSubtitle", _caller];
		_target setVariable ["MCC_neutralize",true,true];
		_init = "
				_this setcaptive false;
				_this allowFleeing 1;
				_this enableAI 'MOVE';
				_this setUnitPos 'AUTO';
				_this playmoveNow 'Acts_ExecutionVictim_Unbow';
				";

		sleep 1;
		[_target] join _caller;
		_nul = _caller addaction [format ["Disband %1", name _target],MCC_path + "mcc\general_scripts\hostages\hostage.sqf",[1,_target],6,false,true,"","_target == _this"];
		[[[netID _target,_target], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
		[_target] spawn MCC_fnc_deleteHelper;
	},
	{
		[name _target,"What are you doing?"] remoteExec ["BIS_fnc_showSubtitle", _caller];
	},
	[],
	3,
	0,
	true,
	false
] remoteExec ["bis_fnc_holdActionAdd", 0];



