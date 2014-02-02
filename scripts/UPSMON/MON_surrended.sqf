// =========================================================================================================
//  Script for adding the action of follow player.
//  Version: 1.0 
//  Author: Monsada (smirall@hotmail.com)
// ---------------------------------------------------------------------------------------------------------
private ["_side","_soldiers"];
_side = _this select 0;

_soldiers = switch (_side) do {
  case west: {KRON_AllWest};
  case east: {KRON_AllEast};
  case resistance: {KRON_AllRes};
};

{
	if ( leader _x == _x ) then {
		_x addaction ["Order your men to follow me", "scripts\UPSMON\actions\followme.sqf", [], 1, false];
	} else {
		_x addaction ["Follow me", "scripts\UPSMON\actions\followme.sqf", [], 1, false];
	};
}foreach _soldiers;
	
if (true) exitWith {};
