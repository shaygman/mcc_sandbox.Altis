/*============================================================MCC_fnc_curatorLHDSpawn==================================================================================
// Spawn LHD Curator Menu
//================================================================================================================================================================*/
private ["_pos","_module","_resualt","_dir","_side","_hq","_isCUP"];
_module = param [0,objNull,[objNull]];
if (isNull _module) exitWith {};

_pos = getpos _module;
_dir = getDir _module;

//did we get here from the 2d editor?
if (typeName (_module getVariable ["side",""]) == typeName 0) exitWith {

	_side = [(_module getVariable ["side",1])] call BIS_fnc_sideType;
	_hq = _module getVariable ["hq",true];
	_isCUP = _module getVariable ["isCUP",false];

	//Start LHD
	if (isServer) then {
		[_pos,_dir,_side,_hq,_isCUP] spawn MCC_fnc_LHDspawn;
	};
};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_resualt = ["Spawn LHD",[
				["Owner",["East","West","Resistance"]],
				["Respawn Position",false],
				["CUP LHD",false]
 			]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

_side = [ _resualt param [0,1]] call BIS_fnc_sideType;
_hq = _resualt param [1,false];
_isCUP = _resualt param [2,false];

[_pos,_dir,_side,_hq,_isCUP] remoteExec ["MCC_fnc_LHDspawn",2];

deleteVehicle _module;