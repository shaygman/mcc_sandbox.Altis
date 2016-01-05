//=========================================================MCC_fnc_DOOR_CAM_Handler==========================================================================================
//==============================================================================================================================================================================
private ["_keyNightVision","_keysBanned","_keyForward","_keyBack","_keyLeft","_keyRight","_mode","_input","_NVGstate","_camTarget","_pos","_relDir"];
_keyNightVision	= actionKeys "NightVision";
_keysBanned		= [1,15];
_keyForward		= actionKeys "carForward";
_keyBack		= actionKeys "carBack";
_keyLeft		= actionKeys "carLeft";
_keyRight		= actionKeys "carRight";
_mode 	= _this select 0;
_input 	= _this select 1;
_cam 	= player getVariable ["MCC_doorCam",objNull];
_camTarget = _cam getVariable ["MCC_DOORCAM_TARGET",[0,2,0]];

if (isnil "_cam") then {player setVariable ["MCC_mirrorCamOff",true]};

if (_mode == "keydown") then
{
	_key = _input select 1;

	//--- Terminate
	if (_key in _keysBanned) then {player setVariable ["MCC_mirrorCamOff",true]};

	//--- Start NVG
	if (_key in _keyNightVision) then
	{
		playSound "nvSound";
		_NVGstate = !(player getVariable ["MCC_DOORCAM_NVSTATE", false]);
		"uavrtt" setPiPEffect (if (_NVGstate) then {[1]} else {[0]});
		player setVariable ["MCC_DOORCAM_NVSTATE", _NVGstate];
	};

	//--- UP
	if (_key in _keyForward) then
	{
		_camTarget set [2,(_camTarget select 2)+0.03];
		_cam setVariable ["MCC_DOORCAM_TARGET",_camTarget];
		_pos = _cam modelToWorld _camTarget;
		if (((_pos select 2) - ((getpos _cam) select 2)) < 1.5) then
		{
			_cam camSetTarget _pos;
			if (player getVariable ["MCC_lastSoundTime",time] <= time) then {playsound ["MCC_zoom",true];player setVariable ["MCC_lastSoundTime",time+0.11]};
		};
	};

	//--- Down
	if (_key in _keyBack) then
	{
		_camTarget set [2,(_camTarget select 2)-0.03];
		_cam setVariable ["MCC_DOORCAM_TARGET",_camTarget];
		_pos = _cam modelToWorld _camTarget;
		if (((_pos select 2) - ((getpos _cam) select 2)) > -1.5) then
		{
			_cam camSetTarget _pos;
			if (player getVariable ["MCC_lastSoundTime",time] <= time) then {playsound ["MCC_zoom",true];player setVariable ["MCC_lastSoundTime",time+0.11]};
		}
	};

	//--- Left
	if (_key in _keyLeft) then
	{
		_camTarget set [0,(_camTarget select 0)-0.03];
		_cam setVariable ["MCC_DOORCAM_TARGET",_camTarget];
		_pos = _cam modelToWorld _camTarget;
		_relDir = [player,_pos] call BIS_fnc_relativeDirTo;
		if ( _relDir > 325 || _relDir < 35) then
		{
			_cam camSetTarget _pos;
			if (player getVariable ["MCC_lastSoundTime",time] <= time) then {playsound ["MCC_zoom",true];player setVariable ["MCC_lastSoundTime",time+0.11]};
		};
	};

	//--- Right
	if (_key in _keyRight) then
	{
		_camTarget set [0,(_camTarget select 0)+0.03];
		_cam setVariable ["MCC_DOORCAM_TARGET",_camTarget];
		_pos = _cam modelToWorld _camTarget;
		_relDir = [player,_pos] call BIS_fnc_relativeDirTo;
		if ( _relDir > 325 || _relDir < 35) then
		{
			_cam camSetTarget _pos;
			if (player getVariable ["MCC_lastSoundTime",time] <= time) then {playsound ["MCC_zoom",true];player setVariable ["MCC_lastSoundTime",time+0.11]};
		};
	};

	 _cam camCommit 0;
};
