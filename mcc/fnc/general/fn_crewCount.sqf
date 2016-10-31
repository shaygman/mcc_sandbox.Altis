/*===================================================================MCC_fnc_crewCount=========================================================================================
return empty seats of a specific vehicle with or without FFV (firing From Vehicles)

<IN>
	0:	STRING: vehicle class
	1: 	STRING:
			cargo 		- 	Cargo ONLY
			crew 		-  	Crew Only
			ffv			-	FFV only
			allCargo	- 	Cargo + FFV
			allCrew		- 	Crew + Cargo + FFV

<OUT>
	INTEGER: number of spaces

==============================================================================================================================================================================*/
private ["_vehicleClass","_returnType","_cargo"];

_vehicleClass = param [0,"", [""]];
_returnType = tolower (param [1,"allCargo", [""]]);

if (_vehicleClass == "") exitWith {};

_cargo = getNumber (configfile >> "CfgVehicles" >> _vehicleClass >> "transportSoldier");
_crew = [_vehicleClass, false] call BIS_fnc_crewCount;
_allCrew = [_vehicleClass, true] call BIS_fnc_crewCount;
_allCargo = _allCrew - _crew;
_ffv = _allCargo - _cargo;


switch (_returnType) do
{
	case "cargo":{_cargo};
	case "crew":{_crew};
	case "ffv":{_ffv};
	case "allcargo":{_allCargo};
	default	{_allCrew};
};
