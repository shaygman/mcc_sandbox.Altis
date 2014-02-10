private ["_eyes","_willsee","_infront","_obstruction"];
_unit = _this select 0;
_focus = _this select 1;

	_eyes = eyepos _unit;
	_focuseyes = eyepos _focus;

	_obstruction = (lineintersectswith [_eyes,_focuseyes,_unit,_focus]) select 0;

	_willsee = if (isnil("_obstruction")) then {true} else {false};

	_infront = getposASL _focus;

[_willsee,_infront]

