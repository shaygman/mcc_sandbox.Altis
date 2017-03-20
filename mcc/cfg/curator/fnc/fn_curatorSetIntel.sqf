//============================================================MCC_fnc_curatorSetIntel======================================================================================
// Make item/object/unit a pickable intel
//===========================================================================================================================================================================
private ["_pos","_module","_objects","_text","_shared","_delete","_markers","_tittle","_marker"];
_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {};

_pos = getpos _module;
//did we get here from the 2d editor?

if (typeName (_module getVariable ["shared",true]) == typeName 0) exitWith {

	if (!isServer) exitWith {};

	_shared = _module getVariable ["shared",2];
	_tittle = _module getVariable ["tittle",""];
	_text = _module getVariable ["text",""];
	_delete = _module getVariable ["delete",true];
	_markers = if ((_module getVariable ["marker",""]) != "") then {[(_module getVariable ["marker",""])]} else {[]};
	_objects = synchronizedObjects _module;

	{
		_x setVariable ["MCC_intelObjectText",[_tittle,_text],true];
		_x setVariable ["MCC_intelObjectShared",_shared,true];
		_x setVariable ["MCC_intelObjectDelete",_delete,true];
		_x setVariable ["MCC_intelObjectMarkerName",_markers,true];

		_x remoteExec ["MCC_fnc_pickItem",0,true];
	} forEach _objects;
};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_object = missionNamespace getVariable ["MCC_curatorMouseOver",[]];

//if no object selected or not a vehicle
if (count _object <2) exitWith {systemchat "No object selected";deleteVehicle _module};
_object = _object select 1;

//if no empty positions
if (isPlayer _object || isPlayer driver _object) exitWith {deleteVehicle _module};

_markers = ["None"] + allMapMarkers;

_resualt = ["Create Intel",[
			["Shared With",["All","Group","Side"]],
			["Tittle",""],
			["Text",""],
			["Marker Name",_markers],
			["Delete Object After",true]
		  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

_shared = (_resualt select 0);
_tittle = (_resualt select 1);
_text = (_resualt select 2);
_marker = if ((_resualt select 3) > 0) then {[(_markers) select (_resualt select 3)]} else {[]};
_delete = (_resualt select 4);


_object setVariable ["MCC_intelObjectText",[_tittle,_text],true];
_object setVariable ["MCC_intelObjectShared",_shared,true];
_object setVariable ["MCC_intelObjectDelete",_delete,true];
_object setVariable ["MCC_intelObjectMarkerName",_marker,true];

_object remoteExec ["MCC_fnc_pickItem",0,true];


deleteVehicle _module;