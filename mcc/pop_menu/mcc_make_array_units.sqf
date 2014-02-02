private ["_CfgVehicles","_type","_i","_CfgVehicle","_vehicleClass","_simulation","_simTypesUnits","_u_GEN_ship_idx","_u_GEN_airplane_idx","_u_GEN_helicopter_idx","_u_GEN_TANK_idx",
		 "_u_GEN_motorcycle_idx","_u_GEN_car_idx","_u_GEN_soldier_idx","_u_ammo_idx","_faction"];
		 
_u_GEN_ship_idx		 	= 0;
_u_GEN_airplane_idx   	= 0;
_u_GEN_helicopter_idx 	= 0;
_u_GEN_TANK_idx		 	= 0;
_u_GEN_motorcycle_idx 	= 0;
_u_GEN_car_idx		 	= 0;
_u_GEN_soldier_idx       = 0;

_u_ammo_idx				= 0;	//VK
_u_ace_ammo_idx			= 0;	//VK

_faction = mcc_faction;
if (isNil "_faction") exitWith {}; 
_simTypesUnits 	= ["soldier", "car","carx", "motorcycle", "tank", "helicopter", "airplane", "ship", "parachute","helicopterX","shipx","shipX","tankX","submarinex","airplanex"];   
_CfgVehicles 		= configFile >> "CfgVehicles" ;



for "_i" from 1 to (count _CfgVehicles - 1) do {
 _CfgVehicle = _CfgVehicles select _i;
 
 //Keep going when it is a public entry
 if ((getNumber(_CfgVehicle >> "scope") == 2)) then {
  
  _vehicleDisplayName 	= getText(_CfgVehicle >> "displayname");
  _cfgclass 			= (configName (_CfgVehicle));  
  _cfgFaction 			= getText(_CfgVehicle >> "faction");
  _simulation 			= getText(_CfgVehicle >> "simulation");
  _vehicleDisplayName	= [_vehicleDisplayName, gettext(_CfgVehicle >> "picture")];
  
  //VK - Added to recognize ammo crates
  _vehicleclass			= getText(_CfgVehicle >> "vehicleclass");
  
  //VK - Let ammoboxes through
  if ((_simulation in _simTypesUnits) or (toLower(_vehicleclass) == "ammo") or (toLower(_vehicleclass) == "ace_ammunition") or (toLower(_vehicleclass) == "ace_ammunitiontransportus") or (toLower(_vehicleclass) == "ace_ammunitiontransportru")) then 
  {
	if (toUpper(_cfgFaction) == _faction) then 
	{
        
		switch (toLower(_simulation)) do 
		{
			//case "soldier"		{hint "1";}; 
			case "soldier"		: {
									_type="LAND";
									U_GEN_SOLDIER set[_u_GEN_soldier_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
									_u_GEN_soldier_idx = _u_GEN_soldier_idx + 1;
								};
								  
			case "car"			: {
									_type="LAND";
									U_GEN_CAR set[_u_GEN_car_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_car_idx = _u_GEN_car_idx + 1;
									
								  };
			case "carx"			: {
									_type="LAND";
									U_GEN_CAR set[_u_GEN_car_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_car_idx = _u_GEN_car_idx + 1;
									
								  };
			case "motorcycle"	: {
									_type="LAND";
									U_GEN_MOTORCYCLE set[_u_GEN_motorcycle_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_motorcycle_idx = _u_GEN_motorcycle_idx + 1;
								  };
			case "tank"			: {
									_type="LAND";
									U_GEN_TANK set[_u_GEN_TANK_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_TANK_idx = _u_GEN_TANK_idx + 1;
								  };
			case "tankx"		: {
									_type="LAND";
									U_GEN_TANK set[_u_GEN_TANK_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_TANK_idx = _u_GEN_TANK_idx + 1;
								  };
			case "helicopter"	: {
									_type="AIR";
									U_GEN_HELICOPTER set[_u_GEN_helicopter_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_helicopter_idx = _u_GEN_helicopter_idx + 1;
								  };
			case "helicopterx"	: {
									_type="AIR";
									U_GEN_HELICOPTER set[_u_GEN_helicopter_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_helicopter_idx = _u_GEN_helicopter_idx + 1;
								  };
			case "airplane"		: {
									_type="AIR";
									U_GEN_AIRPLANE set[_u_GEN_airplane_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_airplane_idx = _u_GEN_airplane_idx + 1;
								  };
			case "airplanex"	: {
									_type="AIR";
									U_GEN_AIRPLANE set[_u_GEN_airplane_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_airplane_idx = _u_GEN_airplane_idx + 1;
								  };
			case "ship"			: {
									_type="WATER";
									U_GEN_SHIP set[_u_GEN_ship_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_ship_idx = _u_GEN_ship_idx + 1;
								  };
			case "shipx"		: {
									_type="WATER";
									U_GEN_SHIP set[_u_GEN_ship_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_ship_idx = _u_GEN_ship_idx + 1;
								  };
			case "submarinex"	: {
									_type="WATER";
									U_GEN_SHIP set[_u_GEN_ship_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
									_u_GEN_ship_idx = _u_GEN_ship_idx + 1;
								  };
		}; 
	};
	
	if ((toLower(_vehicleclass) == "ammo")) then
		{
			_type="LAND";
			U_AMMO set[_u_ammo_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
			_u_ammo_idx = _u_ammo_idx+1;
		};
	};
 };
};
 MCC_unit_array_ready=true; 	//let dialog know we are ready
