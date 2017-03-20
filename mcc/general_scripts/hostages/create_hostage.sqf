private ["_hostage","_init"];
#define	MCC_UNTIE_ICON "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa"

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
	MCC_UNTIE_ICON,
	MCC_UNTIE_ICON,
	"(alive _target) && (_target distance _this < 5)",
	"(alive _target) && (_target distance _this < 5)",
	{
		//Start action
		[name _target,"Oh thank you, Please hurry up!"] remoteExec ["BIS_fnc_showSubtitle", _caller];
	},
	{},
	{
		//Success
		_null = [_target, player, 0,[0]] execVM format ["%1mcc\general_scripts\hostages\hostage.sqf",MCC_path];
		[name _target,"Thank you!"] remoteExec ["BIS_fnc_showSubtitle", _caller];
	},
	{
		//When stopped
		[name _target,"Why did you stopped?"] remoteExec ["BIS_fnc_showSubtitle", _caller];
	},
	[],
	3,
	0,
	true,
	false
] remoteExec ["bis_fnc_holdActionAdd", 0];



