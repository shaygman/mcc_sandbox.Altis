private ["_mccdialog","_comboBox","_displayname","_pic", "_index","_planeName","_counter","_type",
		 "_insetionArray","_control","_effectParams","_time","_message","_messageFinal"];
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
#define MCC_MINIMAP 9120
#define MCC_CONSOLE_AC_MAP 5022

#define MCC_CONSOLEUAVFLIGHTHIGHT 9121
#define MCC_CONSOLEUAVFLIGHTHIGHTTEXT 9122
#define MCC_CONSOLEUAVTAKECONTROL 9123

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
ctrlShow [MCC_CONSOLEUAVFLIGHTHIGHT,false];
ctrlShow [MCC_CONSOLEUAVFLIGHTHIGHTTEXT,false];
ctrlShow [MCC_CONSOLEUAVTAKECONTROL,false];
ctrlShow [MCC_CONSOLE_AC_MAP,false];

ctrlSetText [MCC_CONSOLE_UAVPIP, ""];
_time = time + (1);
while {_time > time && (str (finddisplay mcc_playerConsole2_IDD) != "no display")} do {
	_message = "";
	_messageFinal = ["C","o","n","n","e","c","t","i","n","g"," ","D","R","O","N","E",".",".",".","."];
	for "_i" from 0 to (count _messageFinal - 1) do {
		_message = _message + (_messageFinal select _i);
		ctrlSetText [MCC_CONSOLE_UAVPIP_BCKG, _message];
		sleep 0.05;
	};
};

if ((str (finddisplay mcc_playerConsole2_IDD) == "no display") || (isNull (missionNamespace getVariable ["MCC_ConolseUAV",objNull]))) exitWith {
	if (missionNamespace getVariable ["MCC_Console2Open",false]) then {
		ctrlSetText [MCC_CONSOLE_UAVPIP_BCKG, "No UAV signal found, connection failed"];
	};
};

//Create the UAV
if ((str (finddisplay mcc_playerConsole2_IDD) != "no display") && (alive MCC_ConolseUAV) && MCC_Console2Open) then {
	//Get rid of the connecting text
	ctrlSetText [MCC_CONSOLE_UAVPIP_BCKG, ""];
	_control = _mccdialog displayCtrl MCC_CONSOLE_UAVPIP;
	[_control] call MCC_fnc_pipOpen;
	ctrlSetText [MCC_CONSOLE_UAVPIP, "#(argb,512,512,1)r2t(rendertarget9,1.0);"];
	// Create fake UAV
	if (isNil "MCC_fakeUAV") then {
		MCC_fakeUAV 		= "Camera" camCreate [10,10,10];
		if (!isnil "MCC_fakeUAVCenter") then {deletevehicle MCC_fakeUAVCenter};
		MCC_fakeUAVCenter	= "Sign_Sphere10cm_F" createvehicle [((getpos MCC_ConolseUAV) select 0),(getpos MCC_ConolseUAV) select 1, 0];
		[[[netid MCC_fakeUAVCenter,MCC_fakeUAVCenter], "_this hideObjectGlobal true"], "MCC_fnc_setVehicleInit", false, false] spawn BIS_fnc_MP;
		MCC_fakeUAV cameraEffect ["INTERNAL", "BACK", "rendertarget9"];
		MCC_fakeUAVFOV = 0.6;
		MCC_fakeUAV camsetTarget MCC_fakeUAVCenter;
		MCC_fakeUAV camsetFOV MCC_fakeUAVFOV;
		MCC_fakeUAV camCommit 0;
};

	ctrlSetText [MCC_CONSOLE_ZOOM_TEXT, format ["ZOOM X %1",(10-(10*MCC_fakeUAVFOV))]];
	ctrlSetText [MCC_CONSOLE_VISION_TEXT, MCC_ConsoleUAVvision];

	//Check Ammo
	MCC_ConsoleUAVmissiles = ["",0,""];
	if ("6Rnd_LG_scalpel" in (MCC_ConolseUAV magazinesTurret [0])) then {MCC_ConsoleUAVmissiles = ["AGM",(MCC_ConolseUAV) ammo "missiles_SCALPEL","missiles_SCALPEL","M_Scalpel_AT"]};
	if ("2Rnd_GBU12_LGB" in (MCC_ConolseUAV magazinesTurret [0])) then {MCC_ConsoleUAVmissiles = ["GBU",(MCC_ConolseUAV) ammo "GBU12BombLauncher","GBU12BombLauncher","Bo_GBU12_LGB"]};
	if ((MCC_ConsoleUAVmissiles select 0) != "") then {ctrlSetText [MCC_CONSOLE_UAV_MISSILE_COUNT, format ["%1 #: %2",MCC_ConsoleUAVmissiles select 0,MCC_ConsoleUAVmissiles select 1]]};

	switch (MCC_ConsoleUAVCameraMod) do
	{
		// Normal
		case 0: {
			_effectParams = [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
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
	ctrlShow [MCC_CONSOLE_AC_MAP,true];
	ctrlShow [MCC_CONSOLEUAVTAKECONTROL,true];

	//Show flight hight slider
	if (MCC_ConolseUAV iskindof "AIR") then {
		private ["_alt"];
		ctrlShow [MCC_CONSOLEUAVFLIGHTHIGHT,true];
		ctrlShow [MCC_CONSOLEUAVFLIGHTHIGHTTEXT,true];

		if (MCC_ConolseUAV iskindof "Plane") then
			{
				sliderSetRange [MCC_CONSOLEUAVFLIGHTHIGHT, 300, 1500];
				_alt = if (((getpos MCC_ConolseUAV) select 2) > 1500) then {1500} else {(getpos MCC_ConolseUAV) select 2};
			};
		if (MCC_ConolseUAV iskindof "Helicopter") then
			{
				sliderSetRange [MCC_CONSOLEUAVFLIGHTHIGHT, 1, 500];
				_alt = if (((getpos MCC_ConolseUAV) select 2) > 500) then {500} else {(getpos MCC_ConolseUAV) select 2};
			};
		sliderSetPosition [MCC_CONSOLEUAVFLIGHTHIGHT, _alt];
		//(_mccdialog displayCtrl MCC_CONSOLEUAVFLIGHTHIGHT) ctrlSetTooltip format ["%1 Meters",sliderPosition MCC_CONSOLEUAVFLIGHTHIGHT];
	};

	//Handle on screen data
	[] spawn {
		private ["_structured","_data","_mccdialog","_relPos"];
		disableSerialization;

		while {MCC_Console2Open && (str (finddisplay mcc_playerConsole2_IDD) != "no display") && alive MCC_ConolseUAV} do {
			_relPos = if (MCC_ConolseUAV iskindof "AIR") then {-0.2} else {3};
			MCC_fakeUAV camsetpos [(getpos MCC_ConolseUAV) select 0,(getpos MCC_ConolseUAV) select 1, ((getpos MCC_ConolseUAV) select 2)+_relPos];
			MCC_fakeUAV camsetTarget MCC_fakeUAVCenter;
			MCC_fakeUAV camcommit 0.01;
			_mccdialog = findDisplay mcc_playerConsole2_IDD;
			_structured = composeText [""];
			_data =
				[
				format ["Time:  %1:%2",[date select 3]call MCC_fnc_time2string,[date select 4]call MCC_fnc_time2string],
				format ["Elapsed:  %1",[time]call MCC_fnc_time],
				format ["X: %1  Y: %2",floor ((getpos MCC_fakeUAV) select 0),floor ((getpos MCC_fakeUAV) select 1)],
				format ["Altitude: %1",floor ((getpos MCC_ConolseUAV) select 2)],
				format ["Dir:      %1",floor getdir MCC_ConolseUAV],
				format ["Speed:    %1",floor speed MCC_ConolseUAV],
				format ["Fuel:     %1",floor ((fuel MCC_ConolseUAV)*100)]
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
			sleep 0.01;
		};

		//Cleanup
		if (!isnil "MCC_fakeUAV") then {
			MCC_fakeUAV cameraEffect ["TERMINATE", "BACK"];
			camdestroy MCC_fakeUAV;
			MCC_fakeUAV = nil;
			[(_mccdialog displayctrl MCC_CONSOLE_UAVPIP)] call MCC_fnc_pipOpen;
			_null = [1] execVM format ["%1mcc\general_scripts\console\conoleSwitchMenu.sqf",MCC_path];
		};
	};

};

