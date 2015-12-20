//==================================================================MCC_fnc_missionSettings===============================================================================================
// module
// Example: [] call MCC_fnc_missionSettings;
// _group1 = group, the group name
//===========================================================================================================================================================================
private ["_logic","_var"];

_logic	= _this select 0;

//T2T
_var 	= _logic getvariable ["t2t",0];
missionNamespace setVariable ["MCC_t2tIndex",_var];
if (MCC_t2tIndex == 0) then {MCC_teleportToTeam = false};

//Save gear
_var 	= _logic getvariable ["saveGear",1];
missionNamespace setVariable ["MCC_saveGearIndex",_var];
MCC_saveGear = if (_var == 0) then {false} else {true};

//Messeges
_var 	= _logic getvariable ["messages",1];
missionNamespace setVariable ["MCC_MessagesIndex",_var];
MCC_Chat = if (_var == 0) then {false} else {true};

//Sync
_var 	= _logic getvariable ["sync",1];
MCC_syncOn = if (_var == 0) then {false} else {true};

//Artillery computer
_var 	= _logic getvariable ["artilleryComputer",1];
missionNamespace setVariable ["MCC_artilleryComputerIndex",_var];
enableEngineArtillery (if (_var == 0) then {false} else	{true});

//Time Excel
_var 	= _logic getvariable ["timeAccel",0];
if (_var > 0) then	{setTimeMultiplier _var};

//Delete players body
_var 	= _logic getvariable ["deleteBody",1];
missionNamespace setVariable ["mcc_deletePlayerBodyIndex",_var];
MCC_deletePlayersBody = if (_var == 0) then {false} else {true};

//Respawn Menu
_var 	= _logic getvariable ["respawnMenu",1];
MCC_openRespawnMenu = if (_var == 0) then {false} else {true};

//SQL PDA
_var 	= _logic getvariable ["sqlPDA",1];
MCC_allowsqlPDA = if (_var == 0) then {false} else {true};

//Commander Console
_var 	= _logic getvariable ["commanderConsole",1];
MCC_allowConsole = if (_var == 0) then {false} else {true};

//Commander Console Show units without GPS
_var 	= _logic getvariable ["commanderConsoleShowGPS",1];
MCC_ConsoleOnlyShowUnitsWithGPS = if (_var == 0) then {true} else {false};

//Commander Console Show friendly WP
_var 	= _logic getvariable ["commanderConsoleWP",1];
MCC_ConsoleDrawWP = if (_var == 0) then {false} else {true};
MCC_ConsolePlayersCanSeeWPonMap = if (_var == 0) then {false} else {true};

//Commander Console Can command AI
_var 	= _logic getvariable ["commanderConsoleAI",1];
MCC_ConsoleCanCommandAI = if (_var == 0) then {false} else {true};

//Squad dialog
_var 	= _logic getvariable ["squadDialog",1];
MCC_allowSquadDialog = if (_var == 0) then {false} else {true};

//Squad dialog camera
_var 	= _logic getvariable ["squadDialogPip",1];
MCC_allowSquadDialogCamera = if (_var == 0) then {false} else {true};

//Logistics
_var 	= _logic getvariable ["logistics",1];
MCC_allowlogistics = if (_var == 0) then {false} else {true};

//Role Selection
_var 	= _logic getvariable ["roleSelection",0];
CP_activated = if (_var == 0) then {false} else {true};

//Allow changing kits without respawn in RS
_var 	= _logic getvariable ["allowKitChange",0];
MCC_allowChangingKits = if (_var == 0) then {false} else {true};

//Allow RTS
_var 	= _logic getvariable ["allowRTS",0];
MCC_allowRTS = if (_var == 0) then {false} else {true};
