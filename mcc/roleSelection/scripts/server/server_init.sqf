private ["_string","_group","_weapon","_weaponAttachments"];

if (missionNamespace getVariable ["MCC_debug",false]) then {diag_log "CP server init started"};

//---------------------------------------------
//		Define Global variables
//---------------------------------------------
if (isnil "CP_westGroups") then {CP_westGroups = []};
if (isnil "CP_eastGroups") then {CP_eastGroups = []};
if (isnil "CP_guarGroups") then {CP_guarGroups = []};


publicVariable "CP_westGroups";
publicVariable "CP_eastGroups";
publicVariable "CP_guarGroups";

//Default Groups
CP_defaultGroups = [format ["%1_SERVER",missionName], "RoleSelectionDefinse", "CP_defaultGroups", "read",[],"DEFAULT_SERVER"] call MCC_fnc_handleDB;

if (count CP_defaultGroups == 0) then {
	CP_defaultGroups = ["Alpha","Bravo","Charlie","Delta"];
	_null = [format ["%1_SERVER",missionName], "RoleSelectionDefinse", "CP_defaultGroups", "write",CP_defaultGroups,"DEFAULT_SERVER"] call MCC_fnc_handleDB;
};

publicVariable "CP_defaultGroups";



//---------------------------------------------
//		Create custom groups
//---------------------------------------------
if (count CP_westGroups == 0) then {
	{												//West
		_group = createGroup west;
		waituntil {!isnil "_group"};
		_group setVariable ["MCC_CPGroup",true,true];
		_group setVariable ["name",_x,true];
		CP_westGroups set [_forEachIndex,[_group,_x]];
	} foreach CP_defaultGroups;

	publicvariable "CP_westGroups";
};

if (count CP_eastGroups == 0) then {
	{												//East
		_group = createGroup east;
		waituntil {!isnil "_group"};
		_group setVariable ["MCC_CPGroup",true,true];
		_group setVariable ["name",_x,true];
		CP_eastGroups set [_forEachIndex,[_group,_x]];
	} foreach CP_defaultGroups;

	publicvariable "CP_eastGroups";
};

if (count CP_guarGroups == 0) then {
	{												//East
		_group = createGroup resistance;
		waituntil {!isnil "_group"};
		_group setVariable ["MCC_CPGroup",true,true];
		_group setVariable ["name",_x,true];
		CP_guarGroups set [_forEachIndex,[_group,_x]];
	} foreach CP_defaultGroups;

	publicvariable "CP_guarGroups";
};

//Add event handler for tickets
"CP_activated" addPublicVariableEventHandler {
	{
		_sideTickets = format ["MCC_tickets%1", _x];
		_tickets = missionNameSpace getVariable [_sideTickets,200];
		[_x, _tickets] call BIS_fnc_respawnTickets;
	} foreach [west, east, resistance];
};