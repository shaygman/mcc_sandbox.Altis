#define MCCDELETEBRUSH 1030

//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_pressed","_posX","_posY","_shift","_ctrlKey","_alt","_nearObjects"];
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
MCC_mouseButtonDown = true;	//Mouse state
MCC_mouseButtonUp = false; 

if (_ctrlKey && _pressed!=1) then //Manually detonate IED
	{
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];
		_nearObjects = MCC_pointA nearObjects ["Bomb",40];
		{_x setvariable ["iedTrigered", true, true]} forEach _nearObjects;
	};
	
if (MCC_ambushPlacing && _pressed!=1) then //Sync IED and ambush group
	{
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];
	};
if (_shift && _pressed!=1) then //Sync with shift key
	{
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];
	};
if (MCC_CASrequestMarker && _pressed==0) then //CAS Request
	{
		private ["_marker","_markerPos","_markerDir","_spawn","_away","_ammount"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;	//Drow it first
		sleep 0.25; 
		
		while {MCC_mouseButtonDown} do {														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCDispPosXY,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;
			sleep 0.25;  
			}; 
			
		// set plane spawn and away position
		_markerPos 	= getmarkerpos _marker;
		_markerDir 	= markerDir _marker;
		_spawn 		= [_markerPos,2500,(_markerDir -180)] call BIS_fnc_relpos;
		_away 		= [_markerPos,2500,_markerDir] call BIS_fnc_relpos;
		_ammount	=  floor (((getMarkerSize _marker) select 1)/50) + 1; 		//Ammount of drop min 0 max 6
		
		if (MCC_capture_state) then	{
			hint "Air support captured."; 
			MCC_capture_var=MCC_capture_var + FORMAT ['
				[[%1, %2 , %3, %4, %5, %6],"MCC_fnc_airDrop",true,false] spawn BIS_fnc_MP;
				'	
				,_ammount
				,MCC_spawnkind
				,getmarkerpos _marker
				,MCC_planeType
				,_spawn
				,_away];
			} else 	{
				hint "Air support incomming."; 
				[[_ammount, MCC_spawnkind , getmarkerpos _marker, MCC_planeType, _spawn,_away],"MCC_fnc_airDrop",true,false] spawn BIS_fnc_MP;
				};
				
		MCC_CASrequestMarker = false;			//Wait and delete the marker
		sleep 40;
		deletemarkerlocal _marker;
	};

if (MCC_UMParadropRequestMarker && _pressed==0) then //UM Paradrop Request
	{
		private ["_marker","_markerPos","_markerDir","_spawn","_away","_ammount"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;	//Drow it first
		sleep 0.25; 
		
		while {MCC_mouseButtonDown} do {														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCDispPosXY,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;
			sleep 0.25;  
			}; 
			
		// set plane spawn and away position
		_markerPos 	= getmarkerpos _marker;
		_markerDir 	= markerDir _marker;
		_spawn 		= [_markerPos,4500,(_markerDir -180)] call BIS_fnc_relpos;
		_away 		= [_markerPos,4500,_markerDir] call BIS_fnc_relpos;
				
		['paradrop', [ getmarkerpos _marker, MCC_selectedUnits, MCC_UMUnit, MCC_UMparadropIsHalo,_spawn,_away]] call CBA_fnc_globalEvent;
										
		MCC_UMParadropRequestMarker = false;			//Wait and delete the marker
		sleep 40;
		deletemarkerlocal _marker;
	};
	
if (MCC_zone_drawing && _pressed==0) then //Zone drawing
	{
	private private ["_marker","_size","_pos","_null"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,"RECTANGLE","ColorYellow","SOLID"] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		while {MCC_mouseButtonDown} do {														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCDispPosXY,1,"RECTANGLE","ColorYellow","SOLID"] call MCC_fnc_drawBox;
			sleep 0.1;  
			};
		_size = getMarkerSize _marker;
		_pos = getMarkerPos  _marker;
		deletemarkerlocal _marker;	
		MCC_zone_drawing = false; 
		_null = [1,_pos,_size] execVM MCC_path + "mcc\pop_menu\zones.sqf";
	};
	
if (MCC_brush_drawing && _pressed==0) then //Brush Drawing
	{
	private ["_marker","_size","_pos"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,Mshape,Mcolor,Mbrush] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		while {MCC_mouseButtonDown} do {														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCDispPosXY,1,Mshape,Mcolor,Mbrush] call MCC_fnc_drawBox;
			sleep 0.1;  
			};
		_size = getMarkerSize _marker;
		_pos = getMarkerPos  _marker;
		if (!isnil "_marker") then {deletemarkerlocal _marker};	
		MCC_brush_drawing = false; 
		[Mcase, Mcolor, _size, Mshape, Mbrush, Mtype, Mtext, _pos] call MCC_fnc_makeMarker;
	};

		
if (MCC_drawTriggers && _pressed==0) then //Triggerd drawing
	{
	private ["_marker","_size","_pos"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,Mshape,Mcolor,Mtype] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		while {MCC_mouseButtonDown} do {														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCDispPosXY,1,Mshape,Mcolor,Mtype] call MCC_fnc_drawBox;
			sleep 0.1;  
			};
		_size = getMarkerSize _marker;
		_pos = getMarkerPos  _marker;
		deletemarkerlocal _marker;	
		MCC_drawTriggers = false; 
		nul=[1,_pos,_size] execVM MCC_path + 'mcc\general_scripts\triggers\triggers.sqf';
	};
	
if (MCC_drawMinefield && _pressed==0) then //Minefield drawing
	{
	private ["_marker","_size","_pos"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,Mshape,Mcolor,Mtype] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		while {MCC_mouseButtonDown} do {														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCDispPosXY,1,Mshape,Mcolor,Mtype] call MCC_fnc_drawBox;
			sleep 0.1;  
			};
		MCC_drawBoxZoneSize = getMarkerSize _marker;
		MCC_drawBoxZonePos = getMarkerPos  _marker;
		deletemarkerlocal _marker;	
		MCC_drawMinefield = false; 
	};
	
if (MCC_delete_drawing && _pressed==0) then //Delete Drawing
	{
	private ["_marker","_size","_pos","_type"];
		_type	= lbCurSel MCCDELETEBRUSH;
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the box
		_marker = [MCC_pointA,MCC_pointA,1,"ELLIPSE","colorRed","SOLID"] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		while {MCC_mouseButtonDown} do {														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA,MCCDispPosXY,1,"ELLIPSE","colorRed","SOLID"] call MCC_fnc_drawBox;
			sleep 0.1;  
			};
		_size = getMarkerSize _marker;
		_pos = getMarkerPos  _marker;
		deletemarkerlocal _marker;	
		MCC_delete_drawing = false; 
		
		mcc_safe=mcc_safe + FORMAT ['
								[[%1, %2 select 0, %3],"MCC_fnc_deleteBrush",true,false] spawn BIS_fnc_MP;
								sleep 1;'								 
								, _pos
								, _size
								, _type
								];
		[[_pos, _size select 0, _type],"MCC_fnc_deleteBrush",true,false] spawn BIS_fnc_MP;
	};
};