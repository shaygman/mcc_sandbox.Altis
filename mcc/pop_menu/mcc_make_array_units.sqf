private ["_CfgVehicles","_type","_i","_CfgVehicle","_vehicleClass","_simulation","_simTypesUnits","_faction","_tempArray"];

_faction = missionNamespace getVariable ["mcc_faction",""];

if (isNil "_faction") exitWith {};

//If the faction has been inited once don't do it again
if (missionNamespace getVariable ["MCC_faction_initilized_units",false]) exitWith {
	U_GEN_SOLDIER = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_SOLDIER", _faction],[]]);
	U_GEN_CAR = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_CAR", _faction],[]]);
	U_GEN_MOTORCYCLE = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_MOTORCYCLE", _faction],[]]);
	U_GEN_TANK = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_TANK", _faction],[]]);
	U_GEN_HELICOPTER = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_HELICOPTER", _faction],[]]);
	U_GEN_AIRPLANE = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_AIRPLANE", _faction],[]]);
	U_GEN_SHIP = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_SHIP", _faction],[]]);
	U_AMMO = (missionNamespace getVariable ["MCC_factions_U_AMMO",[]]);
};


_simTypesUnits 	= ["soldier", "car","carx", "motorcycle", "tank", "helicopter", "airplane", "ship", "parachute","helicopterx","helicopterrtd","shipx","shipx","tankx","submarinex","airplanex"];
_CfgVehicles 		= configFile >> "CfgVehicles" ;



for "_i" from 1 to (count _CfgVehicles - 1) do {
	_CfgVehicle = _CfgVehicles select _i;

	//Keep going when it is a public entry
	if ((getNumber(_CfgVehicle >> "scope") == 2)) then {

		_vehicleDisplayName 	= getText(_CfgVehicle >> "displayname");
		_cfgclass 			= (configName (_CfgVehicle));
		_cfgFaction 			= getText(_CfgVehicle >> "faction");
		_simulation 			= toLower (getText(_CfgVehicle >> "simulation"));
		_vehicleDisplayName	= [_vehicleDisplayName, gettext(_CfgVehicle >> "picture")];

		//VK - Added to recognize ammo crates
		_vehicleclass			= toLower (getText(_CfgVehicle >> "vehicleclass"));

		//VK - Let ammoboxes through
		if ((_simulation in _simTypesUnits) or (_vehicleclass == "ammo") or (_vehicleclass == "ace_ammunition") or (_vehicleclass == "ace_ammunitiontransportus") or (_vehicleclass == "ace_ammunitiontransportru")) then {

			switch (true) do {

				case (_simulation == "soldier"):
				{
					_type="LAND";
					_tempArray = missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_SOLDIER", _cfgFaction],[]];
					_tempArray pushBack [_type,_cfgclass,mcc_sidename,_vehicleDisplayName];
					missionNamespace setVariable [format ["MCC_faction_%1_U_GEN_SOLDIER", _cfgFaction],_tempArray];
				};

				case (_simulation in ["car","carx"]):
				{
					_type="LAND";
					_tempArray = missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_CAR", _cfgFaction],[]];
					_tempArray pushBack [_type,_cfgclass,mcc_sidename,_vehicleDisplayName];
					missionNamespace setVariable [format ["MCC_faction_%1_U_GEN_CAR", _cfgFaction],_tempArray];
				};

				case (_simulation == "motorcycle"):
				{
					_type="LAND";
					_tempArray = missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_MOTORCYCLE", _cfgFaction],[]];
					_tempArray pushBack [_type,_cfgclass,mcc_sidename,_vehicleDisplayName];
					missionNamespace setVariable [format ["MCC_faction_%1_U_GEN_MOTORCYCLE", _cfgFaction],_tempArray];
				};


				case (_simulation in ["tank","tankx"]):
				{
					_type="LAND";
					_tempArray = missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_TANK", _cfgFaction],[]];
					_tempArray pushBack [_type,_cfgclass,mcc_sidename,_vehicleDisplayName];
					missionNamespace setVariable [format ["MCC_faction_%1_U_GEN_TANK", _cfgFaction],_tempArray];
				};

				case (_simulation in ["helicopter","helicopterx","helicopterrtd"]):
				{
					_type="LAND";
					_tempArray = missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_HELICOPTER", _cfgFaction],[]];
					_tempArray pushBack [_type,_cfgclass,mcc_sidename,_vehicleDisplayName];
					missionNamespace setVariable [format ["MCC_faction_%1_U_GEN_HELICOPTER", _cfgFaction],_tempArray];
				};

				case (_simulation in ["airplane","airplanex"]):
				{
					_type="LAND";
					_tempArray = missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_AIRPLANE", _cfgFaction],[]];
					_tempArray pushBack [_type,_cfgclass,mcc_sidename,_vehicleDisplayName];
					missionNamespace setVariable [format ["MCC_faction_%1_U_GEN_AIRPLANE", _cfgFaction],_tempArray];
				};

				case (_simulation in ["ship","shipx","submarinex"]):
				{
					_type="LAND";
					_tempArray = missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_SHIP", _cfgFaction],[]];
					_tempArray pushBack [_type,_cfgclass,mcc_sidename,_vehicleDisplayName];
					missionNamespace setVariable [format ["MCC_faction_%1_U_GEN_SHIP", _cfgFaction],_tempArray];
				};
			};

			if (_vehicleclass == "ammo") then {
					_type="LAND";
					_tempArray = missionNamespace getVariable ["MCC_factions_U_AMMO",[]];
					_tempArray pushBack [_type,_cfgclass,mcc_sidename,_vehicleDisplayName];
					missionNamespace setVariable ["MCC_factions_U_AMMO",_tempArray];
			};
		};
	};
};

missionNamespace setVariable ["MCC_faction_initilized_units",true];

U_GEN_SOLDIER = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_SOLDIER", _faction],[]]);
U_GEN_CAR = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_CAR", _faction],[]]);
U_GEN_MOTORCYCLE = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_MOTORCYCLE", _faction],[]]);
U_GEN_TANK = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_TANK", _faction],[]]);
U_GEN_HELICOPTER = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_HELICOPTER", _faction],[]]);
U_GEN_AIRPLANE = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_AIRPLANE", _faction],[]]);
U_GEN_SHIP = (missionNamespace getVariable [format ["MCC_faction_%1_U_GEN_SHIP", _faction],[]]);
U_AMMO = (missionNamespace getVariable ["MCC_factions_U_AMMO",[]]);

MCC_unit_array_ready=true; 	//let dialog know we are ready
