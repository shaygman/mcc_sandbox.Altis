//============================================================MCC_fnc_curatorVehicleSpawner======================================================================================
// Create a vhicles kiosk
//===========================================================================================================================================================================
private ["_pos","_module","_resualt","_array"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;
_array = ["vehicle","tank","heli","jet","ship"];

_resualt = ["Vehicle Kiosk",[
						["Type",["Vehicles","Armored","Helicopters","Fixed-Winged","Ships"]]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

_module setVariable ["type", (_array select (_resualt select 0)) ,true];
[_module,[]] call MCC_fnc_vehicleSpawnerInit;