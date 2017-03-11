//==================================================================MCC_fnc_missionSettingsRS===========================================================================
// module
// Example: [] call MCC_fnc_missionSettingsRS;
//================================================================================================================================================================
private ["_module","_var","_pos"];

_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};


if (typeName (_module getVariable ["rsAllWeapons",true]) == typeName 0) exitWith {

	//(RS)Role Selection
	CP_activated = true;

	//(RS)All Weapons
	MCC_rsAllWeapons = ((_module getvariable ["rsAllWeapons",0])==1);

	//(RS)Kit Change
	MCC_allowChangingKits = ((_module getvariable ["allowKitChange",0])==1);

	//(RS)XP Gain
	CP_gainXP = ((_module getvariable ["rsGainXp",0])==1);

	//(RS)Kit Weapons
	MCC_rsEnableRoleWeapons = ((_module getvariable ["rsEnableRoleWeapons",0])==1);

	//(RS)Drivers/Pilots
	MCC_rsEnableDriversPilots = ((_module getvariable ["rsEnableDriversPilots",0])==1);
};

//Not curator exit
if !(local _module) exitWith {};

_resualt = ["Settings Role Selection",[
 						["(RS)Role Selection",true],
 						["(RS)All Weapons",true],
 						["(RS)Kit Change",true],
 						["(RS)XP Gain",true],
 						["(RS)Limit Weapons",true],
 						["(RS)Restrict Drivers/Pilots",true]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

{
	missionNamespace setVariable [_x,_resualt select _foreachindex];
	publicvariable _x;
} forEach ["CP_activated",
           "MCC_rsAllWeapons",
           "MCC_allowChangingKits",
           "CP_gainXP",
           "MCC_rsEnableRoleWeapons",
           "MCC_rsEnableDriversPilots"
           ];

if (missionNamespace getVariable ["CP_activated",false]) then {
	_null=[] execVM MCC_path + "mcc\roleSelection\scripts\player_init.sqf";

	{
		_sideTickets = format ["MCC_tickets%1", _x];
		_tickets = missionNameSpace getVariable [_sideTickets,200];

		[_x, _tickets] remoteExec ["BIS_fnc_respawnTickets",2];
	} foreach [west, east, resistance];
};

deleteVehicle _module;