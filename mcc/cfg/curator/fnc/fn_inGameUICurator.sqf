//============================================================MCC_fnc_inGameUICurator====================================================================================
// setting MCC's UI
//===========================================================================================================================================================================
private ["_pos","_module","_factionArray","_resualt","_civRelations"];
_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

//Not curator exit
if !(local _module) exitWith {};

_pos = getpos _module;

 _resualt = ["UI Settings",[
 						["3rd Person",["Disable","Only in Vehicles","Only in air Vehicles","Everyone"]],
 						["Compass HUD",true],
 						["Compass Show Squad Markers",true],
 						["Map Squads Markers",true],
 						["Map Units Markers",true],
 						["Name Tags",true],
 						["Name Tags Only When Pointing",true],
 						["Suppression Effects",true],
 						["Hit Radar",true],
 						["Tickets",true],
 						["Tutorials",true]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

//Start
_resualt remoteExec ["MCC_fnc_inGameUI", 0, true];
deleteVehicle _module;