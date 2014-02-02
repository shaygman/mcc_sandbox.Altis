//==================================================================MCC_fnc_makeUnitsArray===============================================================================================
// returns a unit array consist of all the units from the given function and simulation in format [_cfgclass,_vehicleDisplayName]
// Example:_unitsArray	= [_faction ,_sim,_classType] call MCC_fnc_makeUnitsArray;
// faction = string, the faction to search in: "CIV" , "USMC", "INS", "CDF", "RU", "GUE" exc
// _sim = string, simulation type: "soldier", "car", "motorcycle", "tank", "helicopter", "airplane", "ship", "parachute"
// _classType = string, class type "men","car","ship","sumarine"
//==================================================================================================================================================================================
private ["_CfgVehicles","_i","_CfgVehicle","_simulation","_simTypesUnits","_idx","_faction",
"_vehicleDisplayName","_cfgclass","_cfgFaction","_unitsArray","_vehicleClass","_classType"];

_faction			= (toLower(_this select 0));
_simTypesUnits		= (toLower(_this select 1));
_classType			= if (count _this > 2) then {toLower (_this select 2)} else {""}; 

_idx      			= 0;
_CfgVehicles 		= configFile >> "CfgVehicles";
_unitsArray			=[];

for "_i" from 1 to (count _CfgVehicles - 1) do 
{
	_CfgVehicle = _CfgVehicles select _i;
	//Keep going when it is a public entry
	if (getNumber(_CfgVehicle >> "scope") == 2) then 
	{
		_vehicleDisplayName 	= getText(_CfgVehicle >> "displayname");
		_vehicleDisplayName		= [_vehicleDisplayName, gettext(_CfgVehicle >> "picture")];
		_cfgclass 				= (configName (_CfgVehicle));  
		_cfgFaction 			= getText(_CfgVehicle >> "faction");
		_simulation 			= getText(_CfgVehicle >> "simulation");
		_vehicleClass			= getText(_CfgVehicle >> "vehicleClass");
		  
		if (toLower(_cfgFaction) == _faction) then 
		{
			if (toLower(_simulation)== _simTypesUnits) then 
				{
					if ((toLower(_vehicleClass) == _classType) || (_classType == "")) then 
						{
							_unitsArray set[_idx,[_cfgclass,_vehicleDisplayName]];									
							_idx = _idx + 1;
						};
				};
		};
	};
};
_unitsArray
