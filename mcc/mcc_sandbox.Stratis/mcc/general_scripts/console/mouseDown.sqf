//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_pressed","_posX","_posY","_shift","_ctrlKey","_alt","_marker","_markerPos","_markerDir","_spawn","_away","_ammount"];
disableSerialization;
 
_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;
_posX = _params select 2; 
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;

MCC_ConsoleMouseButtonDown = true;	//Mouse state
MCC_ConsoleMouseButtonUp = false;
	

if (MCC_CASrequestMarker && _pressed==0) then //CAS Request
	{
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;	//Drow it first
		sleep 0.25; 
		
		while {MCC_ConsoleMouseButtonDown} do {														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCConsoleDispPosXY,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;
			sleep 0.25;  
			}; 
			
		// set plane spawn and away position
		_markerPos 	= getmarkerpos _marker;
		_markerDir 	= markerDir _marker;
		_spawn 		= [_markerPos,4500,(_markerDir -180)] call BIS_fnc_relpos;
		_away 		= [_markerPos,4500,_markerDir] call BIS_fnc_relpos;
		_ammount	=  floor (((getMarkerSize _marker) select 1)/50) + 1; 		//Ammount of drop min 0 max 6
		
		hint "Air support incomming."; 
		[[_ammount, MCC_spawnkind , getmarkerpos _marker, MCC_planeType, _spawn,_away],"MCC_fnc_airDrop",true,false] spawn BIS_fnc_MP;
						
		MCC_CASrequestMarker = false;			//Wait and delete the marker
		sleep 40;
		deletemarkerlocal _marker;
	};