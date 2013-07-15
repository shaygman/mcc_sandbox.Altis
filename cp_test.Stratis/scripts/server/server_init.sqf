private ["_string","_group"];

if (CP_debug) then {diag_log "CP server init started"};

//---------------------------------------------
//		Define Global variables
//---------------------------------------------
CP_eastSpawnPoints 	= [];
CP_westSpawnPoints 	= [];
CP_guarSpawnPoints  = [];
CP_westGroups 		= [];
CP_eastGroups 		= [];
CP_guarGroups 		= [];
CP_maxPlayers		= 20; 
CP_maxSquads		= 10; 

publicVariable "CP_maxPlayers";
publicVariable "CP_maxSquads";

//Tickets number
CP_eastTickets = 200; 
CP_westTickets = 200; 
publicVariable "CP_eastTickets";
publicVariable "CP_westTickets";

//Build starting spawn points
[[getpos spawn_west, getdir spawn_west, "west", "HQ-BASE", false] , "CP_fnc_buildSpawnPoint", false, false] spawn BIS_fnc_MP;
[[getpos spawn_east, getdir spawn_east,"east", "HQ-BASE", false] , "CP_fnc_buildSpawnPoint", false, false] spawn BIS_fnc_MP;

//onPlayerConnected format ['[_uid, _name] execVM "%1scripts\server\PlayerConnected.sqf"',CP_path];

//---------------------------------------------
//		Create custom groups
//---------------------------------------------
{												//West
	_group = createGroup west;
	CP_westGroups set [_forEachIndex,[_group,_x]];
} foreach ["Alpha","Bravo","Charlie","Delta"];

{												//East
	_group = createGroup east;
	CP_eastGroups set [_forEachIndex,[_group,_x]];
} foreach ["Alpha","Bravo","Charlie","Delta"];

{												//East
	_group = createGroup resistance;
	CP_guarGroups set [_forEachIndex,[_group,_x]];
} foreach ["Alpha","Bravo","Charlie","Delta"];

publicvariable "CP_westGroups";
publicvariable "CP_eastGroups";
publicvariable "CP_guarGroups";