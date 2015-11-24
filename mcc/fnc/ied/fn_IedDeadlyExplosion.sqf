//==================================================================MCC_fnc_IedDeadlyExplosion============================================================================
// Create a deadly explosion, explosion dimiter will be decided by the _trapvolume
// Example: [_pos,_trapvolume] spawn MCC_fnc_IedDeadlyExplosion;
// _pos = position, center of the explosion.
// _trapvolume = string, "small", "medium", "large"
//======================================================================================================================================================================
private ["_pos", "_volume","_bomb","_class"];
_pos = _this select 0;
_volume = _this select 1;

_class = switch (_volume) do {
   			case "medium":{"IEDUrbanSmall_Remote_Ammo"};
   			case "large":{"IEDUrbanBig_Remote_Ammo"};
   			default {"DemoCharge_Remote_Ammo_Scripted"};
		 };

_bomb = createvehicle [_class,_pos,[],0,"none"];
hideObjectGlobal _bomb;
_bomb setposATL _pos;
sleep 0.1;
_bomb setdamage 1;
