//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.


private ["_params","_ctrl","_posX","_posY","_posNew","_rand","_relDir","_distance","_attahcPosition"];
disableSerialization;

_params = _this select 0;

_ctrl = _params select 0;
_posX = _params select 1;
_posY = _params select 2;

if (missionNamespace getVariable ["MCC_ConsoleACMouseButtonDown",false]) then {

	/*
	if (player getVariable ["MCC_lastSoundTime",time] <= time) then {playsound ["MCC_zoom",true];player setVariable ["MCC_lastSoundTime",time+0.12]};
	setMousePosition [0.5,0.44];


	_uav = missionNamespace getVariable ["MCC_ACConsoleUp",objNull];
	if (!alive _uav) exitWith {};
	_attahcPosition = missionNamespace getVariable ["MCC_ConolseAC130_attahcPosition",[-200,2,-5]];
	_attahcPosition set [1,(((_attahcPosition select 1)+((_posX-0.5)*100)) min 352) max -410];
	_attahcPosition set [2,(((_attahcPosition select 2)-((_posY-0.44)*100)) min 195) max -205];

	MCC_fakeACCenter attachTo [_uav,_attahcPosition];

	missionNamespace setVariable ["MCC_ConolseAC130_attahcPosition",_attahcPosition];

	*/
	private ["_fov","_ac","_center"];

	#define MCC_ACPos [0.5,0.44]

	_fov = missionNamespace getVariable ["MCC_fakeACFOV",0.8];
	_ac = missionNamespace getVariable ["MCC_fakeAC",objNull];
	_center = missionNamespace getVariable ["MCC_fakeACCenter",objNull];
	_realAc = missionNamespace getVariable ["MCC_ACConsoleUp",objNull];

	if (isNull _ac || isNull _center || !alive _realAc) exitWith {};

	_relDir = [_realAc, _center] call BIS_fnc_relativeDirto;
	_distance = _realAc distance2d _center;

	if (_relDir < 340 && _relDir > 220 && _distance > 200 && _distance < 2000) then {
		if (player getVariable ["MCC_lastSoundTime",time] <= time) then {playsound ["MCC_zoom",true];player setVariable ["MCC_lastSoundTime",time+0.12]};
		if (random 10<0.03) then {playmusic format ["RadioAmbient%1", (floor (random 30) + 1)]};

		_posNew = [((MCC_ACPos select 0) - _posX)*(_fov*150)*(_ac distance _center)/100 , ((MCC_ACPos select 1) - _posY)*(_fov*150)*(_ac distance _center)/100,0];
		_center setdir (getdir _ac);
		_center setpos (_center modeltoWorld[(_posNew select 0)*-1,(_posNew select 1),0]);
	} else {
		if (_relDir > 340) then {
			//Left
			_center setpos (_center modeltoWorld[(-10*_fov),0,0]);
		} else {
			//Right
			_center setpos (_center modeltoWorld[(10*_fov),0,0]);
		};

		if (_distance < 350) then {
			//Up
			_center setpos (_center modeltoWorld[0,(10*_fov),0]);
		} else {
			//Down
			_center setpos (_center modeltoWorld[0,(-10*_fov),0]);
		};

		_center setdir (getdir _ac);
		_center setposatl [(getpos _center select 0),(getpos _center select 1),0];
	};

	setMousePosition [0.5,0.44];


	/*
	if ((_relDir <90) || (_relDir > 280))then {
		_center setpos (_center modeltoWorld[(_posNew select 0)*-1,(_posNew select 1),0]);
		_rand = random 10;
		if (_rand<0.03) then {playmusic format ["RadioAmbient%1", (floor (random 30) + 1)]};
	} else {

		if ((_relDir>90) && !(_relDir>150)) then {
			//Left
			_center setpos (_center modeltoWorld[(10*_fov),0,0]);
		} else {
			//Right
			_center setpos (_center modeltoWorld[(-10*_fov),0,0]);
		};

		_center setposatl [(getpos _center select 0),(getpos _center select 1),0];
	};

	_distance = _ac distance _center;

	if (_distance > 350 && _distance < 1000) then {
		_center setpos (_center modeltoWorld[(_posNew select 0)*-1,(_posNew select 1),0]);
		} else	{
			if (_distance < 350) then {
				//Up
				_center setpos (_center modeltoWorld[0,(10*_fov),0]);
			} else {
				//Down
				_center setpos (_center modeltoWorld[0,(-10*_fov),0]);
			};

			_center setposatl [(getpos _center select 0),(getpos _center select 1),0];
		};
	*/
};
