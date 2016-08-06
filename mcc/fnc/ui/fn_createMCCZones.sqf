//==================================================================MCC_fnc_createMCCZones===============================================================================================
//Create MCC zones local
// Example: [] call MCC_fnc_createMCCZones;
//==================================================================================================================================================================================
private ["_zone","_markerlabel"];

{
	_zone = createMarkerLocal [str _x, mcc_zone_pos select _x];
	_zone setMarkerShapeLocal "RECTANGLE";
	_zone setMarkerColorLocal "colorBlack";
	_zone setMarkerBrushLocal "Solid";
	_zone setMarkerAlphalocal 0.2;
	_zone setMarkerDirLocal (mcc_zone_dir select _x);
	_zone setMarkerSizeLocal (mcc_zone_size select _x);

	_markerlabel = createMarkerLocal [(format["LABEL_%1",_x]), mcc_zone_pos select _x];
	_markerlabel setMarkerShapeLocal "ICON";
	(format["LABEL_%1",_x]) setMarkerTypeLocal "mil_join";
	(format["LABEL_%1",_x]) setMarkerTextLocal str _x;
	(format["LABEL_%1",_x]) setMarkerColorLocal "ColorRed";
} foreach (missionNamespace getVariable ["MCC_zones_numbers",[]]);


