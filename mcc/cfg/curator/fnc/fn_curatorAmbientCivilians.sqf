//============================================================MCC_fnc_curatorAmbientCivilians====================================================================================
// handles the add ambient civilians module
//===========================================================================================================================================================================
private ["_pos","_module","_factionArray","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {deleteVehicle _module};

//did we get here from the 2d editor?
if (typeName (_module getVariable ["isCiv",true]) == typeName 0) exitWith {
	private ["_isCiv","_isCar","_isParkedCar","_isLocked","_civSpawnDistance","_maxCivSpawn","_factionCiv","_factionCivCar"];

	_isCiv = (_module getVariable ["isCiv",1])==1;
	_isCar = (_module getVariable ["isCar",1])==1;
	_isParkedCar = (_module getVariable ["isParkedCar",1])==1;
	_isLocked  = (_module getVariable ["isLocked",1])==1;
	_civSpawnDistance = 250;
	_maxCivSpawn = 4;
	_factionCiv	= _module getVariable ["factionCiv","CIV_F"];
	_factionCivCar = _module getVariable ["factionCivCar","CIV_F"];

	//Start ambient civilians
	[[_isCiv,_isCar,_isParkedCar,_isLocked,_civSpawnDistance,_maxCivSpawn,_factionCiv,_factionCivCar],"MCC_fnc_ambientInit",false,false] spawn BIS_fnc_MP;
};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

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