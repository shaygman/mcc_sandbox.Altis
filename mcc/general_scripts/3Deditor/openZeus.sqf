//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_pos","_target"];

_pos 	= getpos MCC_3D_CAM; 
_target = getpos MCC_dummyObject; 

cutText ["","BLACK",0.1];

MCC_3DterminateNoMCC = true; 

waituntil {isnil "MCC_3D_CAM"};

while {dialog} do {closeDialog 0; sleep 0.01};

while {str findDisplay 312 == "No display"} do {sleep 1; openCuratorInterface};
sleep 1;
[_pos, _target, 0] call BIS_fnc_setCuratorCamera; 
cutText ["","BLACK IN",0.5];

