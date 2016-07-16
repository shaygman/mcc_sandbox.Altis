#define MCC_CONSOLE_UAV_MISSILE_COUNT 9110
//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_pressed","_posX","_posY","_shift","_ctrlKey","_alt","_rocket","_objects","_fov"];
disableSerialization;

_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;
_posX = _params select 2;
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;

if (isNil "MCC_ConolseUAV" || isNil "MCC_fakeUAV") exitWith {};
if (isNull MCC_ConolseUAV || !alive MCC_ConolseUAV) exitWith {};

//Control camera
if (_pressed==1) then  {
	MCC_uavPos = [0.5,0.44];
	if (MCC_ConsoleUAVMouseButtonDown) then {MCC_ConsoleUAVMouseButtonDown = false} else {
		MCC_ConsoleUAVMouseButtonDown = true};
};

 //Fire Missile
if (_pressed==0) then {
	MCC_ConsoleUAVmissiles = ["",0];
	if ("6Rnd_LG_scalpel" in (MCC_ConolseUAV magazinesTurret [0])) then {MCC_ConsoleUAVmissiles = ["AGM",(MCC_ConolseUAV) ammo "missiles_SCALPEL","missiles_SCALPEL","M_Scalpel_AT"]};
	if ("2Rnd_GBU12_LGB" in (MCC_ConolseUAV magazinesTurret [0])) then {MCC_ConsoleUAVmissiles = ["GBU",(MCC_ConolseUAV) ammo "GBU12BombLauncher","GBU12BombLauncher","Bo_GBU12_LGB"]};
	if ((MCC_ConsoleUAVmissiles select 0) != "" && (MCC_ConsoleUAVmissiles select 1) > 0 && (abs(getdir MCC_ConolseUAV - getdir MCC_fakeUAV) <=90)) then {
		playSound "missileLunch";
		[1,""] execVM MCC_path+"mcc\general_scripts\console\uavControl.sqf";
		//MCC_ConolseUAV fire (MCC_ConsoleUAVmissiles select 2);
		sleep 1;
		_objects = [];
		_objects = (getpos MCC_ConolseUAV) nearObjects [(MCC_ConsoleUAVmissiles select 3), 300];
		_rocket = if (count _objects > 0) then {_objects select 0};
		if (isnil "_rocket") then {_rocket = getpos MCC_ConolseUAV};
		[[[netid MCC_fakeUAV,MCC_fakeUAV], "missileLunch"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		[MCC_fakeUAVCenter, getpos _rocket, (MCC_ConsoleUAVmissiles select 3),400,true,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
		if (!isnil "_rocket") then {deletevehicle _rocket};
		ctrlSetText [MCC_CONSOLE_UAV_MISSILE_COUNT, format ["%1 #: %2",MCC_ConsoleUAVmissiles select 0,(MCC_ConsoleUAVmissiles select 1)-1]];
	};
};
