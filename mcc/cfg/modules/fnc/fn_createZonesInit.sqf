//==================================================================MCC_fnc_createZonesInit============================================================================
// Sync with triggers to create MCC zones
//==============================================================================================================================================================
private ["_logic","_synced"];

// Exit if player or HC
if !(hasInterface || isServer) exitWith {};


_logic = _this select 0;
_logic spawn {
	waitUntil {time > 0};

	//Who synced with the module
	_synced = synchronizedobjects _this;
	_zones = (missionNamespace getVariable ["MCC_zones_numbers",[]]);
	{
		if (_x isKindOf "EmptyDetector") then {
			[count (missionNamespace getVariable ["MCC_zones_numbers",[]])+1,position _x,triggerArea _x] call MCC_fnc_MWUpdateZone;
		};
	} forEach _synced;
};