//============================================================MCC_fnc_addToZeus===============================================================================================
// find nearest civilian house
// In:
//	_pos:	ARRAY
//	_RADIUS: INTEGER
//
//<OUT>
//	_nearhouses ARRAY of objects - good houses found
//===========================================================================================================================================================================
private ["_pos","_module","_object","_house","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;
_object = missionNamespace getVariable ["MCC_curatorMouseOver",objNull];

 _resualt = ["Add Units/Objects in radius to Zeus",[
 						["Radius",100]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

{
	if !(_x isKindOf "Animal") then {
		MCC_curator addCuratorEditableObjects [[_x],true];
	};

} forEach (nearestObjects [_pos, [], (_resualt select 0)]);

deleteVehicle _module;