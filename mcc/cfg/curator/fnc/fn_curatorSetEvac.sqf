//============================================================MCC_fnc_curatorSetEvac=============================================================================================
//Mark Vehicle as Evac Vehicle
//===========================================================================================================================================================================
private ["_pos","_module","_object","_resualt","_side","_gunners","_campaign"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;

//did we get here from the 2d editor?
if (typeName (_module getVariable ["side",true]) == typeName 0) exitWith {

	_side =  [(_module getVariable ["side",1])] call BIS_fnc_sideType;
	_gunners = (_module getVariable ["gunners",0]) == 1;
	_campaign = (_module getVariable ["campaign",0]) == 1;

	{
		[[_x, _side, _gunners, _campaign], "MCC_fnc_setEvac", false, false] call BIS_fnc_MP;
	} forEach (synchronizedObjects _module);
};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_object = missionNamespace getVariable ["MCC_curatorMouseOver",[]];

//if no object selected or not a vehicle
if (count _object <2) exitWith {systemchat "No vehicle selected"; deleteVehicle _module};
_object = _object select 1;

//if no empty positions
if (_object emptyPositions "cargo" <=0 || isplayer driver _object) exitWith {deleteVehicle _module};

//if already an evac
if (count (_object getVariable ["MCC_evacStartPos", []]) > 0) exitWith {deleteVehicle _module};

_resualt = ["Add the vehicle as MCC evac vehicle",[
 						["Side",["East","West","Resistance"]],
 						["Add gunners",true],
 						["Campaign Evac",false]
 					  ]] call MCC_fnc_initDynamicDialog;

_side = (_resualt select 0) call BIS_fnc_sideType;
_gunners = _resualt select 1;
_campaign = _resualt select 2;

if (count _resualt == 0) exitWith {deleteVehicle _module};

[[_object, _side, _gunners, _campaign], "MCC_fnc_setEvac", false, false] call BIS_fnc_MP;


deleteVehicle _module;