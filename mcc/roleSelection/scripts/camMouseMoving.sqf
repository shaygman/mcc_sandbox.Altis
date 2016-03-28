private ["_mode","_ctrl","_posX","_posY","_newY","_center","_position","_camLogic"];

disableSerialization;
_mode = _this select 0;
_input = _this select 1;

_ctrl = _input select 0;

if (isnil "CP_gearCam") exitWith {};
if (isnull CP_gearCam) exitWith {};

if (_mode == "MouseButtonDown") then {
	_key = _input select 1;

	//--- mouseHolding
	if (_key == 0) then {
		CP_camMouseHolding = true;
	};
};

if (_mode == "MouseButtonUp") then {
	_key = _input select 1;
	if (_key == 0) then {			//--- mouse no longer Holding
		CP_camMouseHolding = false;
		};
};

if (_mode == "MouseZChanged") then {
	_key = _input select 1;
	_distance = CP_gearCam distance player;

	_position = if (_key>0) then {
					if (_distance >2.65) then {0.07} else {0};
				} else {
					if (_distance <3.3) then {-0.07} else {0};
				};

	CP_gearCam setpos (CP_gearCam modelToWorld [0,_position,0]);
};

if (_mode == "mousemoving") then {
	if ((missionNamespace getVariable ["CP_camMouseHolding",false]) && !(missionNamespace getVariable ["CP_rotatingPlayer",false])) then {
		missionNamespace setVariable ["CP_rotatingPlayer",true];
		_posX = _input select 1;
		_dir = direction player;
		_dir = if (_dir <180) then {360 - (180 -_dir)} else {_dir -180};
		_left = (missionNamespace getVariable ["CP_camMouseMovingX",_posX]) < _posX;

		if (_left) then {player setDir (_dir + 4)} else {player setDir (_dir - 4)};

		CP_camMouseMovingX = _posX;
		sleep 0.01;
		missionNamespace setVariable ["CP_rotatingPlayer",false];
	};
};