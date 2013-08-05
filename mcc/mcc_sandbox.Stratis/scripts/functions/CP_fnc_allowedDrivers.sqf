//==================================================================CP_fnc_setValue======================================================================================
// Check if the player is in vehicle while he is not a pilot or a crewman
//==============================================================================================================================================================================	
private ["_getout","_role"];
_getout = false;
_role = "crewman";  
if (vehicle player != player) then	{
	if ((player != commander vehicle player) && (player != driver vehicle player) && (player != gunner vehicle player)) exitWith {}; //as cargo
		
	if ((((vehicle player) iskindof "Tank") || ((vehicle player) iskindof "Tank_F") || ((vehicle player) iskindof "Wheeled_APC_F")) && (tolower (player getvariable "CP_role") != "crew")) then	{		//Tank-APC
				_getout = true; 
		};
	if (((vehicle player) iskindof "Air") && (tolower (player getvariable "CP_role") != "pilot")) then {		//Helicopter
				_getout = true; 
		};
	if (_getout) then	{
		player action ["getOut", vehicle player];
		cutText [format ["You need to be a %1 inorder to use this vehicle",_role],"BLACK OUT",0.1];
		sleep 3; 
		cutText ["","BLACK IN",0.1];
		};
	};

