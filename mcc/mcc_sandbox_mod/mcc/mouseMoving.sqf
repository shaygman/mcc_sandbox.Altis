//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_posX","_posY"];
disableSerialization;
 
_params = _this select 0;

_ctrl = _params select 0;
MCCDispPosXY = _ctrl ctrlmapscreentoworld [_params select 1,_params select 2];
