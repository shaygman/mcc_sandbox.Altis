/*=================================================================MCC_fnc_ConsoleACFullScreen=============================================================================
  Init AC/UAV HUD
  IN <>
    Nothing
*/

private ["_target","_cam","_fov","_leftDownPos","_uav","_keyDown","_mouseMoving"];
if (!hasInterface || isDedicated) exitWith {};

waituntil {!(IsNull (findDisplay 46))};

if (missionNamespace getVariable ["MCC_initConsoleACFullScreen",false]) exitWith {};

//Init
missionNamespace setVariable ["MCC_initConsoleACFullScreen",true];
(["MCC_ConsoleACFullScreen"] call BIS_fnc_rscLayer) cutRsc ["MCC_uavDialog", "PLAIN"];

_uav = missionNamespace getVariable ["MCC_ACConsoleUp",objNull];
_fov = missionNamespace getVariable ["MCC_fakeACFOV",0.8];

if (!alive _uav) exitWith {};

//Close Dialog
while {dialog} do {closeDialog 0;sleep 0.01};

//Create Camera
_cam =  "Camera" camCreate [10,10,10];
_cam cameraEffect ["INTERNAL", "BACK"];
_cam camsetPos (_uav modelToWorld [-6,2,-5]);
_cam camsetFOV _fov;
missionNamespace setVariable ["MCC_fakeACFull",_cam];
cameraEffectEnableHUD false;
showCinemaBorder false;

//Create target
_leftDownPos = _uav modelToWorld [-400,2,-5];
_leftDownPos set [2,0];
_target	= "Sign_Sphere10cm_F" createvehicle _leftDownPos;
_target hideObjectGlobal true;
missionNamespace setVariable ["MCC_fakeACCenterFull",_target];

//Set camera on target
_cam camsetTarget _target;
_cam camCommit 0;

_uav dowatch _target;

MCC_fnc_ConsoleACControlHandler = {
	disableSerialization;
	private ["_keyNightVision","_keysBanned","_keyForward","_keyBack","_keyLeft","_keyRight","_mode","_input","_NVGstate","_camTarget","_pos","_relDir","_posNew","_camTargetPos","_posX","_posY","_uav"];
	_keyNightVision	= actionKeys "NightVision";
	_keysBanned		= [1,15];
	_keyForward		= actionKeys "carForward";
	_keyBack		= actionKeys "carBack";
	_keyLeft		= actionKeys "carLeft";
	_keyRight		= actionKeys "carRight";
	_mode 	= _this select 0;
	_input 	= _this select 1;
	_cam 	= missionNamespace getVariable ["MCC_fakeACFull",objNull];
	_camTarget = missionNamespace getVariable ["MCC_fakeACCenterFull",objNull];
	_uav =  missionNamespace getVariable ["MCC_ACConsoleUp",objNull];

	//if (!alive _cam || !alive _camTarget) exitWith {missionNamespace setVariable ["MCC_initConsoleACFullScreen",false]};

	if (_mode == "keydown") then {
		_key = _input select 1;

		//--- Terminate
		if (_key in _keysBanned) then {missionNamespace setVariable ["MCC_initConsoleACFullScreen",false]};
	};

	if (_mode == "MouseMoving") then {
		_posX = _input select 1;
		_posY = _input select 2;
		_camTargetPos = getPos _camTarget;
		_fov = missionNamespace getVariable ["MCC_fakeACFOV",0.8];

		_posNew = [(_posX * _fov*150) , (_posY *_fov*150),0];
		systemChat str _posNew;
		_camTarget setdir (getdir _uav);
		_camTarget setpos (_camTarget modeltoWorld[(_posNew select 0)*-1,(_posNew select 1),0]);
	};
	systemChat str _this;
};

//Handles
_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "if (missionNamespace getVariable ['MCC_initConsoleACFullScreen',false]) then {['keydown',_this] spawn MCC_fnc_ConsoleACControlHandler;},true"];

_mouseMoving = (findDisplay 46) displayAddEventHandler  ["MouseMoving", "if (missionNamespace getVariable ['MCC_initConsoleACFullScreen',false]) then {['MouseMoving',_this] spawn MCC_fnc_ConsoleACControlHandler;},true"];

while {alive _uav && alive _target && (missionNamespace getVariable ["MCC_initConsoleACFullScreen",false])} do {
	_cam camsetpos (_uav modelToWorld [-6,2,-5]);
	_cam camsetTarget _target;
	_cam camcommit 0.01;
	sleep 0.01;
};

//Clean up
_cam cameraeffect ["terminate","back"];
camdestroy _cam;
_cam = nil;
deletevehicle _target;
missionNamespace setVariable ["MCC_initConsoleACFullScreen",false];
cameraEffectEnableHUD true;
(findDisplay 46) displayRemoveEventHandler  ["KeyDown",_keyDown];
(findDisplay 46) displayRemoveEventHandler  ["MouseMoving",_mouseMoving];
["MCC_ConsoleACFullScreen"] call BIS_fnc_rscLayer cutText ["", "PLAIN DOWN"];