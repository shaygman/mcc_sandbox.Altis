//==================================================================MCC_fnc_allowedDrivers===============================================================================
// Check if the player is in vehicle while he is not a pilot or a crewman
//====================================================================================================================================================================
private ["_getout","_role","_roleName","_playerVehicle","_string","_counter","_cfg"];
_vehiclePosition = tolower (_this select 1);
_playerVehicle = _this select 2;

if (missionNamespace getVariable ["MCC_rsEnableDriversPilots",false]) then {
	_getout 		= false;
	_roleName 		= "crewman";
	_role 			= tolower (player getvariable ["CP_role","n/a"]);
	_cfg = if (isClass (missionconfigFile >> "MCC_loadouts" )) then {(missionconfigFile >> "MCC_loadouts")} else {(configFile >> "MCC_loadouts")};

	//Allowed drivers check
	if (_vehiclePosition == "cargo") exitWith {}; //as cargo

	//Tank-APC
	if (((_playerVehicle iskindof "Tank") || (_playerVehicle iskindof "Tank_F") || (_playerVehicle iskindof "Wheeled_APC_F")) && (getNumber(_cfg >> _role >> "allowCrew")==0)) then {
		_getout = true;
	};

	//Helicopter
	if ((_playerVehicle iskindof "Air" && !(_playerVehicle isKindOf "ParachuteBase")) && (getNumber(_cfg >> _role >> "allowPilot")==0)) then {
			//Allow gunner in transport heli
			if ((_playerVehicle iskindof "Heli_Transport_01_base_F") &&  (player == gunner _playerVehicle)) then {
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

if (missionNamespace getVariable ["MCC_arcadeTanks",false]) then {
	if ((_playerVehicle iskindof "Tank") || (_playerVehicle iskindof "Tank_F") || (_playerVehicle iskindof "Wheeled_APC_F")) then {

		if (_vehiclePosition != "cargo") then {
			enableSentences false;
		    player action ["EngineOn", _playerVehicle];
		    player action ["MoveToGunner", _playerVehicle];

		    _playerVehicle spawn {
		        waitUntil {!isNull gunner _this};
		        _ai = createAgent [typeOf gunner _this, [0,0,0], [], 0, "NONE"];
		        _ai allowDamage false;
		        _ai moveInDriver _this;

		        [_this,true] remoteExec ["lockDriver",_this];

		        waitUntil {isNull gunner _this};
		        _ai action ["EngineOff", _this];
		        deleteVehicle _ai;

		        [_this,false] remoteExec ["lockDriver",_this];
	            enableSentences true;
		    };
		};
	};
};