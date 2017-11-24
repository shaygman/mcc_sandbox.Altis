//==================================================================MCC_fnc_countGroup===============================================================================================
// Count the number of infantry, vehicles, tank, air, ships in a group expand
// Example: [_group1] call MCC_fnc_countGroup;
// _group1 = group, the group name
//===========================================================================================================================================================================
private ["_group","_infantryCount","_CarCount","_tankCount","_airCount","_shipCount","_CarClass","_class","_SoldierCargo","_tankClass","_airClass","_boatClass","_vehicleClass","_reconCount","_supportClass","_supportCount","_autonomousCount","_autonomousClass"
		 ,"_staticCount","_staticClass","_submarineCount","_submarineClass","_TurretWeapons"];

_units 			=  param [0,[],[[]]];
_infantryCount 	= 0;
_reconCount		= 0;
_mortarCount	= 0;

_CarCount		= 0;
_tankCount		= 0;
_supportCount	= 0;
_airCount		= 0;
_shipCount		= 0;
_artilleryCount = 0;
_AACount 		= 0;
_autonomousCount= 0;
_staticCount 	= 0;
_submarineCount = 0 ;
_CargoCount		= 0;
_MortarCount	= 0;
_SoldierCargo	= 0;
_armor 			= 0;



_tempVehicles		= [];
_CarClass			= [];
_tankClass			= [];
_artilleryClass 	= [];
_AAClass 			= [];
_supportClass		= [];
_airClass			= [];
_boatClass			= [];
_autonomousClass	= [];
_staticClass 		= [];
_mortarClass 		= [];
_submarineClass 	= [];
_UnitAssets			= [];
_TurretWeapons      = [];
_at					=false;
_aa					=false;
_art  				=false;
_atCount			=0;
_AaCount			=0;
_ArtCount			=0;


{
	if (alive _x) then {
			_class = typeof (vehicle _x);
			_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> _class >> "vehicleClass"));
			_SoldierCargo  = getNumber  (configFile >> "CfgVehicles" >> _class >> "transportSoldier");
			_simulation	= toLower (getText (configfile >> "CfgVehicles" >> _class  >> "simulation"));
			_armor	= getNumber  (configFile >> "CfgVehicles" >> _class >> "armor");
			
			

			if ((vehicle _x) != _x) then {

				if (!((vehicle _x) in _tempVehicles) and !(_x in (assignedCargo vehicle _x))) then {

					_tempVehicles pushBack (vehicle _x);
					
					//Add Armor points
					_armor=_Armor + _armor;
					
					//check his guns
					{
					
					if ( 
					    !(["Horn", _x, true] call BIS_fnc_inString)
					     and
						!(["Smoke", _x, true] call BIS_fnc_inString)
						and 
						!(["Flare", _x, true] call BIS_fnc_inString)
						and 
						!(["SEARCHLIGHT", _x, true] call BIS_fnc_inString)
						)
                     then 
					 {_TurretWeapons = _TurretWeapons + [_x]};
					    
					   
					} foreach weapons vehicle _x;

					_UnitAssets = [vehicle _x] call GAIA_fnc_getUnitAssets;
					_at = (_UnitAssets select 0);
					_aa = (_UnitAssets select 2);
					_art = (_UnitAssets select 3);
					
					//how many we got
					if (_at) then {_atCount=_atCount+1;};
					if (_aa) then {_aaCount=_aaCount+1;};
					if (_art) then {_artCount=_artCount+1;};
					switch (toLower _vehicleClass) do
					{
						case "car":
						{
							_CarCount = _CarCount + 1;
							_CarClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
						};

						case "armored":
						{
							if (_art) then {
								_artilleryCount = _artilleryCount + 1;
								_artilleryClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
							} else {
								if (_aa) then {
									_AACount = _AACount + 1;
									_AAClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
								} else {
									_tankCount = _tankCount + 1;
									_tankClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
								};
							};
						};

						case "support":
						{
							_supportCount = _supportCount + 1;
							_supportClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
						};

						case "static":
						{
							if (_art) then {
								_MortarCount = _staticCount + 1;
								_MortarClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
							} else {
								if (_aa) then {
									_AACount = _AACount + 1;
									_AAClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
								} else {
									_staticCount = _staticCount + 1;
									_staticClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
								};
							};
						};

						case "air":
						{
							_airCount = _airCount + 1;
							_airClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
						};

						case "ship":
						{
							_shipCount = _shipCount + 1;
							_boatClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
						};

						case "submarine":
						{
							_submarineCount = _submarineCount + 1;
							_submarineClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
						};

						case "autonomous":
						{
							_autonomousCount = _autonomousCount + 1;
							_autonomousClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
						};

						default
						{
							/* BRUTE FORCE IF NO CLASS */
							switch (true) do
							{
								case (_simulation in ["car","carx","motorcycle","motorcyclex"]):
								{
									_CarCount = _CarCount + 1;
									_CarClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
								};

								case (_simulation in ["tank","tankx"]):
								{
									if (_art) then {
										_artilleryCount = _artilleryCount + 1;
										_artilleryClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
									} else {
										if (_aa) then {
											_AACount = _AACount + 1;
											_AAClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
										} else {
											_tankCount = _tankCount + 1;
											_tankClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
										};
									};
								};

								case (_simulation in ["helicopter","helicopterx","helicopterrtd","airplane","airplanex"]):
								{
									_airCount = _airCount + 1;
									_airClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
								};

								case (_simulation in ["ship","shipx"]):
								{
									_shipCount = _shipCount + 1;
									_boatClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
								};

								case (_simulation in ["submarine","submarinex"]):
								{
									_submarineCount = _submarineCount + 1;
									_submarineClass pushBack [_class,_SoldierCargo,count(_TurretWeapons)];
								};
							};
						};
					};
				};
		};

		_at	= false;
		_aa	= false;
		_art = false;

		_UnitAssets = [vehicle _x] call GAIA_fnc_getUnitAssets;
			if (_UnitAssets select 0) then {_at = true};
			if (_UnitAssets select 2) then {_aa = true};
			if (_UnitAssets select 3) then {_art = true};
			if (_at) then {_atCount=_atCount+1;};
			if (_aa) then {_aaCount=_aaCount+1;};
			if (_art) then {_artCount=_artCount+1;};

		if (
					(format["%1", (assignedVehicleRole _x)]=="[]")
					or
					(format["%1", (assignedVehicleRole _x)]=='["Cargo"]')
			 )
		then {
			if (_vehicleClass == "mendiver" || _vehicleClass == "menrecon" || _vehicleClass == "mensniper") then {
				_reconCount = _reconCount + 1
			} else {
				if (_simulation == "soldier") then {
					_infantryCount = _infantryCount + 1
				};
			};
			//Add Armor points
			_armor=_Armor + _armor;
		};

	};
} foreach _units;

[_infantryCount,_CarCount,_tankCount,_artilleryCount,_airCount,_shipCount,_reconCount,_supportCount,_autonomousCount,_staticCount,_submarineCount,_AACOUNT,_SoldierCargo,_MortarCount,[_CarClass,_tankClass,_artilleryClass,_airClass,_boatClass,_supportClass,_autonomousClass,_AAClass,_MortarClass],_armor,_atCount,_aaCount,_ArtCount];

