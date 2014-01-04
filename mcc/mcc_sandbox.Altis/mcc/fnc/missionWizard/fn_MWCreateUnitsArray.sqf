//======================================================MCC_fnc_MWCreateUnitsArray=========================================================================================================
// Create units array by type
// Example:[_] call MCC_fnc_MWCreateUnitsArray; 
// Creates unit arrays by vehicle class
//	MCC_MWunitsArrayMen = [];			//vehicleClass = "Men";
//	MCC_MWunitsArrayMenDiver = []; 		// vehicleClass = "MenDiver";
//	MCC_MWunitsArrayMenRecon = []; 		// vehicleClass = "MenRecon";
//	MCC_MWunitsArrayMenSniper = []; 	// vehicleClass = "MenSniper";
//	MCC_MWunitsArrayMenSupport = []; 	// vehicleClass = "MenSupport";
//	MCC_MWunitsArrayMenStory = []; 		//  vehicleClass = "MenStory";
//
//	MCC_MWunitsArrayCar = []; 			// vehicleClass = "Car";
//	MCC_MWunitsArrayArmored = []; 		// vehicleClass = "Armored";
//	MCC_MWunitsArrayAir = []; 			// vehicleClass = "Air";
//	MCC_MWunitsArrayAutonomous = []; 	// vehicleClass = "Autonomous";
//	MCC_MWunitsArraySupport = []; 		// vehicleClass = "Support";
//
//	MCC_MWunitsArrayShip = []; 			// vehicleClass = "Ship";
//	MCC_MWunitsArraySubmarine = []; 	// vehicleClass = "Submarine";
//	MCC_MWunitsArrayStatic = []; 		// vehicleClass = "Static";
//========================================================================================================================================================================================
private ["_CfgVehicles","_type","_i","_CfgVehicle","_vehicleClass","_simulation","_simTypesUnits","_faction"];
		 
_faction = mcc_faction;
if (isNil "_faction") exitWith {}; 
_simTypesUnits 	= ["soldier", "car","carx", "motorcycle", "tank", "helicopter", "airplane", "ship", "parachute","helicopterX","shipx","shipX","tankX","submarinex","airplanex"];   
_CfgVehicles 		= configFile >> "CfgVehicles" ;

MCC_MWunitsArrayMen = [];			//vehicleClass = "Men";
MCC_MWunitsArrayMenDiver = []; 		// vehicleClass = "MenDiver";
MCC_MWunitsArrayMenRecon = []; 		// vehicleClass = "MenRecon";
MCC_MWunitsArrayMenSniper = []; 	// vehicleClass = "MenSniper";
MCC_MWunitsArrayMenSupport = []; 	// vehicleClass = "MenSupport";
MCC_MWunitsArrayMenStory = []; 		//  vehicleClass = "MenStory";

MCC_MWunitsArrayCar = []; 			// vehicleClass = "Car";
MCC_MWunitsArrayArmored = []; 		// vehicleClass = "Armored";
MCC_MWunitsArrayAir = []; 			// vehicleClass = "Air";
MCC_MWunitsArrayAutonomous = []; 	// vehicleClass = "Autonomous";
MCC_MWunitsArraySupport = []; 		// vehicleClass = "Support";

MCC_MWunitsArrayShip = []; 			// vehicleClass = "Ship";
MCC_MWunitsArraySubmarine = []; 	// vehicleClass = "Submarine";
MCC_MWunitsArrayStatic = []; 		// vehicleClass = "Static";


for "_i" from 0 to (count _CfgVehicles - 1) do 
{
	_CfgVehicle = _CfgVehicles select _i;
	if (isclass _CfgVehicle) then
	{
		//Keep going when it is a public entry
		if ((getNumber(_CfgVehicle >> "scope") == 2)) then 
		{
			_vehicleDisplayName 	= getText(_CfgVehicle >> "displayname");
			_cfgclass 				= (configName (_CfgVehicle));  
			_cfgFaction 			= getText(_CfgVehicle >> "faction");
			_simulation 			= getText(_CfgVehicle >> "simulation");
			_vehicleDisplayName		= [_vehicleDisplayName, gettext(_CfgVehicle >> "picture")];
			_vehicleclass			= getText(_CfgVehicle >> "vehicleclass");

			if (_simulation in _simTypesUnits) then 
			{
				if (toUpper(_cfgFaction) == toUpper _faction) then 
				{
					if (_vehicleclass in ["Men","MenDiver","MenRecon","MenSniper","MenSupport","MenStory","Car","Armored","Air","Autonomous","Support","Ship","Submarine","Static"]) then
					{
						switch (toLower(_vehicleclass)) do 
						{
							case "men"		: 	{
													_type="LAND";
													MCC_MWunitsArrayMen set[count MCC_MWunitsArrayMen,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};
											  
							case "mendiver"	: 	{
													_type="WATER";
													MCC_MWunitsArrayMenDiver set[count MCC_MWunitsArrayMenDiver,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};
											  
							case "menrecon"	: 	{
													_type="LAND";
													MCC_MWunitsArrayMenRecon set[count MCC_MWunitsArrayMenRecon,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};
											  
							case "mensniper": 	{
													_type="LAND";
													MCC_MWunitsArrayMenSniper set[count MCC_MWunitsArrayMenSniper,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};
											  
							case "mensupport": 	{
													_type="LAND";
													MCC_MWunitsArrayMenSupport set[count MCC_MWunitsArrayMenSupport,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};
											  
							case "car"		: 	{
													_type="LAND";
													MCC_MWunitsArrayCar set[count MCC_MWunitsArrayCar,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};	
											  
							case "armored"	: 	{
													_type="LAND";
													MCC_MWunitsArrayArmored set[count MCC_MWunitsArrayArmored,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};
											  
							case "support"		: 	{
													_type="LAND";
													MCC_MWunitsArraySupport set[count MCC_MWunitsArraySupport,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};	

							case "air"		: 	{
													_type="AIR";
													MCC_MWunitsArrayAir set[count MCC_MWunitsArrayAir,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};

							case "ship"		: 	{
													_type="WATER";
													MCC_MWunitsArrayShip set[count MCC_MWunitsArrayShip,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};	
							
							case "submarine"	: 	{
													_type="WATER";
													MCC_MWunitsArraySubmarine set[count MCC_MWunitsArraySubmarine,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};
												
							case "static"	: 	{
													_type="LAND";
													MCC_MWunitsArrayStatic set[count MCC_MWunitsArrayStatic,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
												};
						
						}; 
					}
					else
					{
						switch (toLower(_simulation)) do 
						{
							case "soldier": 
							{
								_type="LAND";
								MCC_MWunitsArrayMen set[count MCC_MWunitsArrayMen,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
												  
							case "car":
							{
								_type="LAND";
								MCC_MWunitsArrayCar set[count MCC_MWunitsArrayCar,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
							
							case "carx":
							{
								_type="LAND";
								MCC_MWunitsArrayCar set[count MCC_MWunitsArrayCar,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
							case "motorcycle":
							{
								_type="LAND";
								MCC_MWunitsArrayCar set[count MCC_MWunitsArrayCar,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
							case "tank":
							{
								_type="LAND";
								MCC_MWunitsArrayArmored set[count MCC_MWunitsArrayArmored,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
							};
							case "tankx":
							{
								_type="LAND";
								MCC_MWunitsArrayArmored set[count MCC_MWunitsArrayArmored,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];									
							};
							case "helicopter":
							{
								_type="AIR";
								MCC_MWunitsArrayAir set[count MCC_MWunitsArrayAir,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
							case "helicopterx":
							{
								_type="AIR";
								MCC_MWunitsArrayAir set[count MCC_MWunitsArrayAir,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
							case "airplane":
							{
								_type="AIR";
								MCC_MWunitsArrayAir set[count MCC_MWunitsArrayAir,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
							case "airplanex":
							{
								_type="AIR";
								MCC_MWunitsArrayAir set[count MCC_MWunitsArrayAir,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
							case "ship":
							{
								_type="WATER";
								MCC_MWunitsArrayShip set[count MCC_MWunitsArrayShip,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
							case "shipx":
							{
								_type="WATER";
								MCC_MWunitsArrayShip set[count MCC_MWunitsArrayShip,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
							case "submarinex":
							{
								_type="WATER";
								MCC_MWunitsArraySubmarine set[count MCC_MWunitsArraySubmarine,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
							};
						};
					};
				};
			};
		};
	};
};

publicvariableserver "MCC_MWunitsArrayMen"; 
publicvariableserver "MCC_MWunitsArrayMenDiver"; 
publicvariableserver "MCC_MWunitsArrayMenRecon"; 
publicvariableserver "MCC_MWunitsArrayMenSniper"; 
publicvariableserver "MCC_MWunitsArrayMenSupport"; 
publicvariableserver "MCC_MWunitsArrayCar"; 
publicvariableserver "MCC_MWunitsArrayArmored"; 
publicvariableserver "MCC_MWunitsArrayAir"; 
publicvariableserver "MCC_MWunitsArraySupport"; 
publicvariableserver "MCC_MWunitsArrayShip"; 
publicvariableserver "MCC_MWunitsArraySubmarine"; 
publicvariableserver "MCC_MWunitsArrayStatic"; 

true	
		
