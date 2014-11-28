//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params", "_ctrl", "_pressed", "_posX", "_posY", "_shift", "_ctrlKey", "_alt", "_eib_marker","_pointB","_nearObjectsA","_nearObjectsB"];
disableSerialization;
 
_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;
_posX = _params select 2; 
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;

if (mcc_missionmaker == (name player)) then
{
	MCC_GroupGenMouseButtonDown = false;	//Mouse state
	MCC_GroupGenMouseButtonUp = true;
	
	//Clear some markers
	if (_pressed == 1 && ((missionNameSpace getVariable ["MCC_artilleryEnabled",false]) || (missionNameSpace getVariable ["MCC_spawnEnabled",false])) && (str MCC_XYmap == format ["[%1,%2]",_posX,_posY])) then
	{
		missionNameSpace setVariable ["MCC_artilleryEnabled",false];
		deleteMarkerLocal "mcc_arty";
		
		missionNameSpace setVariable ["MCC_spawnEnabled",false];
		deleteMarkerLocal "mcc_spawnMarker";
	};
		
	if (MCC_ambushPlacing && _pressed!=1) exitWith //Ambush group placing
	{
		MCC_pointB = _ctrl ctrlmapscreentoworld [_posX,_posY];
		IEDDir = [MCC_pointA,MCC_pointB] call BIS_fnc_dirTo;
		
		if (MCC_capture_state) then
		{
			hint "Ambush Captured."; 
			MCC_capture_var = MCC_capture_var 
					+ FORMAT ["[[%1 , '%2' , '%3', %4, %5, %6, %7, %8],'MCC_fnc_ambushSingle',true,false] call BIS_fnc_MP;", MCC_pointA, IEDAmbushspawnname, mcc_sidename, IedName, IEDDir, MCC_pointB, MCC_IEDisSpotter, iedside];
		} 
		else 
		{
			hint "Ambush Placed."; 
			[[MCC_pointA , IEDAmbushspawnname,mcc_sidename, IedName, IEDDir, MCC_pointB, MCC_IEDisSpotter, iedside],"MCC_fnc_ambushSingle",false,false] call BIS_fnc_MP;
		};
		
		MCC_ambushPlacing = false; 							
	};
	
	if (_shift && _pressed!=1) exitWith //Sync with shift key
	{
		MCC_pointB = _ctrl ctrlmapscreentoworld [_posX,_posY];
		_nearObjectsA = MCC_pointA nearObjects [MCC_dummy,50];
		_nearObjectsB = MCC_pointB nearObjects [MCC_dummy,50];
		
		if (count _nearObjectsA > 0 && count _nearObjectsB > 0) then
		{
			[[MCC_pointA , MCC_pointB],"MCC_fnc_iedSync",true,false] call BIS_fnc_MP;
		};
	};
};