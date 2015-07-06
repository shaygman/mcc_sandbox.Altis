//============================================================MCC_fnc_curatorSetIED=============================================================================================
// Make item/object/unit an IED
//===========================================================================================================================================================================
private ["_pos","_module","_object","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;
_object = missionNamespace getVariable ["MCC_curatorMouseOver",[]];

//if no object selected or not a vehicle
if (count _object <2) exitWith {deleteVehicle _module};
_object = _object select 1;

//if no empty positions
if (isPlayer _object || isPlayer driver _object) exitWith {deleteVehicle _module};

//if already an IED
if (_object getVariable ["isIED", false]) exitWith {deleteVehicle _module};
_object setVariable ["isIED",true,true];

private ["_trapvolume","_IEDExplosionType","_IEDDisarmTime","_IEDJammable","_IEDTriggerType","_trapdistance","_iedside","_init"];

//Suicide Bomber
if (_object isKindOf "Man") then {
	_resualt = ["Make unit act as Suicide Bomber",[
	 						["Explosion Size",["Small","Medium","large"]],
	 						["Explosion Effect",["Deadly","Disabling","Fake","None"]],
	 						["Activation Side",["East","West","Resistance"]]
	 					  ]] call MCC_fnc_initDynamicDialog;

	if (count _resualt == 0) exitWith {deleteVehicle _module};


	_trapvolume 		= ["small","medium","large"] select (_resualt select 0);
	_IEDExplosionType 	= (_resualt select 1);
	_iedside 			= (_resualt select 2) call BIS_fnc_sideType;

	[[_object, _iedside, _trapvolume, _IEDExplosionType], "MCC_fnc_manageSB", _object, false] spawn BIS_fnc_MP;

} else {
	_resualt = ["Make an object act as an IED",[
	 						["Explosion Size",["Small","Medium","large"]],
	 						["Explosion Effect",["Deadly","Disabling","Fake","None"]],
	 						["Disarm Time",300],
	 						["Can be jammed using ECM vehicle",true],
	 						["Activation Type",["Proximity","Radio/Spotter","Mission Maker Only"]],
	 						["Activation Distance",60],
	 						["Activation Side",["East","West","Resistance"]]
	 					  ]] call MCC_fnc_initDynamicDialog;

	if (count _resualt == 0) exitWith {deleteVehicle _module};


	_trapvolume 		= ["small","medium","large"] select (_resualt select 0);
	_IEDExplosionType 	= (_resualt select 1);
	_IEDDisarmTime 		= (_resualt select 2);
	_IEDJammable 		= (_resualt select 3);
	_IEDTriggerType 	= (_resualt select 4);
	_trapdistance 		= (_resualt select 5);
	_iedside 			= (_resualt select 6) call BIS_fnc_sideType;


	[[_object, _trapvolume, _IEDExplosionType, _IEDDisarmTime, _IEDJammable, _IEDTriggerType, _trapdistance, _iedside], "MCC_fnc_createIED", false, false] call BIS_fnc_MP;
};


deleteVehicle _module;