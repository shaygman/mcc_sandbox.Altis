#define MCC_CONSOLE_AC_ZOOM_TEXT 5015
//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params", "_ctrl", "_pressed", "_posX", "_posY", "_shift", "_ctrlKey", "_alt", "_eib_marker","_pointB","_nearObjectsA","_nearObjectsB"];
disableSerialization;

_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;

if (isNil "MCC_fakeAC") exitWith {};
if (isNull MCC_fakeAC) exitWith {};

if (_pressed<0) then {
	MCC_fakeACFOV = MCC_fakeACFOV + 0.02;
	} else {
		MCC_fakeACFOV = MCC_fakeACFOV - 0.02;
		};
if (MCC_fakeACFOV <= 0.02) then {MCC_fakeACFOV = 0.02};
if (MCC_fakeACFOV >= 0.9) then {MCC_fakeACFOV = 0.9};
MCC_fakeAC camsetFOV MCC_fakeACFOV;
MCC_fakeAC camCommit 0.1;
ctrlSetText [MCC_CONSOLE_AC_ZOOM_TEXT, format ["ZOOM: %1x ",(10-(10*MCC_fakeACFOV))]];