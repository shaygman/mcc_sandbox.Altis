//============================================================MCC_fnc_curatorAmbientCivilians====================================================================================
// handles the add ambient civilians module
//===========================================================================================================================================================================
private ["_pos","_module","_factionArray","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;

_factionArray = [];
{
	_factionArray pushBack (_x select 0);
} forEach U_FACTIONS;

 _resualt = ["Ambient Civilians - runs on the server per player (CPU demanding)",[
 						["Ambient Civilians",true],
 						["Ambient Driving Cars",true],
 						["Ambient Parked Cars",true],
 						["Parked cars will always be locked ",false],
 						["Spawn distance around the players",500],
 						["max units spawned around the player",8],
 						["Faction",_factionArray],
 						["Car's Faction",_factionArray]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

_resualt set [6,(U_FACTIONS select (_resualt select 6)) select 2];
_resualt set [7,(U_FACTIONS select (_resualt select 7)) select 2];

//Start ambient civilians
[_resualt,"MCC_fnc_ambientInit",false,false] spawn BIS_fnc_MP;
deleteVehicle _module;