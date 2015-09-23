//==================================================================MCC_fnc_allowedDrivers======================================================================================
// Check if the player is in vehicle while he is not a pilot or a crewman
//==============================================================================================================================================================================
private ["_getout","_role","_roleName","_playerVehicle","_string","_counter"];
_getout 		= false;
_roleName 		= "crewman";
_role 			= tolower (player getvariable ["CP_role","n/a"]);
_playerVehicle	= vehicle player;

//Allowed drivers check
if (_playerVehicle != player) then {
	if ((player != commander _playerVehicle) && (player != driver _playerVehicle) && (player != gunner _playerVehicle)) exitWith {}; //as cargo

	//Tank-APC
	if (((_playerVehicle iskindof "Tank") || (_playerVehicle iskindof "Tank_F") || (_playerVehicle iskindof "Wheeled_APC_F")) && (_role != "crew")) then {
		_getout = true;
	};

	//Helicopter
	if ((_playerVehicle iskindof "Air" && !(_playerVehicle isKindOf "ParachuteBase")) && _role != "pilot") then {
			if ((_playerVehicle iskindof "Heli_Transport_01_base_F") &&  (player == gunner _playerVehicle)) then {		//Allow gunner in transport heli
				_getout = false;
					} else {
						_getout = true;
						_roleName = "pilot";
						};
	};

	//Not allowed kick him out
	if (_getout) then {
		player action ["getOut", _playerVehicle];
		cutText [format ["You need to be a %1 inorder to use this vehicle",_roleName],"BLACK OUT",0.1];
		sleep 3;
		cutText ["","BLACK IN",0.1];
	};
};