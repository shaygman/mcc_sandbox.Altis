//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_pressed","_posX","_posY","_shift","_ctrlKey","_alt","_marker","_markerPos","_markerDir","_spawn","_away","_ammount","_dir"];
#define MCC_CONSOLEINFOTEXT 9150
#define MCC_CONSOLEINFOLIVEFEED 9151
#define MCC_CONSOLEINFOUAVCONTROL 9162

#define MCC_CONSOLEWPBCKGR 9157
#define MCC_CONSOLEWPCOMBO 9158
#define MCC_CONSOLEWPFORMATIONCOMBO 9166
#define MCC_CONSOLEWPSPEEDCOMBO 9167
#define MCC_CONSOLEWPBEHAVIORCOMBO 9168

#define MCC_CONSOLEWPADD 	9159
#define MCC_CONSOLEWPREPLACE 9160
#define MCC_CONSOLEWPCLEAR 9161
#define MCC_ConsoleMapRulerDir 9164
#define MCC_ConsoleMapRulerDis 9165

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
if (isnil "MCC_doubleClicked") then {MCC_doubleClicked =false};	

if ((_pressed == 0 || _pressed == 1)&& !MCC_doubleClicked) then 								//Close Group info control
	{
		ctrlShow [MCC_CONSOLEINFOTEXT,false];
		ctrlShow [MCC_CONSOLEINFOLIVEFEED,false];
		ctrlShow [MCC_CONSOLEWPBCKGR,false];
		ctrlShow [MCC_CONSOLEWPCOMBO,false];
		ctrlShow [MCC_CONSOLEWPFORMATIONCOMBO,false];
		ctrlShow [MCC_CONSOLEWPSPEEDCOMBO,false];
		ctrlShow [MCC_CONSOLEWPBEHAVIORCOMBO,false];
		ctrlShow [MCC_CONSOLEWPADD,false];
		ctrlShow [MCC_CONSOLEWPREPLACE,false];
		ctrlShow [MCC_CONSOLEWPCLEAR,false];
		ctrlShow [MCC_CONSOLEINFOUAVCONTROL,false];
	};		

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

if (_pressed==0 && MCC_ConsoleRuler) then //Ruler drawing select
		{
			MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
			_marker = [MCC_pointA,MCC_pointA,1,"mil_arrow",20,"ColorBlue",1000000] call MCC_fnc_drawArrow;	//Drow it first
			sleep 0.25; 
			
			while {MCC_ConsoleMouseButtonDown} do 
				{														//While mouse pressed
					deleteMarkerLocal _marker;
					_marker = [MCC_pointA, MCCConsoleDispPosXY,1,"mil_arrow",20,"ColorBlue",1000000] call MCC_fnc_drawArrow;
					sleep 0.25;  
				}; 
				
			sleep 0.01;
			deletemarkerLocal _marker;
			
			//get distance and directio
			_dir = [MCC_pointA, MCCConsoleDispPosXY] call BIS_fnc_dirTo;
			_dir = if (_dir < 0) then {360 + _dir} else {_dir};

			MCC_ConsoleRulerData set [0,floor _dir];
			MCC_ConsoleRulerData set [1,floor (MCC_pointA distance MCCConsoleDispPosXY)];
			
			//Set control
			ctrlSetText [MCC_ConsoleMapRulerDir,format ["Dir: %1",MCC_ConsoleRulerData select 0]];
			ctrlSetText [MCC_ConsoleMapRulerDis,format ["Dis: %1m",MCC_ConsoleRulerData select 1]];
			
			MCC_ConsoleRuler = false; 
			
		};
if (_pressed==0 && !MCC_ConsoleRuler && !MCC_doubleClicked) then //Box drawing select
		{
			private ["_marker","_markersize","_markerpos","_null","_markerposX","_markerposY","_markersize","_markersizeX","_markersizeY",
						 "_borderXleft","_borderXright","_borderYdown","_borderYtop","_group","_groupX","_groupY","_leader","_icon","_groupControl"];
			
			//Close WP dialog
			ctrlShow [MCC_CONSOLEWPBCKGR,false];
			ctrlShow [MCC_CONSOLEWPCOMBO,false];
			ctrlShow [MCC_CONSOLEWPADD,false];
			ctrlShow [MCC_CONSOLEWPREPLACE,false];
			ctrlShow [MCC_CONSOLEWPCLEAR,false];
			
			//Start creating the box
			MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
			_marker = [MCC_pointA,MCC_pointA,1,"RECTANGLE","ColorGreen","Border"] call MCC_fnc_drawBox;	//Drow it first
			sleep 0.1; 
			//if (!MCC_ConsoleMouseButtonDown) exitWith {};				//looks like we are not making a box
			while {MCC_ConsoleMouseButtonDown} do 
				{														//While mouse pressed
					deleteMarkerLocal _marker;
					_marker = [MCC_pointA, MCCConsoleDispPosXY,1,"RECTANGLE","ColorGreen","Border"] call MCC_fnc_drawBox;
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
			if (isnil "MCC_ConsoleGroupSelected") then {MCC_ConsoleGroupSelected=[]};
			if (_markersizeX < 10 || _markersizeY<10) exitWith {}; 
			{_x removeGroupIcon (_x getvariable "MCCgroupIconDataSelected")} foreach MCC_ConsoleGroupSelected;
			MCC_ConsoleGroupSelected = [];
			{
				_groupControl = nil; 
				_leader = (leader _x);
				_groupControl = if ((isplayer _leader) || (getText (configfile >> "CfgVehicles" >> typeOF vehicle _leader >> "vehicleClass")== "Autonomous")) then {true} else {_x getvariable ["MCC_canbecontrolled",false]};	//Can we control this group
				if ((side _leader == side player) && alive _leader && count (units _x)>0 && _groupControl) then
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
							MCC_ConsoleGroupSelected = MCC_ConsoleGroupSelected + [_group];
						};
					};
			} foreach allgroups;
			if (count MCC_ConsoleGroupSelected == 0) exitWith {};
			{
				_icon = _x addGroupIcon ["selector_selectedFriendly",[0,0]];
				_x setvariable ["MCCgroupIconDataSelected",_icon,false];
			} foreach MCC_ConsoleGroupSelected;

		};