//======================================================MCC_fnc_MWUpdateZone=========================================================================================================
// Create a pick intel objective
// Example:[_zoneNumber,_pos,_radius] call MCC_fnc_MWUpdateZone; 
// Return - handler
//========================================================================================================================================================================================
private ["_zoneNumber","_script_handler","_pos","_radius"];

_zoneNumber = _this select 0;
_pos		= _this select 1; 
_radius		= _this select 2; 

mcc_zone_markposition	= _pos;
mcc_zone_number			= _zoneNumber;
mcc_zone_marker_X		= _radius;
mcc_zone_marker_Y		= _radius;
mcc_zone_markername		= str _zoneNumber;
MCC_Marker_dir			= 0;
mcc_hc					= 0;

MCC_zones_numbers set [count MCC_zones_numbers, mcc_zone_number]; 
publicVariableServer "MCC_zones_numbers"; 

_script_handler 		= [0] execVM format ["%1mcc\general_scripts\mcc_make_the_marker.sqf",MCC_path];
waitUntil {scriptDone _script_handler};

mcc_spawntype			= '';
mcc_classtype			= '';
mcc_isnewzone			= true;
mcc_spawnwithcrew		= true;
mcc_spawnname			= '';
mcc_spawnfaction		= '';
mcc_zone_number			= _zoneNumber;
mcc_zoneinform			= 'NOTHING';
mcc_zone_markername		= str _zoneNumber;
mcc_spawnbehavior		= 'MOVE';
mcc_grouptype     		= '';
mcc_spawndisplayname 	= '';
mcc_track_units 		= false;
mcc_awareness 			= 'DEFAULT';
mcc_hc 					= 0;
_script_handler = [0] execVM format ["%1mcc\general_scripts\mcc_SpawnStuff.sqf",MCC_path];
waitUntil {scriptDone _script_handler};

scriptDone _script_handler;



				
		
