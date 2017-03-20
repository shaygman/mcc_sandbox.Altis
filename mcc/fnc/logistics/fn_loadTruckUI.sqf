//==================================================================MCC_fnc_loadTruckUI==========================================================================================
// Open logistic truck UI
// Example: []player call MCC_fnc_loadTruckUI;
//===============================================================================================================================================================================
private ["_truck","_caller","_startPos"];
_caller 	= _this select 0;
_truck 		= vehicle _caller;

if ({_truck distance2d _x < 50} count ([_caller] call BIS_fnc_getRespawnPositions) > 0) then {
	player setVariable ["mcc_logTruck_screenStart", true];
} else {
	player setVariable ["mcc_logTruck_screenStart", false];
};

createDialog "MCC_LOGISTICS_LOAD_TRUCK";
 waituntil {!dialog};



