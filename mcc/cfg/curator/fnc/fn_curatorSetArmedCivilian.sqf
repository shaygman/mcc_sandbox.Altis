//============================================================MCC_fnc_curatorSetArmedCivilian====================================================================================
// Make unit armed civilian
//===========================================================================================================================================================================
private ["_pos","_module","_object","_resualt","_iedside","_static"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;
//did we get here from the 2d editor?
if (typeName (_module getVariable ["side",true]) == typeName 0) exitWith {

	_iedside =  [(_module getVariable ["side",1])] call BIS_fnc_sideType;
	_static = (_module getVariable ["patrol",0]) == 1;

	{
		[_x, _iedside, 25] spawn MCC_fnc_manageAC;
	} forEach (synchronizedObjects _module);
};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_object = missionNamespace getVariable ["MCC_curatorMouseOver",[]];

//if no object selected or not a vehicle
if (count _object <2) exitWith {systemchat "No unit selected"; deleteVehicle _module};
_object = _object select 1;

//if nis player
if (isPlayer _object || !(_object isKindOf "Man")) exitWith {deleteVehicle _module};

//if already an armed civilian
if ((_object getVariable ["MCC_IEDtype",""])=="ac") exitWith {deleteVehicle _module};

//Suicide Bomber

_resualt = ["Make unit act as Suicide Bomber",[
 						["Attack Side",["East","West","Resistance"]],
 						["Patrol",false]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};
_object setVariable ["MCC_IEDtype","ac",true];

_iedside = (_resualt select 0) call BIS_fnc_sideType;
_static = !(_resualt select 1);
_object setVariable ["static",_static,true];
[[_object, _iedside, 25], "MCC_fnc_manageAC", _object, false] spawn BIS_fnc_MP;

deleteVehicle _module;