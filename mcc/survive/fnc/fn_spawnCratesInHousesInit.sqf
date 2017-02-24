//============================================================MCC_fnc_spawnCratesInHousesInit======================================================================
// spawn crates in houses
//===========================================================================================================================================================================
private ["_pos","_module","_resualt","_radius","_density","_triggers","_markers"];
_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

_pos = getpos _module;
//did we get here from the 2d editor?
if (typeName (_module getVariable ["radius",true]) == typeName 0) exitWith {

	if (!isServer) exitWith {};
	_triggers = [];
	_radius = _module getVariable ["radius",300];
	_density = _module getVariable ["density",1];
	_markers = _module getVariable ["markers",false];

	//Get all synced triggers
	{
		if (_x iskindof "EmptyDetector") then {
			_triggers pushBack _x;
		};
	} forEach (synchronizedObjects _module);

	//If we have synced triggers spawn on them
	if (count _triggers > 0) then {
		{
			[getpos _x,((triggerArea _x) select 0),_density,_markers] call MCC_fnc_spawnCratesInHouses;
		} forEach _triggers;
	} else {
		[_pos,_radius,_density,_markers] call MCC_fnc_spawnCratesInHouses;
	};
};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

 _resualt = ["Survival Spawn Crates in Buildings",[
 						["Radius",1000],
 						["Density",10],
 						["Markers",false]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

_radius = _resualt select 0;
_density = _resualt select 1;
_markers = _resualt select 2;

//Start spawning
[_pos,_radius,_density,_markers] remoteExec ["MCC_fnc_spawnCratesInHouses", 2];

deleteVehicle _module;