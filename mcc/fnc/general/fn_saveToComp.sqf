//===================================================================MCC_fnc_saveToComp=========================================================================================
// Save MCC's 3D editor placments in a composition's format to clipboard and RPT file
// Example: [] call MCC_fnc_saveToComp
// Params:
// 	<_anchorPos = referance position>
// Returns:
//     <Nothing>
//==============================================================================================================================================================================	
 private ["_obj","_type","_mission","_objPos", "_dX", "_dY", "_z", "_azimuth", "_fuel", "_damage", "_vehicleinit","_sim","_anchorPos","_br","_start"];
 
_anchorPos = _this select 0;
_br = toString [0x0D, 0x0A];
_start = true; 

diag_log "###########################################";
diag_log "# Log: MCC_fnc_saveToComp : StartGrabbing #";
diag_log "###########################################";

_mission = "[" + _br; 

diag_log text "[";
{
	if (typeName _x == "ARRAY") then	//Vehicle
	{
		_obj = _x select 0; 
	}
	else
	{
		_obj = _x; 
	};
	

	_type = typeOf _obj;
     
	//Exclude human objects.
	_sim = getText (configFile >> "CfgVehicles" >> _type >> "simulation");
	if (!(_sim in ["soldier"]) && (_obj distance _anchorPos < 200)) then
	{
		_objPos = position _obj;
		_dX = (_objPos select 0) - (_anchorPos select 0);
		_dY = (_objPos select 1) - (_anchorPos select 1);
		_z = _objPos select 2;
		_azimuth = direction _obj;
		_fuel = fuel _obj;
		_damage = damage _obj;
		_vehicleinit = if (isnil {_obj getvariable "vehicleinit"}) then {{}} else {_obj getvariable "vehicleinit";};
		if (_start) then
		{
			diag_log text(format ["    %1", [_type, [_dX, _dY, _z], _azimuth, _fuel, _damage, _vehicleinit]]);
			_mission = _mission + (format ["    %1", [_type, [_dX, _dY, _z], _azimuth, _fuel, _damage, _vehicleinit]]) + _br;
			_start = false; 
		}
		else
		{
			diag_log text(format ["    ,%1", [_type, [_dX, _dY, _z], _azimuth, _fuel, _damage, _vehicleinit]]);
			_mission = _mission + (format ["    ,%1", [_type, [_dX, _dY, _z], _azimuth, _fuel, _damage, _vehicleinit]]) + _br;
		};
	};
} foreach MCC_lastSpawn; 

_mission = _mission + "]";

diag_log text "];";

diag_log "###########################################";
diag_log "# Log: MCC_fnc_saveToComp : EndGrabbing   #";
diag_log "###########################################";

copyToClipboard _mission;
systemchat "Objects saved to clipboard and droped to rpt file in a composition's format";
_mission;