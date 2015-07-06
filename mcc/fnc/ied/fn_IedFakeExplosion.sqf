//==================================================================MCC_fnc_IedFakeExplosion===============================================================================================
// Create a fake explosion, explosion dimiter will be decided by the _trapvolume
// Example: [_pos,_trapvolume] spawn MCC_fnc_IedFakeExplosion;
// _pos = position, center of the explosion.
// _trapvolume = string, "small", "medium", "large"
//=================================================================================================================================================================================
private ["_pos", "_volume","_vehicle","_vehicleClass"];
_pos = _this select 0;
_volume = _this select 1;

_vehicleClass = switch (_volume) do
	{
	   case "small": {"SmallSecondary"};
	   case "medium": {"SmallSecondary"};
	   case "large": {"SmallSecondary"};
	};

_vehicle = _vehicleClass createVehicle _pos;
_vehicle setpos _pos;