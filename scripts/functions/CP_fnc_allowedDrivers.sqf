//==================================================================CP_fnc_allowedDrivers======================================================================================
// Check if the player is in vehicle while he is not a pilot or a crewman
//==============================================================================================================================================================================	
private ["_getout","_role","_roleName"];
_getout = false;
_roleName = "crewman";  
	
//Gain XP Officer
if ((tolower (player getvariable "CP_role") == "officer") ) then 
{		
	if (CP_debug) then {player sidechat format ["rating: %1", rating player]};
	
	{
		if (!isnil "_x") then
		{
			if ((isPlayer _x) && (player != _x)) then {{player addrating 0.5};};
		};
	} foreach (units (group player));
}; 

//Allowed drivers check
if (vehicle player != player) then	
{
	if ((player != commander vehicle player) && (player != driver vehicle player) && (player != gunner vehicle player)) exitWith {}; //as cargo
	
	//Tank-APC	
	if ((((vehicle player) iskindof "Tank") || ((vehicle player) iskindof "Tank_F") || ((vehicle player) iskindof "Wheeled_APC_F")) && (tolower (player getvariable "CP_role") != "crew")) then	
	{		
		_getout = true; 
	};
	
	//Helicopter
	if (((vehicle player) iskindof "Air") && (tolower (player getvariable "CP_role") != "pilot")) then 
	{		
			if (((vehicle player) iskindof "Heli_Transport_01_base_F") &&  (player == gunner vehicle player)) then {		//Allow gunner in transport heli
				_getout = false; 
					} else {
						_getout = true; 
						_roleName = "pilot";
						};
	};
	
	//Not allowed kick him out
	if (_getout) then	
	{
		player action ["getOut", vehicle player];
		cutText [format ["You need to be a %1 inorder to use this vehicle",_roleName],"BLACK OUT",0.1];
		sleep 3; 
		cutText ["","BLACK IN",0.1];
	};
};


//Gain XP as Pilot
if (((vehicle player) iskindof "Air") && (tolower (player getvariable "CP_role") == "pilot") && (isengineon (vehicle player))) then 
{
	if (CP_debug) then {player sidechat format ["rating: %1", rating player]};
	
	{
		if (!isnil "_x") then {
				if ((isPlayer _x) && (player != _x) && (vehicle _x == vehicle player)) then {player addrating 3};
			};
	} foreach (assignedCargo (vehicle player));
};


//Gain XP crewman
if ((((vehicle player) iskindof "Tank") || ((vehicle player) iskindof "Tank_F") || ((vehicle player) iskindof "Wheeled_APC_F")) && (tolower (player getvariable "CP_role") == "crew") && (isengineon (vehicle player))) then 
{
	if (CP_debug) then {player sidechat format ["rating: %1", rating player]};
	
	{
		if (!isnil "_x") then 
		{
			if ((isPlayer _x) && (player != _x) && (vehicle _x == vehicle player)) then {player addrating 2};
		};
	} foreach (assignedCargo (vehicle player));
};