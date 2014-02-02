//==================================================================MCC_fnc_IedDeadlyExplosion===============================================================================================
// Create a deadly explosion, explosion dimiter will be decided by the _trapvolume
// Example: [_pos,_trapvolume] spawn MCC_fnc_IedDeadlyExplosion; 
// _pos = position, center of the explosion.
// _trapvolume = string, "small", "medium", "large"
//=================================================================================================================================================================================
private ["_pos", "_volume"];
_pos = _this select 0;
_volume = _this select 1; 
switch (_volume) do
{
   case "small":	
	{ 
	   "SmallSecondary" createVehicle _pos;
	};
	
	case "medium":	
	{ 
	   "HelicopterExploSmall" createVehicle _pos;
	};
	
	case "large":	
	{ 
	   "HelicopterExploBig" createVehicle _pos;
	};
};
