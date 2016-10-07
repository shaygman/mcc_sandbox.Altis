/*=================================================================MCC_fnc_movieMaker==============================================================
create a movie scene made of intro if needed and a zoom in on an object
<IN>
	0:	OBJECT	The subject of the movie
	1:	STRING	structured text that will show when focusing on object
	2: 	STRING	Either "nv","ti" or "none" for nightVision/Thermal imaging or none.
	3: 	NUMBER 	0-1 start zoom level
	4:	NUMBER 	0-1 end zoom level
	5:	NUMBER	In seconds how long the scene would lust - it is the minimum time as the scene will not end before displaying all the text
	6:	NUMBER 	In seconds how much time a transition take between scenes
	7:	SPECIAL	defins opening scene
		"sky" - for an up the cloud opening scene
		"uav" - for a UAV simulation opening scene
		"none"- for no opening scene
		ARRAY - array of units for tracking units opening scene
	8:	ARRAY - array of sounds to play and the duration of each sound for naroating example [["sound1",0.2],["sound2",0.3]....] leave [] for none
	9: 	STRING - music track name - leave "" for none
	10: ARRAY - array of text needed for the BIS_fnc_typeText in format:
				[
					["example Text","<t size='2.0' font='PuristaBold'>%1</t><br/>",3],
				  	["More example Text","<t size='1.0' font='PuristaBold'>%1</t><br/>",0]
				]
=======================================================================================================================================================*/
private ["_sfx","_blur","_cam","_camPos","_targetPos","_fnc_tranzEffect","_target","_units","_timeEnd","_endCinimeticEH"];
params ["_object","_taskDescription","_sfxName","_zoomStart","_zoomEnd","_shotDuration","_trazDuration","_specialIntro","_sounds","_music","_plainText","_distance"];

MCC_fnc_tranzEffect = {
	params ["_cutText","_duration","_adjust"];parsetext

	cutText ["", _cutText, _duration];
	private _blur = ppEffectCreate ["dynamicBlur", 450];
	_blur ppEffectEnable true;
	_blur ppEffectAdjust [_adjust];
	_blur ppEffectCommit _duration;

	sleep _duration;

	_blur ppEffectEnable false;
	ppEffectDestroy _blur;
};

_sfx = ppEffectCreate ["FilmGrain", 2012];
_sfx ppEffectEnable true;
_sfx ppEffectAdjust [0.1, 1, 1, 0, 1];
_sfx ppEffectEnable true;
_sfx ppEffectCommit 0;
 missionNamespace setVariable ["MCC_fnc_movieMaker_Sfx",_sfx];

//NVG/TI
switch (_sfxName) do {
	case "nv": 	{camUseNVG true};
	case "ti": 	{true setCamUseTi 0};
	default		{
		camUseNVG false;
		false setCamUseTi 0;
	};
};

//Start Camera
_camPos = [(getPos _object), 300, random 360] call BIS_fnc_relPos;
_cam = "camera" camCreate _camPos;
_cam camPrepareFOV _zoomStart;
showCinemaBorder true;
missionNamespace setVariable ["MCC_fnc_movieMaker_cam",_cam];

//if intro is an object
if (typeName _specialIntro == typeName []) then {
	_units = _specialIntro;
	_specialIntro = "track";
};

missionNamespace setVariable ["MCC_fnc_movieMaker_running",true];

_endCinimeticEH = (findDisplay 46) displayAddEventHandler ["KeyDown", {
	_keyDown = _this select 1;

	if (_keyDown == 1) then {
		_sfx = missionNamespace getVariable ["MCC_fnc_movieMaker_Sfx",nil];
		_sfx ppEffectEnable false;
		ppEffectDestroy _sfx;

		_cam = missionNamespace getVariable ["MCC_fnc_movieMaker_cam",nil];
		_cam cameraeffect ["terminate", "back"];
		camDestroy _cam;

		missionNamespace setVariable ["MCC_fnc_movieMaker_running",false];
	};

	false;
}];

//First scene - make an intro
if (_specialIntro != "none") then {
	missionNamespace setVariable ["MCC_MWcenematicIntroFirstScene",true];

	switch (_specialIntro) do
	{
		case "sky":
		{
			_targetPos = [(getPos _cam), 5000, getDir _cam] call BIS_fnc_relPos;
			_targetPos  set [2,3500];
			_camPos set [2,3500];
			_cam camSetPos _camPos;
			_cam camPrepareTarget _targetPos;
			_cam cameraEffect ["internal", "BACK"];
			_cam camCommitPrepared 0;

			//Fade in
			["BLACK IN",_trazDuration,0] call MCC_fnc_tranzEffect;

			//if not attached camera make it move
			_cam camPreparePos _targetPos;
			_cam camCommitPrepared 10;
		};

		case "track":
		{
			[_units,_cam,_trazDuration] spawn {
				private ["_target"];
				params ["_units","_cam","_trazDuration"];

				while {(missionNamespace getVariable ["MCC_MWcenematicIntroFirstScene",false]) && (missionNamespace getVariable ["MCC_fnc_movieMaker_running",false])} do {
					_target = _units call bis_fnc_selectrandom;

					if (_target isKindOf "man") then {
						_cam attachTo [_target, [2,-3,2],"neck"];
					} else {
						_cam attachTo [_target, [5,-5,5]]
					};
					_cam camPrepareTarget _target;
					_cam cameraEffect ["internal", "BACK"];
					_cam camCommand "inertia off";

					//Fade in
					["BLACK IN",_trazDuration,0] call MCC_fnc_tranzEffect;

					//if not attached camera make it move
					_cam camCommitPrepared 10;

					sleep 5;
				};
			};
		};

		default
		{
			//Fade in
			["BLACK IN",_trazDuration,0] call MCC_fnc_tranzEffect;
			_camPos set [2,30];
			_cam camPrepareTarget _camPos;
			_cam cameraEffect ["internal", "BACK"];
			_cam camCommitPrepared 0;

			// Move camera in a circle
			[position _object, 400, 400, random 360, round random 1,_cam] spawn {
				params ["_pos", "_alt", "_rad", "_ang", "_dir","_cam"];
				private ["_coords"];

				while {(missionNamespace getVariable ["MCC_MWcenematicIntroFirstScene",false]) && (missionNamespace getVariable ["MCC_fnc_movieMaker_running",false])} do {
					_coords = [_pos, _rad, _ang] call BIS_fnc_relPos;
					_coords set [2, _alt];

					_cam camPreparePos _coords;
					_cam camCommitPrepared 0.2;

					waitUntil {camCommitted _cam || !(isNil "BIS_missionStarted")};

					_cam camPreparePos _coords;
					_cam camCommitPrepared 0;

					_ang = if (_dir == 0) then {_ang - 0.5} else {_ang + 0.5};
				};
			};
		};
	};

	//music
	playMusic _music;

	/*
	//Intel
	[getpos _object] call MCC_fnc_camp_showOSD;
	sleep 15;
	*/
	//Intel
	//get daytime data
	if !(missionNamespace getVariable ["MCC_fnc_movieMaker_running",false]) exitWith {};

	private ["_date","_tYear","_tMonth","_tDay","_tTimeH","_tTime","_tTimeM","_output"];
	_date = date;
	_tYear 	= _date select 0;
	_tMonth = _date select 1;
	_tDay 	= _date select 2;

	if (_tMonth < 10) then {_tMonth = format["0%1",_tMonth]};
	if (_tDay < 10) then {_tDay = format["0%1",_tDay]};

	//get date text
	_tDate = format["%1-%2-%3",_tYear,_tMonth,_tDay];

	//get time text
	_tTimeH = _date select 3;
	_tTimeM = _date select 4;

	if (_tTimeH < 10) then {_tTimeH = format["0%1",_tTimeH]};
	if (_tTimeM < 10) then {_tTimeM = format["0%1",_tTimeM]};

	_tTime = format["%1:%2",_tTimeH,_tTimeM];


	//sum the output params & print it
	_output =
	[
		[_tDate,"<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
		[_tTime,"<t size='1.0' font='PuristaBold'>%1</t><br/>",5],
		[worldName,"<t size='1.0' font='PuristaBold'>%1</t><br/>",5]
	];

	[_output,safezoneX,0,"<t color='#FFFFFFFF' align='left'>%1</t>"] call BIS_fnc_typeText;
	sleep 5;

	//Sounds
	sleep 1;
	if !(missionNamespace getVariable ["MCC_fnc_movieMaker_running",false]) exitWith {};
	[_sounds] spawn MCC_fnc_playBriefings;

	//Briefings
	if !(missionNamespace getVariable ["MCC_fnc_movieMaker_running",false]) exitWith {};
	_timeEnd = time + _shotDuration;
	[_plainText,safezoneX,0,"<t color='#FFFFFFFF' align='left'>%1</t>"] call BIS_fnc_typeText;

	waituntil {time >= _timeEnd};

	sleep 1-_trazDuration;

	//Fade out
	["BLACK OUT",_trazDuration,100] call MCC_fnc_tranzEffect;

	if !(isNull attachedTo _cam) then {detach _cam};
	missionNamespace setVariable ["MCC_MWcenematicIntroFirstScene",false];
} else {

	//first scene
	_camPos = [(getPos _object), 200, random 360] call BIS_fnc_relPos;
	_camPos set [2,20];
	_cam cameraEffect ["internal", "BACK"];
	_cam camSetPos _camPos;
	_cam camPrepareTarget _object;
	_cam camCommitPrepared 0;

	//Fade in
	[ "BLACK IN",_trazDuration,0] call MCC_fnc_tranzEffect;

	// Rolling
	_distance = 15;
	_camPos = [(getPos _object), _distance, random 360] call BIS_fnc_relPos;
	while {lineIntersects [ATLToASL _camPos, getposasl _object, _object, _cam]} do {
		_distance = _distance -1;
		_camPos = [(getPos _object), _distance, random 360] call BIS_fnc_relPos;
	};

	_camPos set [2,5];
	_cam camPreparePos _camPos;
	_cam camPrepareTarget _object;
	_cam camPrepareFOV _zoomEnd;
	_cam camCommitPrepared (((count (toArray _taskDescription))*0.011) max _shotDuration);

	//Briefings
	[[[_taskDescription,"<t size='0.7' font='PuristaMedium'>%1</t>",0]],safezoneX,0,"<t color='#E2EEE0' align='left'>%1</t>"] call BIS_fnc_typeText;

	sleep 1-_trazDuration;
};

//Clean up
(findDisplay 46) displayRemoveEventHandler ["KeyDown", _endCinimeticEH];

if !(missionNamespace getVariable ["MCC_fnc_movieMaker_running",false]) exitWith {};

_sfx ppEffectEnable false;
ppEffectDestroy _sfx;

_cam cameraeffect ["terminate", "back"];
camDestroy _cam;

missionNamespace setVariable ["MCC_fnc_movieMaker_running",true];
