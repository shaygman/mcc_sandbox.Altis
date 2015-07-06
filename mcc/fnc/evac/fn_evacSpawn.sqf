//===================================================================MCC_fnc_evacSpawn======================================================================================
// Spawn a vehicle with crew and gunners, mark it as an evac vehicle
// Example:[[vehicleClass, position],"MCC_fnc_evacSpawn",true,false] spawn BIS_fnc_MP;
// Params:
// 	vehicleClass: string, vehicleClass to spawn
// 	position: array, spawn position
//==============================================================================================================================================================================
private ["_heliType","_pos", "_evac_p_type","_side","_evac","_campaignEvac"];

_heliType 	= _this select 0; 	//Type of heli
_pos 		= _this select 1;
_campaignEvac = [_this, 2, false, [false]] call BIS_fnc_param;

//wait for mission start
waitUntil {time >0};

_evac_p_type = getText (configFile >> "CfgVehicles" >> _heliType >> "crew");
_side =  (getNumber (configFile >> "CfgVehicles" >> _heliType >> "side")) call BIS_fnc_sideType;

_evac = _heliType createVehicle [_pos select 0, _pos select 1, 500]; 				//spawn heli
if (surfaceIsWater _pos) then {
	_evac setposasl _pos;
} else {
	_evac setposatl _pos;
};

[_evac, _side, true,_campaignEvac] call MCC_fnc_setEvac;