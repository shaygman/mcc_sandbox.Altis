//Made by Shay_Gman (c) 09.10
private ["_pos", "_trapkind", "_iedMarkerName", "_fakeIed", "_eib_marker","_iedDir","_init"]; 
disableSerialization;

_pos = _this select 0; 
_trapkind = _this select 1; 
_iedMarkerName = _this select 2;
_iedDir = _this select 3;

_eib_marker = createMarkerlocal ["traps",_pos];
_pos= getMarkerPos "traps";

_fakeIed = _trapkind createVehicle _pos;
_fakeIed setposatl _pos;

_fakeIed setvariable ["iedTrigered", false, true]; 
_fakeIed setdir _iedDir;
_init = format ["_this setVariable [""direction"", %1];", _iedDir];
[[[netid _fakeIed,_fakeIed], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
[_fakeIed, _iedMarkerName] spawn
	{
	private ["_fakeIedS", "_iedMarkerNameS"];
	_fakeIedS = _this select 0;
	_iedMarkerNameS = _this select 1;
	waituntil {!alive _fakeIedS};
	[[2,compile format ["deletemarkerlocal '%1';",_iedMarkerNameS]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;	//delete IED marker 
	_fakeIedS setvariable ["iedTrigered", true, true]; 
	};


sleep 0.01;
deletemarker "traps";