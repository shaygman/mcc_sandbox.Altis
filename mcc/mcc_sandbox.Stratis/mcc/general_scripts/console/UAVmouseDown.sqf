#define MCC_CONSOLE_UAV_MISSILE 9109
#define MCC_CONSOLE_UAV_MISSILE_COUNT 9110
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

if (_pressed==1) then //Control camera
	{
		MCC_uavPos = [0.5,0.44];
		if (MCC_ConsoleUAVMouseButtonDown) then {MCC_ConsoleUAVMouseButtonDown = false} else {
			MCC_ConsoleUAVMouseButtonDown = true};
	};

if (_pressed==0) then //Fire Missile
	{
		if (MCC_ConsoleUAVmissiles > 0) then {
			MCC_ConsoleUAVmissiles = MCC_ConsoleUAVmissiles - 1;
			publicvariable "MCC_ConsoleUAVmissiles";
			playSound "missileLunch";
			[[netid MCC_fakeUAV, "missileLunch"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			[MCC_fakeUAVCenter, getpos MCC_fakeUAV, "M_NLAW_AT_F",400,true,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
			MCC_ConsoleUAVmissilesArmed = false; 
			ctrlSetText [MCC_CONSOLE_UAV_MISSILE_COUNT, format ["AGM #: %1",MCC_ConsoleUAVmissiles]];
			};
	};
