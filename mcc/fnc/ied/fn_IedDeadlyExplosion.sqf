//==================================================================MCC_fnc_IedDeadlyExplosion===============================================================================================
// Create a deadly explosion, explosion dimiter will be decided by the _trapvolume
// Example: [_pos,_trapvolume] spawn MCC_fnc_IedDeadlyExplosion; 
// _pos = position, center of the explosion.
// _trapvolume = string, "small", "medium", "large"
//=================================================================================================================================================================================
private ["_pos", "_volume","_bomb"];
_pos = _this select 0;
_volume = _this select 1; 

switch (_volume) do
{
   case "small":	
	{ 
	   _bomb = createvehicle ["DemoCharge_Remote_Ammo_Scripted",_pos,[],0,"none"]; 
	   _bomb setposATL _pos;
	   _bomb setdamage 1;
	  
	};
	
	case "medium":	
	{ 
	   _bomb = createvehicle ["IEDUrbanSmall_Remote_Ammo",_pos,[],0,"none"]; 
	   _bomb = "IEDUrbanSmall_Remote_Ammo" createVehicle _pos;	
	   _bomb setposATL _pos;
	   _bomb setdamage 1;	   
	};
	
	case "large":	
	{ 
	   _bomb = createvehicle ["IEDUrbanBig_Remote_Ammo",_pos,[],0,"none"]; 
	   _bomb setposATL _pos;
	   _bomb setdamage 1;
	};
};
