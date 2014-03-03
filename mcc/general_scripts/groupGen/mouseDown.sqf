//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_pressed","_posX","_posY","_shift","_ctrlKey","_alt","_marker","_markerPos","_markerDir","_spawn","_away","_ammount","_dir","_nearObjects"];

#define MCCDELETEBRUSH 1030

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
	MCC_GroupGenMouseButtonDown = true;	//Mouse state
	MCC_GroupGenMouseButtonUp = false;
	
	if (isnil "MCC_doubleClicked") then {MCC_doubleClicked =false};	
	
	//Close Group info control
	if ((_pressed == 0 || _pressed == 1)&& !MCC_doubleClicked) then 								
	{
		ctrlShow [510,false];
		ctrlShow [9013,false];
		hintsilent "";
	};		
	
	//Open 3D
	if ((_pressed == 0) && _alt)  exitWith 								
	{
		//worldPos
		MCC_ConsoleWPpos = _ctrl ctrlMapScreenToWorld [_posX,_posY];
		
		[0,MCC_ConsoleWPpos] execVM format ["%1mcc\pop_menu\spawn_group3d.sqf",MCC_path];
	};	
	
	//Box drawing select
	if (_pressed==0 && !MCC_ConsoleRuler && !MCC_doubleClicked && !MCC_zone_drawing && !MCC3DRuning && !MCC_CASrequestMarker && !MCC_brush_drawing && !MCC_drawTriggers
	    && !MCC_drawMinefield && !MCC_delete_drawing && !MCC_ambushPlacing && !MCC_UMParadropRequestMarker && !_shift) then 
	{
		private ["_marker","_markersize","_markerpos","_null","_markerposX","_markerposY","_markersize","_markersizeX","_markersizeY",
					 "_borderXleft","_borderXright","_borderYdown","_borderYtop","_group","_groupX","_groupY","_leader","_icon","_groupControl"];
		
		//Close WP dialog and hints
		ctrlShow [510,false];
		ctrlShow [9013,false];
		hintsilent "";
		
		//Start creating the box
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,"RECTANGLE","ColorGreen","Border"] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 

		while {MCC_GroupGenMouseButtonDown} do 
			{														//While mouse pressed
				deleteMarkerLocal _marker;
				_marker = [MCC_pointA, MCCGroupGenDispPosXY,1,"RECTANGLE","ColorGreen","Border"] call MCC_fnc_drawBox;
				sleep 0.1;  
			};
		_markersize = getMarkerSize _marker;
		_markerpos = markerpos  _marker;
		deletemarkerlocal _marker;	

		_markerposX = _markerpos select 0;
		_markerposY = _markerpos select 1;
		_markersizeX = abs(_markersize select 0);
		_markersizeY = abs(_markersize select 1);

		_borderXleft = _markerposX - _markersizeX;
		_borderXright = _markerposX + _markersizeX;
		_borderYdown = _markerposY - _markersizeY;
		_borderYtop = _markerposY + _markersizeY;
		if (isnil "MCC_GroupGenGroupSelected") then {MCC_GroupGenGroupSelected=[]};
		if (_markersizeX < 10 || _markersizeY<10) exitWith {}; 
		{_x removeGroupIcon (_x getvariable "MCCgroupIconDataSelected")} foreach MCC_GroupGenGroupSelected;
		
		MCC_GroupGenGroupSelected = [];
		{
			_groupControl = nil; 
			_leader = (leader _x);
			if ((side _leader in MCC_groupGenGroupStatus) && alive _leader && count (units _x)>0) then
			{
				_group = _x;

				//--- Check if group is assigned to local commander
				_groupX = (position _leader) select 0;
				_groupY = (position _leader) select 1;
				if (
					_groupX > _borderXleft && 
					_groupX < _borderXright &&
					_groupY > _borderYdown &&
					_groupY < _borderYtop
				) then 
				{
					MCC_GroupGenGroupSelected = MCC_GroupGenGroupSelected + [_group];
				};
			};
		} foreach allgroups;
		
		if (count MCC_GroupGenGroupSelected == 0) exitWith {};
		
		{
			_icon = _x addGroupIcon ["selector_selectedFriendly",[0,0]];
			_x setvariable ["MCCgroupIconDataSelected",_icon,false];
		} foreach MCC_GroupGenGroupSelected;
	};
	
	//Manually detonate IED
	if (_ctrlKey && _pressed!=1) then 
	{
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];
		_nearObjects = MCC_pointA nearObjects ["Bomb",40];
		{_x setvariable ["iedTrigered", true, true]} forEach _nearObjects;
	};
	
	//Sync IED and ambush group
	if (MCC_ambushPlacing && _pressed!=1) then 
	{
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];
	};
	
	//Sync with shift key
	if (_shift && _pressed!=1) then 
	{
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];
	};
	
	 //CAS Request
	if (MCC_CASrequestMarker && _pressed==0) then
	{
		private ["_marker","_markerPos","_markerDir","_spawn","_away","_ammount"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;	//Drow it first
		sleep 0.25; 
		
		while {MCC_GroupGenMouseButtonDown} do {														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCGroupGenDispPosXY,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;
			sleep 0.25;  
			}; 
			
		// set plane spawn and away position
		_markerPos 	= getmarkerpos _marker;
		_markerDir 	= markerDir _marker;
		_spawn 		= [_markerPos,2500,(_markerDir -180)] call BIS_fnc_relpos;
		_away 		= [_markerPos,2500,_markerDir] call BIS_fnc_relpos;
		_ammount	=  floor (((getMarkerSize _marker) select 1)/50) + 1; 		//Ammount of drop min 0 max 6
		
		if (MCC_capture_state) then	
		{
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
		} 
		else
		{
			hint "Air support incomming."; 
			[[_ammount, MCC_spawnkind , getmarkerpos _marker, MCC_planeType, _spawn,_away],"MCC_fnc_airDrop",true,false] spawn BIS_fnc_MP;
		};
				
		MCC_CASrequestMarker = false;			//Wait and delete the marker
		sleep 40;
		deletemarkerlocal _marker;
	};
	
	//UM Paradrop Request
	if (MCC_UMParadropRequestMarker && _pressed==0) then 
	{
		private ["_marker","_markerPos","_markerDir","_spawn","_away","_ammount"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;	//Drow it first
		sleep 0.25; 
		
		while {MCC_GroupGenMouseButtonDown} do 
		{														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCGroupGenDispPosXY,1,"mil_arrow",20,"ColorRed",300] call MCC_fnc_drawArrow;
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
	
	//Zone drawing
	if (MCC_zone_drawing && _pressed==0) then 
	{
		private private ["_marker","_size","_pos","_null"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,"RECTANGLE","ColorYellow","SOLID"] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		
		while {MCC_GroupGenMouseButtonDown} do
		{														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCGroupGenDispPosXY,1,"RECTANGLE","ColorYellow","SOLID"] call MCC_fnc_drawBox;
			sleep 0.1;  
		};
		
		_size = getMarkerSize _marker;
		_pos = getMarkerPos  _marker;
		deletemarkerlocal _marker;	
		MCC_zone_drawing = false; 
		_null = [1,_pos,_size] execVM MCC_path + "mcc\pop_menu\zones.sqf";
	};
	
	 //Brush Drawing
	if (MCC_brush_drawing && _pressed==0) then
	{
		private ["_marker","_size","_pos"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,Mshape,Mcolor,Mbrush] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		
		while {MCC_GroupGenMouseButtonDown} do 
		{														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCGroupGenDispPosXY,1,Mshape,Mcolor,Mbrush] call MCC_fnc_drawBox;
			sleep 0.1;  
		};
		
		_size = getMarkerSize _marker;
		_pos = getMarkerPos  _marker;
		if (!isnil "_marker") then {deletemarkerlocal _marker};	
		MCC_brush_drawing = false; 
		[[Mcase, Mcolor, _size, Mshape, Mbrush, Mtype, Mtext, _pos],"MCC_fnc_makeMarker",true,false] spawn BIS_fnc_MP;
	};

	//Triggerd drawing	
	if (MCC_drawTriggers && _pressed==0) then 
	{
		private ["_marker","_size","_pos"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,Mshape,Mcolor,Mtype] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		
		while {MCC_GroupGenMouseButtonDown} do 
		{														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCGroupGenDispPosXY,1,Mshape,Mcolor,Mtype] call MCC_fnc_drawBox;
			sleep 0.1;  
		};
		
		_size = getMarkerSize _marker;
		_pos = getMarkerPos  _marker;
		deletemarkerlocal _marker;	
		MCC_drawTriggers = false; 
		nul=[1,_pos,_size] execVM MCC_path + 'mcc\general_scripts\triggers\triggers.sqf';
	};
	
	 //Minefield drawing	
	if (MCC_drawMinefield && _pressed==0) then
	{
		private ["_marker","_size","_pos"];
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
		_marker = [MCC_pointA,MCC_pointA,1,Mshape,Mcolor,Mtype] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		
		while {MCC_GroupGenMouseButtonDown} do 
		{														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA, MCCGroupGenDispPosXY,1,Mshape,Mcolor,Mtype] call MCC_fnc_drawBox;
			sleep 0.1;  
		};
		
		MCC_drawBoxZoneSize = getMarkerSize _marker;
		MCC_drawBoxZonePos = getMarkerPos  _marker;
		deletemarkerlocal _marker;	
		MCC_drawMinefield = false; 
	};
	
	 //Delete Drawing
	if (MCC_delete_drawing && _pressed==0) then
	{
		private ["_marker","_size","_pos","_type"];
		_type	= lbCurSel MCCDELETEBRUSH;
		MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the box
		_marker = [MCC_pointA,MCC_pointA,1,"ELLIPSE","colorRed","SOLID"] call MCC_fnc_drawBox;	//Drow it first
		sleep 0.1; 
		
		while {MCC_GroupGenMouseButtonDown} do 
		{														//While mouse pressed
			deleteMarkerLocal _marker;
			_marker = [MCC_pointA,MCCGroupGenDispPosXY,1,"ELLIPSE","colorRed","SOLID"] call MCC_fnc_drawBox;
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