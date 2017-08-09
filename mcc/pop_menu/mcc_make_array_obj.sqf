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

	switch (toLower _vehicleclass) do		//Which unit do we want
	{
		case "fortifications":
		{
			_type="LAND";
			U_FORT set[_u_Fortifications_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_Fortifications_idx = _u_Fortifications_idx+1;
		};

		case "dead_bodies":
		{
			_type="LAND";
			U_DEAD_BODIES set[_u_Dead_bodies_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_Dead_bodies_idx = _u_Dead_bodies_idx+1;
		};

		case "furniture":
		{
			_type="LAND";
			U_FURNITURE set[_u_furniture_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_furniture_idx = _u_furniture_idx+1;
		};

		case "market":
		{
			_type="LAND";
			U_MARKET set[_u_market_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_market_idx = _u_market_idx+1;
		};

		case "cargo":
		{
			_type="LAND";
			U_MISC set[_u_misc_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_misc_idx = _u_misc_idx+1;
		};

		case "signs":
		{
			_type="LAND";
			U_SIGHNS set[_u_sighns_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_sighns_idx = _u_sighns_idx+1;
		};

		case "flag":
		{
			_type="LAND";
			U_FLAGS set[_u_flags_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_flags_idx = _u_flags_idx+1;
		};

		case "military":
		{
			_type="LAND";
			U_MILITARY set[_u_military_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_military_idx = _u_military_idx+1;
		};

		case "wreck":
		{
			_type="LAND";
			U_WRECKS set[_u_wrecks_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_wrecks_idx = _u_wrecks_idx+1;
		};

		case "wreck_sub":
		{
			_type="LAND";
			U_WRECKS set[_u_wrecks_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_wrecks_idx = _u_wrecks_idx+1;
		};

		case "submerged":
		{
			_type="LAND";
			U_SUBMERGED set[_u_submerged_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_submerged_idx = _u_submerged_idx+1;
		};

		case "tents":
		{
			_type="LAND";
			U_TENTS set[_u_ruins_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_ruins_idx = _u_ruins_idx+1;
		};

		case "garbage":
		{
			_type="LAND";
			U_GARBAGE set[_u_garbage_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_garbage_idx = _u_garbage_idx+1;
		};

		case "lamps":
		{
			_type="LAND";
			U_LAMPS set[_u_lamp_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_lamp_idx = _u_lamp_idx+1;
		};

		case "container":
		{
			_type="LAND";
			U_CONTAINER set[_u_container_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_container_idx = _u_container_idx+1;
		};

		case "small_items":
		{
			_type="LAND";
			U_SMALL_ITEMS set[_u_smallItems_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_smallItems_idx = _u_smallItems_idx+1;
		};

		case "structures":
		{
			_type="LAND";
			U_STRUCTERS set[_u_ssructers_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_ssructers_idx = _u_ssructers_idx+1;
		};

		case "helpers":
		{
			_type="LAND";
			U_HELPERS set[_u_helpers_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_helpers_idx = _u_helpers_idx+1;
		};

		case "training":
		{
			_type="LAND";
			U_TRAINING set[_u_training_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_training_idx = _u_training_idx+1;
		};

		case "mines":
		{
			_type="LAND";
			U_MINES set[_u_mines_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_mines_idx = _u_mines_idx+1;
		};

		case "backpacks":
		{
			_type="LAND";
			W_RUCKS set[_ruck_index,[_cfgclass,_vehicleDisplayName select 0,_vehicleDisplayName select 1]];
			O_BACKPACKS set [count O_BACKPACKS,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_ruck_index = _ruck_index + 1;
		};

		case "animals":
		{
			_type="LAND";
			U_ANIMALS set[_u_animals_idx,[_type,_cfgclass,_faction,_vehicleDisplayName]];
			_u_animals_idx = _u_animals_idx + 1;
		};

		case "structures_transport":
		{
			_type="LAND";
			S_AIRPORT set[count S_AIRPORT,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "structures_military":
		{
			_type="LAND";
			S_MILITARY set[count S_MILITARY,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "structures_military":
		{
			_type="LAND";
			S_CULTURAL set[count S_CULTURAL,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "structures_walls":
		{
			_type="LAND";
			S_WALLS set[count S_WALLS,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "structures_infrastructure":
		{
			_type="LAND";
			S_INFRAS set[count S_INFRAS,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "structures_commercial":
		{
			_type="LAND";
			S_COMMERSIAL set[count S_COMMERSIAL,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "structures_industrial":
		{
			_type="LAND";
			S_INDUSTRIAL set[count S_INDUSTRIAL,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "structures_town":
		{
			_type="LAND";
			S_TOWN set[count S_TOWN,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "structures_village":
		{
			_type="LAND";
			S_VILLAGE set[count S_VILLAGE,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "structures_fences":
		{
			_type="LAND";
			S_FENCES set[count S_FENCES,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "intel":
		{
			_type="LAND";
			O_INTEL set[count O_INTEL,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "items":
		{
			_type="LAND";
			O_ITEMS set[count O_ITEMS,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "itemsheadgear":
		{
			_type="LAND";
			O_HEADGEAR set[count O_HEADGEAR,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "itemsuniforms":
		{
			_type="LAND";
			O_UNIFORMS set[count O_UNIFORMS,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "itemsvests":
		{
			_type="LAND";
			O_VESTS set[count O_VESTS,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "weaponaccessories":
		{
			_type="LAND";
			O_WEAPONSACCES set[count O_WEAPONSACCES,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "weaponshandguns":
		{
			_type="LAND";
			O_WEAPONSHANDGUNS set[count O_WEAPONSHANDGUNS,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "weaponsprimary":
		{
			_type="LAND";
			O_WEAPONSPRIMARY set[count O_WEAPONSPRIMARY,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "weaponssecondary":
		{
			_type="LAND";
			O_WEAPONSSECONDARY set[count O_WEAPONSSECONDARY,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "respawn":
		{
			_type="LAND";
			O_RESPWN set[count O_RESPWN,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};

		case "sounds":
		{
			_type="LAND";
			O_SOUNDS set[count O_SOUNDS,[_type,_cfgclass,_faction,_vehicleDisplayName]];
		};
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


