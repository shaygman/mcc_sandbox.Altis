//============================================================MCC_fnc_curatorModuleCapturePoint=================================================================================
// Capture points
//===========================================================================================================================================================================
private ["_resualt","_type","_scoreReward","_flag","_radius","_module","_enableHUD"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};
//if (player != getAssignedCuratorUnit (missionNamespace getVariable ["MCC_curator",objNull]) || isDedicated) exitWith {};

_resualt = ["Create a cpature point",[["Type",[["Ammo",format ["%1data\IconAmmo.paa",MCC_path]],["Supply",format ["%1data\IconRepair.paa",MCC_path]],["Fuel",format ["%1data\IconFuel.paa",MCC_path]],["Tickets",""]]],
				["Radius",300],
				["Score Reward",50],
				["Flag",false],
				["UI",true]
			  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

_type = _resualt select 0;
_radius = _resualt select 1;
_scoreReward = _resualt select 2;
_flag = _resualt select 3;
_enableHUD = _resualt select 4;

_module setvariable ["type",_type,true];
_module setvariable ["ScoreReward",_scoreReward,true];
_module setvariable ["flag",_flag,true];
_module setvariable ["radius",_radius,true];
_module setvariable ["enableHUD",_enableHUD,true];

_null = [[_module],"MCC_fnc_moduleCapturePoint",false] call bis_fnc_mp;