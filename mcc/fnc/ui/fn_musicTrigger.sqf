/*====================================================== MCC_fnc_MusicTrigger ==========================================================
	Execute music or sound on all clients triggers
========================================================================================================================================*/
private ["_zone","_zonePos","_zoneX","_zoneY","_activate","_cond","_track","_trigger","_dummy","_init","_jukeBoxMusic"];

_zone = _this select 0;
_zonePos = _this select 1;
_zoneX = _this select 2;
_zoneY = _this select 3;
_activate = _this select 4;
_cond = _this select 5;
_track = _this select 6;
_jukeBoxMusic = _this select 7;

_trigger = createTrigger ["EmptyDetector", _zonePos];
_trigger setpos _zonePos;
_trigger setTriggerArea [_zoneX, _zoneY, 0, true];

if (_jukeBoxMusic) then {
	_trigger setTriggerStatements ["this",format ["playMusic  '%1'",_track], ""];
} else {
	if (isClass(configFile >> "CfgSounds" >> _track) || isClass(missionconfigFile >> "CfgSounds" >> _track)) then {
		_trigger setTriggerStatements ["this",format ["playSound '%1'",_track], ""];
	} else {
		_trigger setSoundEffect["ClickSoft", "", "",format ['%1',_track]];
	};
};

_trigger setTriggerActivation [_activate, _cond, false];

