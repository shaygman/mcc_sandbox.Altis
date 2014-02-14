private ["_Cfgside","_i","_j","_Cfgfaction","_k","_Cfgtype","_cfgname","_factionDisplayName","_CfgfactionName","_groupName","_groupDisplayname","_CfgGroup","_cfgentry"];
if (isNil "mcc_faction") exitWith {}; 
//Create the groups type array
#define CONFIG (configFile >> "CfgGroups" )
MCC_groupTypes = []; 
MCC_MWGroupArrayMen = [];			//vehicleClass = "Men";
MCC_MWGroupArrayMenDiver = []; 		// vehicleClass = "MenDiver";
MCC_MWGroupArrayMenRecon = []; 		// vehicleClass = "MenRecon";
MCC_MWGroupArrayMenSniper = []; 	// vehicleClass = "MenSniper";
MCC_MWGroupArrayMenSupport = []; 	// vehicleClass = "MenSupport";
MCC_MWGroupArrayMenStory = []; 		//  vehicleClass = "MenStory";

MCC_MWGroupArrayCar = []; 			// vehicleClass = "Car";
MCC_MWGroupArrayArmored = []; 		// vehicleClass = "Armored";
MCC_MWGroupArrayAir = []; 			// vehicleClass = "Air";
MCC_MWGroupArrayAutonomous = []; 	// vehicleClass = "Autonomous";
MCC_MWGroupArraySupport = []; 		// vehicleClass = "Support";

MCC_MWGroupArrayShip = []; 			// vehicleClass = "Ship";
MCC_MWGroupArraySubmarine = []; 	// vehicleClass = "Submarine";
MCC_MWGroupArrayStatic = []; 		// vehicleClass = "Static";

_factionDisplayName = getText (configFile >> "CfgFactionClasses" >> MCC_faction >> "displayName");

for "_i" from 0 to ((count CONFIG) - 1)  do
{
_Cfgside = (CONFIG select _i);  
if (isClass(_cfgside)) then
	{
	for "_j" from 0 to ((count _Cfgside) - 1) do
		{
		_Cfgfaction 	= (_cfgside select _j); 
		if (isClass(_cfgfaction)) then
			{
			_CfgfactionName	= getText (_cfgfaction >> "name");
			if ((_CfgfactionName == _factionDisplayName) || (configname(configFile >> "CfgFactionClasses" >> MCC_faction) == configname(_cfgfaction))) then 
				{
				for "_k" from 0 to ((count _Cfgfaction) - 1) do
					{
					_Cfgtype = (_cfgfaction select _k); 
					if (isClass(_cfgtype)) then
						{
						_cfgname 		= configname(_cfgtype );
						_cfgDisplayname = getText (_Cfgtype >> "name");
						MCC_groupTypes set [count MCC_groupTypes, [_cfgname,_cfgDisplayname]]; 
						for "_l" from 0 to ((count _cfgtype) - 1) do //Let's divide the groups
							{
							_CfgGroup = (_cfgtype select _l); 
							if (isClass(_CfgGroup)) then
								{
									_groupName 		  = configname(_CfgGroup );
									_groupDisplayname = getText (_CfgGroup >> "name");
									_cfgentry = format ["configFile >> ""CfgGroups"" >>""%1"">>""%2"">>""%3"">>""%4""",(configname (_Cfgside)),(configname (_Cfgfaction)),(configname (_Cfgtype)),(configname (_CfgGroup))];
									private ["_man","_diver","_recon","_sniper","_menSupport","_story","_car","_armored","_air","_extreme","_simulation",
											 "_autonomos","_carSuppory","_ship","_submarine","_static","_CfgUnit","_unitName","_unitClass","_count"];
									_man = 0;
									_diver = 0;
									_recon = 0;
									_sniper = 0;
									_menSupport = 0; 
									_story = 0;
									_car = 0;
									_armored = 0;
									_air = 0;
									_autonomos = 0;
									_carSuppory = 0;
									_ship = 0;
									_submarine = 0;
									_static = 0; 
									_count = 0; 
									for "_n" from 0 to ((count _CfgGroup) - 1) do	//Lets scan the units and see who is who
										{
										_CfgUnit = (_CfgGroup select _n); 
										if (isClass(_CfgUnit)) then
											{
												_unitName 	= getText (_CfgUnit >> "vehicle");
												_unitClass 	= getText (configfile >> "CfgVehicles" >> _unitName  >> "vehicleClass");
												_simulation	= getText (configfile >> "CfgVehicles" >> _unitName  >> "simulation");
												_count = _count + 1;
												//Search by vehicleClass
												if (_unitClass in ["Men","MenDiver","MenRecon","MenSniper","MenSupport","MenStory","Car","Armored","Air","Autonomous","Support","Ship","Submarine","Static"]) then 
												{
													switch (_unitClass) do
													{
														case "Men":		
														{
															_man = _man +1;
														};
														case "MenDiver":		
														{
															_diver = _diver +1;
														};
														case "MenRecon":		
														{
															_recon = _recon +1;
														};
														case "MenSniper":		
														{
															_sniper = _sniper +1;
														};
														case "MenSupport":		
														{
															_menSupport = _menSupport +1;
														};
														case "MenStory":		
														{
															_story = _story +1;
														};
														case "Car":		
														{
															_car = _car +1;
														};
														case "Armored":		
														{
															_armored = _armored +1;
														};
														case "Air":		
														{
															_air = _air +1;
														};
														case "Autonomous":		
														{
															_autonomos = _autonomos +1;
														};
														case "Support":		
														{
															_carSuppory = _carSuppory +1;
														};
														case "Ship":		
														{
															_ship = _ship +1;
														};
														case "Submarine":		
														{
															_submarine = _submarine +1;
														};
														case "Static":		
														{
															_static = _static +1;
														};
													};
												}
												else //no vehicleClass go to simulate
												{
													switch (toLower(_simulation)) do 
													{
														case "soldier": 
														{
															_man = _man +1;
														};
																			  
														case "car":
														{
															_car = _car +1;
														};
														
														case "carx":
														{
															_car = _car +1;
														};
														case "motorcycle":
														{
															_car = _car +1;
														};
														case "tank":
														{
															_armored = _armored +1;
														};
														case "tankx":
														{
															_armored = _armored +1;
														};
														case "helicopter":
														{
															_air = _air +1;
														};
														case "helicopterx":
														{
															_air = _air +1;
														};
														case "airplane":
														{
															_air = _air +1;
														};
														case "airplanex":
														{
															_air = _air +1;
														};
														case "ship":
														{
															_ship = _ship +1;
														};
														case "shipx":
														{
															_ship = _ship +1;
														};
														case "submarinex":
														{
															_submarine = _submarine +1;
														};
													};
												};
											};
										};
										
										//If we have a vehicle
										if (_static > 0) exitWith {MCC_MWGroupArrayStatic set [count MCC_MWGroupArrayStatic,[_groupName,_count,_cfgentry]]};
										if (_submarine > 0) exitWith {MCC_MWGroupArraySubmarine set [count MCC_MWGroupArraySubmarine,[_groupName,_count,_cfgentry]]};
										if (_ship > 0) exitWith {MCC_MWGroupArrayShip set [count MCC_MWGroupArrayShip,[_groupName,_count,_cfgentry]]};
										if (_carSuppory > 0) exitWith {MCC_MWGroupArraySupport set [count MCC_MWGroupArraySupport,[_groupName,_count,_cfgentry]]};
										if (_autonomos > 0) exitWith {MCC_MWGroupArrayAutonomous set [count MCC_MWGroupArrayAutonomous,[_groupName,_count,_cfgentry]]};
										if (_air > 0) exitWith {MCC_MWGroupArrayAir set [count MCC_MWGroupArrayAir,[_groupName,_count,_cfgentry]]};
										if (_armored > 0) exitWith {MCC_MWGroupArrayArmored set [count MCC_MWGroupArrayArmored,[_groupName,_count,_cfgentry]]};
										if (_car > 0) exitWith {MCC_MWGroupArrayCar set [count MCC_MWGroupArrayCar,[_groupName,_count,_cfgentry]]};
										
										//If we have men
										_extreme = [[_man,_diver,_recon,_sniper,_menSupport,_story],1] call BIS_fnc_findExtreme; 
										if (_extreme == _man) exitWith {MCC_MWGroupArrayMen set [count MCC_MWGroupArrayMen,[_groupName,_count,_cfgentry]]};
										if (_extreme == _diver) exitWith {MCC_MWGroupArrayMenDiver set [count MCC_MWGroupArrayMenDiver,[_groupName,_count,_cfgentry]]};
										if (_extreme == _recon) exitWith {MCC_MWGroupArrayMenRecon set [count MCC_MWGroupArrayMenRecon,[_groupName,_count,_cfgentry]]};
										if (_extreme == _sniper) exitWith {MCC_MWGroupArrayMenSniper set [count MCC_MWGroupArrayMenSniper,[_groupName,_count,_cfgentry]]};
										if (_extreme == _menSupport) exitWith {MCC_MWGroupArrayMenSupport set [count MCC_MWGroupArrayMenSupport,[_groupName,_count,_cfgentry]]};
										if (_extreme == _story) exitWith {MCC_MWGroupArrayMenStory set [count MCC_MWGroupArrayMenStory,[_groupName,_count,_cfgentry]]};
								};
							};
						};
					};
				};
			};
		};
	};
};

publicVariableServer "MCC_MWGroupArrayMen";
publicVariableServer "MCC_MWGroupArrayMenDiver";
publicVariableServer "MCC_MWGroupArrayMenRecon";
publicVariableServer "MCC_MWGroupArrayMenSniper";
publicVariableServer "MCC_MWGroupArrayMenSupport";
publicVariableServer "MCC_MWGroupArrayMenStory";
publicVariableServer "MCC_MWGroupArrayCar";
publicVariableServer "MCC_MWGroupArrayArmored";
publicVariableServer "MCC_MWGroupArrayAir";
publicVariableServer "MCC_MWGroupArraySupport";
publicVariableServer "MCC_MWGroupArrayShip";
publicVariableServer "MCC_MWGroupArraySubmarine";
publicVariableServer "MCC_MWGroupArrayStatic";

//Add this two for general stuff
MCC_groupTypes set [count MCC_groupTypes, ["Reinforcement","Reinforcement"]]; 
MCC_groupTypes set [count MCC_groupTypes, ["Garrison","Garrison"]]; 
MCC_groupTypes set [count MCC_groupTypes, ["Custom","Custom"]];

GEN_INFANTRY   		= [mcc_sidename,mcc_faction,(MCC_groupTypes select 0) select 0,"LAND"]   call mcc_make_array_grps;

// Create the units
// Load the different units into the arrays above
U_GEN_SHIP 			= [];
U_GEN_AIRPLANE		= [];
U_GEN_HELICOPTER 	= [];
U_GEN_TANK 			= [];
U_GEN_MOTORCYCLE	= [];
U_GEN_CAR			= [];
U_GEN_SOLDIER    	= [];

call mcc_make_array_units;

// Load DOC -> Dynamic Object Compositions

GEN_DOC1 = [];
GEN_DOC1 = [mcc_faction,0]  call mcc_make_array_comp;

if (!mcc_firstTime) then 
	{
	closeDialog 0;
	nul=[] execVM MCC_path + "mcc\Dialogs\mcc_PopupMenu.sqf";
	}
	else {mcc_firstTime=false}; //If it's not first time refresh the menu
