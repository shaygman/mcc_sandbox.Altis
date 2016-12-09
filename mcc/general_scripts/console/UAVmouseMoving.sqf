//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_posX","_posY","_posNew","_fakeUav"];
disableSerialization;

_params = _this select 0;

_ctrl = _params select 0;
_posX = _params select 1;
_posY = _params select 2;
_fakeUav = missionNamespace getVariable ["MCC_fakeUAV",objNull];

if !(alive _fakeUav) exitWith {};

if (MCC_ConsoleUAVMouseButtonDown) then {
	if (player getVariable ["MCC_lastSoundTime",time] <= time) then {playsound ["MCC_zoom",true];player setVariable ["MCC_lastSoundTime",time+0.11]};
	_posNew = [((MCC_uavPos select 0) - _posX)*(MCC_fakeUAVFOV*150)*(_fakeUav distance MCC_fakeUAVCenter)/100 , ((MCC_uavPos select 1) - _posY)*(MCC_fakeUAVFOV*150)*(MCC_fakeUAV distance MCC_fakeUAVCenter)/100,0];
	MCC_fakeUAVCenter setdir (getdir _fakeUav);
	MCC_fakeUAVCenter setpos (MCC_fakeUAVCenter modeltoWorld[(_posNew select 0)*-1,(_posNew select 1),0]);
	setMousePosition [0.5,0.44];
};