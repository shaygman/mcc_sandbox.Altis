private ["_mccdialog","_comboBox","_displayname","_pic", "_index","_planeName","_counter","_type",
		 "_insetionArray","_control","_rad","_alt","_coords","_effectParams","_time","_message","_messageFinal"];
// By: Shay_gman
// Version: 1.1 (April 2013)
#define mcc_playerConsole2_IDD 5000

#define MCC_CONSOLE_UAVPIP 9106 
#define MCC_CONSOLE_UAVMISSILELEFTTEXT 9107  
#define MCC_CONSOLE_UAVPIP_BCKG 9108
#define MCC_CONSOLE_UAV_MISSILE_COUNT 9110
#define MCC_CONSOLE_VISION_TEXT 9111
#define MCC_CONSOLE_TIME_TEXT 9112
#define MCC_CONSOLE_ZOOM_TEXT 9113
#define MCC_CONSOLE_UAV_TARGET 9114
#define MCC_CONSOLE_DIR_TEXT 9115
#define MCC_CONSOLE_COMPASS_N 9116
#define MCC_CONSOLE_COMPASS_E 9117
#define MCC_CONSOLE_COMPASS_S 9118
#define MCC_CONSOLE_COMPASS_W 9119
#define MCC_MINIMAP 9000

disableSerialization;
_mccdialog = findDisplay mcc_playerConsole2_IDD;

MCC_Console1Open = false;
MCC_Console2Open = true;
MCC_Console3Open = false;
MCC_Console4Open = false;

//-------------------------------------------------UAV--------------------------------------------------------------------------------
ctrlShow [MCC_CONSOLE_UAV_TARGET,false];
ctrlShow [MCC_CONSOLE_COMPASS_N,false];
ctrlShow [MCC_CONSOLE_COMPASS_E,false];
ctrlShow [MCC_CONSOLE_COMPASS_S,false];
ctrlShow [MCC_CONSOLE_COMPASS_W,false];
ctrlShow [MCC_MINIMAP,false];

ctrlSetText [MCC_CONSOLE_UAVPIP, ""];
_time = time + (2 + random 5);
while {_time > time && dialog && (isNil "MCC_fakeUAV")} do {
	_message = "";
	_messageFinal = ["C","o","n","n","e","c","t","i","n","g"," ","M","Q","9","-","R","e","a","p","e","r",".",".",".","."];
	for "_i" from 0 to (count _messageFinal - 1) do {
		_message = _message + (_messageFinal select _i);
		ctrlSetText [MCC_CONSOLE_UAVPIP_BCKG, _message];
		sleep 0.05;
	};
};
	
if (dialog && !MCC_uavConsoleUp && MCC_Console2Open) then {
	ctrlSetText [MCC_CONSOLE_UAVPIP_BCKG, "Error connecting to UAV, connection failed"];
	};
	
if (dialog && MCC_uavConsoleUp && MCC_Console2Open) then {				//Create the UAV
	//Get rid of the connecting text
	ctrlSetText [MCC_CONSOLE_UAVPIP_BCKG, ""];
	_control = _mccdialog displayCtrl MCC_CONSOLE_UAVPIP;
	[_control] call MCC_fnc_pipOpen;
	ctrlSetText [MCC_CONSOLE_UAVPIP, "#(argb,512,512,1)r2t(rendertarget9,1.0);"];
	// Create fake UAV
	if (isNil "MCC_fakeUAV") then {
		MCC_fakeUAV 		= "Camera" camCreate [10,10,10];
		if (!isnil "MCC_fakeUAVCenter") then {deletevehicle MCC_fakeUAVCenter};
		MCC_fakeUAVCenter	= "Sign_Sphere10cm_F" createvehicle [MCC_consoleUAVpos select 0,MCC_consoleUAVpos select 1, 0];
		hideobject MCC_fakeUAVCenter;
		_rad	=	400;
		_alt	=	500;
		MCC_UAVAng	= 	180;
		MCC_fakeUAV cameraEffect ["INTERNAL", "BACK", "rendertarget9"];
		_coords = [MCC_consoleUAVpos, _rad, MCC_UAVAng] call BIS_fnc_relPos;
		_coords set [2, _alt];
		MCC_fakeUAVFOV = 0.6;
		MCC_fakeUAV camsetTarget MCC_fakeUAVCenter;
		MCC_fakeUAV camsetPos _coords;
		MCC_fakeUAV camsetFOV MCC_fakeUAVFOV;
		MCC_fakeUAV camCommit 0;
	};
	
	ctrlSetText [MCC_CONSOLE_ZOOM_TEXT, format ["ZOOM X %1",(10-(10*MCC_fakeUAVFOV))]];
	ctrlSetText [MCC_CONSOLE_VISION_TEXT, MCC_ConsoleUAVvision];
	ctrlSetText [MCC_CONSOLE_UAV_MISSILE_COUNT, format ["AGM #: %1",MCC_ConsoleUAVmissiles]];
	
	switch (MCC_ConsoleUAVCameraMod) do {
		// Normal
		case 0: {
			_effectParams = [3, 1, 1, 1, 0.1, [0, 0.4, 1, 0.1], [0, 0.2, 1, 1], [0, 0, 0, 0]];
			MCC_ConsoleUAVvision = "VIDEO";
		};
		
		// Night vision
		case 1: {
			_effectParams = [1];
			MCC_ConsoleUAVvision = "N/V";
		};
		
		// Thermal imaging
		case 2: {
			_effectParams = [2];
			MCC_ConsoleUAVvision = "WHOT";
		};
	};
	"rendertarget9" setPiPEffect _effectParams;
	ctrlShow [MCC_CONSOLE_UAV_TARGET,true];
	ctrlShow [MCC_CONSOLE_COMPASS_N,true];
	ctrlShow [MCC_CONSOLE_COMPASS_E,true];
	ctrlShow [MCC_CONSOLE_COMPASS_S,true];
	ctrlShow [MCC_CONSOLE_COMPASS_W,true];
		
	//Handle on screen data
	[] spawn {
		private ["_structured","_data","_mccdialog"];
		disableSerialization;
		
		while {MCC_Console2Open && dialog} do {
			_mccdialog = findDisplay mcc_playerConsole2_IDD;
			_structured = composeText [""];
			_data = 
				[
				format ["Time: %1 : %2",[date select 3]call MCC_fnc_time2string,[date select 4]call MCC_fnc_time2string],
				format ["Elapsed: %1",[time]call MCC_fnc_time],
				format ["X: %1 Y: %2",floor ((getpos MCC_fakeUAV) select 0),floor ((getpos MCC_fakeUAV) select 1)]
				];
			{_structured = composeText [_structured,_x,lineBreak]} forEach _data;
			(_mccdialog displayctrl MCC_CONSOLE_TIME_TEXT) ctrlSetStructuredText _structured;
			ctrlSetText [MCC_CONSOLE_DIR_TEXT, format ["Dir:%1",floor (getdir MCC_fakeUAV)]];
			
			//Compass
			for [{_i = 0;_j = 0},{_i < 360;_j < 4},{_i = _i + 90;_j = _j + 1}] do 
			{
				_x = (0.476 + sin(_i - (getdir MCC_fakeUAV))*(SafeZoneW/8 - SafeZoneW/200));
				_y = (0.42 - cos(_i - (getdir MCC_fakeUAV))*(SafeZoneH/8 - SafeZoneH/200));
				
				(_mccdialog displayCtrl 9116+_j) ctrlSetPosition [_x,_y];
				(_mccdialog displayCtrl 9116+_j) ctrlCommit 0;

			};
			sleep 0.1;
		};
	};
	
	//Make the UAV spin
	if (MCC_uavConsoleUAVFirstTime) then {
		MCC_uavConsoleUAVFirstTime = false; 
				// Move camera in a circle
			[getpos MCC_fakeUAVCenter, _alt, _rad] spawn {
				private ["_pos", "_alt", "_rad","_coords"];
				_pos = _this select 0;
				_alt = _this select 1;
				_rad = _this select 2;				

				while {alive MCC_fakeUAV} do {
					MCC_UAVAng = MCC_UAVAng - 0.5;
					_coords = [_pos, _rad, MCC_UAVAng] call BIS_fnc_relPos;
					_coords set [2, _alt];
					
					MCC_fakeUAV camPreparePos _coords;
					MCC_fakeUAVCenter setdir (getdir MCC_fakeUAV);
					MCC_fakeUAV camCommitPrepared 1;
					waitUntil {camCommitted MCC_fakeUAV};
					
					MCC_fakeUAV camPreparePos _coords;
					MCC_fakeUAV camCommitPrepared 0;
				};					
			};
		};
	};

		