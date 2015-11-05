//==================================================================GAIA_fnc_getUnitTypeAmounts=================================================================================
// Count the number of infantry, vehicles, tank, air, ships in a group expand
// Example: [_group1] call MCC_fnc_countGroup;
// _group1 = group, the group name
//===========================================================================================================================================================================
private ["_group","_infantryCount","_CarCount","_tankCount","_airCount","_shipCount","_CarClass",
		 "_SoldierCargo","_tankClass","_airClass","_boatClass","_vehicleClass","_reconCount","_supportClass","_supportCount","_autonomousCount","_autonomousClass"
		 ,"_staticCount","_staticClass","_submarineCount","_submarineClass","_TurretWeapons","_simType","_vehicleX","_typeVehicleX"];

_units 			= _this select 0;
_infantryCount 	= 0;
_reconCount		= 0;
_mortarCount	=0;

_CarCount		= 0;
_tankCount		= 0;
_supportCount	= 0;
_airCount		= 0;
_shipCount		= 0;
_artilleryCount = 0;
_AACount 		= 0;
_autonomousCount = 0;
_staticCount 	= 0;
_submarineCount = 0 ;
_CargoCount		=0;





_tempVehicles	= [];
_CarClass		= [];
_tankClass		= [];
_artilleryClass = [];
_AAClass = [];
_supportClass = [];
_airClass = [];
_boatClass = [];
_autonomousClass = [];
_staticClass =[];
_mortarClass =[];
_submarineClass = [];
_UnitAssets	= [];
_at	=false;
_aa	=false;
_art  =false;

if (isNil "_units") exitWith {
	[_infantryCount,_CarCount,_tankCount,_artilleryCount,_airCount,_shipCount,_reconCount,_supportCount,_autonomousCount,_staticCount,_submarineCount,_AACOUNT,_CargoCount,_mortarCount,[_CarClass,_tankClass,_artilleryClass,_airClass,_boatClass,_supportClass,_autonomousClass,_AAClass,_mortarClass],[_at,_aa]];
};

{
	if (alive _x) then {

		_vehicleX = vehicle _x;
		_typeVehicleX = typeof _vehicleX;

		_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> _typeVehicleX >> "vehicleClass"));
		if (_vehicleX != _x) then {
			if (!(_vehicleX in _tempVehicles) and !(_x in (assignedCargo _vehicleX))) then {

				_tempVehicles set [count _tempVehicles, vehicle _x];
				_SoldierCargo  = getNumber  (configFile >> "CfgVehicles" >> _typeVehicleX >> "transportSoldier");
				_simType = tolower (getText  (configFile >> "CfgVehicles" >> _typeVehicleX >> "simulation"));
				_CargoCount 	 = _CargoCount + _SoldierCargo;
				_TurretWeapons = (_typeVehicleX) call GAIA_fnc_getTurretWeapons;

				_at		=false;_aa		=false;_art  =false;
				_UnitAssets = [_vehicleX] call GAIA_fnc_getUnitAssets;
				if (_UnitAssets select 0) then {_at 	= true};
				if (_UnitAssets select 2) then {_aa 	= true};
				if (_UnitAssets select 3) then {_art 	= true};

				switch (true) do {
					//Car
				    case (_vehicleClass == "car"): {
				    	_CarCount = _CarCount + 1;
						_CarClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
				    };

				    //Armor
				    case (_vehicleClass == "armored"): {
				    	//Artillery
				    	if (_art) then {
							_artilleryCount = _artilleryCount + 1;
							_artilleryClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
						} else {
							//AA
							if (_aa) then {
								_AACount = _AACount + 1;
								_AAClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
							} else {
								_tankCount = _tankCount + 1;
								_tankClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
							};
						};
				    };

				    //Support
				    case (_vehicleClass == "support"): {
				    	_supportCount = _supportCount + 1;
						_supportClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
				    };

				    //Support
				    case (_vehicleClass == "static" and !_art): {
				    	_staticCount = _staticCount + 1;
						_staticClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
				    };

				    //Support
				    case (_vehicleClass == "static" and _art): {
				    	_mortarCount = _mortarCount + 1;
						_mortarClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
				    };

				    //Air
				    case (_vehicleClass == "air"): {
				    	_airCount = _airCount + 1;
						_airClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
				    };

				    //Ship
				    case (_vehicleClass == "ship"): {
				    	_shipCount = _shipCount + 1;
						_boatClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
				    };

				    //submarine
				    case (_vehicleClass == "submarine"): {
				    	_submarineCount = _submarineCount + 1;
						_submarineClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
				    };

				    //autonomous
				    case (_vehicleClass == "autonomous"): {
				    	_autonomousCount = _autonomousCount + 1;
						_autonomousClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
				    };

				    //======================If we got here then the vehicleClass is uselss let's go primitive=====================================
					case (_simType in ["tank","tankx"]):	{
						_tankCount = _tankCount + 1;
						_tankClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
					};

					case (_simType in ["helicopter","helicopterx","airplane","airplanex","helicopterrtd"]):	{
						_airCount = _airCount + 1;
						_airClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
					};

					case (_simType in ["ship","shipx"]):	{
						_shipCount = _shipCount + 1;
						_boatClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
					};

					case (_simType in ["submarinex"]):	{
						_submarineCount = _submarineCount + 1;
						_submarineClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
					};

				    default {
				    	//(_simType in ["car","carx","motorcycle"])
				    	_CarCount = _CarCount + 1;
						_CarClass pushBack [_typeVehicleX,_SoldierCargo,count(_TurretWeapons)];
				    };
				};
			};
		} else {
			_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> typeof ( _x) >> "vehicleClass"));

			_at		=false;_aa		=false;_art  =false;
			_UnitAssets = [vehicle _x] call GAIA_fnc_getUnitAssets;
				if (_UnitAssets select 0) then {_at 	= true};
				if (_UnitAssets select 2) then {_aa 	= true};
				if (_UnitAssets select 3) then {_art 	= true};

			if (
						(format["%1", (assignedVehicleRole _x)]=="[]")
						or
						(format["%1", (assignedVehicleRole _x)]=='["Cargo"]')
				 )
			then {

				if (_vehicleClass == "men" || _vehicleClass == "menstory"  || _vehicleClass == "mensupport") then {_infantryCount = _infantryCount + 1};
				if (_vehicleClass == "mendiver" || _vehicleClass == "menrecon" || _vehicleClass == "mensniper") then {_reconCount = _reconCount + 1};
			};

		};
	};
} foreach _units;

[_infantryCount,_CarCount,_tankCount,_artilleryCount,_airCount,_shipCount,_reconCount,_supportCount,_autonomousCount,_staticCount,_submarineCount,_AACOUNT,_CargoCount,_MortarCount,[_CarClass,_tankClass,_artilleryClass,_airClass,_boatClass,_supportClass,_autonomousClass,_AAClass,_MortarClass],[_at,_aa]];

