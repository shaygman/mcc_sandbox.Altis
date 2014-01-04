private ["_mccdialog","_comboBox","_displayname","_time", "_index","_message","_messageFinal","_type",
		 "_insetionArray","_control","_data","_rad","_alt","_coords","_effectParams"];
// By: Shay_gman
// Version: 1.1 (April 2013)
#define mcc_playerConsole3_IDD 5010

#define MCC_CONSOLE_AC_BCKG 5011
#define MCC_CONSOLE_AC_MISSILE_COUNT 5012
#define MCC_CONSOLE_AC_MISSILE_COUNT2 5019
#define MCC_CONSOLE_AC_MISSILE_COUNT3 5020
#define MCC_CONSOLE_AC_VISION_TEXT 5013
#define MCC_CONSOLE_AC_TIME_TEXT 5014
#define MCC_CONSOLE_AC_ZOOM_TEXT 5015
#define MCC_CONSOLE_AC_TARGET 5016
#define MCC_CONSOLE_AC_WEAPON 5017
#define MCC_CONSOLE_ACPIP 5018
#define MCC_CONSOLE_AC_DIR_TEXT 5021
#define MCC_CONSOLE_COMPASS_N 9116
#define MCC_CONSOLE_COMPASS_E 9117
#define MCC_CONSOLE_COMPASS_S 9118
#define MCC_CONSOLE_COMPASS_W 9119
#define MCC_MINIMAP 9120
#define MCC_CONSOLE_AC_MAP 5022

disableSerialization;
_mccdialog = findDisplay mcc_playerConsole3_IDD;
MCC_Console1Open = false;
MCC_Console2Open = false;
MCC_Console3Open = true;
MCC_Console4Open = false;
//-------------------------------------------------AC-130--------------------------------------------------------------------------------
ctrlShow [MCC_CONSOLE_AC_TARGET,false];
ctrlShow [MCC_CONSOLE_COMPASS_N,false];
ctrlShow [MCC_CONSOLE_COMPASS_E,false];
ctrlShow [MCC_CONSOLE_COMPASS_S,false];
ctrlShow [MCC_CONSOLE_COMPASS_W,false];
ctrlShow [MCC_MINIMAP,false];
ctrlShow [MCC_CONSOLE_AC_MAP,false];

ctrlSetText [MCC_CONSOLE_ACPIP, ""];
_time = time + (2 + random 5);
	while {_time > time && dialog && (isNil "MCC_fakeAC")} do {
		_message = "";
		_messageFinal = ["C","o","n","n","e","c","t","i","n","g"," ","A","C","-","1","3","0"," ","S","p","o","o","k","y",".",".","."];
		for "_i" from 0 to (count _messageFinal - 1) do {
			_message = _message + (_messageFinal select _i);
			ctrlSetText [MCC_CONSOLE_AC_BCKG, _message];
			sleep 0.05;
		};
	};

if (dialog && !MCC_ACConsoleUp) then {
		ctrlSetText [MCC_CONSOLE_AC_BCKG, "Error connecting to AC-130, connection failed"];
		};
		
if (dialog && MCC_ACConsoleUp) then {				//Create the AC
		//Get rid of the connecting text
		ctrlSetText [MCC_CONSOLE_AC_BCKG, ""];
		_control = _mccdialog displayCtrl MCC_CONSOLE_ACPIP;
		[_control] call MCC_fnc_pipOpen;
		ctrlSetText [MCC_CONSOLE_ACPIP, "#(argb,512,512,1)r2t(rendertarget8,1.0);"];
		// Create fake AC
		if (isNil "MCC_fakeAC") then {
			MCC_fakeAC 		= "Camera" camCreate [10,10,10];
			if (!isnil "MCC_fakeACCenter") then {deletevehicle MCC_fakeACCenter};
			MCC_fakeACCenter	= "Sign_Sphere10cm_F" createvehicle [MCC_consoleACpos select 0,MCC_consoleACpos select 1, 0];
			hideobject MCC_fakeACCenter;
			_rad	=	400;
			_alt	=	300;
			MCC_ACAng	= 	0;
			MCC_fakeAC cameraEffect ["INTERNAL", "BACK", "rendertarget8"];
			_coords = [MCC_consoleACpos, _rad, MCC_ACAng] call BIS_fnc_relPos;
			_coords set [2, _alt];
			MCC_fakeACFOV = 0.8;
			MCC_fakeAC camsetTarget MCC_fakeACCenter;
			MCC_fakeAC camsetPos _coords;
			MCC_fakeAC camsetFOV MCC_fakeACFOV;
			MCC_fakeAC camCommit 0;
		};
		
		ctrlSetText [MCC_CONSOLE_AC_ZOOM_TEXT, format ["ZOOM: %1x",(10-(10*MCC_fakeACFOV))]];
		ctrlSetText [MCC_CONSOLE_AC_VISION_TEXT, MCC_ConsoleACvision];
		ctrlSetText [MCC_CONSOLE_AC_MISSILE_COUNT, format ["25mm: %1",MCC_ConsoleACAmmo select 0]];
		ctrlSetText [MCC_CONSOLE_AC_MISSILE_COUNT2, format ["40mm: %1",MCC_ConsoleACAmmo select 1]];
		ctrlSetText [MCC_CONSOLE_AC_MISSILE_COUNT3, format ["105mm: %1",MCC_ConsoleACAmmo select 2]];
		
		switch (MCC_ConsoleACCameraMod) do {
			// Normal
			case 0: {
				_effectParams = [3, 1, 1, 1, 0.1, [0, 0.4, 1, 0.1], [0, 0.2, 1, 1], [0, 0, 0, 0]];
				MCC_ConsoleACvision = "VIDEO";
			};
			
			// Night vision
			case 1: {
				_effectParams = [1];
				MCC_ConsoleACvision = "N/V";
			};
			
			// Thermal imaging
			case 2: {
				_effectParams = [2];
				MCC_ConsoleACvision = "WHOT";
			};
		};
		"rendertarget8" setPiPEffect _effectParams;
		
		switch (MCC_ConsoleACweaponSelected) do {
			// 20mm
			case 0: {
				ctrlSetText [MCC_CONSOLE_AC_TARGET, MCC_path +"data\consuleTarget1.paa"];
			};
			
			// 40mm
			case 1: {
				ctrlSetText [MCC_CONSOLE_AC_TARGET, MCC_path +"data\consuleTarget2.paa"];
			};
			
			// 105mm
			case 2: {
				ctrlSetText [MCC_CONSOLE_AC_TARGET, MCC_path +"data\consuleTarget3.paa"];
			};
		};
		
		ctrlshow [MCC_CONSOLE_AC_TARGET,true];
		ctrlShow [MCC_CONSOLE_COMPASS_N,true];
		ctrlShow [MCC_CONSOLE_COMPASS_E,true];
		ctrlShow [MCC_CONSOLE_COMPASS_S,true];
		ctrlShow [MCC_CONSOLE_COMPASS_W,true];
		ctrlShow [MCC_CONSOLE_AC_MAP,true];
		
		//Handle on screen data
		[] spawn {
			private ["_structured","_data","_mccdialog"];
			disableSerialization;
			
			while {MCC_Console3Open && dialog} do {
				_mccdialog = findDisplay mcc_playerConsole3_IDD;
				_structured = composeText [""];
				_data = 
					[
					format ["Time: %1:%2",[date select 3]call MCC_fnc_time2string,[date select 4]call MCC_fnc_time2string],
					format ["Elapsed: %1",[time]call MCC_fnc_time],
					format ["X: %1 Y: %2",floor ((getpos MCC_fakeAC) select 0),floor ((getpos MCC_fakeAC) select 1)]
					];
				{_structured = composeText [_structured,_x,lineBreak]} forEach _data;
				(_mccdialog displayctrl MCC_CONSOLE_AC_TIME_TEXT) ctrlSetStructuredText _structured;
				ctrlSetText [MCC_CONSOLE_AC_DIR_TEXT, format ["Dir: %1",floor (getdir MCC_fakeAC)]];
				
				//Compass
				for [{_i = 0;_j = 0},{_i < 360;_j < 4},{_i = _i + 90;_j = _j + 1}] do 
				{
					_x = (0.476 + sin(_i - (getdir MCC_fakeAC))*(SafeZoneW/8 - SafeZoneW/200));
					_y = (0.42 - cos(_i - (getdir MCC_fakeAC))*(SafeZoneH/8 - SafeZoneH/200));
					
					(_mccdialog displayCtrl 9116+_j) ctrlSetPosition [_x,_y];
					(_mccdialog displayCtrl 9116+_j) ctrlCommit 0;

				};
				sleep 0.1;
			};
		};
	
		MCC_ACcenter = getpos MCC_fakeACCenter;
		
		if (MCC_uavConsoleACFirstTime) then {
			MCC_uavConsoleACFirstTime = false; 
					// Move camera in a circle
				[getpos MCC_fakeACCenter, _alt, _rad] spawn {
					private ["_pos", "_alt", "_rad", "_coords"];
					disableSerialization;
					
					_pos = _this select 0;
					_alt = _this select 1;
					_rad = _this select 2;
										
					while {alive MCC_fakeAC} do {
						MCC_ACAng = MCC_ACAng - 0.5;
						_coords = [_pos, _rad, MCC_ACAng] call BIS_fnc_relPos;
						_coords set [2, _alt];
						
						MCC_fakeAC camPreparePos _coords;
						MCC_fakeACCenter setdir getdir (MCC_fakeAC);
						MCC_fakeAC camCommitPrepared 0.3;
						waitUntil {camCommitted MCC_fakeAC};
					
						MCC_fakeAC camPreparePos _coords;
						MCC_fakeAC camCommitPrepared 0;
					};
				};
			};
		};