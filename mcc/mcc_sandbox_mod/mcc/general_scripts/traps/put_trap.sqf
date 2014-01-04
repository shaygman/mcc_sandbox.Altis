//Made by Shay_Gman (c) 09.10
private ["_pos", "_trapkind", "_trapvolume", "_IEDExplosionType", "_IEDDisarmTime", "_IEDJammable", "_IEDTriggerType", "_IEDAmbushGroup",
 "_trapdistance", "_iedside", "_iedMarkerName", "_fakeIed", "_dummy", "_eib_marker","_ok","_iedDir","_init"]; 
disableSerialization;

_pos = _this select 0; 
_trapkind = _this select 1; 
_trapvolume = _this select 2; 
_IEDExplosionType = _this select 3; 
_IEDDisarmTime = _this select 4; 
_IEDJammable = _this select 5;
_IEDTriggerType = _this select 6;
_trapdistance = _this select 7;
_iedside = _this select 8;
_iedMarkerName = _this select 9;
_iedDir = _this select 10;

_eib_marker = createMarkerlocal ["traps",_pos];
//_pos= getMarkerPos "traps";

_fakeIed = _trapkind createVehicle _pos; 
_fakeIed setpos _pos;
_dummy = "Bomb" createVehicle _pos;
_init = '_this hideobject true; _this addEventHandler ["handleDamage","_this execVM ""' + MCC_path + 'mcc\general_scripts\traps\ied_hit.sqf"""];';
[[[netid _dummy,_dummy], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

_init ='_this addaction ["<t color=""#FF9900"">" + "Disarm IED" + "</t>","' + MCC_path + 'mcc\general_scripts\traps\ied_disarm.sqf","",6,false,true,"_target distance _this < 10"];';
[[[netid _fakeIed,_fakeIed], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
_fakeIed setdir _iedDir;

_dummy attachto [_fakeIed,[0,0,0]];

//[[2,compile format ["(objectFromNetID '%1') hideobject true", netID _dummy]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;

[_fakeIed, _dummy] spawn
	{
	private ["_fakeIedS"];
	_fakeIedS 	= _this select 0;
	_dummy 		= _this select 1;
	waituntil {!alive _fakeIedS};
	sleep 1;
	deletevehicle _dummy;
	};
	
_dummy setvariable ["fakeIed", _fakeIed ,true];
_dummy setvariable ["armed", true, true];
_dummy setvariable ["disarmTime", _IEDDisarmTime, true];
_dummy setvariable ["iedMarkerName", _iedMarkerName, true];
_dummy setvariable ["iedTrigered", false, true]; 
_dummy setvariable ["iedAmbush", false, true];
if (_IEDTriggerType == 1) then {
	_dummy setvariable ["iedTrigereRadio", true, true]
	} else {_dummy setvariable ["iedTrigereRadio", false, true]};	//If it is radio IED
	
_fakeIed setvariable ["realIed", _dummy ,true];


_ok = [_dummy,_trapvolume,_IEDExplosionType,_IEDJammable,_IEDTriggerType,_trapdistance,_iedside] execVM MCC_path +"mcc\general_scripts\traps\IED.sqf";

sleep 0.01;
deletemarker "traps";