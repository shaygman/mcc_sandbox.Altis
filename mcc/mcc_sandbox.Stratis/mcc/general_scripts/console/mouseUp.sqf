//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params", "_ctrl", "_pressed", "_posX", "_posY", "_shift", "_ctrlKey", "_alt", "_eib_marker","_pointB","_nearObjectsA","_nearObjectsB"];
disableSerialization;
 
_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;
_posX = _params select 2; 
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;

MCC_ConsoleMouseButtonDown = false;	//Mouse state
MCC_ConsoleMouseButtonUp = true;