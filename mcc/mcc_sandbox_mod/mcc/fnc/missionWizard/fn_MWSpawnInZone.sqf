//======================================================MCC_fnc_MWSpawnInZone=========================================================================================================
// Create a pick intel objective
// Example:[_zoneNumber,_spawnType,_classtype,_spawnwithcrew,_spawnname,_spawnfaction,_spawnbehavior,_spawndisplayname] call MCC_fnc_MWSpawnInZone; 
// Return - handler
//========================================================================================================================================================================================
private ["_zoneNumber","_script_handler","_spawnType","_classtype","_spawnwithcrew","_spawnname","_spawnfaction","_spawnbehavior","_spawndisplayname","_previusZone"];

_zoneNumber 		= _this select 0;
_spawnType			= _this select 1; 
_classtype			= _this select 2; 
_spawnwithcrew		= _this select 3;
_spawnname			= _this select 4;
_spawnfaction		= _this select 5;
_spawnbehavior		= _this select 6;
_spawndisplayname	= _this select 7;

_previusZone = format ["%1", mcc_active_zone];
_previusZone setMarkerColorLocal "colorBlack";
_previusZone setMarkerBrushLocal "Solid";
	
mcc_spawntype			= _spawnType ; 		//'GROUP';
mcc_classtype			= _classtype;		//'LAND';
mcc_isnewzone			= false;
mcc_spawnwithcrew		= _spawnwithcrew;	//true;
mcc_spawnname			= _spawnname;		//'BUS_InfSquad';
mcc_spawnfaction		= _spawnfaction;	//'configFile >> "CfgGroups" >>"West">>"BLU_F">>"Infantry">>"BUS_InfSquad" ';
mcc_zone_number			= _zoneNumber;
mcc_zoneinform			= 'NOTHING';
mcc_zone_markername		= str _zoneNumber;
mcc_spawnbehavior		= _spawnbehavior;	//'MOVE';
mcc_grouptype     		= '';
mcc_spawndisplayname 	= _spawndisplayname;//'Rifle Squad';
mcc_track_units 		= false;
mcc_awareness 			= 'default';
mcc_hc 					= 0;
mcc_active_zone 		= mcc_zone_number;
_script_handler 		= [0] execVM format ["%1mcc\general_scripts\mcc_SpawnStuff.sqf",MCC_path];
waitUntil {scriptDone _script_handler};
scriptDone _script_handler;



				
		
