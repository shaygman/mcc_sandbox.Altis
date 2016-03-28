//============================================================MCC_fnc_curatorGarrisonUnits====================================================================================
// "Garrison units in the selected buildings
//===========================================================================================================================================================================
private ["_pos","_module","_factionArray","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_pos = getpos _module;

_factionArray = [];
{
	_factionArray pushBack (_x select 0);
} forEach U_FACTIONS;

 _resualt = ["Garrison Buildings",[
 						["Faction",_factionArray],
 						["Radius",500],
 						["Population Intensity",1],
 						["Parked Cars",true],
 						["Cars Always Locked ",false],
 						["One Group Per House",true]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

private ["_faction","_side","_radius","_spawnVehicles","_locked","_intanse","_groupUnits","_side"];
_faction = (U_FACTIONS select (_resualt select 0)) select 2;
_radius = _resualt select 1;
_intanse = _resualt select 2;
_spawnVehicles = _resualt select 3;
_locked = _resualt select 4;
_groupUnits = _resualt select 5;
_side = [(getNumber (configfile >> "CfgFactionClasses" >> _faction >> "side"))] call BIS_fnc_sideType;

//Start ambient civilians
[[_pos, _radius, _spawnVehicles, _intanse, _faction, _side, _groupUnits, _locked],"MCC_fnc_garrison",false,false] spawn BIS_fnc_MP;
deleteVehicle _module;