//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_pressed","_posX","_posY","_shift","_ctrlKey","_alt","_marker","_markerPos","_markerDir","_spawn","_away","_ammount","_dir","_nearObjects"];

#define MCCDELETEBRUSH 1030
#define MCCZONENUMBER 1023
#define MCC_MINIMAP 9000
#define MCC_GroupGenInfo_IDC 530

disableSerialization;
 
_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;
_posX = _params select 2; 
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;
MCC_XYmap = [_posX,_posY]; 

if (mcc_missionmaker == (name player)) then
{
	MCC_GroupGenMouseButtonDown = true;	//Mouse state
	MCC_GroupGenMouseButtonUp = false;
	
	if (isnil "MCC_doubleClicked") then {MCC_doubleClicked =false};	
	
	//Close Group info control
	if ((_pressed == 0 || _pressed == 1)&& !MCC_doubleClicked) then 								
	{
		ctrlShow [510,false];
		ctrlShow [MCC_GroupGenInfo_IDC,false];
		hintsilent "";
	};		
	
	//Open 3D
	if ((_pressed == 0) && _alt)  exitWith 								
	{
		//worldPos
		MCC_ConsoleWPpos = _ctrl ctrlMapScreenToWorld [_posX,_posY];
		
		[0,MCC_ConsoleWPpos] execVM format ["%1mcc\pop_menu\spawn_group3d.sqf",MCC_path];
	};	
	
	//Select zone 
	if (_pressed == 0) then
	{
		private ["_nearZone","_selectedPos","_newZone","_comboBox","_distance","_marker","_nearMarker","_markerName","_isIcon"];
		_selectedPos = _ctrl ctrlmapscreentoworld MCC_XYmap;
		_nearZone 	= false;
		_nearMarker	= false; 
		_distance = (ctrlMapScale ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl MCC_MINIMAP)) * 400;
		
		//Are we near a zone marker
		{
			if (!isnil "_x") then
			{
				if ((_selectedPos distance _x) < _distance) exitWith 
				{
					_nearZone = true;
					_newZone = _foreachIndex;
				};
			};
		} foreach mcc_zone_pos;
		
		//Are we near MCC marker
		{
			if ((_selectedPos distance (markerpos _x)) < _distance) exitWith 
			{
				_nearMarker = true;
				_markerName = _x;
			};
		} foreach MCC_activeMarkers;
		
		if ((_nearZone || _nearMarker) && !MCC_artilleryEnabled && !MCC_spawnEnabled && !MCC_ConsoleRuler && !MCC_doubleClicked && !MCC_zone_drawing && !MCC_CASrequestMarker && !MCC_brush_drawing && !MCC_drawTriggers
			&& !MCC_drawMinefield && !MCC_delete_drawing && !MCC_ambushPlacing && !MCC_UMParadropRequestMarker) exitWith
		{
				private ["_size","_pos","_center","_width","_hight"];
				if (_nearZone) then
				{
					//Change the combobox indicatior
					MCC_zone_index = _newZone -1;
					_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl MCCZONENUMBER); 
					_comboBox lbSetCurSel MCC_zone_index;
					
					sleep 0.3; 

					_markerName = str mcc_active_zone;
				};
				
				_isIcon = if (MarkerShape _markerName == "ICON") then {0} else {1}; 
				
				if (!MCC_GroupGenMouseButtonDown) exitWith {}; 
				_markerName setMarkerAlphalocal 1;
				
				//While mouse pressed
				while {MCC_GroupGenMouseButtonDown} do 
				{	
					//Moving the zone
					if (!_shift && !_ctrlKey) then
					{
						_markerName setMarkerposLocal MCCGroupGenDispPosXY;
						MCC_Marker_dir	= markerDir  _markerName;
					};
					
					//Resizing it
					if (_shift && (_isIcon != 0)) then
					{
						_center = (getMarkerpos _markerName);
						_width 	= abs ((MCCGroupGenDispPosXY select 1) - (_center select 1));  
						_hight 	= abs ((MCCGroupGenDispPosXY select 0) - (_center select 0)); 
						
						_markerName setMarkerSizeLocal [_hight,_width];
					};
					
					//Changing dir
					if (_ctrlKey) then
					{
						_center 		= (getMarkerpos _markerName);
						MCC_Marker_dir	= [_center, MCCGroupGenDispPosXY] call BIS_fnc_dirTo;
						_markerName setMarkerdirLocal MCC_Marker_dir;
					};
					sleep 0.1;  
				};
				
				_size = getMarkerSize _markerName;
				_pos = getMarkerPos  _markerName;
				
				sleep 0.2;
				
				mcc_isnewzone = false;
				mcc_grouptype = "";
				mcc_spawntype = "";
				mcc_classtype = "";
				mcc_spawnname = "";
				mcc_spawnfaction ="";
				mcc_resetmissionmaker = false;
					
				if (_nearZone) then
				{
					deletemarkerlocal _markerName;	
					_null = [2,_pos,_size] execVM MCC_path + "mcc\pop_menu\zones.sqf";
				}
				else
				{
					[_isIcon, getMarkerColor _markerName , _size, MarkerShape _markerName, MarkerBrush _markerName, MarkerType _markerName, _markerName, _pos, MCC_Marker_dir] call MCC_fnc_makeMarker;
				}; 
		};
	};
	
	//Artillery
	if (MCC_artilleryEnabled &&  _pressed == 0) exitWith
	{
		if (!_ctrlKey) then {MCC_artilleryEnabled = false}; 
		if (MCC_capture_state) then
		{
			hint "Artillery captured.";
			MCC_capture_var = MCC_capture_var + FORMAT ["
			[[%1, '%2', %3, %4, %5, %6],'MCC_fnc_artillery',true,false] spawn BIS_fnc_MP;
			"
			,_ctrl ctrlMapScreenToWorld [_posX,_posY]
			,shelltype
			,shellspread
			,nshell
			,MCCSimulate
			,MCC_artyDelay
			];
		}	
		else
		{
			hint "Artillery inbound.";
			[[_ctrl ctrlMapScreenToWorld [_posX,_posY], shelltype, shellspread, nshell,MCCSimulate,MCC_artyDelay],'MCC_fnc_artillery',true,false] spawn BIS_fnc_MP;								
		};
		sleep 0.5;
		deleteMarkerLocal "mcc_arty";
	};
	
	//Spawn
	if (MCC_spawnEnabled &&  _pressed == 0) exitWith
	{
		if (!_ctrlKey) then {MCC_spawnEnabled = false}; 
		if (MCC_capture_state) then
		{
			hint "Spawned Captured";
			MCC_capture_var = MCC_capture_var + FORMAT ["
									[[%1 , %2, %3, %4, %5],'MCC_fnc_groupSpawn',false,false] spawn BIS_fnc_MP;
									"
									, _ctrl ctrlMapScreenToWorld [_posX,_posY]
									, MCC_groupBroadcast
									, mcc_hc
									, mcc_sidename
									, MCC_isEmpty
									];
		}	
		else
		{
			hint "Spawned";
			/*
			mcc_safe = mcc_safe + FORMAT ["
									[[%1 , %2, %3, %4, %5],'MCC_fnc_groupSpawn',false,false] spawn BIS_fnc_MP;
									sleep 1;
									"
									, _ctrl ctrlMapScreenToWorld [_posX,_posY]
									, MCC_groupBroadcast
									, mcc_hc
									, mcc_sidename
									, MCC_isEmpty
									];
			*/						
			[[_ctrl ctrlMapScreenToWorld [_posX,_posY], MCC_groupBroadcast, mcc_hc, mcc_sidename, MCC_isEmpty],"MCC_fnc_groupSpawn",false,false] spawn BIS_fnc_MP;
		};
		sleep 0.5;
		deleteMarkerLocal "mcc_spawnMarker";
	};
	
	
	//Box drawing select
	if (_pressed==0 && !MCC_ConsoleRuler && !MCC_doubleClicked && !MCC_zone_drawing && !MCC3DRuning && !MCC_CASrequestMarker && !MCC_brush_drawing && !MCC_drawTriggers
	    && !MCC_drawMinefield && !MCC_delete_drawing && !MCC_ambushPlacing && !MCC_UMParadropRequestMarker && !_shift) then 
	{
		private ["_marker","_markersize","_markerpos","_null","_markerposX","_markerposY","_markersize","_markersizeX","_markersizeY",
					 "_borderXleft","_borderXright","_borderYdown","_borderYtop","_group","_groupX","_groupY","_leader","_icon","_groupControl"];
		
		//Close WP dialog and hints
		ctrlShow [510,false];
		ctrlShow [MCC_GroupGenInfo_IDC,false];
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
		_spawn 		= [_markerPos,3000,(_markerDir -180)] call BIS_fnc_relpos;
		_away 		= [_markerPos,3500,_markerDir] call BIS_fnc_relpos;
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
		
		[[getmarkerpos _marker, MCC_selectedUnits, MCC_UMUnit, MCC_UMparadropIsHalo,_spawn,_away, MCC_path], "MCC_fnc_realParadrop", false] spawn BIS_fnc_MP;

		MCC_UMParadropRequestMarker = false;			//Wait and delete the marker
		sleep 40;
		deletemarkerlocal _marker;
	};
	
	//Zone drawing
	if (MCC_zone_drawing && _pressed==0) then 
	{
		private private ["_marker","_size","_pos","_null"];
		MCC_Marker_dir = 0; 
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
		[Mcase, Mcolor, _size, Mshape, Mbrush, Mtype, Mtext, _pos, MCC_Marker_dir] call MCC_fnc_makeMarker;
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