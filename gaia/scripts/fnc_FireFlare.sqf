/*
	Fire a flare up in the sky
	
	Start: The start position of the flare
		- (ARRAY)
	
	End: The end position of the flare
		- (ARRAY)
	
	Horizontal Speed: The added horizontal speed to the flare
		- (NUMBER)
	
	Vertical Speed: The added vertical speed to the flare
		- (NUMBER)
	
	Class: The flare class
		- (STRING)
*/

//Params
private ["_start", "_end", "_horizontalSpeed", "_verticalSpeed"];
_start			= [_this, 0, [0,0,0], [[]]] call BIS_fnc_param;
_end 			= [_this, 1, [0,0,0], [[]]] call BIS_fnc_param;
_horizontalSpeed 	= [_this, 2, 5, [0]] call BIS_fnc_param;
_verticalSpeed 		= [_this, 3, 30, [0]] call BIS_fnc_param;

//The flare class name
private "_class";
_class = [
	"F_40mm_Cir",
	"F_40mm_Green",
	"F_40mm_Red",
	"F_40mm_White",
	"F_40mm_Yellow"
] call BIS_fnc_selectRandom;

//The moving direction of the flare
private "_direction";
_direction = [_start, _end] call BIS_fnc_dirTo;

//The flare
private "_flare";
_flare = _class createVehicle _start;

//Add motion
_flare setVelocity [
	sin _direction * _horizontalSpeed,
	cos _direction * _horizontalSpeed,
	_verticalSpeed
];

//Flare weapon firing sound
_flare say3D "SN_Flare_Weapon_Fired";

//Flare sounds
_flare spawn {
	sleep 0.5;
	
	//The sound of the flare starting to burn
	_this say3D "SN_Flare_Fired_4";
	
	sleep 1;
	
	//The flare burning loop sound
	while { !isNull _this } do {
		_this say3D "SN_Flare_Loop";
		sleep 4;
	};
	
	//Log
	"Flare stopped burning!" call BIS_fnc_log;
};

//Log
["Flare %1 (%2) fired! Start: %3 - End: %4 - Direction: %5 - Horizontal Speed: %6 - Vertical Speed: %7", _class, _flare, _start, _end, _direction, _horizontalSpeed, _verticalSpeed] call BIS_fnc_logFormat;

//Return value
_flare;