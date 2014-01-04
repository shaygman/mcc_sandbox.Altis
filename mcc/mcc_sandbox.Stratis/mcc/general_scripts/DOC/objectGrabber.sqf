scriptName "objectGrabber.sqf";
/*
	File: objectGrabber.sqf
	Author: Joris-Jan van 't Land

	Description:
	Converts a set of placed objects to an object array for the DynO mapper.
	Places this information in the debug output for processing.

	Parameter(s):
	_this select 0: position of the anchor point
	_this select 1: size of the covered area
	
	Returns:
	Success flag (Boolean)
	
	init:
	null = [getpos this,200] execvm "objectGrabber.sqf";
*/

//Validate parameter count
if ((count _this) < 2) exitWith {diag_log "Log: [objectGrabber] Function requires at least 2 parameter!"; false};

private ["_anchorPos", "_anchorDim"];
_anchorPos = _this select 0;
_anchorDim = _this select 1;

//Validate parameters
if ((typeName _anchorPos) != (typeName [])) exitWith {diag_log "Log: [objectGrabber] Anchor position (0) must be an Array!"; false};
if ((typeName _anchorDim) != (typeName 0)) exitWith {diag_log "Log: [objectGrabber] Covered area size (1) must be an Number!"; false};

private ["_objs"];
_objs = nearestObjects [_anchorPos, ["All"], _anchorDim];

diag_log "#####################################";
diag_log "### Log: objectGrabber: StartGrabbing";
diag_log "#####################################";

for "_i" from 0 to ((count _objs) - 1) do
{
  private ["_obj", "_type"];
	_obj = _objs select _i;

	_type = typeOf _obj;

	//Exclude human objects.
	private ["_sim"];
	_sim = getText (configFile >> "CfgVehicles" >> _type >> "simulation");
	if !(_sim in ["soldier"]) then
	{
		private ["_objPos", "_dX", "_dY", "_z", "_azimuth", "_fuel", "_damage", "_vehicleinit"];
		_objPos = position _obj;
		_dX = (_objPos select 0) - (_anchorPos select 0);
		_dY = (_objPos select 1) - (_anchorPos select 1);
		_z = _objPos select 2;
		_azimuth = direction _obj;
		_fuel = fuel _obj;
		_damage = damage _obj;
		_vehicleinit = if (isnil {_obj getvariable "vehicleinit"}) then {{}} else {_obj getvariable "vehicleinit";};
		// _obj setvariable ["vehicleInit",_vehicleInit];

		diag_log text(format ["%1,", [_type, [_dX, _dY, _z], _azimuth, _fuel, _damage, _vehicleinit]]);
	};
};
diag_log "###################################";
diag_log "### Log: objectGrabber: EndGrabbing";
diag_log "###################################";

true