private ["_string","_group","_weapon","_weaponAttachments"];

if (CP_debug) then {diag_log "CP server init started"};

//---------------------------------------------
//		Define Global variables
//---------------------------------------------
if (isnil "CP_westGroups") then {CP_westGroups 		= []};
if (isnil "CP_eastGroups") then {CP_eastGroups 		= []};
if (isnil "CP_guarGroups") then {CP_guarGroups 		= []};


publicVariable "CP_westGroups";
publicVariable "CP_eastGroups";
publicVariable "CP_guarGroups";
publicVariable "CP_maxPlayers";
publicVariable "CP_maxSquads";


//Default Groups
if (MCC_iniDBenabled) then
{
	CP_defaultGroups = ["SERVER_misc", "RoleSelectionDefinse", "CP_defaultGroups", "ARRAY"] call iniDB_read;

	if (count CP_defaultGroups == 0) then
	{
		CP_defaultGroups = ["Alpha","Bravo","Charlie","Delta"];
		 ["SERVER_misc", "RoleSelectionDefinse", "CP_defaultGroups",CP_defaultGroups, "ARRAY"] call iniDB_write;
	};

	publicVariable "CP_defaultGroups";
};



//---------------------------------------------
//		Create custom groups
//---------------------------------------------
if (count CP_westGroups == 0) then
{
	{												//West
		_group = createGroup west;
		waituntil {!isnil "_group"};
		_group setVariable ["MCC_CPGroup",true,true];
		_group setVariable ["name",_x,true];
		CP_westGroups set [_forEachIndex,[_group,_x]];
	} foreach CP_defaultGroups;

	publicvariable "CP_westGroups";
};

if (count CP_eastGroups == 0) then
{
	{												//East
		_group = createGroup east;
		waituntil {!isnil "_group"};
		_group setVariable ["MCC_CPGroup",true,true];
		_group setVariable ["name",_x,true];
		CP_eastGroups set [_forEachIndex,[_group,_x]];
	} foreach CP_defaultGroups;

	publicvariable "CP_eastGroups";
};

if (count CP_guarGroups == 0) then
{
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

//******************************************************************************************************************************
//											You can edit between this line and the next
//******************************************************************************************************************************

//---------------------------------------------
//		gears array
//---------------------------------------------
if (!MCC_iniDBenabled) exitWIth {diag_log format["MCC: %1 iniDB isn't running. Can't access role selection",time]};

//HandGuns
CP_handguns = ["SERVER_misc", "handguns", "CP_handguns", "ARRAY"] call iniDB_read;

if (count CP_handguns == 0) then
{
	CP_handguns	= 	call compileFinal str	[
					[0,"",["",0]],
					[4,"hgun_Rook40_F",["16Rnd_9x21_Mag",3]],
					[8,"hgun_P07_F",["16Rnd_9x21_Mag",3]],
					[12,"hgun_ACPC2_F",["9Rnd_45ACP_Mag",3]],
					[16,"hgun_Pistol_heavy_02_F",["6Rnd_45ACP_Cylinder",3]],
					[20,"hgun_Pistol_heavy_01_F",["11Rnd_45ACP_Mag",3]]
					];

	 ["SERVER_misc", "handguns", "CP_handguns",CP_handguns, "ARRAY"] call iniDB_write;
};
publicvariable "CP_handguns";


//------------------------------------------------------------------------------------------------------------------------------
//			Roles
//------------------------------------------------------------------------------------------------------------------------------

#include "officer.sqf"
#include "ar.sqf"
#include "rifleman.sqf"
#include "at.sqf"
#include "corpsman.sqf"
#include "marksman.sqf"
#include "specialist.sqf"
#include "crew.sqf"
#include "pilot.sqf"