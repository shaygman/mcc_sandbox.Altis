//===================================================================MCC_fnc_evacDelete======================================================================================
// Delete the given vehicle or it's driver
// Example:[[option, evac],"MCC_fnc_evacDelete",true,false] spawn BIS_fnc_MP;
// Params:
// 	option number, 0- delete driver, 1 - spawn driver, 2- delete vehicle, driver and gunners.
// 	evac: object, the evac vehicle
//==============================================================================================================================================================================
private ["_option","_evac","_heliType","_evac_p","_evac_p_type"];
_option	= [_this, 0, 0, [0]] call BIS_fnc_param;
_evac	= [_this, 1, objNull, [objNull]] call BIS_fnc_param;

if (isnull _evac || !isServer) exitWith {};

_heliType		= typeof _evac;
_evac_p 		= driver _evac;
_evac_p_type 	= getText (configFile >> "CfgVehicles" >> _heliType >> "crew");

switch (_option) do {
		case 0:		//Delete pilot
	{
		if (isnil "_evac_p") exitWith {};
		_evac_p action ["getOut", vehicle _evac_p];
		sleep 2;
		deletegroup (group _evac);	//case we want to delete the pilot
		deletevehicle _evac_p;
	};
	case 1:
	{
	_evac_p = (group _evac) createUnit [_evac_p_type, getpos _evac, [], 0, "NONE"];		//spawn pilot
	_evac_p assignAsDriver _evac;
	_evac_p moveindriver _evac;
	};
	case 2:
	{
		{deleteVehicle _x} forEach (crew _evac);
		deletegroup (group _evac);	//case we want to delete the whole shabang
		deletevehicle _evac;
		deletevehicle _evac_p;
	};
};
