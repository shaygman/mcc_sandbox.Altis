//==================================================================MCC_fnc_gainXPfromRoles======================================================================================
// Gain XP from specific roles.
//==============================================================================================================================================================================
private ["_role","_playerVehicle","_string","_counter","_notes"];
_role 			= tolower (player getvariable ["CP_role","n/a"]);
_playerVehicle	= vehicle player;
_notes = missionNamespace getvariable ["CP_expNotifications",true];

//Gain XP Officer
if (_role == "officer") then {
	if (MCC_debug) then {systemchat format ["rating: %1", rating player]};

	_counter = 0;
	{
		if (!isnil "_x") then {
			if ((isPlayer _x) && (player != _x)) then {
				_counter = _counter + 10;
				player addrating 10;
			};
		};
	} foreach (units (group player));

	if (_counter > 0 && _notes) then {
		_string = format ["<t font='puristaMedium' size='0.5' color='#FFFFFF '>+%1 Exp For Leading</t>",_counter];
		[_string,0,1,2,1,0,4] spawn BIS_fnc_dynamicText;
	};
};

//Gain XP as Pilot
if (((_playerVehicle iskindof "Air") && _role == "pilot") && (isengineon _playerVehicle)) then {
	if (MCC_debug) then {systemchat format ["rating: %1", rating player]};

	_counter = 0;
	{
		if (!isnil "_x") then {
				if ((isPlayer _x) && (vehicle _x == vehicle player)) then {
					_counter = _counter + 50;
					player addrating 50;
				};
		};
	} foreach (assignedCargo _playerVehicle);

	if (_counter > 0 && _notes) then {
		_string = format ["<t font='puristaMedium' size='0.5' color='#FFFFFF '>+%1 Exp For Flying Taxi</t>",_counter];
		[_string,0,1,2,1,0,4] spawn BIS_fnc_dynamicText;
	};
};


//Gain XP crewman
if ((((_playerVehicle iskindof "Tank") || (_playerVehicle iskindof "Tank_F") || (_playerVehicle iskindof "Wheeled_APC_F")) && _role == "crew") && (isengineon _playerVehicle)) then {
	if (MCC_debug) then {systemchat format ["rating: %1", rating player]};

	_counter = 0;
	{
		if (!isnil "_x") then {
			if ((isPlayer _x) && (vehicle _x == _playerVehicle)) then {
				_counter = _counter + 20;
				player addrating 1;
			};
		};
	} foreach (assignedCargo _playerVehicle);

	if (_counter > 0 && _notes) then {
		_string = format ["<t font='puristaMedium' size='0.5' color='#FFFFFF '>+%1 Exp For Driving Taxi</t>",_counter];
		[_string,0,1,2,1,0,4] spawn BIS_fnc_dynamicText;
	};
};
