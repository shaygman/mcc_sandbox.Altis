//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_pressed","_posX","_posY","_shift","_ctrlKey","_alt","_marker","_markerPos","_markerDir","_spawn","_away","_ammount","_dir"];
#define MCC_GroupGenInfoText_IDC 9013
#define MCC_GroupGenWPBckgr_IDC 9014
#define MCC_GroupGenWPCombo_IDC 9015
#define MCC_GroupGenWPformationCombo_IDC 9016
#define MCC_GroupGenWPspeedCombo_IDC 9017
#define MCC_GroupGenWPbehaviorCombo_IDC 9018
#define MCC_GroupGenWPAdd_IDC 9019
#define MCC_GroupGenWPReplace_IDC 9020
#define MCC_GroupGenWPClear_IDC 9021

disableSerialization;
 
_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;
_posX = _params select 2; 
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;

MCC_GroupGenMouseButtonDown = true;	//Mouse state
MCC_GroupGenMouseButtonUp = false;
if (isnil "MCC_doubleClicked") then {MCC_doubleClicked =false};	

if ((_pressed == 0 || _pressed == 1)&& !MCC_doubleClicked) then 								//Close Group info control
	{
		ctrlShow [MCC_GroupGenInfoText_IDC,false];
		ctrlShow [MCC_GroupGenWPBckgr_IDC,false];
		ctrlShow [MCC_GroupGenWPCombo_IDC,false];
		ctrlShow [MCC_GroupGenWPformationCombo_IDC,false];
		ctrlShow [MCC_GroupGenWPspeedCombo_IDC,false];
		ctrlShow [MCC_GroupGenWPbehaviorCombo_IDC,false];
		ctrlShow [MCC_GroupGenWPAdd_IDC,false];
		ctrlShow [MCC_GroupGenWPReplace_IDC,false];
		ctrlShow [MCC_GroupGenWPClear_IDC,false];
	};		

if (_pressed==0 && !MCC_ConsoleRuler && !MCC_doubleClicked) then //Box drawing select
		{
			private ["_marker","_markersize","_markerpos","_null","_markerposX","_markerposY","_markersize","_markersizeX","_markersizeY",
						 "_borderXleft","_borderXright","_borderYdown","_borderYtop","_group","_groupX","_groupY","_leader","_icon","_groupControl"];
			
			//Close WP dialog
			ctrlShow [MCC_GroupGenWPBckgr_IDC,false];
			ctrlShow [MCC_GroupGenWPCombo_IDC,false];
			ctrlShow [MCC_GroupGenWPAdd_IDC,false];
			ctrlShow [MCC_GroupGenWPReplace_IDC,false];
			ctrlShow [MCC_GroupGenWPClear_IDC,false];
			
			//Start creating the box
			MCC_pointA = _ctrl ctrlmapscreentoworld [_posX,_posY];									//Base of the arrow
			_marker = [MCC_pointA,MCC_pointA,1,"RECTANGLE","ColorGreen","Border"] call MCC_fnc_drawBox;	//Drow it first
			sleep 0.1; 
			//if (!MCC_GroupGenMouseButtonDown) exitWith {};				//looks like we are not making a box
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
				if ((side _leader == MCC_groupGenGroupStatus) && alive _leader && count (units _x)>0) then
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