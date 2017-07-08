//================================================================MCC_fnc_rtsStartElectricity==============================================================================
//	Start electricity production
//  Parameter(s):
//     _ctrl: CONTROL
//		_res: resources Needed
//=======================================================================================================================================================================
private ["_ctrl","_res","_varName","_stat"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];

//Start building time
private ["_obj","_BuildTime"];
playsound "click";
if (count MCC_ConsoleGroupSelected <=0) exitWith {};
_obj = MCC_ConsoleGroupSelected select 0;

//Start building time
if !([_obj,_res] call MCC_fnc_rtsBuildingProgress) exitWith {};

_varName = format ["MCC_rtsElecOn_%1", playerSide];
_stat = !(missionNamespace getVariable [_varName,false]);
missionNamespace setVariable [_varName,_stat];
publicVariable _varName;
[MCC_ConsoleGroupSelected] spawn MCC_fnc_baseSelected;

if (missionNamespace getVariable [_varName,false]) then {
	[_obj,_varName] spawn {
		params ["_obj","_varName"];

		while {(missionNamespace getVariable [_varName,false])} do {
			playSound3D ["A3\Sounds_F\vehicles\armor\apc\apc1\ext_exhaust_01.wss", _obj];
			sleep 2.7;
		};
	};
};

