private ["_string","_group","_weapon","_weaponAttachments"];

if (!MCC_iniDBenabled) exitWIth {player sidechat "iniDB isn't running. Can't access role selection"};
if (CP_debug) then {diag_log "CP server init started"};

//---------------------------------------------
//		Define Global variables
//---------------------------------------------
if (isnil "CP_eastSpawnPoints") then {CP_eastSpawnPoints 	= []};
if (isnil "CP_westSpawnPoints") then {CP_westSpawnPoints 	= []};
if (isnil "CP_guarSpawnPoints") then {CP_guarSpawnPoints  = []};
if (isnil "CP_westGroups") then {CP_westGroups 		= []};
if (isnil "CP_eastGroups") then {CP_eastGroups 		= []};
if (isnil "CP_guarGroups") then {CP_guarGroups 		= []};


publicVariable "CP_westSpawnPoints";
publicVariable "CP_guarSpawnPoints";
publicVariable "CP_westGroups";
publicVariable "CP_eastGroups";
publicVariable "CP_guarGroups";
publicVariable "CP_maxPlayers";
publicVariable "CP_maxSquads";

//Tickets number
if (isnil "CP_eastTickets") then {CP_eastTickets = 200}; 
if (isnil "CP_westTickets") then {CP_westTickets = 200}; 
publicVariable "CP_eastTickets";
publicVariable "CP_westTickets";

//Default Groups
CP_defaultGroups = ["SERVER_misc", "RoleSelectionDefinse", "CP_defaultGroups", "ARRAY"] call iniDB_read;

if (count CP_defaultGroups == 0) then
{
	CP_defaultGroups = ["Alpha","Bravo","Charlie","Delta"];
	 ["SERVER_misc", "RoleSelectionDefinse", "CP_defaultGroups",CP_defaultGroups, "ARRAY"] call iniDB_write;
};
publicVariable "CP_defaultGroups";


//---------------------------------------------
//		Create custom groups
//---------------------------------------------
if (count CP_westGroups == 0) then
{
	{												//West
		_group = createGroup west;
		waituntil {!isnil "_group"};
		_group setVariable ["MCC_CPGroup",true,true]; 
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
		CP_guarGroups set [_forEachIndex,[_group,_x]];
	} foreach CP_defaultGroups;
	
	publicvariable "CP_guarGroups";
};


//******************************************************************************************************************************
//											You can edit between this line and the next
//******************************************************************************************************************************

//---------------------------------------------
//		gears array
//---------------------------------------------

//HandGuns
CP_handguns = ["SERVER_misc", "handguns", "CP_handguns", "ARRAY"] call iniDB_read;

if (count CP_handguns == 0) then
{
	CP_handguns	= 	call compileFinal str	[
					[0,"",["",0]],
					[3,"hgun_Rook40_F",["16Rnd_9x21_Mag",3]],
					[6,"hgun_P07_F",["16Rnd_9x21_Mag",3]],
					[10,"hgun_ACPC2_F",["9Rnd_45ACP_Mag",3]],
					[15,"hgun_Pistol_heavy_02_F",["6Rnd_45ACP_Cylinder",3]],
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