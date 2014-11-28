//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_posX","_posY","_shellspread"];
disableSerialization;
 
_params = _this select 0;
_ctrl = _params select 0;

MCCGroupGenDispPosXY = _ctrl ctrlmapscreentoworld [_params select 1,_params select 2];



//Artillery
if (missionNameSpace getVariable ["MCC_artilleryEnabled",false]) exitWith
{
		deleteMarkerLocal "mcc_arty";
		_shellspread = if (shellspread == 0) then
						{
							[MCCshellRadius,MCCshellRadius]
						}
						else
						{
							[shellspread,shellspread]
						}; 
		createMarkerLocal ["mcc_arty", MCCGroupGenDispPosXY];
		"mcc_arty" setMarkerShapeLocal "ELLIPSE";
		"mcc_arty" setMarkerSizeLocal _shellspread;
		"mcc_arty" setMarkerColorLocal "ColorRed";
		"mcc_arty" setMarkerBrushLocal "SOLID";			
};

//Group/Unit spawn
if (missionNameSpace getVariable ["MCC_spawnEnabled",false]) exitWith
{
		createMarkerLocal ["mcc_spawnMarker", MCCGroupGenDispPosXY];
		"mcc_spawnMarker" setMarkerTypeLocal "KIA";
		"mcc_spawnMarker" setMarkerSizeLocal [0.5,0.5];
		"mcc_spawnMarker" setMarkerColorLocal "ColorRed";
		deleteMarkerLocal "mcc_spawnMarker";
};