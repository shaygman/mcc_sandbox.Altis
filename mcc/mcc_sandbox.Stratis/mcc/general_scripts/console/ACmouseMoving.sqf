//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_posX","_posY","_posNew","_rand","_relDir","_distance"];
disableSerialization;
 
_params = _this select 0;

_ctrl = _params select 0;
_posX = _params select 1;
_posY = _params select 2; 

if (MCC_ConsoleACMouseButtonDown) then {
	_posNew = [((MCC_ACPos select 0) - _posX)*(MCC_fakeACFOV*150), ((MCC_ACPos select 1) - _posY)*(MCC_fakeACFOV*150),0];
	setMousePosition [0.5,0.44];
	_relDir = [MCC_fakeAC, MCC_ACcenter] call BIS_fnc_relativeDirto;
	//hint format ["%1", MCC_fakeAC distance MCC_fakeACCenter];
	if ((_relDir <90) || (_relDir > 280))then {
		MCC_fakeACCenter setpos (MCC_fakeACCenter modeltoWorld[(_posNew select 0)*-1,(_posNew select 1),0]);
		_rand = random 10;
		if (_rand<0.03) then {playmusic format ["RadioAmbient%1", (floor (random 30) + 1)]};
		} else	{
				if ((_relDir>90) && !(_relDir>150)) then {
					MCC_fakeACCenter setpos (MCC_fakeACCenter modeltoWorld[(10*MCC_fakeACFOV),0,0]);
					MCC_fakeACCenter setposatl [(getpos MCC_fakeACCenter select 0),(getpos MCC_fakeACCenter select 1),0];
					//hint "left";
				} else {
					MCC_fakeACCenter setpos (MCC_fakeACCenter modeltoWorld[(-10*MCC_fakeACFOV),0,0]);
					MCC_fakeACCenter setposatl [(getpos MCC_fakeACCenter select 0),(getpos MCC_fakeACCenter select 1),0];
					//hint "right";
					};
		};
	_distance = MCC_fakeAC distance MCC_fakeACCenter;
	if (_distance > 350 && _distance < 1000) then {
		MCC_fakeACCenter setpos (MCC_fakeACCenter modeltoWorld[(_posNew select 0)*-1,(_posNew select 1),0]);
		} else	{
			if (_distance < 350) then {
				MCC_fakeACCenter setpos (MCC_fakeACCenter modeltoWorld[0,(10*MCC_fakeACFOV),0]);
				MCC_fakeACCenter setposatl [(getpos MCC_fakeACCenter select 0),(getpos MCC_fakeACCenter select 1),0];
			} else {
				MCC_fakeACCenter setpos (MCC_fakeACCenter modeltoWorld[0,(-10*MCC_fakeACFOV),0]);
				MCC_fakeACCenter setposatl [(getpos MCC_fakeACCenter select 0),(getpos MCC_fakeACCenter select 1),0];
				};
		};
	};
	