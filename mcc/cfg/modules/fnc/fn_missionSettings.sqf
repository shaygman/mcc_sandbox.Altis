//==================================================================MCC_fnc_missionSettings===========================================================================
// module
// Example: [] call MCC_fnc_missionSettings;
// _group1 = group, the group name
//================================================================================================================================================================
private ["_module","_var","_pos"];

_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

if (typeName (_module getVariable ["t2t",true]) == typeName 0) exitWith {
	//T2T
	_var 	= _module getvariable ["t2t",0];
	missionNamespace setVariable ["MCC_t2tIndex",_var];
	if (MCC_t2tIndex == 0) then {MCC_teleportToTeam = false};

	//Save gear
	_var 	= _module getvariable ["saveGear",1];
	missionNamespace setVariable ["MCC_saveGearIndex",_var];
	MCC_saveGear = if (_var == 0) then {false} else {true};

	//Messeges
	_var 	= _module getvariable ["messages",1];
	missionNamespace setVariable ["MCC_MessagesIndex",_var];
	MCC_Chat = if (_var == 0) then {false} else {true};

	//Sync
	_var 	= _module getvariable ["sync",1];
	MCC_syncOn = if (_var == 0) then {false} else {true};

	//Artillery computer
	_var 	= _module getvariable ["artilleryComputer",1];
	missionNamespace setVariable ["MCC_artilleryComputerIndex",_var];
	enableEngineArtillery (if (_var == 0) then {false} else	{true});

	//Time Excel
	_var 	= _module getvariable ["timeAccel",0];
	if (_var > 0) then	{setTimeMultiplier _var};

	//Delete players body
	_var 	= _module getvariable ["deleteBody",1];
	missionNamespace setVariable ["mcc_deletePlayerBodyIndex",_var];
	MCC_deletePlayersBody = if (_var == 0) then {false} else {true};

	//Respawn Menu
	_var 	= _module getvariable ["respawnMenu",1];
	MCC_openRespawnMenu = if (_var == 0) then {false} else {true};

	//Respawn Cinematic
	MCC_respawnCinematic = ((_module getvariable ["respawnCinematic",1]) == 1);

	//Respawn on Leader
	missionNameSpace setVariable ["MCC_respawnOnGroupLeader",(_module getvariable ["respawnOnGroupLeader",1]) ==1];

	//SQL PDA
	_var 	= _module getvariable ["sqlPDA",1];
	MCC_allowsqlPDA = if (_var == 0) then {false} else {true};

	//Commander Console
	_var 	= _module getvariable ["commanderConsole",1];
	MCC_allowConsole = if (_var == 0) then {false} else {true};

	//Commander Console Show units without GPS
	_var 	= _module getvariable ["commanderConsoleShowGPS",1];
	MCC_ConsoleOnlyShowUnitsWithGPS = if (_var == 0) then {true} else {false};

	//Commander Console Show friendly WP
	_var 	= _module getvariable ["commanderConsoleWP",1];
	MCC_ConsoleDrawWP = if (_var == 0) then {false} else {true};
	MCC_ConsolePlayersCanSeeWPonMap = if (_var == 0) then {false} else {true};

	//Commander Console Can command AI
	_var 	= _module getvariable ["commanderConsoleAI",1];
	MCC_ConsoleCanCommandAI = if (_var == 0) then {false} else {true};

	//Squad dialog
	_var 	= _module getvariable ["squadDialog",1];
	MCC_allowSquadDialog = if (_var == 0) then {false} else {true};

	//Squad dialog camera
	_var 	= _module getvariable ["squadDialogPip",1];
	MCC_allowSquadDialogCamera = if (_var == 0) then {false} else {true};

	//Logistics
	_var 	= _module getvariable ["logistics",1];
	MCC_allowlogistics = if (_var == 0) then {false} else {true};

	//Allow RTS
	_var 	= _module getvariable ["allowRTS",0];
	MCC_allowRTS = if (_var == 0) then {false} else {true};

	//Purchable airDrops
	MCC_defaultSupplyDropsEnabled = _module getvariable ["defaultSupplyDropsEnabled",false];

	//Purchable CAS
	MCC_defaultCASEnabled = _module getvariable ["defaultCASEnabled",false];
};

//Not curator exit
if !(local _module) exitWith {};

_resualt = ["Settings MCC",[
 						["Teleport 2 Team",["Disabled","JIP Only","After Respawn","Always"]],
 						["Save Gear",(missionNamespace getVariable ["MCC_saveGear",true])],
 						["MCC Messages",(missionNamespace getVariable ["MCC_Chat",true])],
 						["Delete Players' Bodies",(missionNamespace getVariable ["MCC_deletePlayersBody",true])],
 						["Respawn Dialog",(missionNamespace getVariable ["MCC_openRespawnMenu",true])],
 						["Respawn On Leader",(missionNamespace getVariable ["MCC_respawnOnGroupLeader",true])],
 						["Respawn Cinematic",(missionNamespace getVariable ["MCC_respawnCinematic",true])],
 						["Squad Leader PDA",(missionNamespace getVariable ["MCC_allowsqlPDA",true])],
 						["(CS) Commander Console",(missionNamespace getVariable ["MCC_allowConsole",true])],
 						["(CS) Show groups with GPS only",(missionNamespace getVariable ["MCC_ConsoleOnlyShowUnitsWithGPS",true])],
 						["(CS) Show friendly WP",(missionNamespace getVariable ["MCC_ConsolePlayersCanSeeWPonMap",true])],
 						["(CS) Can command AI",(missionNamespace getVariable ["MCC_ConsoleCanCommandAI",true])],
 						["Squad Dialog",(missionNamespace getVariable ["MCC_allowSquadDialog",true])],
 						["Logistics",(missionNamespace getVariable ["MCC_allowlogistics",true])],
 						["Real Time Strategy",(missionNamespace getVariable ["MCC_allowRTS",true])],
 						["Purchasable Supply Drops",(missionNamespace getVariable ["MCC_defaultSupplyDropsEnabled",true])],
 						["Purchasable CAS",(missionNamespace getVariable ["MCC_defaultCASEnabled",true])],
 						["Artilery Computer",true],
 						["Time Acceleration",20],
 						["Resistance Hostile To",["All","East","West"]]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

{
	missionNamespace setVariable [_x,_resualt select _foreachindex];
	publicvariable _x;
} forEach ["MCC_t2tIndex",
           "MCC_saveGear",
           "MCC_Chat",
           "MCC_deletePlayersBody",
           "MCC_openRespawnMenu",
           "MCC_respawnOnGroupLeader",
           "MCC_respawnCinematic",
           "MCC_allowsqlPDA",
           "MCC_allowConsole",
           "MCC_ConsoleOnlyShowUnitsWithGPS",
           "MCC_ConsolePlayersCanSeeWPonMap",
           "MCC_ConsoleCanCommandAI",
           "MCC_allowSquadDialog",
           "MCC_allowlogistics",
           "MCC_allowRTS",
           "MCC_defaultSupplyDropsEnabled",
           "MCC_defaultCASEnabled"
           ];

(_resualt select 17) remoteExec ["enableEngineArtillery",0];
(_resualt select 18) remoteExec ["setTimeMultiplier",2];

//Resistance Hostility
switch (_resualt select 19) do {

	//East
	case 1:
	{
		[resistance,[east, 0]] remoteExec ["setfriend",2];
		[resistance,[west, 0.8]] remoteExec ["setfriend",2];
		[east,[resistance, 0]] remoteExec ["setfriend",2];
		[west,[resistance, 0.8]] remoteExec ["setfriend",2];
	};

	//West
	case 2:
	{
		[resistance,[east, 0.8]] remoteExec ["setfriend",2];
		[resistance,[west, 0]] remoteExec ["setfriend",2];
		[east,[resistance, 0.8]] remoteExec ["setfriend",2];
		[west,[resistance, 0]] remoteExec ["setfriend",2];
	};

	//All
	default
	{
		[resistance,[east, 0.8]] remoteExec ["setfriend",2];
		[resistance,[west, 0]] remoteExec ["setfriend",2];
		[east,[resistance, 0.8]] remoteExec ["setfriend",2];
		[west,[resistance, 0]] remoteExec ["setfriend",2];
	};
};

deleteVehicle _module;