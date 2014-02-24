//==================================================================MCC_fnc_countGroup===============================================================================================
// Count the number of infantry, vehicles, tank, air, ships in a group expand
// Example: [_group1] call MCC_fnc_countGroup;
// _group1 = group, the group name
//===========================================================================================================================================================================	
private ["_group","_infantryCount","_CarCount","_tankCount","_airCount","_shipCount","_CarClass",
		 "_SoldierCargo","_tankClass","_airClass","_boatClass","_vehicleClass","_reconCount","_supportClass","_supportCount","_autonomousCount","_autonomousClass"
		 ,"_staticCount","_staticClass","_submarineCount","_submarineClass","_TurretWeapons"];

_units 			= _this select 0; 
_infantryCount 	= 0;
_reconCount		= 0;
_mortarCount	=0;

_CarCount	= 0;
_tankCount		= 0;
_supportCount	= 0;
_airCount		= 0;
_shipCount		= 0;
_artilleryCount = 0;
_AACount = 0;
_autonomousCount = 0;
_staticCount = 0;
_submarineCount = 0 ;
_CargoCount			=0;
_MortarCount			=0;





_tempVehicles	= [];
_CarClass		= []; 
_tankClass		= []; 
_artilleryClass = []; 
_AAClass = []; 
_supportClass		= [];
_airClass			= []; 
_boatClass		= []; 
_autonomousClass	= [];
_staticClass =[];
_mortarClass =[];
_submarineClass = [];
_UnitAssets			= [];
_at		=false;
_aa		=false;
_art  =false;

if (! isnil "_units") then {
	
		{
			if (alive _x) then
			{
			
					
					_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> typeof (assignedVehicle _x) >> "vehicleClass")); 
					if ((assignedVehicle _x) != _x) then 
					{
						if (!((assignedVehicle _x) in _tempVehicles) and !(_x in (assignedCargo assignedVehicle _x))) then {
							
							_tempVehicles set [count _tempVehicles, vehicle _x];
							_SoldierCargo  = getNumber  (configFile >> "CfgVehicles" >> typeof (assignedVehicle _x) >> "transportSoldier"); 
							_CargoCount 	 = _CargoCount + _SoldierCargo;
							_TurretWeapons = (typeof (assignedVehicle _x)) call fnc_GetTurretsWeapons;
							
							_at		=false;_aa		=false;_art  =false;
							_UnitAssets = [assignedVehicle _x] call fnc_AnalyseUnit;
							if (_UnitAssets select 0) then {_at 	= true};
							if (_UnitAssets select 2) then {_aa 	= true};
							if (_UnitAssets select 3) then {_art 	= true};
							
							if (_vehicleClass == "car") then 
								{
									_CarCount = _CarCount + 1;
									_CarClass set [count _CarClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
								};
							if (_vehicleClass == "armored") then 
								{
									if (_art) then
									{
										_artilleryCount = _artilleryCount + 1;
										_artilleryClass set [count _artilleryClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
									}
									else
									{
									if (_aa) then
										{
										_AACount = _AACount + 1;
										_AAClass set [count _AAClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
										}	
									else	
										{
										_tankCount = _tankCount + 1;
										_tankClass set [count _tankClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
										};
									};
								};
								
							if (_vehicleClass == "support" ) then 									//support
								{
									_supportCount = _supportCount + 1;
									_supportClass set [count _supportClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
								};
								
							if (_vehicleClass == "static" and !_art ) then 									//support
								{
									_staticCount = _staticCount + 1;
									_staticClass set [count _staticClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
								};
								
						 if (_vehicleClass == "static" and _art ) then 									//support
								{
									_MortarCount = _staticCount + 1;
									_MortarClass set [count _MortarClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
								};
			
							if (_vehicleClass == "air") then 
								{
									_airCount = _airCount + 1;
									_airClass set [count _airClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
								};
							if (_vehicleClass == "ship") then
								{
									_shipCount = _shipCount + 1;
									_boatClass set [count _boatClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
								};
							if (_vehicleClass == "submarine") then
								{
									_submarineCount = _submarineCount + 1;
									_submarineClass set [count _submarineClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]];
								};
							if (_vehicleClass == "autonomous") then 											//atunomos
								{
									_autonomousCount = _autonomousCount + 1;
									_autonomousClass set [count _autonomousClass,[typeof(assignedVehicle _x),_SoldierCargo,count(_TurretWeapons)]]; 
								};
							};
						}; 
						_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> typeof ( _x) >> "vehicleClass"));
									
						_at		=false;_aa		=false;_art  =false;
						_UnitAssets = [vehicle _x] call fnc_Analyseunit;
							if (_UnitAssets select 0) then {_at 	= true};
							if (_UnitAssets select 2) then {_aa 	= true};
							if (_UnitAssets select 3) then {_art 	= true};
							
						if (
									(format["%1", (assignedVehicleRole _x)]=="[]") 
									or
									(format["%1", (assignedVehicleRole _x)]=='["Cargo"]') 
							 )
						then
						{
			
			
							if (_vehicleClass == "men" || _vehicleClass == "menstory"  || _vehicleClass == "mensupport") then {_infantryCount = _infantryCount + 1}; 
							if (_vehicleClass == "mendiver" || _vehicleClass == "menrecon" || _vehicleClass == "mensniper") then {_reconCount = _reconCount + 1};
						};
			
			};		
		} foreach _units; 
	
	[_infantryCount,_CarCount,_tankCount,_artilleryCount,_airCount,_shipCount,_reconCount,_supportCount,_autonomousCount,_staticCount,_submarineCount,_AACOUNT,_CargoCount,_MortarCount,[_CarClass,_tankClass,_artilleryClass,_airClass,_boatClass,_supportClass,_autonomousClass,_AAClass,_MortarClass],[_at,_aa]];
};
