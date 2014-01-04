private 
["_CfgVehicles",  "_type",  "_i",  "_CfgVehicle",   "_vehicleClass","_vehicleDisplayName","_cfgclass","_faction","_u_Fortifications_idx","_u_Dead_bodies_idx","_u_furniture_idx"
	,"_u_market_idx","_u_misc_idx","_u_sighns_idx","_u_warfare_idx","_u_wrecks_idx", "_u_submerged_idx", "_u_ruins_idx","_u_military_idx","_u_flags_idx"
	,"_u_garbage_idx","_vehiclesclass","_u_lamp_idx","_u_smallItems_idx","_u_container_idx","_u_helpers_idx","_u_training_idx","_u_mines_idx"];

_u_Fortifications_idx		= 0;	
_u_Dead_bodies_idx			= 0;	
_u_furniture_idx			= 0;	
_u_market_idx				= 0;
_u_misc_idx					= 0;
_u_sighns_idx				= 0;
_u_warfare_idx				= 0;
_u_military_idx				= 0;
_u_wrecks_idx				= 0;
_u_submerged_idx			= 0;
_u_ruins_idx				= 0;
_u_ace_ammo_idx				= 0;
_u_garbage_idx				= 0;
_u_lamp_idx					= 0;
_u_container_idx			= 0;
_u_smallItems_idx			= 0;
_u_ssructers_idx			= 0;
_u_helpers_idx				= 0;
_u_training_idx				= 0;
_ruck_index					= 0;
_u_mines_idx				= 0;
_u_flags_idx				= 0;
_u_animals_idx				= 0;
_faction = "CIV"; 

_CfgVehicles 		= configFile >> "CfgVehicles" ;
for "_i" from 1 to (count _CfgVehicles - 1) do
	{
	_CfgVehicle 			= _CfgVehicles select _i;
	 if ((getNumber(_CfgVehicle >> "scope") == 2) || (getNumber(_CfgVehicle >> "scope") == 1)) then {
		_vehicleDisplayName 	= getText(_CfgVehicle >> "displayname");
		_cfgclass 				= (configName (_CfgVehicle));  
		_vehicleclass			= getText(_CfgVehicle >> "vehicleClass");
		_vehiclesclass			= getText(_CfgVehicle >> "vehiclesClass");
		_vehicleDisplayName		= [_vehicleDisplayName, gettext(_CfgVehicle >> "picture")];
			
		if ((toLower(_vehicleclass) == "fortifications")) then
			{
				_type="LAND";
				U_FORT set[_u_Fortifications_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_Fortifications_idx = _u_Fortifications_idx+1;
			};

		if (toLower(_vehicleclass) == "dead_bodies")then
			{
				_type="LAND";
				U_DEAD_BODIES set[_u_Dead_bodies_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_Dead_bodies_idx = _u_Dead_bodies_idx+1;
			};

		if (toLower(_vehicleclass) == "furniture")then
			{
				_type="LAND";
				U_FURNITURE set[_u_furniture_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_furniture_idx = _u_furniture_idx+1;
			};
		
		if (toLower(_vehicleclass) == "market")then
			{
				_type="LAND";
				U_MARKET set[_u_market_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_market_idx = _u_market_idx+1;
			};
		
		if (toLower(_vehicleclass) == "cargo")then
			{
				_type="LAND";
				U_MISC set[_u_misc_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_misc_idx = _u_misc_idx+1;
			};
			
		if (toLower(_vehicleclass) == "signs")then
			{
				_type="LAND";
				U_SIGHNS set[_u_sighns_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_sighns_idx = _u_sighns_idx+1;
			};
			
		if (toLower(_vehicleclass) == "flag")then
			{
				_type="LAND";
				U_FLAGS set[_u_flags_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_flags_idx = _u_flags_idx+1;
			};
			
		if (toLower(_vehicleclass) == "military")then
			{
				_type="LAND";
				U_MILITARY set[_u_military_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_military_idx = _u_military_idx+1;
			};
			
		if ((toLower(_vehicleclass) == "wreck") || (toLower(_vehicleclass) == "wreck_sub"))then
			{
				_type="LAND";
				U_WRECKS set[_u_wrecks_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_wrecks_idx = _u_wrecks_idx+1;
			};
		
		if (toLower(_vehicleclass) == "submerged")then 
			{
				_type="LAND";
				U_SUBMERGED set[_u_submerged_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_submerged_idx = _u_submerged_idx+1;
			};
			
		if (toLower(_vehicleclass) == "tents")then
			{
				_type="LAND";
				U_TENTS set[_u_ruins_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_ruins_idx = _u_ruins_idx+1;
			};
		if (toLower(_vehicleclass) == "garbage")then
			{
				_type="LAND";
				U_GARBAGE set[_u_garbage_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_garbage_idx = _u_garbage_idx+1;
			};
		if (toLower(_vehicleclass) == "lamps")then
			{
				_type="LAND";
				U_LAMPS set[_u_lamp_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_lamp_idx = _u_lamp_idx+1;
			};
		if (toLower(_vehicleclass) == "container")then
			{
				_type="LAND";
				U_CONTAINER set[_u_container_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_container_idx = _u_container_idx+1;
			};
		if (toLower(_vehicleclass) == "small_items")then
			{
				_type="LAND";
				U_SMALL_ITEMS set[_u_smallItems_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_smallItems_idx = _u_smallItems_idx+1;
			};
		if (toLower(_vehicleclass) == "structures")then
			{
				_type="LAND";
				U_STRUCTERS set[_u_ssructers_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_ssructers_idx = _u_ssructers_idx+1;
			};
		if (toLower(_vehicleclass) == "helpers")then
			{
				_type="LAND";
				U_HELPERS set[_u_helpers_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_helpers_idx = _u_helpers_idx+1;
			};
		if (toLower(_vehicleclass) == "training")then
			{
				_type="LAND";
				U_TRAINING set[_u_training_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_training_idx = _u_training_idx+1;
			};
		if (toLower(_vehicleclass) == "mines")then
			{
				_type="LAND";
				U_MINES set[_u_mines_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_mines_idx = _u_mines_idx+1;
			};
		if (toLower(_vehicleclass) == "backpacks")then
			{
				W_RUCKS set[_ruck_index,[_cfgclass,_vehicleDisplayName select 0,_vehicleDisplayName select 1]];
				_ruck_index = _ruck_index + 1;
			};
		if (toLower(_vehicleclass) == "animals")then
			{
				U_ANIMALS set[_u_animals_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
				_u_animals_idx = _u_animals_idx + 1;
			};
			
			//For separate menu for ACE stuff, problems with the length when combined into single menu, I think.
		if (toLower(_vehicleclass) == "ace_ammunition" || toLower(_vehicleclass) == "ace_ammunitiontransportus" || toLower(_vehicleclass) == "ace_ammunitiontransportru"
			|| toLower(_vehicleclass) == "ace_ammunition_rope" || toLower(_vehicleclass) == "ace_objects" ||  toLower(_vehicleclass) == "ace_ammunition_csw" 
			||  toLower(_vehicleclass) == "ace_ammunitiontransportcsw" ||  toLower(_vehicleclass) == "ace_ammunition_rope" ||  toLower(_vehicleclass) == "ace_arty_ammunition"
			||  toLower(_vehicleclass) == "ace_arty_equipment")then
			{
				_type="LAND";
				U_ACE_AMMO set[_u_ace_ammo_idx,[_type,_cfgclass,mcc_sidename,_vehicleDisplayName]];
				_u_ace_ammo_idx = _u_ace_ammo_idx+1;
			};
		};
	};
	

